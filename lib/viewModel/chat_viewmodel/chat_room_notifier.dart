import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicha/model/user_model.dart';
import 'package:quicha/viewModel/chat_viewmodel/chat_room_state.dart';

import '../../model/message.dart';
import '../../model/quiz_handler.dart';
import '../../model/quiz_man.dart';
import '../../model/quiz_model.dart';
import '../../repository/socket_client.dart';
import '../../test_data.dart';

final chatRoomProvider =
    StateNotifierProvider.autoDispose<ChatRoomNotifier, ChatRoomState>(((ref) {
  ref.onDispose(() {
    print("disposed chatRoomProvider");
  });
  return ChatRoomNotifier(ref);
}));

class ChatRoomNotifier extends StateNotifier<ChatRoomState> {
  late QuizHandler _quizHandler;
  late QuizMan _quizMan;
  late Quiz currentQuiz;

  var countDownController = CountDownController();

  final _socketClient = SocketClient.instance.socket!;

  final StateNotifierProviderRef ref;

  ChatRoomNotifier(this.ref) : super(const ChatRoomState()) {
    //取得クイズ全体のハンドリング
    _quizHandler = QuizHandler(quizList: []);
    //出題AI
    _quizMan = QuizMan();
    //出題クイズ
    currentQuiz = Quiz(
        quizID: "annonymous",
        quizItems: [QuizItem(item: "初期値", type: MessageType.text)],
        quizCategory: "初期値",
        answer: "初期値");

    //リスナーを削除
    _socketClient.clearListeners();

    //レシーブイベント
    _receivedEvent();

    //最初の挨拶
    _quizmanGreet();
    showQuizmanNextMessage();

    //クイズを取得
    if (RoleLeader.getIsLeader()) {
      fetchQuiz();
    }

    //クイズを出題
    // _startFirstQuiz();
  }

  void _receivedEvent() {
    _socketClient.on("receiveMessage", (data) {
      String receivedMessage = data["receivedMessage"];
      String userID = data["userID"];

      var messages = [...state.chatMessages];
      messages.add(
        ChatMessage(messageContent: receivedMessage, messangerID: userID),
      );
      state = state.copyWith(chatMessages: messages);

      if (RoleLeader.getIsLeader() &&
          currentQuiz.answer == data["receivedMessage"]) {
        print("正解");
        _socketClient.emit(
            "correctAnswer",
            ({
              "quizAnswer": currentQuiz.answer,
              "answerUserID": userID,
            }));
      }
    });

    _socketClient.on("receiveQuiz", (data) {
      List<dynamic> quizes = data;
      List<Quiz> fetchecQuizes = [];
      try {
        quizes.forEach((quiz) {
          List<dynamic> materialQuizItems = quiz["quizItems"];
          List<QuizItem> quizItems = [];

          //問題です。
          quizItems.add(QuizItem(item: "問題です", type: MessageType.text));

          //問題文を取得
          materialQuizItems.forEach((element) {
            MessageType type = MessageType.getType(element["type"]);
            quizItems.add(QuizItem(item: element["item"], type: type));
          });

          var newQuiz = Quiz(
              answer: quiz["answer"],
              quizItems: quizItems,
              quizCategory: quiz["category"],
              quizID: quiz["quizID"]);

          fetchecQuizes.add(newQuiz);

          _quizHandler.setQuizList(fetchecQuizes);
        });
        print(fetchecQuizes);
      } catch (e) {
        print("error:${e}");
      }
      print("receiveQuiz");
    });

    _socketClient.on("startQuiz", (data) {
      removeQuizmanMessage();
      _setNextQuiz();
      Future.delayed(Duration(seconds: 2), () {
        showQuizmanNextMessage();
      });
    });

    _socketClient.on("startNextQuiz", (data) {
      removeQuizmanMessage();
      incQuizCount();
      _setNextQuiz();
      Future.delayed(Duration(seconds: 2), () {
        showQuizmanNextMessage();
      });
    });
  }

  void leaveChatRoom() {
    _socketClient.emit('leaveChatRoom');
  }

  void moveToNextQuiz() {
    _socketClient.emit('moveToNextQuiz');

    if (_quizHandler.quizListIndex >= _quizHandler.quizList.length - 1) {
      fetchQuiz();
    }
  }

  void showQuizAnswer() {
    final answer = currentQuiz.answer;
    _socketClient.emit('showQuizAnswer', answer);
  }

  void _quizmanGreet() {
    String _myName = ref.read(myUserProvider).nickname;
    String _opponentName = ref.read(opponentUserProvider).nickname;

    _quizMan.setMessages(messages: [
      QuizManMessage(
          message: "ようこそ${_myName}さん、${_opponentName}さん！",
          type: MessageType.text),
      QuizManMessage(
          message: "俺の名前はクイズマン！好きな言葉は「飲まず食わずでクイズ」!楽しんでってくれよな!",
          type: MessageType.text),
    ]);
  }

  // void _startFirstQuiz() async {
  //   if (!RoleLeader.getIsLeader()) {
  //     return;
  //   }
  //   Future.delayed(Duration(seconds: 30), () {
  //     _socketClient.emit("startQuiz");
  //   });
  // }

  //クイズ取得
  void fetchQuiz() {
    _socketClient.emit("requestQuizes");
  }

  void incrementVictoryCount() async {
    state = state.copyWith(victoryCount: state.victoryCount + 1);
  }

  void startBoundAnime(AnimationController controller) {
    controller.repeat();
  }

  void sendMessage(TextEditingController controller) {
    var message = controller.text;

    if (message.isEmpty) {
      return;
    }

    _socketClient.emit("sendMessage", {
      "sendUserID": FirebaseAuth.instance.currentUser!.uid,
      "sendMessage": message,
    });

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
    Future.delayed(Duration(seconds: 1), () {
      if (_quizMan.isLastIndex) {
        // _startCountdown();
        // _setVisibleTime();
        print(state.isShowTime.toString());
        return;
      }

      List<QuizManMessage> quizmanMessages = [...state.quizmanMessages];
      quizmanMessages.add(_quizMan.getNewMessage());

      state = state.copyWith(quizmanMessages: quizmanMessages);
    });
  }

  void removeQuizmanMessage() async {
    state = state.copyWith(isVisibleQuiz: false);

    Future.delayed(Duration(seconds: 1), () {
      state = state.copyWith(quizmanMessages: []);
    });
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

    //現在のクイズからメッセージアイテムリストを取り出す。
    List<QuizManMessage> quizManMessages = currentQuiz.quizItems
        .asMap()
        .entries
        .map((item) =>
            QuizManMessage(message: item.value.item, type: item.value.type))
        .toList()
        .cast<QuizManMessage>();

    _quizMan.setMessages(messages: quizManMessages);
  }

  void _startCountdown() {
    countDownController.start();
    _getCountTimer();
  }

  void _resetCountDown() {
    countDownController.reset();
    state = state.copyWith(timerText: "", isDangerZone: false, isTimeUp: false);
  }

  String _convertToTime(int timer) {
    String minute = (timer ~/ 60).toString();
    String second = (timer % 60).toString();
    if (int.parse(second) < 10) {
      second = "0$second";
    }
    String conevertedTime = "$minute : $second";

    return conevertedTime;
  }

  void requestQuizAnswer() {
    _socketClient.emit("sendMessage", {
      "sendUserID": FirebaseAuth.instance.currentUser!.uid,
      "sendMessage": "QUIZ_ANSWER_58932eDsa3",
    });
  }

  void requestNextQuiz() {
    _socketClient.emit("sendMessage", {
      "sendUserID": FirebaseAuth.instance.currentUser!.uid,
      "sendMessage": "NEXT_QUIZ_9A4B38S38s48A",
    });
  }

  void _getCountTimer() {
    //初期制限時間
    state = state.copyWith(timerText: _convertToTime(state.timerValue));
    Timer.periodic(Duration(seconds: 1), (timer) {
      int countTimer = state.timerValue - timer.tick;
      state = state.copyWith(timerText: _convertToTime(countTimer));

      if (countTimer <= 10) {
        state = state.copyWith(isDangerZone: true);
        if (countTimer == 0) {
          state = state.copyWith(isTimeUp: true);
          timer.cancel();
        }
      }
    });
  }
}
