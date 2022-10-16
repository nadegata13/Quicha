import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quicha/ui/character_icons.dart';

import '../../../test_data.dart';
import '../../../viewModel/chat_viewmodel.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({
    Key? key,
    required this.topHeight,
    required this.size,
  }) : super(key: key);

  final double topHeight;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Container(
            height: topHeight ,
            width: size.width / 3,
            child:
            _User(size: size, user: TestData.user1, isMe: false,)
      ),
        Container(width: size.width / 10,
            alignment: Alignment.center,
            child:
            Text("x")
        ),
        _User(size: size, isMe: true, user: TestData.user2)
      ],
    );
  }
}

class _User extends StatelessWidget {
  const _User({
    Key? key,
    required this.size,
    required this.isMe,
    required this.user,
  }) : super(key: key);


  final User user;
  final Size size;
  final isMe;

  @override
  Widget build(BuildContext context) {

    var nameTextStyle =  TextStyle(fontSize: size.height / 50, );
    var counterTextStyle = TextStyle(fontSize:  size.height / 70);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

        isMe ?
        _UserAvatar(size: size, user: user) : Container(),

        Container(
            padding: isMe ? EdgeInsets.only(left: size.width / 50) : EdgeInsets.only(right: size.width / 50),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width / 5,
                  height: size.height / 40,
                  child:
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(user.nickname, style: nameTextStyle,),
                  ),

                ),
                //正解カウンター
                Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return Container(
                    child: AnimatedFlipCounter(

                      duration: Duration(milliseconds: 500),
                      textStyle: counterTextStyle,
                      value: ref.watch(chatProvider).victoryCount, // pass in a value like 2014
                    ),
                  );
                },

                )
              ],
            )
        ),

        !isMe ?
        _UserAvatar(size: size, user: user) : Container()
      ],
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({
    Key? key,
    required this.size,
    required this.user,
  }) : super(key: key);

  final Size size;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: size.height / 45,
          backgroundColor: Colors.white,
        ),
        CircleAvatar(
          radius: size.height / 50 ,
          child: SvgPicture.asset(user.icon.getPath),
        ),
      ],
    );
  }
}
