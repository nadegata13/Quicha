import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quicha/model/user_model.dart';
import 'package:quicha/repository/socket_client.dart';
import 'package:quicha/ui/character_icons.dart';
import 'package:quicha/ui/custom_style.dart';
import 'package:quicha/view/chat_screen/chat_screen.dart';
import 'package:quicha/view/common_widget.dart';
import 'package:quicha/view/home_screen/home_screen.dart';
import 'package:quicha/viewModel/matching_viewmodel/matching_notifier.dart';
import 'package:rive/rive.dart';

class MatchingScreen extends HookConsumerWidget {
  const MatchingScreen({
    Key? key,
  }) : super(key: key);


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
        Future.delayed(Duration(milliseconds: 1500), (){
          viewModel.showVsAnimation();

          Future.delayed(Duration(milliseconds: 3000), (){
                Navigator.pushReplacement(context,
                    MaterialPageRoute(
                      // （2） 実際に表示するページ(ウィジェット)を指定する
                        builder: (context) => ChatScreen(),

                    ));

          });
        });
      }

    });

    useEffect((){
      animationController.addListener(() {
      });
    });

    return Scaffold(


      // appBar: AppBar(
      //   title: Text(state.matchingMessage),
      //   backgroundColor: CustomColor.appBarTheme,
      //   leading: IconButton(icon: const Icon(Icons.arrow_back),
      //   onPressed: (){
      //     Navigator.pushReplacement(context,
      //         MaterialPageRoute(
      //           // （2） 実際に表示するページ(ウィジェット)を指定する
      //             builder: (context) => HomeScreen()
      //
      //         ));
      //   },),
      //
      // ),
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

          //VSアニメーション
          Align(alignment: Alignment.center,
              child: state.isShowVsAnimation ?
              SizedBox(
                height: size.height / 5,
                  child: RiveAnimation.asset('assets/rive/vsAnimation.riv'))
              : SizedBox(height: size.height / 5,)
          ),

          //戻るボタン
          Align(
            alignment: Alignment(-0.9 , -0.8),
            child: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.blueAccent,),iconSize: size.height / 30,
                onPressed:
                    //本番用
                // state.isAnimation ? null :
                    (){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(
                        // （2） 実際に表示するページ(ウィジェット)を指定する
                          builder: (context) => HomeScreen()

                      ));
                },),
          ),

          //マッチングテキスト
          Align(
            alignment: Alignment(0, -0.7),
            child: Text(state.matchingMessage, style:
            GoogleFonts.mochiyPopOne(fontSize: size.height / 50, color: Colors.black),),
          ),

          Align(
            alignment: Alignment(0,-userPosition),
            child: _UserWidget(size: size, isMe: true,
              icon: ref.read(myUserProvider).iconNum,
              nickname: ref.read(myUserProvider).nickname,
          ),),

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
          CircleIcon(size: size.height / 8, iconNum: icon
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
              padding: EdgeInsets.symmetric(horizontal: size.width / 50, vertical: size.height / 100),
              child: Text(nickname,
              //   style: TextStyle(fontFamily: 'MPlus', fontWeight: FontWeight.bold,
              // fontSize: size.height / 50 ),
                style: GoogleFonts.rocknRollOne(fontSize: size.height / 50)
              )),
        );
  }
  
}
