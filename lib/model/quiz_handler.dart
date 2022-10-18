import 'package:quicha/model/quiz_model.dart';
import 'package:quicha/test_data.dart';

class QuizHandler {
  QuizHandler({required this.quizList});
  List<Quiz> quizList;
  int _currentQuizCount = 1;
  int quizListIndex = 0;

  void increaseQuizCount() {
    _currentQuizCount++;
  }
  int getQuizCount() {
    return _currentQuizCount;
  }
  void setQuizList(List<Quiz> quizList) {
    this.quizList = quizList;
    quizListIndex = 0;
  }
  void increaseQuizListIndex() {
    quizListIndex++;
  }

  Quiz getOneQuiz() {
    if(quizListIndex > quizList.length - 1) {
      return Quiz(quizString: "クイズがありません", quizCategory: "a", answer: "お待ちください");
    }
    return  quizList[quizListIndex];
  }

}