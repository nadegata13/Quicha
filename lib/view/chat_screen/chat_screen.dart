import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicha/ui/custom_style.dart';
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
          backgroundColor: CustomColor.appBarTheme,
        ),
        // backgroundColor: CustomColor.thinBlue,
        backgroundColor: Colors.white,


        body:
        Stack(
          children: [
            SingleChildScrollView(
              physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child:
                Container(
                  color: Colors.blue,
                    height: size.height - topHeight,
                    child:
                    Column(
                      children: [
                        //出題スペース
                        QuizArea(size: size),



                        //チャットスペース
                        ChatArea(size: size, ),
                        //入力欄
                        ChatTextField(size: size)


                      ],
                    )
                )
            ),
            //TODO: 後で消す
            //テスト用ボタン
            HookConsumer(builder: ((context, ref, child) {
              var flag = useState(false);
              return
                Column(
                  children: [

                    flag.value ? ButtonsForTest(size: size, ) : Container(),
                    Switch(value: flag.value, onChanged: (value){
                      flag.value = value;
                    })
                  ],
                );
            })),
          ],
        )
    );
  }
}







