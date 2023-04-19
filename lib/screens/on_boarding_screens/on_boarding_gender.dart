import 'package:ai_girlfriend_v1/widgets/custom_button.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

import 'on_boarding_interests.dart';

class OnBoardingScreen extends StatefulWidget {
  static String screenName = "genders";

  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var tag = 1;
  List<String> options = [" Male ", "Female"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffffd1d9),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Image(
                height: 200,
                width: 200,
                image: AssetImage("assets/images/selectgender.png"),
              ),
            ),
            const Text(
              "Select your gender",
              style: TextStyle(fontSize: 18.0),
            ),
            ChipsChoice.single(
              value: tag,
              onChanged: (val) =>
                  setState(() => tag = int.parse(val.toString())),
              choiceItems: C2Choice.listFrom(
                  source: options,
                  value: (i, v) => i,
                  label: (i, v) => v.toString()),
              choiceStyle:
                  const C2ChipStyle(height: 100, padding: EdgeInsets.all(20)),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 40,
                  child: CustomButton(
                    onTap: () {
                      Navigator.pushNamed(
                          context, OnBoardingScreen2.screenName);
                    },
                    text: "Next",
                  ),
                ),
                const SizedBox(height: 10.0,),
                const Text(
                  "Hi, friend, kindly tell me your gender so I can behave accordingly",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
