
class TestData{
  static String currentTime = "32:00";
  static String username = "タカシ";
  static int fillLifeCount = 2;
  static List<TestQuiz> quizObject = [TestQuiz(quizString: "大相撲で関取衆が土俵入りする際に着用する、金銀の刺繍などを施した前垂れが付いた儀式用のまわしを何というでしょう？", quizCategory: "a", answer: "化粧まわし"),
    TestQuiz(quizString: "オーストラリアの先住民のことを「アボリジニ」といいますが、ニュージーランドの先住民のことを何というでしょう？", quizCategory: "あ",answer: "マオリ"),
    TestQuiz(quizString: "ボウリングで、フレームの1投目にヘッドピンが倒れ、残りの2本以上のピンが隣接しない状態で残ることを何というでしょう？", quizCategory: "あ",answer: "スプリット")
  ];
}


class TestQuiz{

  final String _quizString;
  final String _quizCategory;
  final String _answer;
  final bool _isPicture;
  final bool _isSound;



  TestQuiz({required String answer, required String quizString, required String quizCategory, bool isPicture = false, bool isSound = false}):
  _quizString = quizString,
  _quizCategory = quizCategory,
  _isPicture = isPicture,
  _isSound = isSound,
  _answer = answer;


  String get answer => _answer;
  String get quizString => _quizString;
  String get quizCategory => _quizCategory;
  bool get isPicture => _isPicture;
  bool get isSound => _isSound;

}

