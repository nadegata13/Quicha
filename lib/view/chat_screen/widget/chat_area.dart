import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quicha/ui/custom_style.dart';
import 'package:quicha/viewModel/chat_viewmodel/chat_room_notifier.dart';

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
      Padding(
          // padding: EdgeInsets.symmetric(horizontal: size.width / 30),
        padding: EdgeInsets.zero,
          child:
          Stack(
            children: [
              Align(
                alignment: Alignment(0, -4),
                child: Container(
                  height: size.height / 3,
                    child: Lottie.asset("assets/lottile/cloudAnimation3.json",reverse: true,)
                ) ),
              Container(
                height: size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 1.0],
                    colors: [
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0),
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                  ),
                ),
                child:
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: size.width / 30),
                  child: HookConsumer(builder: (context,ref, _) {
                    final state = ref.watch(chatRoomProvider);
                    return

                      FadingEdgeScrollView.fromSingleChildScrollView(
                        gradientFractionOnStart: 0.5,
                          child:
                              // ChatList(onMsgKey: (int index) {  }, itemBuilder: (BuildContext context, int index) {  },)
                      SingleChildScrollView(
                        reverse: true,
                        controller: ScrollController(),
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.zero,
                            itemCount: state.chatMessages.length,
                            itemBuilder: (context, index) {
                              var items = state.chatMessages;
                              bool isMe = items[index].messanger == "me";


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
                                        color: isMe ? CustomColor.myBubbleColor : CustomColor.yourBubbleColor,
                                        showNip: !isContinuousMessage(items, index),
                                        child: Text(
                                          items[index].messageContent,
                                          style: TextStyle(
                                              fontSize: size.height / 50,
                                              fontFamily: "NotoSans",
                                          ),
                                        ))
                                  ],
                                );
                            }),
                      )
                      );
                  }),
                ),
              ),
            ],
          )
      )
      );
  }
  bool isContinuousMessage(List<ChatMessage> items , int index) {

    if(index <= 0) {
      return false;
    }

    return items[index -1].messanger == items[index].messanger;
  }
}
