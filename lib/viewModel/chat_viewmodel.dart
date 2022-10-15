
import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quicha/model/message.dart';
import 'package:quicha/model/quiz_handler.dart';
import 'package:quicha/screen/chat_screen.dart';
import 'package:quicha/test_data.dart';

class ChatViewModel extends ChangeNotifier{

  var chatScrollController = ScrollController();
  var txtController = TextEditingController();

  List<Widget> quizWidget = [];
  List<ChatMessage> messageList= [ChatMessage(messageContent: "a", messageType: "a")];

  Color color = Colors.blue;
  QuizHandler _quizHandler = QuizHandler(quizList: []);
  TestQuiz currentQuiz = TestQuiz(quizString: "初期値", quizCategory: "初期値",answer: "初期値");

  bool isShowTime = false;
  bool isVisibleQuiz = true;

  final CountDownController countDownController = CountDownController();
  final int duration = 120;

  void _scrollDown() {

    chatScrollController.jumpTo(chatScrollController.position.maxScrollExtent);
    notifyListeners();

  }

  void sendMessage(){

    txtController.notifyListeners();
    String message = txtController.text;
    messageList.add(ChatMessage(messageContent: message, messageType: "me"));
    _scrollDown();
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
  void increaseQuizCount() {
    //出題数
    _quizHandler.increaseQuizCount();
    //クイズオブジェクト配列のインデックス
    _quizHandler.increaseQuizListIndex();
    _setCurrentQuiz();
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
