import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState{
  const factory HomeState({

    @Default("") String successJoinRoom,
    @Default(false) bool isClickedEntryButton,
    @Default("マッチング中………") String matchingMessage,
    @Default("0人") String connectClientCount,
  }) = _HomeState;
}


