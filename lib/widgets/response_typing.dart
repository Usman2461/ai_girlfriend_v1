import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ResponseTypingAnimation extends StatelessWidget {
  const ResponseTypingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250.0,
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'Typing...',
              textStyle: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              speed: const Duration(milliseconds: 100),
            ),
          ],
          repeatForever: true,
        ),
      ),
    );
  }
}

