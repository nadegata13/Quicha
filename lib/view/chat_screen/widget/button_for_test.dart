import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicha/view/chat_screen/widget/animation_text.dart';
import 'package:quicha/viewModel/chat_viewmodel/chat_room_notifier.dart';

import 'chat_bubble.dart';

class ButtonsForTest extends ConsumerWidget {
  const ButtonsForTest({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatRoomProvider);
    final viewModel = ref.read(chatRoomProvider.notifier);

    return Container(
      height: size.height / 30,
      child:
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(flex: 1,child:
          ElevatedButton(onPressed:
              (){
            viewModel.showQuizmanNextMessage();
          }, child:
          Text("Start"),
          ),
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
            viewModel.incQuizCount();

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
              viewModel.fetchQuiz();
            }, child:
            Text("message"),
            ),
            flex: 1,
          ),

        ],),

    );
  }
}
