import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import 'on_board_ai_namee.dart';

class OnBoardingScreen2 extends StatefulWidget {
  static String screenName = "interests";

  OnBoardingScreen2({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen2> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen2> {
  List<String> tags = [];
  List<String> options = [
    "Travelling",
    "Modeling",
    "Study",
    "Eat",
    "Games",
    "Technology",
    "Programming",
    "Sleep",
    "Reading",
    "Designing",
    "Politics",
    "Beauty",
    "Cycling",
    "Romantic",
    "Decoration",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Image(
              image: AssetImage("assets/images/interests.png",),
              height: 200,
              width: 200,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Text("Please choose your interests", style: TextStyle(fontSize: 18.0, ),),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              child: ChipsChoice<String>.multiple(
                value: tags,
                wrapped: true,
                onChanged: (val) =>
                    setState(() => tags = val),
                choiceItems: C2Choice.listFrom(
                    source: options,
                    value: (i, v) => v.toString(),
                    label: (i, v) => v.toString()),
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              width: 200,
              height: 40,
              child: CustomButton(onTap: (){
                Navigator.pushNamed(context, PartnerNameScreen.screenName);
              }, text: "Let's Go ",),
            ),
            const SizedBox(height: 10,),
            const Text("Knowing your interest,\n "
                "can help me understand you better",
            textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
