import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicha/viewModel/chat_viewmodel.dart';

import '../../../model/message.dart';
import 'chat_bubble.dart';

class ChatArea extends StatelessWidget {
  ChatArea({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;


  @override
  Widget build(BuildContext context) {
    return
      Expanded(child:
      Container(
          padding: EdgeInsets.symmetric(horizontal: size.width / 30),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background/first_background.png"),
                  fit: BoxFit.fill
              )

          ),
          child:
          SingleChildScrollView(
            reverse: true,
            child:
                Consumer(builder: (context,ref, _) {
                  final watchProvider = ref.watch(chatProvider);
                  final readProvider = ref.read(chatProvider);
                  return
                    ListView.builder(
                        controller: watchProvider.chatScrollController,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.zero,
                        itemCount: watchProvider.messageList.length,
                        itemBuilder: (context, index) {
                          var items = watchProvider.messageList;
                          bool isMe = items[index].messageType == "me";


                          return
                          //吹き出し
                            Row(
                              mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                              children: [
                                isMe ? Container() : Container(
                                  height: 30,
                                  width: 30,
                                  decoration:
                                  isContinuousMessage(items, index) ?
                                  BoxDecoration()
                                      :
                                  BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ) ,

                                ),

                                ChatBubble(
                                    isLeft: !isMe,
                                    color: isMe ? Colors.yellow : Colors.white,
                                    showNip: !isContinuousMessage(items, index),
                                    child: Text(
                                      items[index].messageContent,
                                      style: TextStyle(
                                          fontSize: size.height / 50,
                                          fontFamily: "NotoSans"
                                      ),
                                    ))
                              ],
                            );
                        });
                }),
          )
      )
      );
  }
  bool isContinuousMessage(List<ChatMessage> items , int index) {

    if(index <= 0) {
      return false;
    }

    return items[index -1].messageType == items[index].messageType;
  }
}
