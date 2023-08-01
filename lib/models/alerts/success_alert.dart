import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/buttons/ok_button.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class SuccesssAlert extends StatelessWidget {
  final String alertText;

  SuccesssAlert({@required this.alertText});

  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: Controller.getSize(context).width * 0.005),
      content: Container(
        height: Controller.getHeight(context) * 0.25,
        width: Controller.getSize(context).width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Abgeschlossen',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: Controller.getHeight(context) * 0.01),
            Text(
              alertText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(height: Controller.getHeight(context) * 0.02),
            OkButton(onPressed: () => Navigator.pop(context))
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
    );
  }
}
