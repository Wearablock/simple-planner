import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:simple_planner/services/purchase_service.dart';

class AdService extends ChangeNotifier {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  // TODO: 프로덕션 출시 전 실제 AdMob 광고 단위 ID로 교체 필요
  // 현재는 테스트 ID 사용 중
  String get bannerAdUnitId {
    return Platform.isAndroid
        ? 'ca-app-pub-8841058711613546/4088024019' // Android 프로덕션 ID
        : 'ca-app-pub-8841058711613546/6967448154'; // iOS 프로덕션 ID
  }

  BannerAd? _bannerAd;
  bool _isBannerAdLoaded = false;

  bool get isBannerAdLoaded => _isBannerAdLoaded;

  BannerAd? get bannerAd => _isBannerAdLoaded ? _bannerAd : null;

  bool _isInitialized = false;

  double? _screenWidth;

  bool get shouldShowAds {
    return !PurchaseService().isAdFree;
  }

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      await MobileAds.instance.initialize();
      _isInitialized = true;
      debugPrint('AdService 초기화 완료');
    } catch (e) {
      debugPrint('AdService 초기화 실패: $e');
      _isInitialized = false;
    }
  }

  Future<void> loadBannerAd(double screenWidth) async {
    if (!shouldShowAds) {
      debugPrint('광고 제거 구매됨 - 배너 광고 로드 스킵');
      return;
    }

    if (_isBannerAdLoaded && _screenWidth == screenWidth) return;
    _screenWidth = screenWidth;

    await _bannerAd?.dispose();
    _isBannerAdLoaded = false;

    final AdSize? adaptiveSize = await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      screenWidth.toInt(),
    );

    final AdSize adSize = adaptiveSize ?? AdSize.banner;

    _bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      size: adSize,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _isBannerAdLoaded = true;
          notifyListeners();
          debugPrint("배너 광고 로드 성공");
        },
        onAdFailedToLoad: (ad, error) {
          _isBannerAdLoaded = false;
          ad.dispose();
          debugPrint('배너 광고 로드 실패: ${error.message}');
        },
        onAdOpened: (ad) => debugPrint('배너 광고 열림'),
        onAdClosed: (ad) => debugPrint('배너 광고 닫힘'),
      ),
    );

    await _bannerAd!.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _bannerAd = null;
    _isBannerAdLoaded = false;
    super.dispose();
  }
}
