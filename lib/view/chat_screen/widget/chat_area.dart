import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    return Expanded(
        child: Padding(
            // padding: EdgeInsets.symmetric(horizontal: size.width / 30),
            padding: EdgeInsets.zero,
            child: Stack(
              children: [
                Align(
                    alignment: Alignment(0, -4),
                    child: Container(
                        height: size.height / 3,
                        child: Lottie.asset(
                          "assets/lottile/cloudAnimation3.json",
                          reverse: true,
                        ))),
                Container(
                  height: size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 1.0],
                      colors: [
                        Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.0),
                        Theme.of(context).scaffoldBackgroundColor,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width / 30),
                    child: HookConsumer(builder: (context, ref, _) {
                      final state = ref.watch(chatRoomProvider);
                      final viewModel = ref.read(chatRoomProvider.notifier);
                      return FadingEdgeScrollView.fromSingleChildScrollView(
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
                                  bool isMe = items[index].messangerID ==
                                      ref.read(myUserProvider).userID;
                                  bool isOtherUser = isOpponent(
                                      userID: items[index].messangerID);
                                  String messengerID = items[index].messangerID;

                                  return Row(
                                    mainAxisAlignment: isMe
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      isMe
                                          ? Container()
                                          :
                                          //前回の発信者は同じか
                                          isContinuousMessage(items, index)
                                              ? Container(
                                                  height: size.height / 25,
                                                  width: size.height / 25,
                                                )
                                              : isOtherUser
                                                  ? CircleIcon(
                                                      size: size.height / 25,
                                                      iconNum: ref
                                                          .read(
                                                              opponentUserProvider)
                                                          .iconNum)
                                                  : Container(
                                                      height: size.height / 25,
                                                      width: size.height / 25,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              width: 0.3,
                                                              color:
                                                                  Colors.grey),
                                                          image: const DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: AssetImage(
                                                                  "assets/images/system/bot.png"))),
                                                    ),
                                      ChatBubble(
                                        color: isMe
                                            ? CustomColor.myBubbleColor
                                            : isOtherUser
                                                ? CustomColor.yourBubbleColor
                                                : Colors.grey,
                                        showNip:
                                            !isContinuousMessage(items, index),
                                        messengerID: messengerID,
                                        child: items[index].messageContent ==
                                                "NEXT_QUIZ_9A4B38S38s48A"
                                            ? SizedBox(
                                                height: size.height / 10,
                                                child: Column(
                                                  children: [
                                                    const Text("次のクイズを出題する"),
                                                    isMe
                                                        ? Container()
                                                        : HookConsumer(
                                                            builder: ((context,
                                                                ref, child) {
                                                              final isClicked =
                                                                  useState(
                                                                      false);
                                                              return ElevatedButton(
                                                                  onPressed:
                                                                      isClicked
                                                                              .value
                                                                          ? null
                                                                          : () {
                                                                              isClicked.value = true;
                                                                              viewModel.moveToNextQuiz();
                                                                            },
                                                                  child: Text(
                                                                      "賛成"));
                                                            }),
                                                          )
                                                  ],
                                                ),
                                              )
                                            : items[index].messageContent ==
                                                    "QUIZ_ANSWER_58932eDsa3"
                                                ? SizedBox(
                                                    height: size.height / 10,
                                                    child: Column(
                                                      children: [
                                                        const Text("答えを表示する"),
                                                        isMe
                                                            ? Container()
                                                            : HookConsumer(
                                                                builder:
                                                                    ((context,
                                                                        ref,
                                                                        child) {
                                                                  final isClicked =
                                                                      useState(
                                                                          false);
                                                                  return ElevatedButton(
                                                                      onPressed: isClicked
                                                                              .value
                                                                          ? null
                                                                          : () {
                                                                              isClicked.value = true;
                                                                              viewModel.showQuizAnswer();
                                                                            },
                                                                      child: Text(
                                                                          "賛成"));
                                                                }),
                                                              )
                                                      ],
                                                    ),
                                                  )
                                                : Text(
                                                    items[index].messageContent,
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.height / 50,
                                                      fontFamily: "NotoSans",
                                                    ),
                                                  ),
                                      )
                                    ],
                                  );
                                }),
                          ));
                    }),
                  ),
                ),
              ],
            )));
  }

  BoxDecoration getIcon({required String userID, required UserData userInfo}) {
    final String BOT_ID = "BOT";
    if (userID == BOT_ID) {
      return BoxDecoration(shape: BoxShape.circle, color: Colors.red);
    } else {
      return BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage(
                  CharacterIcons.getIcon(userInfo.iconNum).getPath)));
    }
  }

  bool isOpponent({required String userID}) {
    final String BOT_ID = "BOT";

    return userID != BOT_ID;
  }

  bool isContinuousMessage(List<ChatMessage> items, int index) {
    if (index <= 0) {
      return false;
    }

    return items[index - 1].messangerID == items[index].messangerID;
  }
}
