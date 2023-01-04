import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quicha/model/socket_client.dart';
import 'package:quicha/ui/character_icons.dart';
import 'package:quicha/ui/custom_style.dart';
import 'package:quicha/view/common_widget.dart';
import 'package:quicha/view/home_screen/home_screen.dart';
import 'package:quicha/viewModel/matching_viewmodel/matching_notifier.dart';
import 'package:rive/rive.dart';

class MatchingScreen extends HookConsumerWidget {
  const MatchingScreen({
    required this.currrentIcon,
    required this.currentNickname,
    Key? key,
  }) : super(key: key);

  final int currrentIcon;
  final String currentNickname;

  @override
  Widget build(BuildContext context, ref, ) {

    final Size size = MediaQuery.of(context).size;
    final state = ref.watch(matchingProvider);
    final viewModel = ref.read(matchingProvider.notifier);

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 1000),
    );

    final double userPosition = 0.5;
    final tweenAnimation = Tween(begin: 1.0, end: userPosition).animate(animationController);

    final tweenOpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(animationController);



    useValueChanged<bool,void>(state.isAnimation  ,(_ , __){

      if (animationController.isCompleted) {
        animationController.reverse();
      } else {
        animationController.forward();
      }

    });

    useEffect((){
      animationController.addListener(() {
      });
    });

    return Scaffold(


      appBar: AppBar(
        title: Text(state.matchingMessage),
        backgroundColor: CustomColor.appBarTheme,

      ),
      body:Stack(
        children: [
          //バス
          AnimatedOpacity(
            opacity: state.isVisibleBus ? 1 : 0,
            duration: Duration(seconds: 1),
            child: Container(height: size.height, width: size.width,
              child: Lottie.asset("assets/lottile/bus.json",)
                // child: Lottie.network("https://assets7.lottiefiles.com/packages/lf20_4qklCv.json")
            ),

          ),

          Align(
            alignment: Alignment(0,-userPosition),
            child: _UserWidget(size: size, isMe: true,
              icon: currrentIcon,
              nickname: currentNickname,),
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: ( context,  child) {
              return
                Align(alignment:
                  Alignment(0, tweenAnimation.value),
                child: Opacity(
                  opacity: tweenOpacityAnimation.value,
                  child:
                  _UserWidget(size: size, isMe: false,
                    icon: state.opponentIcon,
                    nickname: state.opponentNickname,)
                ),
                );
              // Positioned(
              // bottom: tweenAnimation.value,
              //     // alignment: Alignment(0, tweenAnimation.value),
              // );
            },
          ),
          Container(
            child: Center(
              child: Column(
                children: [

                  SizedBox(height: size.height / 10,),
                  //自分のアイコン




                  // Expanded(child:
                  // Container(
                  //   alignment: Alignment.bottomCenter,
                  //   child:
                  //   Text("接続数: " + state.connectClientCount),
                  // )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserWidget extends StatelessWidget {
  const _UserWidget({
    
    Key? key,
    required this.size,
    required this.isMe,
    required this.icon,
    required this.nickname
  }) : super(key: key);

  final Size size;
  final bool isMe;
  final int icon;
  final String nickname;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 4,
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _userWidget(isShow: isMe),
          CircleIcon(size: size.height / 8, imagePath:
          CharacterIcons.getIcon(icon).getPath
            ,),
          _userWidget(isShow: !isMe),
        ],
      ),
    );
  }

  Opacity _userWidget({required bool isShow}) {
    return Opacity(
          opacity: !isShow ? 1 : 0,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: size.width / 50),
              child: Text(nickname)),
        );
  }
  
}
