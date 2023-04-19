import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:clipboard/clipboard.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String sender;
  bool isSender;

  ChatMessage({Key? key, this.text = "", this.sender = "",  this.isSender=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 45,
          height: 45,
          child: Text(sender[0],overflow: TextOverflow.ellipsis,maxLines: 1)
              .text.semiBold.white.capitalize.isIntrinsic
              .subtitle1(context)
              .make()
              .box
              .color(isSender?Vx.red100:Vx.purple200)
              .roundedSM
              .alignCenter
              .makeCentered(),
        ),
        Expanded(
            child: text.trim().text.bodyText2(context).make().px8()),
        IconButton(onPressed: (){
          FlutterClipboard.copy(text.trim()).then(( value ) =>
              print('copied'));
        }, icon: Icon(Icons.copy),)
      ],
    ).py8();
  }
}
