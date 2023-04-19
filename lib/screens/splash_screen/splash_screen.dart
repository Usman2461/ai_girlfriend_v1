import 'package:ai_girlfriend_v1/helpers/ad_helper.dart';
import 'package:ai_girlfriend_v1/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ai_chat_screen/ai_chat_screen.dart';
import '../on_boarding_screens/on_boarding_gender.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

const int maxFailedLoadAttempts = 3;

class _SplashScreenState extends State<SplashScreen> {
  bool isFirst = true;
  InterstitialAd? _interstitialAd;
  int _interstitialAttempts = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateInterstitialAd();
    isFirstTime();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _interstitialAd?.dispose();
  }

  void generateInterstitialAd() {
    InterstitialAd.load(adUnitId: AdHelper.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad) {
              _interstitialAd = ad;
              _interstitialAttempts = 0;
            }, onAdFailedToLoad: (LoadAdError error) {
          _interstitialAttempts += 1;
          _interstitialAd = null;
          if (_interstitialAttempts >= maxFailedLoadAttempts) {
            generateInterstitialAd();
          }
        }));
  }

  void showAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (InterstitialAd ad){
            ad.dispose();
            generateInterstitialAd();
          }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error){
            ad.dispose();
            generateInterstitialAd();
          });
      _interstitialAd!.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image(
                image: AssetImage(
                  "assets/images/splash.png",
                ),
                fit: BoxFit.cover,
              )),
          Positioned(
              bottom: 40,
              child: Column(
                children: [
                  CustomButton(
                    onTap: () {
                      showAd();
                      Navigator.pushNamed(
                          context,
                          isFirst
                              ? OnBoardingScreen.screenName
                              : AIChatScreen.screenName);
                    },
                    text: "Hi, Friend, Let's Chat",
                  ),
                  const Text(
                    "I am your AI chatting partner",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ))
        ],
      ),
    );
  }

  void isFirstTime() async {
    var sharedPref = await SharedPreferences.getInstance();
    isFirst = sharedPref.getBool("isFirst") ?? true;
  }
}
