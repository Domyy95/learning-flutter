import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  Function resetHandler;

  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    String resultText = 'You did it';
    if (resultScore <= 8) {
      resultText = 'meeee';
    } else if (resultScore <= 12) {
      resultText = 'O boy, pretty cool';
    } else {
      resultText = 'So cool MY BOY';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: <Widget>[
        Text(
          'So cool MY BOY',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          child: Text("Restart Quiz!"),
          onPressed: resetHandler(),
        )
      ]),
    );
  }
}
