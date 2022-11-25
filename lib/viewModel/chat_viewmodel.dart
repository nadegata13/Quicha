
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
import 'package:quicha/ui/custom_style.dart';
import 'package:spring/spring.dart';

import '../model/quiz_model.dart';

final chatProvider = ChangeNotifierProvider((ref) {
  return ChatNotifier();
});

class ChatNotifier extends ChangeNotifier{

  QuizHandler _quizHandler = QuizHandler(quizList: []);
  QuizMan _quizMan = QuizMan();

  List<String> quizManMessages = [];
  List<ChatMessage> messageList= [];

  Color color = Colors.green;
  Quiz currentQuiz = Quiz(quizString: "初期値", quizCategory: "初期値",answer: "初期値");

  bool isShowTime = false;
  bool isVisibleQuiz = true;
  final CountDownController countDownController = CountDownController();
  final int duration = 120;
  int victoryCount = 0;

  void incrementVictoryCount() {
    victoryCount++;
    notifyListeners();
  }


  void startBoundAnime(AnimationController controller) {
    controller.repeat();
    notifyListeners();
  }
  void addMessageFromPartner(){
    List<ChatMessage> partnerMessage = [ChatMessage(messageContent: "こんにちは！", messanger: "partner"),
      ChatMessage(messageContent: "うーんふんどしかなあ？", messanger: "partner"),];

    int random = Random().nextInt(2);
    messageList.add(partnerMessage[random]);
    notifyListeners();

  }

  void sendMessage(TextEditingController controller){

    var message = controller.text;

    if(message.isEmpty) {return;}

    messageList.add(ChatMessage(messageContent: message, messanger: "me"));
    controller.clear();

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
    currentQuiz.quizText];
    _quizMan.setMessages(messages: quizStringList);

    notifyListeners();
  }




  void changeColor() {
    color = Color(0xFFBC0707);
    notifyListeners();
  }

  void startCountdown()  {
    color = Color(0xFF076003);
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
          // quizWidget.add(_quizMan.readMesseges());
          // print(quizWidget);
          // notifyListeners();

              if(_quizMan.isLastIndex) {
                startCountdown();
                setVisibleTime();
                notifyListeners();
                return ;}

              quizManMessages.add(_quizMan.getNewMessage());
              notifyListeners();
        });
  }

  void removeQuizWidget() async {

    isVisibleQuiz = false;
    notifyListeners();
    Future.delayed(Duration(seconds: 1),
            (){
          quizManMessages.clear();
          notifyListeners();
        }
    );
    notifyListeners();
  }

}

