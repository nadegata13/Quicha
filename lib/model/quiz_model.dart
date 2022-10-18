class Quiz{

  final String _quizString;
  final String _quizCategory;
  final String _answer;
  final bool _isPicture;
  final bool _isSound;



  Quiz({required String answer, required String quizString, required String quizCategory, bool isPicture = false, bool isSound = false}):
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
