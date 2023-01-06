import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState{
  const factory HomeState({

    @Default(false) bool isClickedEntryButton,
    @Default(0) int icon,
    @Default("name") String nickname,
    @Default("") String lifeUpTime,
    @Default(0) int lifeCount,

  }) = _HomeState;
}


