import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicha/view/chat_screen/widget/animation_text.dart';

import '../../../viewModel/chat_viewmodel.dart';
import 'chat_bubble.dart';

class ButtonsForTest extends ConsumerWidget {
  const ButtonsForTest({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchProvider = ref.watch(chatProvider);
    final readProvider = ref.read(chatProvider);

    return Container(
      height: size.height / 30,
      child:
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(child:
          ElevatedButton(onPressed: (){
            readProvider.getQuizWidget(
                 ChatBubble(
              isLeft: true,
              color: Colors.white,
              showNip: true,
              child: AnimationText(  string: "第" + watchProvider.getQuizCount().toString() + "問",
                onFinished: () {
                  //クイズの問題文
                  readProvider.getQuizWidget(
                      ChatBubble(
                          isLeft: true,
                          color: Colors.white,
                          showNip: false,
                          child:
                          AnimationText(string: readProvider.currentQuiz.quizString,
                            onFinished: (){
                              //画像か音声クイズなら
                              if(watchProvider.currentQuiz.isPicture! || watchProvider.currentQuiz.isSound!) {

                              } else {
                                //クイズカウントダウン
                                readProvider.startCountdown();
                                readProvider.setVisibleTime();
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
            readProvider.clearChat();
          }, child:
          Text("Clear"),
          ),
            flex: 1,
          ),
          Expanded(child:
          ElevatedButton(onPressed: (){
            readProvider.increaseQuizCount();

          }, child:
          Text("Next"),
          ),
            flex: 1,
          ),
          Expanded(
            child:
            ElevatedButton(onPressed: (){
              readProvider.setQuizList();

            }, child:
            Text("Set"),
            ),
            flex: 1,
          ),
          Expanded(
            child:
            ElevatedButton(onPressed: (){
              readProvider.addMessageFromPartner();
              readProvider.incrementVictoryCount();

            }, child:
            Text("message"),
            ),
            flex: 1,
          ),

        ],),

    );
  }
}
