import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class AgainstTheTimeAnswerList extends StatefulWidget {
  final List<dynamic> questions;
  final int questionIndex;
  final Function answerQuestion;
  final StopWatchTimer stopwatch;
  final List<List<dynamic>> answerChoices;
  final int correctAnswerChoiceIndex;
  final int wrongQuestions;

  AgainstTheTimeAnswerList(
      {this.questions,
      this.questionIndex,
      this.answerQuestion,
      this.stopwatch,
      this.answerChoices,
      this.correctAnswerChoiceIndex,
      this.wrongQuestions});

  @override
  _AgainstTheTimeAnswerListState createState() =>
      _AgainstTheTimeAnswerListState();
}

class _AgainstTheTimeAnswerListState extends State<AgainstTheTimeAnswerList> {
  AudioCache _audioCache;

  @override
  void initState() {
    super.initState();
    //TODO: Fix the audio cache
    /*
    _audioCache = AudioCache(
        fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY)
          ..setReleaseMode(ReleaseMode.STOP));
        */
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: Controller.getHeight(context) * 0.0075),
        child: Container(
          height: Controller.getHeight(context) * 0.09,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Controller.getSize(context).width * 0.05),
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  enableFeedback: true,
                  primary: Colors.white,
                  backgroundColor: widget.correctAnswerChoiceIndex == 0
                      ? correctlyAnsweredColor
                      : firstAnswerButtonColor,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(15)),
                  side: BorderSide(
                      width: borderWidth,
                      color: widget.correctAnswerChoiceIndex == 0
                          ? correctlyAnsweredBorderColor
                          : firstAnswerButtonBorderColor),
                ),
                child: Text(widget.answerChoices[0][0],
                    style: TextStyle(
                        color: widget.correctAnswerChoiceIndex == 0
                            ? correctlyAnsweredTextColor
                            : firstAnswerTextColor,
                        fontSize: 17)),
                onPressed: () async {
                  if (widget.answerChoices[0][1] == 0) {
                    setState(() {
                      /// Increase the timer
                      if ((10 / log(widget.questionIndex + 1).round() * 1000 +
                              1)
                          .isInfinite) {
                        widget.stopwatch.setPresetTime(
                            mSec: widget.stopwatch.initialPresetTime + 14000);
                      } else {
                        widget.stopwatch.setPresetTime(
                            mSec: widget.stopwatch.initialPresetTime +
                                (10 /
                                        log(widget.questionIndex + 1).round() *
                                        2000)
                                    .toInt());
                      }

                      /// Play the correct answer sound
                      //_audioCache.play('assets/sounds/correct.mp3');

                      /// Give the user haptic feedback
                      HapticFeedback.lightImpact();

                      /// Give the user visual feedback
                      firstAnswerTextColor = Colors.white;
                      firstAnswerBorderWidth = 2.0;
                      timerColor = Colors.green;
                      correctAnswer = true;
                      firstAnswerButtonColor = Colors.green;
                      firstAnswerButtonBorderColor = Colors.green;

                      /// Change the color of the correct button
                      correctlyAnsweredColor = Colors.green;
                      correctlyAnsweredBorderColor = Colors.green;
                      correctlyAnsweredTextColor = Colors.white;

                      /// Shows seconds gained right next to the time
                      BotToast.showAttachedWidget(
                          attachedBuilder: (_) => Stack(children: [
                                Positioned(
                                  top: Controller.getHeight(context) *
                                      topTimeOffset,
                                  left: Controller.getSize(context).width *
                                      leftTimeOffset,
                                  child: (10 /
                                              log(widget.questionIndex + 1)
                                                  .round() *
                                              2)
                                          .isInfinite
                                      ? Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          elevation: 10,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    Controller.getHeight(
                                                            context) *
                                                        0.02),
                                            child: Text(("+14"),
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize:
                                                        responseTimeFontSize)),
                                          ),
                                        )
                                      : Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          elevation: 10,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    Controller.getHeight(
                                                            context) *
                                                        0.02),
                                            child: Text(
                                                ("+" +
                                                    (10 /
                                                            log(widget.questionIndex +
                                                                    1)
                                                                .round() *
                                                            2)
                                                        .toInt()
                                                        .toString()),
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize:
                                                        responseTimeFontSize)),
                                          ),
                                        ),
                                ),
                              ]),
                          duration:
                              Duration(milliseconds: responseTimeDuration),
                          target: Offset(
                              Controller.getSize(context).width * 0.4, 0));
                    });
                  } else if (widget.answerChoices[0][1] == -1) {
                    setState(() {
                      widget.stopwatch.setPresetTime(
                          mSec: widget.stopwatch.initialPresetTime -
                              Controller.calculateTimeDeduction(
                                  widget.questionIndex, widget.wrongQuestions));

                      /// Play the wrong answer sound
                      //_audioCache.play('assets/sounds/false.mp3');

                      /// Give the user haptic feedback
                      HapticFeedback.lightImpact();
                      Timer(Duration(milliseconds: 150), () {
                        HapticFeedback.mediumImpact();
                      });

                      /// Give the user visual feedback
                      firstAnswerTextColor = Colors.white;
                      firstAnswerBorderWidth = 2.0;
                      timerColor = Colors.red;
                      falseAnswer = true;
                      firstAnswerButtonColor = Colors.red;
                      firstAnswerButtonBorderColor = Colors.red;

                      /// Change the color of the correct button
                      correctlyAnsweredColor = Colors.green;
                      correctlyAnsweredBorderColor = Colors.green;
                      correctlyAnsweredTextColor = Colors.white;

                      /// Shows seconds lost right next to the time
                      int.parse(StopWatchTimer.getDisplayTime(
                                      widget.stopwatch.rawTime.value,
                                      hours: false,
                                      minute: false,
                                      milliSecond: false)) -
                                  pow(widget.questionIndex, 1.25).round() * 1 >
                              3
                          ? BotToast.showAttachedWidget(
                              attachedBuilder: (_) => Stack(children: [
                                    Positioned(
                                      top: Controller.getHeight(context) *
                                          topTimeOffset,
                                      left: Controller.getSize(context).width *
                                          leftTimeOffset,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        elevation: 10,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Controller.getHeight(
                                                      context) *
                                                  0.02),
                                          child: Text(
                                              "-${(Controller.calculateTimeDeduction(widget.questionIndex, widget.wrongQuestions) ~/ 1000)}",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize:
                                                      responseTimeFontSize)),
                                        ),
                                      ),
                                    ),
                                  ]),
                              duration:
                                  Duration(milliseconds: responseTimeDuration),
                              target: Offset(1000, 500))
                          : Container();
                    });
                  }

                  Timer(Duration(milliseconds: 500), () {
                    widget.answerQuestion(widget.answerChoices[0][1], false);
                    firstAnswerTextColor = Colors.black;
                    timerColor = Colors.black;
                    firstAnswerButtonColor = Colors.white;
                    firstAnswerButtonBorderColor = Colors.grey;
                    firstAnswerBorderWidth = 1.0;
                    correctlyAnsweredColor = Colors.white;
                    correctlyAnsweredBorderColor = Colors.grey;
                    correctlyAnsweredTextColor = Colors.black;
                  });
                }),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: Controller.getHeight(context) * 0.0075),
        child: Container(
          height: Controller.getHeight(context) * 0.09,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Controller.getSize(context).width * 0.05),
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  enableFeedback: true,
                  primary: Colors.white,
                  backgroundColor: widget.correctAnswerChoiceIndex == 1
                      ? correctlyAnsweredColor
                      : secondAnswerButtonColor,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(15)),
                  side: BorderSide(
                      width: borderWidth,
                      color: widget.correctAnswerChoiceIndex == 1
                          ? correctlyAnsweredBorderColor
                          : secondAnswerButtonBorderColor),
                ),
                child: Text(widget.answerChoices[1][0],
                    style: TextStyle(
                        color: widget.correctAnswerChoiceIndex == 1
                            ? correctlyAnsweredTextColor
                            : secondAnswerTextColor,
                        fontSize: 17)),
                onPressed: () async {
                  if (widget.answerChoices[1][1] == 0) {
                    setState(() {
                      /// Increase the timer
                      if ((10 / log(widget.questionIndex + 1).round() * 1000 +
                              1)
                          .isInfinite) {
                        widget.stopwatch.setPresetTime(
                            mSec: widget.stopwatch.initialPresetTime + 14000);
                      } else {
                        widget.stopwatch.setPresetTime(
                            mSec: widget.stopwatch.initialPresetTime +
                                (10 /
                                        log(widget.questionIndex + 1).round() *
                                        2000)
                                    .toInt());
                      }

                      /// Play the correct answer sound
                      //_audioCache.play('assets/sounds/correct.mp3');

                      /// Give the user haptic feedback
                      HapticFeedback.lightImpact();

                      /// Give the user feedback
                      secondAnswerTextColor = Colors.white;
                      secondAnswerBorderWidth = 2.0;
                      timerColor = Colors.green;
                      correctAnswer = true;
                      secondAnswerButtonColor = Colors.green;
                      secondAnswerButtonBorderColor = Colors.green;

                      /// Change the color of the correct button
                      correctlyAnsweredColor = Colors.green;
                      correctlyAnsweredBorderColor = Colors.green;
                      correctlyAnsweredTextColor = Colors.white;

                      /// Shows seconds gained right next to the time
                      BotToast.showAttachedWidget(
                          attachedBuilder: (_) => Stack(children: [
                                Positioned(
                                  top: Controller.getHeight(context) *
                                      topTimeOffset,
                                  left: Controller.getSize(context).width *
                                      leftTimeOffset,
                                  child: (10 /
                                              log(widget.questionIndex + 1)
                                                  .round() *
                                              2)
                                          .isInfinite
                                      ? Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          elevation: 10,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    Controller.getHeight(
                                                            context) *
                                                        0.02),
                                            child: Text(("+14"),
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize:
                                                        responseTimeFontSize)),
                                          ),
                                        )
                                      : Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          elevation: 10,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    Controller.getHeight(
                                                            context) *
                                                        0.02),
                                            child: Text(
                                                ("+" +
                                                    (10 /
                                                            log(widget.questionIndex +
                                                                    1)
                                                                .round() *
                                                            2)
                                                        .toInt()
                                                        .toString()),
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize:
                                                        responseTimeFontSize)),
                                          ),
                                        ),
                                ),
                              ]),
                          duration:
                              Duration(milliseconds: responseTimeDuration),
                          target: Offset(
                              Controller.getSize(context).width * 0.4, 0));
                    });
                  } else if (widget.answerChoices[1][1] == -1) {
                    setState(() {
                      /// Decrease the timer
                      widget.stopwatch.setPresetTime(
                          mSec: widget.stopwatch.initialPresetTime -
                              Controller.calculateTimeDeduction(
                                  widget.questionIndex, widget.wrongQuestions));

                      /// Play the wrong answer sound
                      //_audioCache.play('assets/sounds/false.mp3');

                      /// Give the user haptic feedback
                      HapticFeedback.lightImpact();
                      Timer(Duration(milliseconds: 150), () {
                        HapticFeedback.mediumImpact();
                      });

                      /// Give the user feedback
                      secondAnswerTextColor = Colors.white;
                      secondAnswerBorderWidth = 2.0;
                      timerColor = Colors.red;
                      falseAnswer = true;
                      secondAnswerButtonColor = Colors.red;
                      secondAnswerButtonBorderColor = Colors.red;

                      /// Change the color of the correct button
                      correctlyAnsweredColor = Colors.green;
                      correctlyAnsweredBorderColor = Colors.green;
                      correctlyAnsweredTextColor = Colors.white;

                      /// Shows seconds lost right next to the time
                      /// Shows seconds lost right next to the time
                      int.parse(StopWatchTimer.getDisplayTime(
                                      widget.stopwatch.rawTime.value,
                                      hours: false,
                                      minute: false,
                                      milliSecond: false)) -
                                  pow(widget.questionIndex, 1.25).round() * 1 >
                              3
                          ? BotToast.showAttachedWidget(
                              attachedBuilder: (_) => Stack(children: [
                                    Positioned(
                                      top: Controller.getHeight(context) *
                                          topTimeOffset,
                                      left: Controller.getSize(context).width *
                                          leftTimeOffset,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        elevation: 10,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Controller.getHeight(
                                                      context) *
                                                  0.02),
                                          child: Text(
                                              "-${(Controller.calculateTimeDeduction(widget.questionIndex, widget.wrongQuestions) ~/ 1000)}",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize:
                                                      responseTimeFontSize)),
                                        ),
                                      ),
                                    ),
                                  ]),
                              duration:
                                  Duration(milliseconds: responseTimeDuration),
                              target: Offset(1000, 500))
                          : Container();
                    });
                  }

                  Timer(Duration(milliseconds: 500), () {
                    widget.answerQuestion(widget.answerChoices[0][1], false);
                    secondAnswerTextColor = Colors.black;
                    timerColor = Colors.black;
                    secondAnswerButtonColor = Colors.white;
                    secondAnswerButtonBorderColor = Colors.grey;
                    secondAnswerBorderWidth = 1.0;
                    correctlyAnsweredColor = Colors.white;
                    correctlyAnsweredBorderColor = Colors.grey;
                    correctlyAnsweredTextColor = Colors.black;
                  });
                }),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: Controller.getHeight(context) * 0.0075),
        child: Container(
          height: Controller.getHeight(context) * 0.09,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Controller.getSize(context).width * 0.05),
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  enableFeedback: true,
                  primary: Colors.white,
                  backgroundColor: widget.correctAnswerChoiceIndex == 2
                      ? correctlyAnsweredColor
                      : thirdAnswerButtonColor,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(15)),
                  side: BorderSide(
                      width: borderWidth,
                      color: widget.correctAnswerChoiceIndex == 2
                          ? correctlyAnsweredBorderColor
                          : thirdAnswerButtonBorderColor),
                ),
                child: Text(widget.answerChoices[2][0],
                    style: TextStyle(
                        color: widget.correctAnswerChoiceIndex == 2
                            ? correctlyAnsweredTextColor
                            : thirdAnswerTextColor,
                        fontSize: 17)),
                onPressed: () async {
                  if (widget.answerChoices[2][1] == 0) {
                    setState(() {
                      /// Increase the timer
                      if ((10 / log(widget.questionIndex + 1).round() * 1000 +
                              1)
                          .isInfinite) {
                        widget.stopwatch.setPresetTime(
                            mSec: widget.stopwatch.initialPresetTime + 14000);
                      } else {
                        widget.stopwatch.setPresetTime(
                            mSec: widget.stopwatch.initialPresetTime +
                                (10 /
                                        log(widget.questionIndex + 1).round() *
                                        2000)
                                    .toInt());
                      }

                      /// Play the correct answer sound
                      //_audioCache.play('assets/sounds/correct.mp3');

                      /// Give the user haptic feedback
                      HapticFeedback.lightImpact();

                      /// Give the user feedback
                      thirdAnswerTextColor = Colors.white;
                      thirdAnswerBorderWidth = 2.0;
                      timerColor = Colors.green;
                      correctAnswer = true;
                      thirdAnswerButtonColor = Colors.green;
                      thirdAnswerButtonBorderColor = Colors.green;

                      /// Change the color of the correct button
                      correctlyAnsweredColor = Colors.green;
                      correctlyAnsweredBorderColor = Colors.green;
                      correctlyAnsweredTextColor = Colors.white;

                      /// Shows seconds gained right next to the time
                      BotToast.showAttachedWidget(
                          attachedBuilder: (_) => Stack(children: [
                                Positioned(
                                  top: Controller.getHeight(context) *
                                      topTimeOffset,
                                  left: Controller.getSize(context).width *
                                      leftTimeOffset,
                                  child: (10 /
                                              log(widget.questionIndex + 1)
                                                  .round() *
                                              2)
                                          .isInfinite
                                      ? Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          elevation: 10,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    Controller.getHeight(
                                                            context) *
                                                        0.02),
                                            child: Text(("+14"),
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize:
                                                        responseTimeFontSize)),
                                          ),
                                        )
                                      : Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          elevation: 10,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    Controller.getHeight(
                                                            context) *
                                                        0.02),
                                            child: Text(
                                                ("+" +
                                                    (10 /
                                                            log(widget.questionIndex +
                                                                    1)
                                                                .round() *
                                                            2)
                                                        .toInt()
                                                        .toString()),
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize:
                                                        responseTimeFontSize)),
                                          ),
                                        ),
                                ),
                              ]),
                          duration:
                              Duration(milliseconds: responseTimeDuration),
                          target: Offset(
                              Controller.getSize(context).width * 0.4, 0));
                    });
                  } else if (widget.answerChoices[2][1] == -1) {
                    setState(() {
                      /// Decrease the timer
                      widget.stopwatch.setPresetTime(
                          mSec: widget.stopwatch.initialPresetTime -
                              Controller.calculateTimeDeduction(
                                  widget.questionIndex, widget.wrongQuestions));

                      /// Play the wrong answer sound
                      //_audioCache.play('assets/sounds/false.mp3');

                      /// Give the user haptic feedback
                      HapticFeedback.lightImpact();
                      Timer(Duration(milliseconds: 150), () {
                        HapticFeedback.mediumImpact();
                      });

                      /// Give the user feedback
                      thirdAnswerTextColor = Colors.white;
                      thirdAnswerBorderWidth = 2.0;
                      timerColor = Colors.red;
                      falseAnswer = true;
                      thirdAnswerButtonColor = Colors.red;
                      thirdAnswerButtonBorderColor = Colors.red;

                      /// Change the color of the correct button
                      correctlyAnsweredColor = Colors.green;
                      correctlyAnsweredBorderColor = Colors.green;
                      correctlyAnsweredTextColor = Colors.white;

                      /// Shows seconds lost right next to the time
                      /// Shows seconds lost right next to the time
                      int.parse(StopWatchTimer.getDisplayTime(
                                      widget.stopwatch.rawTime.value,
                                      hours: false,
                                      minute: false,
                                      milliSecond: false)) -
                                  pow(widget.questionIndex, 1.25).round() * 1 >
                              3
                          ? BotToast.showAttachedWidget(
                              attachedBuilder: (_) => Stack(children: [
                                    Positioned(
                                      top: Controller.getHeight(context) *
                                          topTimeOffset,
                                      left: Controller.getSize(context).width *
                                          leftTimeOffset,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        elevation: 10,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Controller.getHeight(
                                                      context) *
                                                  0.02),
                                          child: Text(
                                              "-${(Controller.calculateTimeDeduction(widget.questionIndex, widget.wrongQuestions) ~/ 1000)}",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize:
                                                      responseTimeFontSize)),
                                        ),
                                      ),
                                    ),
                                  ]),
                              duration:
                                  Duration(milliseconds: responseTimeDuration),
                              target: Offset(1000, 500))
                          : Container();
                    });
                  }

                  Timer(Duration(milliseconds: 500), () {
                    widget.answerQuestion(widget.answerChoices[0][1], false);
                    thirdAnswerTextColor = Colors.black;
                    timerColor = Colors.black;
                    thirdAnswerButtonColor = Colors.white;
                    thirdAnswerButtonBorderColor = Colors.grey;
                    thirdAnswerBorderWidth = 1.0;
                    correctlyAnsweredColor = Colors.white;
                    correctlyAnsweredBorderColor = Colors.grey;
                    correctlyAnsweredTextColor = Colors.black;
                  });
                }),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: Controller.getHeight(context) * 0.0075),
        child: Container(
          height: Controller.getHeight(context) * 0.09,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Controller.getSize(context).width * 0.05),
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  enableFeedback: true,
                  primary: Colors.white,
                  backgroundColor: widget.correctAnswerChoiceIndex == 3
                      ? correctlyAnsweredColor
                      : fourthAnswerButtonColor,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(15)),
                  side: BorderSide(
                      width: borderWidth,
                      color: widget.correctAnswerChoiceIndex == 3
                          ? correctlyAnsweredBorderColor
                          : fourthAnswerButtonBorderColor),
                ),
                child: Text(widget.answerChoices[3][0],
                    style: TextStyle(
                        color: widget.correctAnswerChoiceIndex == 3
                            ? correctlyAnsweredTextColor
                            : fourthAnswerTextColor,
                        fontSize: 17)),
                onPressed: () async {
                  if (widget.answerChoices[3][1] == 0) {
                    setState(() {
                      /// Increase the timer
                      if ((10 / log(widget.questionIndex + 1).round() * 1000 +
                              1)
                          .isInfinite) {
                        widget.stopwatch.setPresetTime(
                            mSec: widget.stopwatch.initialPresetTime + 14000);
                      } else {
                        widget.stopwatch.setPresetTime(
                            mSec: widget.stopwatch.initialPresetTime +
                                (10 /
                                        log(widget.questionIndex + 1).round() *
                                        2000)
                                    .toInt());
                      }

                      /// Play the correct answer sound
                      //_audioCache.play('assets/sounds/correct.mp3');

                      /// Give the user haptic feedback
                      HapticFeedback.lightImpact();

                      /// Give the user feedback
                      fourthAnswerTextColor = Colors.white;
                      fourthAnswerBorderWidth = 2.0;
                      timerColor = Colors.green;
                      correctAnswer = true;
                      fourthAnswerButtonColor = Colors.green;
                      fourthAnswerButtonBorderColor = Colors.green;

                      /// Change the color of the correct button
                      correctlyAnsweredColor = Colors.green;
                      correctlyAnsweredBorderColor = Colors.green;
                      correctlyAnsweredTextColor = Colors.white;

                      /// Shows seconds gained right next to the time
                      BotToast.showAttachedWidget(
                          attachedBuilder: (_) => Stack(children: [
                                Positioned(
                                  top: Controller.getHeight(context) *
                                      topTimeOffset,
                                  left: Controller.getSize(context).width *
                                      leftTimeOffset,
                                  child: (10 /
                                              log(widget.questionIndex + 1)
                                                  .round() *
                                              2)
                                          .isInfinite
                                      ? Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          elevation: 10,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    Controller.getHeight(
                                                            context) *
                                                        0.02),
                                            child: Text(("+14"),
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize:
                                                        responseTimeFontSize)),
                                          ),
                                        )
                                      : Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          elevation: 10,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    Controller.getHeight(
                                                            context) *
                                                        0.02),
                                            child: Text(
                                                ("+" +
                                                    (10 /
                                                            log(widget.questionIndex +
                                                                    1)
                                                                .round() *
                                                            2)
                                                        .toInt()
                                                        .toString()),
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize:
                                                        responseTimeFontSize)),
                                          ),
                                        ),
                                ),
                              ]),
                          duration:
                              Duration(milliseconds: responseTimeDuration),
                          target: Offset(
                              Controller.getSize(context).width * 0.4, 0));
                    });
                  } else if (widget.answerChoices[3][1] == -1) {
                    setState(() {
                      /// Decrease the timer
                      widget.stopwatch.setPresetTime(
                          mSec: widget.stopwatch.initialPresetTime -
                              Controller.calculateTimeDeduction(
                                  widget.questionIndex, widget.wrongQuestions));

                      /// Play the wrong answer sound
                      //_audioCache.play('assets/sounds/false.mp3');

                      /// Give the user haptic feedback
                      HapticFeedback.lightImpact();
                      Timer(Duration(milliseconds: 150), () {
                        HapticFeedback.mediumImpact();
                      });

                      /// Give the user feedback
                      fourthAnswerTextColor = Colors.white;
                      fourthAnswerBorderWidth = 2.0;
                      timerColor = Colors.red;
                      falseAnswer = true;
                      fourthAnswerButtonColor = Colors.red;
                      fourthAnswerButtonBorderColor = Colors.red;

                      /// Change the color of the correct button
                      correctlyAnsweredColor = Colors.green;
                      correctlyAnsweredBorderColor = Colors.green;
                      correctlyAnsweredTextColor = Colors.white;

                      /// Shows seconds lost right next to the time
                      /// Shows seconds lost right next to the time
                      int.parse(StopWatchTimer.getDisplayTime(
                                      widget.stopwatch.rawTime.value,
                                      hours: false,
                                      minute: false,
                                      milliSecond: false)) -
                                  pow(widget.questionIndex, 1.25).round() * 1 >
                              3
                          ? BotToast.showAttachedWidget(
                              attachedBuilder: (_) => Stack(children: [
                                    Positioned(
                                      top: Controller.getHeight(context) *
                                          topTimeOffset,
                                      left: Controller.getSize(context).width *
                                          leftTimeOffset,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        elevation: 10,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Controller.getHeight(
                                                      context) *
                                                  0.02),
                                          child: Text(
                                              "-${(Controller.calculateTimeDeduction(widget.questionIndex, widget.wrongQuestions) ~/ 1000)}",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize:
                                                      responseTimeFontSize)),
                                        ),
                                      ),
                                    ),
                                  ]),
                              duration:
                                  Duration(milliseconds: responseTimeDuration),
                              target: Offset(1000, 500))
                          : Container();
                    });
                  }

                  Timer(Duration(milliseconds: 500), () {
                    widget.answerQuestion(widget.answerChoices[0][1], false);
                    fourthAnswerTextColor = Colors.black;
                    timerColor = Colors.black;
                    fourthAnswerButtonColor = Colors.white;
                    fourthAnswerButtonBorderColor = Colors.grey;
                    fourthAnswerBorderWidth = 1.0;
                    correctlyAnsweredColor = Colors.white;
                    correctlyAnsweredBorderColor = Colors.grey;
                    correctlyAnsweredTextColor = Colors.black;
                  });
                }),
          ),
        ),
      ),
    ]);
  }
}
