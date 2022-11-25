import 'dart:async';
import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicha/viewModel/chat_viewmodel/chat_room_state.dart';

import '../../model/message.dart';
import '../../model/quiz_handler.dart';
import '../../model/quiz_man.dart';
import '../../model/quiz_model.dart';
import '../../test_data.dart';

final chatRoomProvider = StateNotifierProvider.autoDispose<ChatRoomNotifier, ChatRoomState>(
    ((ref) => ChatRoomNotifier())
);


class ChatRoomNotifier extends StateNotifier<ChatRoomState> {

  late QuizHandler _quizHandler;
  late QuizMan _quizMan;
  late Quiz currentQuiz;


  var countDownController = CountDownController();

  ChatRoomNotifier() : super (const ChatRoomState()){
    //取得クイズ全体のハンドリング
    _quizHandler = QuizHandler(quizList: []);
    //出題AI
    _quizMan = QuizMan();
    //出題クイズ
    currentQuiz = Quiz(quizString: "初期値", quizCategory: "初期値",answer: "初期値");

  }


  void incrementVictoryCount() async {
    state = state.copyWith(victoryCount: state.victoryCount + 1);
  }

  void startBoundAnime(AnimationController controller) {
    controller.repeat();
  }

  void addMessageFromPartner(){
    List<ChatMessage> partnerMessage = [ChatMessage(messageContent: "こんにちは！", messanger: "partner"),
      ChatMessage(messageContent: "うーんふんどしかなあ？", messanger: "partner"),];

    int random = Random().nextInt(2);
    //実験 不変クラスだから反映されない可能性
    List<ChatMessage> messages = [...state.chatMessages];
    messages.add(partnerMessage[random]);
    state = state.copyWith(chatMessages: messages);
  }

  void sendMessage(TextEditingController controller){

    var message = controller.text;

    if(message.isEmpty) {return;}

    var messages = [...state.chatMessages];
    messages.add(ChatMessage(messageContent: message, messanger: "me"));
    state = state.copyWith(chatMessages: messages);
    //消去
    controller.clear();

  }


  //For Test
  //チャットメッセージを全消去
  void clearChat() {
    state.chatMessages.clear();
  }

  //次のクイズをセット
  void incQuizCount() {
    //出題数＋1;
    _quizHandler.increaseQuizCount();
    //次のクイズへ
    _quizHandler.increaseQuizListIndex();

    //次のクイズをセット
    _setNextQuiz();
    //クイズマンのメッセージをクリア
    removeQuizmanMessage();
    //カウントダウンをリセット
    _resetCountDown();
    //時間制限を非表示
    _setInVisibleTime();
  }

  void setQuizList() {
    _quizHandler.setQuizList(TestData.quizObject);
    _setNextQuiz();
  }




  //getQuizWidget
  void showQuizmanNextMessage() async {
    //クイズを可視化
    state = state.copyWith(isVisibleQuiz: true);

    //1秒あける
    Future.delayed(Duration(seconds: 1),
            (){

          if(_quizMan.isLastIndex) {
            _startCountdown();
            _setVisibleTime();
            print(state.isShowTime.toString());
            return ;
          }
          //不変クラスのリストが参照されてしまうため、この書き方
          List<String> quizmanMessages = [...state.quizmanMessages];
          quizmanMessages.add(_quizMan.getNewMessage());

          state = state.copyWith(quizmanMessages: quizmanMessages);
        });
  }
  
  void removeQuizmanMessage() async {

    state = state.copyWith(isVisibleQuiz: false);
    
    Future.delayed(Duration(seconds: 1),
            (){
          state = state.copyWith(quizmanMessages: []);
        }
    );
  }

  //時間制限表示
  void _setVisibleTime() {
    state = state.copyWith(isShowTime: true);
  }
  void _setInVisibleTime() {
    state = state.copyWith(isShowTime: false);
  }

  void _setNextQuiz() {
    currentQuiz = _quizHandler.getOneQuiz();
    //FIXME:
    String quizCount = _quizHandler.getQuizCount().toString();

    List<String> quizStringList = ["第" + quizCount + "問", currentQuiz.quizText];
    _quizMan.setMessages(messages: quizStringList);
  }


  void _startCountdown()  {
    countDownController.start();
    _getCountTimer();


  }
  void _resetCountDown(){
    countDownController.reset();
    state = state.copyWith(timerText: "",isDangerZone: false, isTimeUp: false);
  }


  String _convertToTime(int timer) {
    String minute = (timer ~/ 60).toString();
    String second = (timer % 60).toString();
    if(int.parse(second) < 10){
      second = "0$second";
    }
    String conevertedTime = "$minute : $second";

    return conevertedTime;
  }


  void _getCountTimer(){

    //初期制限時間
    state = state.copyWith(timerText:_convertToTime(state.timerValue) );
    Timer.periodic(Duration(seconds: 1), (timer) {
      int countTimer = state.timerValue - timer.tick;
      state = state.copyWith(timerText: _convertToTime(countTimer));
      
      if(countTimer <= 10) {
        state = state.copyWith(isDangerZone: true);
        if(countTimer == 0) {
          state = state.copyWith(isTimeUp: true);
          timer.cancel();
        }
      }
    });

  }
}