import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class DoneButton extends StatelessWidget {
  DoneButton({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Controller.getSize(context).width * 0.7,
      height: Controller.getHeight(context) * 0.08,
      child: CupertinoButton(
        onPressed: onPressed,
        color: Color.fromRGBO(10, 122, 255, 1),
        borderRadius: new BorderRadius.circular(10.0),
        child: new Text(
          "Fertig",
          textAlign: TextAlign.center,
          style: new TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
