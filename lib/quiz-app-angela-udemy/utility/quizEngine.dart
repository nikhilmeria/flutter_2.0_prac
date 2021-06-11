import 'package:coffee_shop_ui/quiz-app-angela-udemy/utility/quiz.dart';

class QuizEngine {
  List<Game> _quiz = [
    Game(ques: "India is in Asia Continent ?", ans: "True"),
    Game(ques: "India is a devloping country ?", ans: "False"),
    Game(ques: "India\'s PM is Mr Modi ?", ans: "True"),
  ];
  int _questionNo = 0;

  void nextQues() {
    if (_questionNo < _quiz.length - 1) {
      _questionNo++;
    } else {
      _questionNo = 0; // to reset the quiz
    }
  }

  String quizQues() {
    return _quiz[_questionNo].ques;
  }

  String quizAns() {
    return _quiz[_questionNo].ans;
  }

  int get quesNo {
    return _questionNo;
  }
}
