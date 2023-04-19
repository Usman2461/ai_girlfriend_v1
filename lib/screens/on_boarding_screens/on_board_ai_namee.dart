import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/c_text_field.dart';
import '../../widgets/custom_button.dart';
import '../ai_chat_screen/ai_chat_screen.dart';

class PartnerNameScreen extends StatelessWidget {
  static String screenName = "AIName";
  TextEditingController myNameController = TextEditingController();
  TextEditingController partnerNameController = TextEditingController();

  PartnerNameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xe5ffffff),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const Image(
                  image: AssetImage(
                    "assets/images/chatp.png",
                  ),
                  height: 200,
                  width: 200,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    "Let's Know Each Other",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CTextField(
                  controller: myNameController,
                  label: "Enter your name",
                ),
                CTextField(
                  controller: partnerNameController,
                  label: "Give nickname to AI partner",
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  height: 40,
                  child: CustomButton(
                    onTap: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.setBool("isFirst", false);
                      pref.setString("userName", myNameController.text);
                      pref.setString("botName", partnerNameController.text);

                      Navigator.pushNamed(context, AIChatScreen.screenName);
                    },
                    text: "Let's Start Chat",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("I am ready friend, let's start chatting"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
