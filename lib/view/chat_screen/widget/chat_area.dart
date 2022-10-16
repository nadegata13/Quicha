import 'package:flutter/material.dart';

import '../../../model/message.dart';
import '../../../viewModel/chat_viewmodel.dart';
import 'chat_bubble.dart';

class ChatArea extends StatelessWidget {
  ChatArea({
    Key? key,
    required this.size,
    required this.viewModel,
  }) : super(key: key);

  final Size size;
  final ChatViewModel viewModel;


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
            ListView.builder(
                controller: viewModel.chatScrollController,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                itemCount: viewModel.messageList.length,
                itemBuilder: (context, index) {
                  var items = viewModel.messageList;
                  bool isMe = items[index].messageType == "me";


                  return
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
