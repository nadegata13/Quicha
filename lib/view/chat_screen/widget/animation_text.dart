import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimationText extends StatelessWidget {
  const AnimationText({
    Key? key,
    required this.string,
    required this.onFinished
  }) : super(key: key);

  final String string;
  final VoidCallback onFinished;

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Container(
      child: DefaultTextStyle(
        style:  TextStyle(
            fontSize: size.height / 50,
            fontFamily: 'NotoSans',
            color: Colors.black
        ),
        child: AnimatedTextKit(isRepeatingAnimation: false,
            totalRepeatCount: 0,
            onFinished: onFinished,
            animatedTexts: [
              TyperAnimatedText(string,
                  speed: Duration(milliseconds: 200)),
            ]),
      ),
    );
  }
}
