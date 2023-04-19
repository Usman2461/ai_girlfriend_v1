import 'dart:async';
import 'package:ai_girlfriend_v1/helpers/ad_helper.dart';
import 'package:ai_girlfriend_v1/screens/privacy_policy/privacy_policy.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../widgets/chat_message.dart';
import '../../widgets/response_typing.dart';
import '../settings/settings.dart';

class AIChatScreen extends StatefulWidget {
  static String screenName = "chatscreen";

  AIChatScreen({Key? key}) : super(key: key);

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  StreamSubscription? subscription;
  OpenAI? openAI;
  String userName = "";
  String partnerName = "";
  bool isTyping = false;
  late BannerAd _bottomBannerAd;
  late BannerAd _inlineBannerAd;
  bool isBannerAdLoaded = false;
  bool isInlineAdLoaded = false;
  bool activateAd = false;
  int activateAdValue = 6;

  @override
  void initState() {
    openAI = OpenAI.instance;
    getData();
    createBtmBannerAd();
    createInlineBannerAd();
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    _bottomBannerAd.dispose();
    _inlineBannerAd.dispose();
    super.dispose();
  }

  void _sendMessage() {
    ChatMessage message = ChatMessage(
      text: _controller.text,
      sender: userName,
      isSender: true,
    );

    setState(() {
      _messages.insert(0, message);
      isTyping = true;
    });

    _controller.clear();
    subscription?.cancel();

    final request = CompleteText(
        prompt: message.text, maxTokens: 200, model: kTranslateModelV3);
    try {
      subscription = openAI!
          .build(
        token: "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",
        baseOption: HttpSetup(receiveTimeout: 10000, connectTimeout: 10000),
      )
          .onCompleteStream(request: request)
          .timeout(Duration(seconds: 5), onTimeout: (event) {
        setState(() {
          isTyping = false;
        });
      }).listen((response) {
        Vx.log(response!.choices[0].text);

        ChatMessage botMessage = ChatMessage(
          text: response.choices[0].text,
          sender: partnerName,
          isSender: false,
        );
        setState(() {
          isTyping = false;
          _messages.insert(0, botMessage);
        });
      });
    } catch (e) {
      ChatMessage botMessage = ChatMessage(
        text: "lo g",
        sender: partnerName,
        isSender: false,
      );
      setState(() {
        isTyping = false;
        _messages.insert(0, botMessage);
      });
    }
  }


  void createBtmBannerAd() {
    _bottomBannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitId,
        listener: BannerAdListener(onAdLoaded: (_) {
          setState(() {
            isBannerAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
        }),
        request: AdRequest());
    _bottomBannerAd.load();
  }

  void createInlineBannerAd() {
    _inlineBannerAd = BannerAd(size: AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitId2,
        listener: BannerAdListener(onAdLoaded: (_) {
          setState(() {
            isInlineAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
        }),
        request: AdRequest());
    _inlineBannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, SettingsScreen.screenName);
                },
                title: const Text(
                  "Settings",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const Divider(),
              ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, PrivacyPolicy.screenName);
                  },
                  title: const Text("Privacy Policy",
                      style: TextStyle(fontSize: 16))),
              Divider(),
              ListTile(
                onTap: () {
                  showAboutDialog(context: context);
                },
                title: const Text("About", style: TextStyle(fontSize: 16)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(image: AssetImage("assets/images/iconapp.png"),height: 50,width: 50,),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Developed by QutechSoft Inc, 2023"),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(14)),
        ),
        backgroundColor: Colors.deepPurple,
        title: Text(partnerName),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.adb_rounded))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            isBannerAdLoaded
                ? Container(
              height: _bottomBannerAd.size.height.toDouble(),
              width: _bottomBannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bottomBannerAd,),
            )
                : SizedBox(),
            Flexible(
                child: SizedBox(
                  child: ListView.builder(
                      reverse: true,
                      padding: Vx.m8,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        if(_messages.length==activateAdValue){
                          activateAd=true;
                          activateAdValue=activateAdValue+6;
                        }
                        if(isInlineAdLoaded && activateAd){
                          activateAd=false;
                          return Column(
                            children: [
                              _messages[index],
                              SizedBox(height: 4,),
                              SizedBox(
                                width: _inlineBannerAd.size.width.toDouble(),
                                height: _inlineBannerAd.size.height.toDouble(),
                                child: AdWidget(ad: _inlineBannerAd),
                              ),

                            ],
                          );
                        }
                        else {
                          return _messages[index];
                        }
                      }),
                )),
            if (isTyping) ResponseTypingAnimation(),
            Divider(),
            Container(
              decoration: BoxDecoration(color: context.cardColor),
              child: buildTextComposer(context),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextComposer(context) {
    return Row(
      children: [
        Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: (value) => _sendMessage(),
              decoration: InputDecoration.collapsed(
                  hintText: "Send a message.."),
            )),
        IconButton(
            onPressed: () {
              _sendMessage();
            },
            icon: const Icon(
              Icons.send,
              color: Colors.deepPurple,
            ))
      ],
    );
  }

  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userName = pref.getString("userName")!;
      partnerName = pref.getString("botName")!;
    });
  }
}
