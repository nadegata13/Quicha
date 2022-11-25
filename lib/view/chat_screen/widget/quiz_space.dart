import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quicha/ui/custom_style.dart';
import 'package:quicha/viewModel/chat_viewmodel/chat_room_notifier.dart';
import '../../../model/quiz_model.dart';
import '../../../viewModel/chat_viewmodel.dart';
import 'animation_text.dart';
import 'chat_bubble.dart';

class QuizArea extends StatelessWidget {
  const QuizArea({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: size.height / 3,
        width: size.width,
        child:
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: size.height,
                width: size.width,
                // decoration: BoxDecoration(
                //   color: Colors.yellow,
                //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
                // ),
                // child: Lottie.network("https://assets4.lottiefiles.com/packages/lf20_f24znioj.json",fit: BoxFit.fill)
          ),
            Padding(
              padding: EdgeInsets.all(size.height / 60),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //クイズマン及びタイマー
                  Column(
                    children: [
                      Text("クイズマン",
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'Meiryo',
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurpleAccent
                        ),),
                      SizedBox(height: size.height / 100,),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey
                            ),
                            padding: EdgeInsets.all(3),
                            child:
                            _CountDownCircle(),
                          ),
                          //クイズマン
                          Container(
                            height: size.height / 14.5,
                            width: size.height / 14.5,
                            child:SvgPicture.asset("assets/images/character_icon/cat.svg"),
                          ),

                        ],
                      ),
                        SizedBox(height: size.height / 100,),
                      HookConsumer(builder: ((context, ref, _) {
                        final state = ref.watch(chatRoomProvider);

                        return Text(state.timerText,
                        style: TextStyle(
                          color: state.isDangerZone ? CustomColor.timeupColor: Colors.white,
                          fontSize: size.height / 50,
                          fontFamily: 'Dseg'
                        ),);
                      }))
                    ],
                  ),


                  FadingEdgeScrollView.fromSingleChildScrollView(
                    gradientFractionOnStart: 0.1,
                    child: SingleChildScrollView(
                        controller: ScrollController(),
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        child:
                        HookConsumer(builder: (BuildContext context, ref, Widget? child) {
                          final state = ref.watch(chatRoomProvider);
                          return
                            AnimatedOpacity(opacity:state.isVisibleQuiz ? 1 : 0 ,
                                duration: Duration(seconds: 1),

                                child:
                                Column(
                                  children: [
                                    SizedBox(height: size.height / 30,),
                                    Column(
                                        children:

                                        // value.watch(chatProvider).quizManMessages.map((e) => QuizChatBabble(message: e,)).toList().cast<Widget>(),
                                        state.quizmanMessages.asMap().entries.map((e) =>
                                            QuizChatBabble(message: e.value,isFirst: e.key == 0,)).toList().cast<Widget>()


                                    ),
                                  ],
                                )
                            );
                        },)
                    ),
                  )

                ],
              ),
            ),
          ],
        )

    );
  }
}

class QuizChatBabble extends StatelessWidget {
  QuizChatBabble({required this.message, required this.isFirst, });

  final String message;
  final bool isFirst;
  @override
  Widget build(BuildContext context) {
    return ChatBubble(
        isLeft: true,
        color: Colors.white,
//最初のメッセージなら
        showNip: isFirst,
        child: _bubbleChild(message),
    );
  }
  Widget _bubbleChild(String message) {


    int lastIndex = message.length -1;
    String filetype = message.substring(message.length <= 4 ? 0 : lastIndex - 4, lastIndex);

    if(filetype == ".png"){
      return
        Container(height: 30, width: 30, child: Text(message));

    } else if(filetype == ".mp3") {

      return
        Container(height: 30, width: 30, child: Text(message));

    } else {

      return
      Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final viewModel = ref.read(chatRoomProvider.notifier);
        return
        AnimationText(  string: message,
          onFinished: () {
            //クイズの問題文
            //最後の要素なら
             viewModel.showQuizmanNextMessage();
          },);
      },
      );
    }
  }

}





class _CountDownCircle extends HookConsumerWidget {
  const _CountDownCircle({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatRoomProvider);
    final viewModel = ref.watch(chatRoomProvider.notifier);


    return CircularCountDownTimer(
      initialDuration: 0,
      duration: state.timerValue,
      controller: ref.watch(chatRoomProvider.notifier).countDownController,
      width: MediaQuery.of(context).size.height / 14,
      height: MediaQuery.of(context).size.height / 14,
      ringColor: Color(0xFFD6DADA),
      fillColor: viewModel.countDownController.isStarted ?
          state.isTimeUp?
          CustomColor.timeupColor :  Colors.lightGreenAccent: Colors.transparent ,
      backgroundGradient: null,
      strokeWidth: MediaQuery.of(context).size.height / 200,
      strokeCap: StrokeCap.round,
      isReverse: true,
      isReverseAnimation: false,
      isTimerTextShown: false,
      autoStart: false,
      onStart: () {
        debugPrint('Countdown Started');
      },
      onComplete: () {
        debugPrint('Countdown Ended');
      },
      onChange: (String timeStamp) {
      },
    );
  }
}
