import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class StartQuizButton extends StatelessWidget {
  StartQuizButton({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Controller.getSize(context).width * 0.7,
      height: Controller.getHeight(context) * 0.08,
      child: CupertinoButton(
          color: Color.fromRGBO(10, 122, 255, 1),
          child: Text(
            "Quiz starten",
            style: new TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          onPressed: onPressed),
    );
  }
}
