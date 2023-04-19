import 'package:ai_girlfriend_v1/screens/ai_chat_screen/ai_chat_screen.dart';
import 'package:ai_girlfriend_v1/screens/on_boarding_screens/on_board_ai_namee.dart';
import 'package:ai_girlfriend_v1/screens/on_boarding_screens/on_boarding_gender.dart';
import 'package:ai_girlfriend_v1/screens/on_boarding_screens/on_boarding_interests.dart';
import 'package:ai_girlfriend_v1/screens/privacy_policy/privacy_policy.dart';
import 'package:ai_girlfriend_v1/screens/settings/settings.dart';
import 'package:ai_girlfriend_v1/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI  Partner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        OnBoardingScreen.screenName: (context) =>OnBoardingScreen(),
        OnBoardingScreen2.screenName: (context) =>OnBoardingScreen2(),
        AIChatScreen.screenName: (context) =>AIChatScreen(),
        PartnerNameScreen.screenName: (context) =>PartnerNameScreen(),
        SettingsScreen.screenName: (context) =>SettingsScreen(),
        PrivacyPolicy.screenName: (context) =>PrivacyPolicy(),

      },
    );
  }
}
