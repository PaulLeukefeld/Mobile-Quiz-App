import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/buttons/next_button.dart';
import 'package:mobile_quiz_app/models/buttons/skip_button.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class NextSkipButtons extends StatelessWidget {
  NextSkipButtons({@required this.onPressedNext, @required this.onPressedSkip});
  final GestureTapCallback onPressedNext;
  final GestureTapCallback onPressedSkip;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NextButton(onPressed: onPressedNext),
        SizedBox(height: Controller.getSize(context).height * 0.01),
        SkipButton(onPressed: onPressedSkip)
      ],
    );
  }
}
