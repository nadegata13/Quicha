
import 'package:quicha/model/quiz_man.dart';

class QuizItem{
  final String item;
  final MessageType type;
  QuizItem({required this.item, required this.type});
}

class Quiz{

  final List<QuizItem> _quizItems;
  final String _quizID;
  final String _quizCategory;
  final String _answer;



  Quiz({required String quizID, required String answer, required List<QuizItem> quizItems, required String quizCategory,}):
      _quizID = quizID,
        _quizItems = quizItems,
        _quizCategory = quizCategory,
        _answer = answer;


  String get answer => _answer;
  List<QuizItem> get quizItems => _quizItems;
  String get quizCategory => _quizCategory;

}
