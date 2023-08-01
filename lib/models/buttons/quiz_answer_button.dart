import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///Button that can be used to select an answer for a given quiz question
class QuizAnswerButton extends StatelessWidget {
  QuizAnswerButton({@required this.onPressed, @required this.answer});
  final GestureTapCallback onPressed;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          gradient: LinearGradient(
            colors: [Colors.orange[200], Colors.orange[500]],
          ),
        ),
        child: Text(
          answer,
          style: TextStyle(fontSize: 15.0, fontFamily: 'Helvetica'),
        ),
        padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 15.0),
      ),
      onPressed: onPressed,
    );
  }
}
