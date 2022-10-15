import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bubble/bubble.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quicha/test_data.dart';
import 'package:quicha/ui/custom_style.dart';
import 'package:quicha/viewModel/chat_viewmodel.dart';
import 'package:spring_button/spring_button.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return
      ChangeNotifierProvider<ChatViewModel>(
          create: (context) => ChatViewModel(),
          child:

              //画面をタップでキーボドを閉じる
          GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: _Body(size: size)
          )

      );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {

    final ChatViewModel viewModel = Provider.of<ChatViewModel>(context);
    var topHeight = MediaQuery.of(context).padding.top + kToolbarHeight;

    return Scaffold(
        appBar: AppBar(),
        // backgroundColor: CustomColor.thinBlue,
        backgroundColor: Colors.white,


        body:
        SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            scrollDirection: Axis.vertical,
            child:
            Container(
                height: size.height - topHeight,
                child:
                Column(
                  children: [
                    //出題スペース
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
                                    CountDownCircle(),
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
                                    AnimatedOpacity(opacity:viewModel.isVisibleQuiz ? 1 : 0 ,
                                        duration: Duration(seconds: 1),

                                        child:
                                        Column(
                                          children: [
                                            SizedBox(height: size.height / 30,),
                                            Column(
                                                children: viewModel.quizWidget
                                            ),
                                          ],
                                        )
                                    )
                                )
                            )

                          ],
                        )

                    ),


                    Container(
                      height: size.height / 30,
                      child:
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Expanded(child:
                          ElevatedButton(onPressed: (){
                            viewModel.getQuizWidget(ChatBubble(
                              child: AnimationText(  string: "第" + viewModel.getQuizCount().toString() + "問",
                                onFinished: () {
                                  //クイズの問題文
                                  viewModel.getQuizWidget(
                                      ChatBubble(
                                          child:
                                          AnimationText(string: viewModel.currentQuiz.quizString,
                                            onFinished: (){
                                              //画像か音声クイズなら
                                              if(viewModel.currentQuiz.isPicture! || viewModel.currentQuiz.isSound!) {

                                              } else {
                                                //クイズカウントダウン
                                                viewModel.startCountdown();
                                                viewModel.setVisibleTime();
                                              }

                                            },)) );
                                },),));
                          }, child:
                          Text("Start"),
                          ),
                            flex: 1,
                          ),

                          Expanded(child:
                          ElevatedButton(onPressed: (){
                            viewModel.removeQuizWidget();
                            viewModel.resetCountDown();
                            viewModel.setInVisibleTime();
                          }, child:
                          Text("Clear"),
                          ),
                            flex: 1,
                          ),
                          Expanded(child:
                          ElevatedButton(onPressed: (){
                            viewModel.increaseQuizCount();

                          }, child:
                          Text("Next"),
                          ),
                            flex: 1,
                          ),
                          Expanded(
                            child:
                            ElevatedButton(onPressed: (){
                              viewModel.setQuizList();

                            }, child:
                            Text("Set"),
                            ),
                            flex: 1,
                          ),

                        ],),

                    ),

                    Expanded(child:
                    Container(
                        width: size.width,
                        height: size.height,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/background/first_background.png"),
                            fit: BoxFit.fill
                          )

                        ),
                        child:
                        ListView.builder(
                            itemCount: viewModel.messageList.length,
                            shrinkWrap: true,
                            controller: viewModel.chatScrollController,
                            itemBuilder: (context, index) {
                              return ChatBubble(child: Text(
                                  viewModel.messageList[index].messageContent));
                            }),
                    ),
                    ),


                    _InputTextField(size: size),
                  ],
                )
            )
        )
    );
  }
}

class _InputTextField extends StatelessWidget {
  const _InputTextField({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {

    var bottomSpace = MediaQuery.of(context).viewInsets.bottom;
    final ChatViewModel viewModel = Provider.of<ChatViewModel>(context);

    return Padding(
      //キーボード出現時に上に上がる
        padding: EdgeInsets.only(bottom: bottomSpace),
        child:
        Column(
          children: [
            //選択された画像

            Container(
              width: size.width,
              padding: EdgeInsets.only(left: size.width / 30, right:  size.width / 30, top: size.height / 100, bottom:  size.height / 30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey, width: 0.3)),
                color: Colors.white,
              ),
              child:

                  Row(
                    children: [
                      Icon(Icons.add),
                      Expanded(child:
                      Container(
                        decoration: BoxDecoration(color: Color(0xFFf4f9f6),
                            border: Border.all(width: 0.2, color: Colors.grey),
                            borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: size.width / 60),
                        margin: EdgeInsets.symmetric(horizontal: size.width / 50),
                        child:
                        TextField(
                          controller: viewModel.txtController,
                          minLines: 1,
                          maxLines: 3,

                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: size.width / 50),
                            border: InputBorder.none,
                            hintText: "何してる？" ,
                            hintStyle: TextStyle(color: Color(0xFFdee1e2), fontSize: size.height / 50),
                          ),

                        ),
                      ),
                      ),
                      SpringButton(SpringButtonType.OnlyScale,
                          Icon(Icons.send,color: Colors.blue,),
                        onTap: () {
                        viewModel.sendMessage();
                        },
                      )

                    ],
                  )
            ),

          ],
        )
    );
  }
}

class CountDownCircle extends StatelessWidget {
  const CountDownCircle({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {

    final ChatViewModel viewModel = Provider.of<ChatViewModel>(context);

    return CircularCountDownTimer(
      initialDuration: 0,
      duration: viewModel.duration,
      controller: viewModel.countDownController,
      width: MediaQuery.of(context).size.height / 14,
      height: MediaQuery.of(context).size.height / 14,
      ringColor: Colors.grey[300]!,
      fillColor: viewModel.countDownController.isStarted ?  viewModel.color : Colors.transparent ,
      backgroundGradient: null,
      strokeWidth: MediaQuery.of(context).size.height / 200,
      strokeCap: StrokeCap.round,
      isReverse: true,
      isReverseAnimation: false,
      isTimerTextShown: viewModel.isShowTime,
      autoStart: false,
      onStart: () {
        debugPrint('Countdown Started');
      },
      onComplete: () {
        debugPrint('Countdown Ended');
        viewModel.changeColor();
      },
      onChange: (String timeStamp) {
      },
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return
      Container(
        width:  size.width - size.width / 4,
        child:
        Bubble(
            alignment: Alignment.topLeft,
            nip: BubbleNip.leftTop,
            color:  Colors.white,
            borderWidth: 0.1,
            borderColor: Colors.grey,
            elevation: 0,

            margin:  BubbleEdges.only(left: size.width / 50, top: 8, bottom: 8),
            padding:  BubbleEdges.symmetric(horizontal: size.height / 50, vertical: size.height / 80),
            nipRadius: 1,
            showNip: true,
            nipHeight: 7,
            nipWidth: 10,
            nipOffset: 10,
            radius: Radius.circular(30),
            child: child
        ),
      );
  }
}

class AnimationText extends StatelessWidget {
  const AnimationText({
    Key? key,
    required this.string,
    required this.onFinished
  }) : super(key: key);

  final String string;
  final VoidCallback onFinished;

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Container(
      child: DefaultTextStyle(
        style:  TextStyle(
            fontSize: size.height / 50,
            fontFamily: 'NotoSans',
            color: Colors.black
        ),
        child: AnimatedTextKit(isRepeatingAnimation: false,
            totalRepeatCount: 0,
            onFinished: onFinished,
            animatedTexts: [
              TyperAnimatedText(string,
                  speed: Duration(milliseconds: 200)),
            ]),
      ),
    );
  }
}



