import 'package:flutter/material.dart';

import '../screens/on_boarding_screens/on_boarding_gender.dart';

class CustomButton extends StatelessWidget {
  Function onTap;
  String text;
  CustomButton({Key? key, this.text="", required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onTap();
        },
        child: Text(text),
        style: ElevatedButton.styleFrom(
            primary: Colors.deepPurple,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(20))));
  }
}
