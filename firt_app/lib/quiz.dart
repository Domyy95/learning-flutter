import 'package:flutter/material.dart';
import 'question.dart';
import 'answer.dart';

class Quiz extends StatelessWidget {
  final int questionIndex;
  final List<Map<String, Object>> questions;
  final Function answerQuestion;

  const Quiz(
      {required this.questions,
      required this.answerQuestion,
      required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          questions.elementAt(questionIndex)['questionText'].toString(),
        ),
        ...(questions.elementAt(questionIndex)['answers']
                as List<Map<String, Object>>)
            .map((answer) {
          return Answer(
              () => answerQuestion(answer['score']), answer['text'].toString());
        }).toList()
      ],
    );
  }
}
