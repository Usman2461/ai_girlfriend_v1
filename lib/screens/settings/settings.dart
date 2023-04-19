import 'package:ai_girlfriend_v1/widgets/c_text_field.dart';
import 'package:ai_girlfriend_v1/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ai_chat_screen/ai_chat_screen.dart';

class SettingsScreen extends StatefulWidget {
  static String screenName = "settings";

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController myNameController = TextEditingController();
  TextEditingController myPartnerController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              CTextField(controller: myNameController, label: "User Name"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: CTextField(controller: myPartnerController, label: "AI Partner Name"),
              ),

              const Icon(Icons.settings,size: 50,color: Color(0x1b2c2b2b),),
              const SizedBox(height: 20,),
              SizedBox(
                width: 220,
                height: 40,
                child: CustomButton(onTap: (){
                  updateData();
                  Navigator.popAndPushNamed(context, AIChatScreen.screenName);
                }, text: "Save",),
              ),





            ],
          ),
        ),
      ),
    );
  }

  void getData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    myNameController.text = pref.getString("userName")??"";
    myPartnerController.text = pref.getString("botName")??"";
  }
  void updateData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("userName",myNameController.text);
    pref.setString("botName", myPartnerController.text);
  }
}
