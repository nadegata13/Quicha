import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quicha/model/user_model.dart';
import 'package:quicha/ui/character_icons.dart';
import 'package:quicha/ui/custom_style.dart';
import 'package:quicha/viewModel/chat_viewmodel/chat_room_notifier.dart';
import 'package:spring/spring.dart';

import '../../../test_data.dart';

class ChatAppBar extends HookConsumerWidget {
  const ChatAppBar({
    Key? key,
    required this.topHeight,
    required this.size,
  }) : super(key: key);

  final double topHeight;
  final Size size;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      color: Colors.white.withOpacity(0.5),
      alignment: Alignment.bottomCenter,
      height: size.height / 9,
      padding: EdgeInsets.only(top: 30),

      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                  height: topHeight ,
                  width: size.width / 3,
                  child:
                  _User(size: size, user: ref.read(myUserProvider), isMe: false,)
            ),
              Container(width: size.width / 10,
                  alignment: Alignment.center,
                  child:
                  Text("x")
              ),
              _User(size: size, isMe: true, user: ref.read(opponentUserProvider))
            ],
          ),
        ],
      ),
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


  final UserData user;
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
        _UserAvatar(size: size, user: user, ) : Container(),

        Container(
            padding: isMe ? EdgeInsets.only(left: size.width / 50) : EdgeInsets.only(right: size.width / 50),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //名前
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
                HookConsumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return Container(
                    child: AnimatedFlipCounter(

                      duration: Duration(milliseconds: 500),
                      textStyle: counterTextStyle,
                      value: ref.watch(chatRoomProvider).victoryCount, // pass in a value like 2014
                    ),
                  );
                },

                )
              ],
            )
        ),

        !isMe ?
        _UserAvatar(size: size, user: user, ) : Container()
      ],
    );
  }
}

class _UserAvatar extends StatefulWidget {

  _UserAvatar({
    Key? key,
    required this.size,
    required this.user,
  }) : super(key: key);

  final Size size;
  final UserData user;

  @override
  __USerAvatarState createState() => __USerAvatarState();
}

class __USerAvatarState extends State<_UserAvatar> with SingleTickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController controller;
  var isAnimation = false;



  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final quick =  Duration(milliseconds: 800);
    final scaleTween = Tween(begin: 1.0, end: 1.5);

    controller = AnimationController(duration: quick, vsync: this);
    animation = scaleTween.animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.bounceIn,
      ),
    )..addListener(() {
      setState(() => scale = animation.value);
    });


  }


  void _stopAnimate() {

  }
  void _animate() {

    controller.repeat(reverse:  true);

    Future.delayed(Duration(seconds: 6), () {
      controller.reset();
      print(controller.isAnimating);
      setState(() {

      });
    });
  }

  double scale = 1.0;
  @override
  Widget build(BuildContext context) {
    return
    Consumer(builder: ((context, ref, child) {
      return
        Container(
            height: widget.size.height / 25,
            width: widget.size.height / 25,
            child: GestureDetector(
              onTap: () {
                _animate();
                showDialog(context: context, builder: ((_) {
                  return CustomAlertDialog();
                  // return  Dialog(
                  //
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  // ),
                  //   child: Container(
                  //     height: widget.size.height / 3,
                  //   ),
                  // );
                }));
              },
              child: Transform.scale(
                  scale: scale,
                  //アイコン
                  child: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage(CharacterIcons.getIcon(widget.user.iconNum).getPath)),
                      border: Border.all(color: controller.isAnimating ? Colors.white : Colors.grey.withOpacity(0.5), width: controller.isAnimating? 1.5 : 0.5),),
                  )
              ),
            ));

    }));
  }
}


//TEST

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({Key? key}) : super(key: key);

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _initScaleAnimation();
  }

  _initScaleAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() => setState(() {}));

    animation = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.linear)
    )..addListener(() {
      setState(() => scale = animation.value);
    });

    controller.forward();
  }

  var scale = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(alignment: Alignment.topCenter,
        child:
        Transform.scale(
          scale: scale,
          child: const AlertDialog(
            backgroundColor: Colors.cyanAccent,
            title: Text("title"),
          ),
        ),
        )
      ],
    );
  }
}
