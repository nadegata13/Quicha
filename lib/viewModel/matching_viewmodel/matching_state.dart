import 'package:freezed_annotation/freezed_annotation.dart';

part 'matching_state.freezed.dart';

@freezed
class MatchingState with _$MatchingState{
  const factory MatchingState({

    @Default("") String successJoinRoom,
    @Default("マッチング中………") String matchingMessage,
    @Default("0人") String connectClientCount,
  }) = _MatchingState;
}


