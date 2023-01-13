import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quicha/model/quiz_man.dart';
import '../../model/message.dart';

part 'chat_room_state.freezed.dart';

@freezed
class ChatRoomState with _$ChatRoomState{
  const factory ChatRoomState({

    @Default(0) int victoryCount,
    @Default(120) timerValue,
    @Default("") String timerText,

    @Default(false) bool isShowTime,
    @Default(true) bool isVisibleQuiz,
    @Default(false) bool isDangerZone,
    @Default(false) bool isTimeUp,

    @Default([]) List<QuizManMessage> quizmanMessages,
    @Default([]) List<ChatMessage> chatMessages,
}) = _ChatRoomState;
}


