import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  static String screenName = "privacy";
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text("Privacy Policy",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                ),
                Text("This Privacy Policy describes how your personal information"
                    " is collected, used, and shared when you use the AI Partner app (the “App”)."),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("Information We Collect"),
                ),
                Text(
                    "When you use the App, we may collect certain information from you, including:"),
                Text(
                    "Device Information: We may collect information about the device you are using to access"
                        " the App, including the model, operating system, and unique device identifier.\n\n "
                    "Usage Information: We may collect information about how you use the App,"
                        " including the features you use and the frequency and duration of your use.\n"
                    " Personal Information: We may collect personal information such as your name, email address,"
                        " and other contact information if you choose to provide it to us."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
