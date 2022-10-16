import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../../viewModel/chat_viewmodel.dart';

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
        padding: EdgeInsets.all(size.height / 50),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5, strokeAlign: StrokeAlign.inside)),
            color: Colors.yellow
        ),
        child:
        Row(
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
                    _CountDownCircle(),
                    //クイズマン
                    Container(
                      height: size.height / 15,
                      width: size.height / 15,
                      child:SvgPicture.asset("assets/images/character_icon/cat.svg"),
                    ),

                  ],
                ),
              ],
            ),


            Scrollbar(

                child:
                SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    reverse: true,
                    child:
                    Consumer(builder: (BuildContext context, value, Widget? child) {
                      return
                        AnimatedOpacity(opacity:value.watch(chatProvider).isVisibleQuiz ? 1 : 0 ,
                            duration: Duration(seconds: 1),

                            child:
                            Column(
                              children: [
                                SizedBox(height: size.height / 30,),
                                Column(
                                    children: value.watch(chatProvider).quizWidget
                                ),
                              ],
                            )
                        );
                    },)
                )
            )

          ],
        )

    );
  }
}

class _CountDownCircle extends ConsumerWidget {
  const _CountDownCircle({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return CircularCountDownTimer(
      initialDuration: 0,
      duration: ref.read(chatProvider).duration,
      controller: ref.watch(chatProvider).countDownController,
      width: MediaQuery.of(context).size.height / 14,
      height: MediaQuery.of(context).size.height / 14,
      ringColor: Colors.grey[300]!,
      fillColor: ref.watch(chatProvider).countDownController.isStarted ?  ref.watch(chatProvider).color : Colors.transparent ,
      backgroundGradient: null,
      strokeWidth: MediaQuery.of(context).size.height / 200,
      strokeCap: StrokeCap.round,
      isReverse: true,
      isReverseAnimation: false,
      isTimerTextShown: ref.watch(chatProvider).isShowTime,
      autoStart: false,
      onStart: () {
        debugPrint('Countdown Started');
      },
      onComplete: () {
        debugPrint('Countdown Ended');
        ref.read(chatProvider).changeColor();
      },
      onChange: (String timeStamp) {
      },
    );
  }
}
