
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quicha/viewModel/chat_viewmodel.dart';

import '../view/chat_screen/widget/animation_text.dart';
import '../view/chat_screen/widget/chat_bubble.dart';

class QuizMan{

  List<String> messages = [];
  List<Widget> bubbleList = [];
  int index = 0;
  StreamController controller = StreamController();
  ChatNotifier viewModel;

  QuizMan({required this.viewModel});


  void setMessages({required List<String> messages}){
    this.messages = messages;
  }

   Widget readMesseges(){
    if(messages.isEmpty) {return Container();}
    return
      ChatBubble(
          isLeft: true,
          color: Colors.white,
          //最初のメッセージなら
          showNip: index == 0,
          child: _bubbleChild(messages[index])
      );

  }

  Widget _bubbleChild(String message) {


    int lastIndex = message.length -1;
    String filetype = message.substring(message.length <= 4 ? 0 : lastIndex - 4, lastIndex);

    if(filetype == ".png"){
      return
        Container(height: 30, width: 30, child: Text(message));

    } else if(filetype == ".mp3") {

      return
          Container(height: 30, width: 30, child: Text(message));

    } else {

      return
      AnimationText(  string: message,
        onFinished: () {
          //クイズの問題文
          //最後の要素なら
          if(index == messages.length - 1){
            print("終わり");
            //初期化
            index = 0;
            //カウントダウン
            startCountDown();
            return;
          }
          index++;
          viewModel.getQuizWidget();
        },);
    }
  }

  void startCountDown(){
    print("カウントダウン");

  }

  void resetCountDown() {
    print("リセット");
  }


}