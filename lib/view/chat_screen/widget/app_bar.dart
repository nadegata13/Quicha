import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quicha/ui/character_icons.dart';
import 'package:quicha/ui/custom_style.dart';
import 'package:spring/spring.dart';

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
        _UserAvatar(size: size, user: user, ) : Container(),

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
        _UserAvatar(size: size, user: user, ) : Container()
      ],
    );
  }
}

class AnimatedCirclePage extends StatefulWidget {
  @override
  _AnimatedCirclePageState createState() => _AnimatedCirclePageState();
}

class _AnimatedCirclePageState extends State<AnimatedCirclePage>  with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation = Tween(begin: 100.0, end: 200.0).animate(animationController);
    animationController.addStatusListener(animationStatusListener);
    animationController.forward();
  }
  void animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return
    AnimatedBuilder(animation: animationController, builder: (context, widget){
      return
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            color: Colors.red,
          ),
        );
    });
  }
}
class _UserAvatar extends StatefulWidget {

  _UserAvatar({
    Key? key,
    required this.size,
    required this.user,
  }) : super(key: key);

  final Size size;
  final User user;

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
      controller.stop();
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
                ref.read(chatProvider).startBoundAnime(controller);
              },
              child: Transform.scale(
                  scale: scale,
                  child: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle,
                      border: Border.all(color: controller.isAnimating ? Colors.white : Colors.grey.withOpacity(0.5), width: controller.isAnimating? 1.5 : 0.5),),
                    child: SvgPicture.asset(CharacterIcons.default_wolf.getPath),
                  )
              ),
            ));

    }));
  }
}



