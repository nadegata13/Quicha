import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState{
  const factory HomeState({

    @Default(false) bool isClickedEntryButton,
    @Default("assets/images/character_icon/greyForIcon.jpg") String iconPath,
    @Default("name") String nickname,
    @Default("") String lifeUpTime,
    @Default(0) int lifeCount,

  }) = _HomeState;
}


