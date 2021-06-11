import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import './utility/quizEngine.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  QuizEngine quiz1 = QuizEngine();
  List<Widget> _scoreKeeper = [];

  handleUpdate(trueOrFalseBtn) {
    print("quesNo = ${quiz1.quesNo}");
// if (quiz1.quesNo == 0) _scoreKeeper = [];
    setState(() {
      if (quiz1.quesNo <= 2) {
        trueOrFalseBtn == "True" && quiz1.quizAns() == "True"
            ? _scoreKeeper.add(
                Icon(
                  Icons.check_box_sharp,
                  color: Colors.green,
                  size: 40.0,
                ),
              )
            : trueOrFalseBtn == "True" && quiz1.quizAns() == "False"
                ? _scoreKeeper.add(
                    Icon(
                      Icons.close_rounded,
                      color: Colors.red,
                      size: 40.0,
                    ),
                  )
                : trueOrFalseBtn == "False" && quiz1.quizAns() == "False"
                    ? _scoreKeeper.add(
                        Icon(
                          Icons.check_box_sharp,
                          color: Colors.green,
                          size: 40.0,
                        ),
                      )
                    : _scoreKeeper.add(
                        Icon(
                          Icons.close_rounded,
                          color: Colors.red,
                          size: 40.0,
                        ),
                      );
        if (quiz1.quesNo == 2) {
          Alert(
            context: context,
            title: 'Finished!',
            desc: 'You\'ve reached the end of the quiz.',
          ).show();
        }
      }

      quiz1.nextQues();

      if (quiz1.quesNo == 0) {
        _scoreKeeper = [];
      }
    }); // setState()
  }

  @override
  Widget build(BuildContext context) {
    // print("quiz1.quiz.length = ${quiz1.quiz.length}");
    // print("quiz1.quesNo = ${quiz1.quesNo}");
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quiz1.quizQues(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: Text(
                'True',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                handleUpdate("True");
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                handleUpdate("False");
              },
            ),
          ),
        ),
        Row(
          children: _scoreKeeper,
        ),
      ],
    );
  }
}
