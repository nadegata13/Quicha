
import 'dart:async';
import 'dart:math';

import 'package:bubble/bubble.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quicha/model/message.dart';
import 'package:quicha/model/quiz_handler.dart';
import 'package:quicha/view/chat_screen/chat_screen.dart';
import 'package:quicha/test_data.dart';

class ChatViewModel extends ChangeNotifier{

  var chatScrollController = ScrollController();
  var txtController = TextEditingController();

  List<Widget> quizWidget = [];
  List<ChatMessage> messageList= [];

  Color color = Colors.blue;
  QuizHandler _quizHandler = QuizHandler(quizList: []);
  TestQuiz currentQuiz = TestQuiz(quizString: "初期値", quizCategory: "初期値",answer: "初期値");

  bool isShowTime = false;
  bool isVisibleQuiz = true;

  final CountDownController countDownController = CountDownController();
  final int duration = 120;
  int victoryCount = 0;


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

    String message = txtController.text;
    if(message.isEmpty) {return;}

    messageList.add(ChatMessage(messageContent: message, messageType: "me"));
    txtController.clear();

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


  void getQuizWidget(Widget widget) async {
    isVisibleQuiz = true;
    //2秒あける
    Future.delayed(Duration(seconds: 1),
        (){
          quizWidget.add(widget);
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
