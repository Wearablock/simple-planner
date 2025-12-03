import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:simple_planner/services/ad_service.dart';
import 'package:simple_planner/services/purchase_service.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final width = MediaQuery.of(context).size.width;
    AdService().loadBannerAd(width);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: PurchaseService(),
      builder: (context, _) {
        if (PurchaseService().isAdFree) {
          return const SizedBox.shrink();
        }

        return ListenableBuilder(
          listenable: AdService(),
          builder: (context, _) {
            final bannerAd = AdService().bannerAd;

            if (bannerAd == null) {
              return const SizedBox(height: 50);
            }

            return Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: bannerAd.size.height.toDouble(),
              child: AdWidget(ad: bannerAd),
            );
          },
        );
      },
    );
  }
}
