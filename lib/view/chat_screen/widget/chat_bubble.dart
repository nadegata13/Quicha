import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicha/model/user_model.dart';

class ChatBubble extends ConsumerWidget {
  const ChatBubble({
    Key? key,
    required this.showNip,
    required this.child,
    required this.color,
    required this.messengerID
  }) : super(key: key);

  final Widget child;
  final Color color;
  final bool showNip;
  final messengerID;

  @override
  Widget build(BuildContext context, ref) {

    final Size size = MediaQuery.of(context).size;
    //自分かどうか
    bool isMe = messengerID == ref.read(myUserProvider).userID;

    return
      Container(
        width:  size.width - size.width / 4,
        child:
        Bubble(
            alignment: isMe ? Alignment.topRight : Alignment.topLeft,
            nip: isMe ?  BubbleNip.rightTop : BubbleNip.leftTop ,
            color:  color,
            borderWidth: 0.1,
            borderColor: Colors.grey,

            margin:  BubbleEdges.only(left: size.width / 50, top: 8, bottom: 8),
            padding:  BubbleEdges.symmetric(horizontal: size.height / 50, vertical: size.height / 80),
            nipRadius: 1,
            showNip: showNip,
            nipHeight: 7,
            nipWidth: 10,
            nipOffset: 10,
            radius: Radius.circular(30),
            child: child
        ),
      );
  }
}

