import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quicha/view/chat_screen/widget/animation_text.dart';

import '../../../viewModel/chat_viewmodel.dart';
import '../chat_bubble.dart';

class ButtonsForTest extends StatelessWidget {
  const ButtonsForTest({
    Key? key,
    required this.size,
    required this.viewModel,
  }) : super(key: key);

  final Size size;
  final ChatViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 30,
      child:
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(child:
          ElevatedButton(onPressed: (){
            viewModel.getQuizWidget(ChatBubble(
              isLeft: true,
              color: Colors.white,
              showNip: true,
              child: AnimationText(  string: "第" + viewModel.getQuizCount().toString() + "問",
                onFinished: () {
                  //クイズの問題文
                  viewModel.getQuizWidget(
                      ChatBubble(
                          isLeft: true,
                          color: Colors.white,
                          showNip: false,
                          child:
                          AnimationText(string: viewModel.currentQuiz.quizString,
                            onFinished: (){
                              //画像か音声クイズなら
                              if(viewModel.currentQuiz.isPicture! || viewModel.currentQuiz.isSound!) {

                              } else {
                                //クイズカウントダウン
                                viewModel.startCountdown();
                                viewModel.setVisibleTime();
                              }

                            },)) );
                },),));
          }, child:
          Text("Start"),
          ),
            flex: 1,
          ),

          Expanded(child:
          ElevatedButton(onPressed: (){
            viewModel.clearChat();
          }, child:
          Text("Clear"),
          ),
            flex: 1,
          ),
          Expanded(child:
          ElevatedButton(onPressed: (){
            viewModel.increaseQuizCount();

          }, child:
          Text("Next"),
          ),
            flex: 1,
          ),
          Expanded(
            child:
            ElevatedButton(onPressed: (){
              viewModel.setQuizList();

            }, child:
            Text("Set"),
            ),
            flex: 1,
          ),
          Expanded(
            child:
            ElevatedButton(onPressed: (){
              viewModel.addMessageFromPartner();
              viewModel.incrementVictoryCount();

            }, child:
            Text("message"),
            ),
            flex: 1,
          ),

        ],),

    );
  }
}
