import 'package:flutter/material.dart';
class CTextField extends StatelessWidget {
  TextEditingController controller;
  String label;
  CTextField({Key? key, required this.controller, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: "Enter name..",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          labelText: label,
        ),
        style: TextStyle(),

      ),
    );
  }
}
