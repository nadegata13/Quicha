
import 'package:quicha/model/quiz_man.dart';

class QuizItem{
  final String item;
  final MessageType type;
  QuizItem({required this.item, required this.type});
}

class Quiz{

  final List<QuizItem> _quizItems;
  final String _quizCategory;
  final String _answer;
  final bool _isPicture;
  final bool _isSound;



  Quiz({required String answer, required List<QuizItem> quizItems, required String quizCategory, bool isPicture = false, bool isSound = false}):
        _quizItems = quizItems,
        _quizCategory = quizCategory,
        _isPicture = isPicture,
        _isSound = isSound,
        _answer = answer;


  String get answer => _answer;
  List<QuizItem> get quizItems => _quizItems;
  String get quizCategory => _quizCategory;
  bool get isPicture => _isPicture;
  bool get isSound => _isSound;

}
