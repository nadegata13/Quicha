import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quicha/ui/character_icons.dart';
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
        _UserAvatar2(size: size, user: user, ) : Container()
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

class _UserAvatar extends ConsumerWidget {
   _UserAvatar({
    Key? key,
    required this.size,
    required this.user,
  }) : super(key: key);

  final Size size;
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readProvider = ref.read(chatProvider);
    final watchProvider = ref.watch(chatProvider);
    final springController = readProvider.myAnimeController ;


    return
      Container(
        height: size.height / 20,
          width: size.height / 20,
          child: GestureDetector(
            onTap: () {
              //reverse the animation on red card click with changed curve
              ref.read(chatProvider).startWinEffect(springController);
            },
            child: Spring.scale(
              springController: springController,
              start: 1.0, //required
              end: 0.8, //required
              animDuration: Duration(milliseconds: 0), //def=1s,
              animStatus: (AnimStatus status) {
                print(status);
              },
              curve: Curves.bounceOut, //def=Curves.easeInOut
              child: Container(
                child: SvgPicture.asset(CharacterIcons.default_human.getPath),
              ),
            ),
          ));
    // Container(height: 30, width: 30,
    // child:
    // Stack(
    //   alignment: Alignment.center,
    //   children: [
    //     // AnimatedContainer(
    //     //   height: size.height / 25,
    //     //   width: size.height /25,
    //     //   duration: Duration(milliseconds: 500),
    //     //   child: SvgPicture.asset(user.icon.getPath),
    //     // ),
    //   ],
    // )
    // );
  }
}
class _UserAvatar2 extends ConsumerWidget {
  _UserAvatar2({
    Key? key,
    required this.size,
    required this.user,
  }) : super(key: key);

  final Size size;
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readProvider = ref.read(chatProvider);
    final springController =  readProvider.partnerAnimeController;


    return
      Container(
          height: size.height / 20,
          width: size.height / 20,
          child: GestureDetector(
            onTap: () {
              //reverse the animation on red card click with changed curve
              ref.read(chatProvider).startWinEffect(springController);
            },
            child: Spring.scale(
              springController: springController,
              start: 1.0, //required
              end: 0.8, //required
              animDuration: Duration(milliseconds: 0), //def=1s,
              animStatus: (AnimStatus status) {
                print(status);
              },
              curve: Curves.bounceOut, //def=Curves.easeInOut
              child: Container(
                child: SvgPicture.asset(CharacterIcons.default_human.getPath),
              ),
            ),
          ));
    // Container(height: 30, width: 30,
    // child:
    // Stack(
    //   alignment: Alignment.center,
    //   children: [
    //     // AnimatedContainer(
    //     //   height: size.height / 25,
    //     //   width: size.height /25,
    //     //   duration: Duration(milliseconds: 500),
    //     //   child: SvgPicture.asset(user.icon.getPath),
    //     // ),
    //   ],
    // )
    // );
  }
}
