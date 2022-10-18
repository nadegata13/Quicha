import 'package:flutter/material.dart';
import 'package:quicha/view/chat_screen/widget/quiz_space.dart';
import 'package:quicha/view/chat_screen/widget/chat_area.dart';
import 'package:quicha/view/chat_screen/widget/chat_text_field.dart';

import 'widget/app_bar.dart';
import 'widget/button_for_test.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return
              GestureDetector(
                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                  child:
                  _Body(size: size)
              );

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
        appBar: AppBar(
          title:
          ChatAppBar(topHeight: topHeight, size: size,),
        ),
        // backgroundColor: CustomColor.thinBlue,
        backgroundColor: Colors.white,


        body:
        SingleChildScrollView(
          physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child:
            Container(
                height: size.height - topHeight,
                child:
                Column(
                  children: [
                    //出題スペース
                    QuizArea(size: size),


                    //TODO: 後で消す
                    //テスト用ボタン
                    ButtonsForTest(size: size, ),

                    //チャットスペース
                    ChatArea(size: size, ),
                    //入力欄
                    ChatTextField(size: size)


                  ],
                )
            )
        )
    );
  }
}







