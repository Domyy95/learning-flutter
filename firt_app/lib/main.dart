import 'package:firt_app/quiz.dart';
import 'package:firt_app/result.dart';
import 'package:flutter/material.dart';

//void main() {
//  runApp(MyApp());
//}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var questions = const [
    {
      'questionText': 'How much are stupid at Vulcano?',
      'answers': [
        {'text': 'a lot', 'score': 10},
        {'text': 'a lot lof', 'score': 5},
        {'text': 'PNDV6', 'score': 100}
      ]
    },
    {
      'questionText': 'Why are you so cool?',
      'answers': [
        {'text': 'dunno man', 'score': 10},
        {'text': 'socio you know', 'score': 30},
        {'text': 'PNDV6', 'score': 100}
      ]
    },
    {
      'questionText': 'Martina where are you',
      'answers': [
        {'text': 'sleeping', 'score': 10},
        {'text': 'Sleeping', 'score': 15},
        {'text': 'PNDV6', 'score': 100}
      ]
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("My first App"),
      ),
      body: (_questionIndex < questions.length)
          ? Quiz(
              answerQuestion: _answerQuestion,
              questions: questions,
              questionIndex: _questionIndex,
            )
          : Result(_totalScore, _resetQuiz),
    ));
  }
}
