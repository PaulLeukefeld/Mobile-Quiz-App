import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(
            Controller.getSize(context).width * 0.05,
            Controller.getSize(context).height * 0.0,
            Controller.getSize(context).width * 0.05,
            Controller.getSize(context).height * 0.0),
        width: Controller.getSize(context).width * 0.8,
        child: Center(
          child: Text(questionText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: questionText.length > 85 ? 17 : 20,
                  fontWeight: FontWeight.bold)),
        ));
  }
}
