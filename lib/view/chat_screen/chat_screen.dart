import 'package:flutter/material.dart';
import 'package:quicha/view/chat_screen/widget/chat_area.dart';
import 'package:quicha/view/chat_screen/widget/chat_text_field.dart';
import 'package:quicha/view/chat_screen/widget/quiz_space.dart';

import 'widget/app_bar.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: _Body(size: size));
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    var topHeight = MediaQuery.of(context).padding.top + kToolbarHeight;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Container(
                color: Colors.blue,
                height: size.height,
                child: Column(
                  children: [
                    //出題スペース
                    ChatAppBar(
                      topHeight: topHeight,
                      size: size,
                    ),
                    QuizArea(size: size),

                    //チャットスペース
                    ChatArea(
                      size: size,
                    ),
                    //入力欄
                    ChatTextField(size: size)
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
