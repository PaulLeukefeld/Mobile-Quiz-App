import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/quiz_item.dart';

class AgainstTheTimeQuizTitle extends StatelessWidget {
  const AgainstTheTimeQuizTitle({this.quizItemData});

  final QuizItem quizItemData;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Gegen die Zeit",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.fromLTRB(size.width * 0.13, size.height * 0.01,
                size.width * 0.01, size.height * 0.03),
            width: size.width * 0.8,
            child: Text("Wie viele Fragen kannst du richtig beantworten?",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.normal))),
      ],
    );
  }
}
