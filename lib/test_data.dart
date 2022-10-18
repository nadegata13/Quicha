
import 'package:quicha/ui/character_icons.dart';

import 'model/quiz_model.dart';

class TestData{
  static String currentTime = "32:00";
  static String username = "タカシ";
  static int fillLifeCount = 2;
  static List<Quiz> quizObject = [Quiz(quizString: "大相撲で関取衆が土俵入りする際に着用する、金銀の刺繍などを施した前垂れが付いた儀式用のまわしを何というでしょう？", quizCategory: "a", answer: "化粧まわし"),
    Quiz(quizString: "オーストラリアの先住民のことを「アボリジニ」といいますが、ニュージーランドの先住民のことを何というでしょう？", quizCategory: "あ",answer: "マオリ"),
    Quiz(quizString: "ボウリングで、フレームの1投目にヘッドピンが倒れ、残りの2本以上のピンが隣接しない状態で残ることを何というでしょう？", quizCategory: "あ",answer: "スプリット")
  ];
  static var user1 = User(nickname: "たかし", icon: CharacterIcons.default_human);
  static var user2 = User(nickname: "魔法戦士よしだだだだだだ", icon: CharacterIcons.default_wolf);

  static var profileImage = "assets/images/character_icon/bird.svg";
}

class User{
  final String _nickname;
  final CharacterIcons _icon;

  User({required String nickname, required CharacterIcons icon }):
    _nickname = nickname,
    _icon = icon;

  CharacterIcons get icon => _icon;
  String get nickname => _nickname;


}





