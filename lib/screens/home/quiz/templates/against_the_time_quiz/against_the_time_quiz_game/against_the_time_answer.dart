import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:mobile_quiz_app/shared/controller.dart';
import 'package:mobile_quiz_app/shared/constants.dart';

class AgainstTheTimeAnswer extends StatefulWidget {
  final String answerText;
  final int score;
  final int questionIndex;
  final Function answerQuestion;
  final StopWatchTimer stopwatch;
  final String rightAnswer;
  final int correctAnswerChoiceIndex;
  final int currentIndex;

  AgainstTheTimeAnswer(
      this.answerText,
      this.score,
      this.answerQuestion,
      this.stopwatch,
      this.questionIndex,
      this.rightAnswer,
      this.correctAnswerChoiceIndex,
      this.currentIndex);

  @override
  _AgainstTheTimeAnswerState createState() => _AgainstTheTimeAnswerState(
      answerText: answerText,
      score: score,
      answerQuestion: answerQuestion,
      stopwatch: stopwatch,
      questionIndex: questionIndex,
      rightAnswer: rightAnswer,
      correctAnswerChoiceIndex: correctAnswerChoiceIndex,
      currentIndex: currentIndex);
}

class _AgainstTheTimeAnswerState extends State<AgainstTheTimeAnswer> {
  _AgainstTheTimeAnswerState({
    @required this.answerText,
    @required this.score,
    @required this.answerQuestion,
    @required this.stopwatch,
    @required this.questionIndex,
    @required this.rightAnswer,
    @required this.correctAnswerChoiceIndex,
    @required this.currentIndex,
  });
  final String answerText;
  final int score;
  final int questionIndex;
  final Function answerQuestion;
  final StopWatchTimer stopwatch;
  final String rightAnswer;
  final int correctAnswerChoiceIndex;
  final int currentIndex;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Controller.getSize(context).height * 0.08,
        width: Controller.getSize(context).width * 0.2,
        decoration: BoxDecoration(
            color: widget.currentIndex == widget.correctAnswerChoiceIndex
                ? correctlyAnsweredColor
                : buttonColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: widget.currentIndex == widget.correctAnswerChoiceIndex
                    ? correctlyAnsweredBorderColor
                    : borderColor,
                width: borderWidth)),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Controller.getSize(context).height * 0.00),
            child: Text(
              widget.answerText,
              style: TextStyle(
                fontSize: 18,
                color: textColor,
              ),
            ),
          ),
        ));
  }
}
