import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.showNip,
    required this.child,
    required this.isLeft,
    required this.color
  }) : super(key: key);

  final Widget child;
  final bool isLeft;
  final Color color;
  final bool showNip;

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return
      Container(
        width:  size.width - size.width / 4,
        child:
        Bubble(
            alignment: isLeft ? Alignment.topLeft : Alignment.topRight,
            nip: isLeft ? BubbleNip.leftTop : BubbleNip.rightTop,
            color:  color,
            borderWidth: 0.1,
            borderColor: Colors.grey,
            elevation: 0,

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

