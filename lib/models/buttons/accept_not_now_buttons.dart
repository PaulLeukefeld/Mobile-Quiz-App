import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/buttons/accept_button.dart';
import 'package:mobile_quiz_app/models/buttons/not_now_button.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class AcceptNotNowButtons extends StatelessWidget {
  AcceptNotNowButtons(
      {@required this.onPressedAccept, @required this.onPressedNotNow});
  final GestureTapCallback onPressedAccept;
  final GestureTapCallback onPressedNotNow;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AcceptButton(onPressed: onPressedAccept),
        SizedBox(height: Controller.getSize(context).height * 0.01),
        NotNowButton(onPressed: onPressedNotNow)
      ],
    );
  }
}
