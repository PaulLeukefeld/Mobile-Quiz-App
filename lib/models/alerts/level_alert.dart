import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/buttons/ok_button.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class LevelAlert extends StatelessWidget {
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: Controller.getSize(context).width * 0.005),
      content: Container(
        height: Controller.getSize(context).height * 0.175,
        width: Controller.getSize(context).width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Dieses Quiz ist gesperrt',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: Controller.getSize(context).height * 0.005),
            Text(
              "Spiele die anderen Level um dieses Quiz freizuschalten",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(height: Controller.getSize(context).height * 0.015),
            OkButton(onPressed: () => Navigator.pop(context))
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
    );
  }
}
