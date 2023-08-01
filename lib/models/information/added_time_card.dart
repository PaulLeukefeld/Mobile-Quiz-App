import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class AddedTime extends StatefulWidget {
  final int questionIndex;

  AddedTime({@required this.questionIndex});

  @override
  _AddedTimeState createState() => _AddedTimeState();
}

class _AddedTimeState extends State<AddedTime> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: Controller.getHeight(context) * topTimeOffset,
        left: Controller.getSize(context).width * leftTimeOffset,
        child: (10 / log(widget.questionIndex + 1).round() * 2).isInfinite
            ? Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Controller.getHeight(context) * 0.02),
                  child: Text(("+14"),
                      style: TextStyle(color: Colors.green, fontSize: 35)),
                ),
              )
            : Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Controller.getHeight(context) * 0.02),
                  child: Text(
                      ("+" +
                          (10 / log(widget.questionIndex + 1).round() * 2)
                              .toInt()
                              .toString()),
                      style: TextStyle(color: Colors.green, fontSize: 35)),
                ),
              ),
      ),
    ]);
  }
}
