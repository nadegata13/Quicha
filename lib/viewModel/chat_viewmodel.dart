
import 'dart:async';
import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicha/model/message.dart';
import 'package:quicha/model/quiz_handler.dart';
import 'package:quicha/model/quiz_man.dart';
import 'package:quicha/test_data.dart';
import 'package:spring/spring.dart';

import '../model/quiz_model.dart';

final chatProvider = ChangeNotifierProvider((ref) {
  return ChatNotifier();
});

class ChatNotifier extends ChangeNotifier{
  ChatNotifier(){
    _quizMan= QuizMan(viewModel: this);
  }

  QuizHandler _quizHandler = QuizHandler(quizList: []);
  late QuizMan _quizMan ;

  var chatScrollController = ScrollController();
  var messageController = TextEditingController();
  final myAnimeController = SpringController();
  final partnerAnimeController = SpringController();

  List<Widget> quizWidget = [];
  List<ChatMessage> messageList= [];

  Color color = Colors.blue;
  Quiz currentQuiz = Quiz(quizString: "初期値", quizCategory: "初期値",answer: "初期値");

  bool isShowTime = false;
  bool isVisibleQuiz = true;

  final CountDownController countDownController = CountDownController();
  final int duration = 120;
  int victoryCount = 0;

  void startWinEffect( SpringController controller) {
    controller.play(motion: Motion.reverse, animDuration: Duration(milliseconds: 2000),);
    notifyListeners();
  }

  void incrementVictoryCount() {
    victoryCount++;
    notifyListeners();
  }

  void scrollDown() {

    // chatScrollController.jumpTo(chatScrollController.position.maxScrollExtent);
    notifyListeners();

  }
  void addMessageFromPartner(){
    List<ChatMessage> partnerMessage = [ChatMessage(messageContent: "こんにちは！", messageType: "partner"),
      ChatMessage(messageContent: "うーんふんどしかなあ？", messageType: "partner"),];

    int random = Random().nextInt(2);
    messageList.add(partnerMessage[random]);
    notifyListeners();

  }

  void sendMessage(){

    String message = messageController.text;
    if(message.isEmpty) {return;}

    messageList.add(ChatMessage(messageContent: message, messageType: "me"));
    messageController.clear();

    notifyListeners();
  }

  void setVisibleTime() {
    isShowTime = true;
    notifyListeners();
  }
  void setInVisibleTime() {
    isShowTime = false;
    notifyListeners();
  }
  void clearChat() {
    messageList.clear();
    notifyListeners();
  }

  void increaseQuizCount() {
    //出題数
    _quizHandler.increaseQuizCount();
    //クイズオブジェクト配列のインデックス
    _quizHandler.increaseQuizListIndex();
    _setCurrentQuiz();
    removeQuizWidget();
    resetCountDown();
    setInVisibleTime();

    notifyListeners();
  }


  int getQuizCount() => _quizHandler.getQuizCount();

  void setQuizList() {
    _quizHandler.setQuizList(TestData.quizObject);
    _setCurrentQuiz();
    notifyListeners();
  }
  void _setCurrentQuiz() {
    currentQuiz = _quizHandler.getOneQuiz();
    //FIXME:
    List<String> quizStringList = ["第" + getQuizCount().toString() + "問",
    currentQuiz.quizString];
    _quizMan.setMessages(messages: quizStringList);

    notifyListeners();
  }




  void changeColor() {
    color = Colors.red;
    notifyListeners();
  }

  void startCountdown()  {
    color = Colors.blue;
    countDownController.start();
    notifyListeners();
  }
  void resetCountDown(){
    countDownController.reset();
    notifyListeners();
  }


  void getQuizWidget() async {
    isVisibleQuiz = true;
    //2秒あける
    Future.delayed(Duration(seconds: 1),
            (){
          quizWidget.add(_quizMan.readMesseges());
          print(quizWidget);
          notifyListeners();
        });
  }

  void removeQuizWidget() async {

    isVisibleQuiz = false;
    notifyListeners();
    Future.delayed(Duration(seconds: 1),
            (){
          quizWidget.clear();
          notifyListeners();
        }
    );
    notifyListeners();
  }

}

class _AvatarAnimation{
  _AvatarAnimation({required this.resized, required this.height}){
  }

  var resized;
  var height;

}
