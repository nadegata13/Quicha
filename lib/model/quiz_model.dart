
class Quiz{

  final String _quizText;
  final String _quizCategory;
  final String _answer;
  final bool _isPicture;
  final bool _isSound;



  Quiz({required String answer, required String quizString, required String quizCategory, bool isPicture = false, bool isSound = false}):
        _quizText = quizString,
        _quizCategory = quizCategory,
        _isPicture = isPicture,
        _isSound = isSound,
        _answer = answer;


  String get answer => _answer;
  String get quizText => _quizText;
  String get quizCategory => _quizCategory;
  bool get isPicture => _isPicture;
  bool get isSound => _isSound;

}
