import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quicha/model/user_model.dart';
import 'package:quicha/ui/character_icons.dart';
import 'package:quicha/ui/custom_style.dart';
import 'package:quicha/view/common_widget.dart';
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
                              bool isMe = items[index].messangerID == ref.read(myUserProvider).userID;
                              String messengerID = items[index].messangerID;


                              return
                                Row(
                                  mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                                  children: [
                                    isMe ?  Container() :
                                        //前回の発信者は同じか
                                    isContinuousMessage(items, index) ?
                                    Container(height: size.height / 25, width: size.height / 25,)
                                        :
                                        isOpponent(userID: items[index].messangerID)?
                                    CircleIcon(size: size.height / 25,
                                        iconNum: ref.read(opponentUserProvider).iconNum) : Container(
                                          height: 20,
                                          width: 20,
                                          color: Colors.red,
                                        ),

                                    // Container(
                                    //   height: size.height / 25,
                                    //   width: size.height / 25,
                                    //   decoration:
                                    //   isContinuousMessage(items, index) ?
                                    //   BoxDecoration()
                                    //       :
                                    //       getIcon(userID: items[index].messangerID, userInfo: ref.read(opponentUserProvider)),
                                    //
                                    // ),

                                    ChatBubble(
                                        color: isMe ? CustomColor.myBubbleColor : CustomColor.yourBubbleColor,
                                        showNip: !isContinuousMessage(items, index),
                                        messengerID: messengerID,
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

  BoxDecoration getIcon({required String userID, required UserData userInfo}){
    final String BOT_ID = "BOT";
    if(userID == BOT_ID){
      return BoxDecoration(shape: BoxShape.circle, color: Colors.red);
    } else {
      return BoxDecoration(shape: BoxShape.circle,
      image: DecorationImage(image: AssetImage(
        CharacterIcons.getIcon(userInfo.iconNum).getPath
      )));
    }
  }
  bool isOpponent({required String userID}){
    final String BOT_ID = "BOT";

    return userID != BOT_ID;

    }

  bool isContinuousMessage(List<ChatMessage> items , int index) {

    if(index <= 0) {
      return false;
    }

    return items[index -1].messangerID == items[index].messangerID;
  }
}
