import 'package:freezed_annotation/freezed_annotation.dart';

part 'matching_state.freezed.dart';

@freezed
class MatchingState with _$MatchingState{
  const factory MatchingState({

    @Default("") String successJoinRoom,
    @Default("") String matchingMessage,
    @Default("0人") String connectClientCount,
    @Default(true) bool isVisibleBus,
    @Default(false) bool isAnimation,
    @Default(false) bool isShowVsAnimation,
    @Default(0) int opponentIcon,
    @Default("opponent") String opponentNickname,
  }) = _MatchingState;
}


