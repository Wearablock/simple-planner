import 'dart:async';

import 'package:flutter/material.dart';

import 'package:in_app_purchase/in_app_purchase.dart' as iap;
import 'package:shared_preferences/shared_preferences.dart';

const String kRemoveAdsProductId = 'remove_ads';

enum AdPurchaseState { unknown, available, purchased, pending, error }

class PurchaseService extends ChangeNotifier {
  static final PurchaseService _instance = PurchaseService._internal();
  factory PurchaseService() => _instance;
  PurchaseService._internal();

  final iap.InAppPurchase _inAppPurchase = iap.InAppPurchase.instance;

  StreamSubscription<List<iap.PurchaseDetails>>? _subscription;

  iap.ProductDetails? _removeAdsProduct;
  iap.ProductDetails? get removeAdsProduct => _removeAdsProduct;

  AdPurchaseState _status = AdPurchaseState.unknown;
  AdPurchaseState get status => _status;

  bool _isAdFree = false;
  bool get isAdFree => _isAdFree;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAvailable = false;
  bool get isAvailable => _isAvailable;

  Future<void> initialize() async {
    await _loadPurchaseState();

    _isAvailable = await _inAppPurchase.isAvailable();

    if (!_isAvailable) {
      debugPrint('PurchaseService: 스토어를 사용할 수 없습니다');
      _status = AdPurchaseState.error;
      _errorMessage = '스토어에 연결할 수 없습니다';
      notifyListeners();
      return;
    }

    _subscription = _inAppPurchase.purchaseStream.listen(
      _onPurchaseUpdate,
      onDone: () => _subscription?.cancel(),
      onError: (error) {
        debugPrint('PurchaseService 스트림 에러: $error');
      },
    );

    await _loadProducts();

    if (!_isAdFree) {
      await restorePurchases();
    }

    debugPrint('PurchaseService 초기화 완료 - isAdFree: $_isAdFree');
  }

  Future<void> _loadProducts() async {
    try {
      final iap.ProductDetailsResponse response = await _inAppPurchase
          .queryProductDetails({kRemoveAdsProductId});

      if (response.error != null) {
        debugPrint('상품 로드 에러: ${response.error}');
        _status = AdPurchaseState.error;
        _errorMessage = '상품 정보를 불러올 수 없습니다';
        notifyListeners();
        return;
      }

      if (response.productDetails.isEmpty) {
        debugPrint('상품을 찾을 수 없습니다: $kRemoveAdsProductId');
        _status = AdPurchaseState.error;
        _errorMessage = '상품을 찾을 수 없습니다';
        notifyListeners();
        return;
      }

      _removeAdsProduct = response.productDetails.first;
      _status = _isAdFree
          ? AdPurchaseState.purchased
          : AdPurchaseState.available;

      debugPrint(
        '상품 로드 완료: ${_removeAdsProduct?.title} - ${_removeAdsProduct?.price}',
      );
      notifyListeners();
    } catch (e) {
      debugPrint('상품 로드 예외: $e');
      _status = AdPurchaseState.error;
      _errorMessage = '상품 정보를 불러오는 중 오류가 발생했습니다';
      notifyListeners();
    }
  }

  Future<bool> purchaseRemoveAds() async {
    if (_removeAdsProduct == null) {
      _errorMessage = '상품 정보가 없습니다';
      notifyListeners();
      return false;
    }

    if (_isAdFree) {
      _errorMessage = '이미 구매하셨습니다';
      notifyListeners();
      return false;
    }

    try {
      _status = AdPurchaseState.pending;
      notifyListeners();

      final iap.PurchaseParam purchaseParam = iap.PurchaseParam(
        productDetails: _removeAdsProduct!,
      );

      final bool success = await _inAppPurchase.buyNonConsumable(
        purchaseParam: purchaseParam,
      );

      if (!success) {
        _status = AdPurchaseState.available;
        _errorMessage = '구매를 시작할 수 없습니다';
        notifyListeners();
      }

      return success;
    } catch (e) {
      debugPrint('구매 시작 예외: $e');
      _status = AdPurchaseState.available;
      _errorMessage = '구매 중 오류가 발생했습니다';
      notifyListeners();
      return false;
    }
  }

  Future<void> restorePurchases() async {
    try {
      _status = AdPurchaseState.pending;
      notifyListeners();

      await _inAppPurchase.restorePurchases();

      await Future.delayed(const Duration(seconds: 5));

      if (_status == AdPurchaseState.pending) {
        _status = _isAdFree
            ? AdPurchaseState.purchased
            : AdPurchaseState.available;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('구매 복원 예외: $e');
      _status = _isAdFree
          ? AdPurchaseState.purchased
          : AdPurchaseState.available;
      _errorMessage = '구매 복원 중 오류가 발생했습니다';
      notifyListeners();
    }
  }

  void _onPurchaseUpdate(List<iap.PurchaseDetails> purchaseDetailsList) {
    for (final iap.PurchaseDetails purchaseDetails in purchaseDetailsList) {
      debugPrint(
        '구매 업데이트: ${purchaseDetails.productID} - ${purchaseDetails.status}',
      );

      if (purchaseDetails.productID != kRemoveAdsProductId) continue;

      switch (purchaseDetails.status) {
        case iap.PurchaseStatus.pending:
          _status = AdPurchaseState.pending;
          notifyListeners();
          break;

        case iap.PurchaseStatus.purchased:
        case iap.PurchaseStatus.restored:
          _handleSuccessfulPurchase(purchaseDetails);
          break;

        case iap.PurchaseStatus.error:
          _handlePurchaseError(purchaseDetails);
          break;

        case iap.PurchaseStatus.canceled:
          _status = AdPurchaseState.available;
          notifyListeners();
          break;
      }
    }
  }

  Future<void> _handleSuccessfulPurchase(
    iap.PurchaseDetails purchaseDetails,
  ) async {
    if (purchaseDetails.pendingCompletePurchase) {
      await _inAppPurchase.completePurchase(purchaseDetails);
    }

    _isAdFree = true;
    await _savePurchaseState();

    _status = AdPurchaseState.purchased;
    _errorMessage = null;
    notifyListeners();

    debugPrint('구매 완료: 광고 제거됨');
  }

  void _handlePurchaseError(iap.PurchaseDetails purchaseDetails) {
    debugPrint('구매 에러: ${purchaseDetails.error?.message}');

    _status = AdPurchaseState.error;
    _errorMessage = purchaseDetails.error?.message ?? '구매 중 오류가 발생했습니다';
    notifyListeners();

    Future.delayed(const Duration(seconds: 2), () {
      if (_status == AdPurchaseState.error) {
        _status = AdPurchaseState.available;
        notifyListeners();
      }
    });
  }

  Future<void> _savePurchaseState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_ad_free', _isAdFree);
      debugPrint('구매 상태 저장: $_isAdFree');
    } catch (e) {
      debugPrint('구매 상태 저장 실패: $e');
    }
  }

  Future<void> _loadPurchaseState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isAdFree = prefs.getBool('is_ad_free') ?? false;
      debugPrint('구매 상태 로드: $_isAdFree');
    } catch (e) {
      debugPrint('구매 상태 로드 실패: $e');
      _isAdFree = false;
    }
  }

  String get priceString {
    return _removeAdsProduct?.price ?? '₩4,900';
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
