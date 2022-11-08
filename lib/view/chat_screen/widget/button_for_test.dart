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

          Expanded(flex: 1,child:
          ElevatedButton(onPressed:
              (){
            readProvider.getQuizWidget();
          }, child:
          Text("Start"),
          ),
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
