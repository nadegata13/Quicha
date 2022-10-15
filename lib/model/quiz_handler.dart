import 'package:quicha/test_data.dart';

class QuizHandler {
  QuizHandler({required this.quizList});
  List<TestQuiz> quizList;
  int currentQuizCount = 1;
  int quizListIndex = 0;

  void increaseQuizCount() {
    currentQuizCount++;
  }
  int getQuizCount() {
    return currentQuizCount;
  }
  void setQuizList(List<TestQuiz> quizList) {
    this.quizList = quizList;
    quizListIndex = 0;
  }
  void increaseQuizListIndex() {
    quizListIndex++;
  }

  TestQuiz getOneQuiz() {
    if(quizListIndex > quizList.length - 1) {
      return TestQuiz(quizString: "クイズがありません", quizCategory: "a", answer: "お待ちください");
    }
    return  quizList[quizListIndex];
  }

}