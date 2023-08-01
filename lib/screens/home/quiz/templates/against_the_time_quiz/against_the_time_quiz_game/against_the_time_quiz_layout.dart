import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:mobile_quiz_app/screens/home/quiz/templates/against_the_time_quiz/against_the_time_quiz_game/against_the_time_answer_list.dart';
import 'package:mobile_quiz_app/screens/home/quiz/templates/against_the_time_quiz/against_the_time_quiz_game/quiz_question.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

// ignore: must_be_immutable
class AgainstTheTimeQuizLayout extends StatefulWidget {
  final List<dynamic> questions;
  final int questionIndex;
  final int questionScore;
  final Function answerQuestion;
  final StopWatchTimer stopWatch;
  final BuildContext gameContext;
  final int wrongQuestions;

  AgainstTheTimeQuizLayout({
    @required this.questions,
    @required this.answerQuestion,
    @required this.questionIndex,
    @required this.questionScore,
    @required this.stopWatch,
    @required this.gameContext,
    @required this.wrongQuestions,
  });

  @override
  _AgainstTheTimeQuizLayoutState createState() =>
      _AgainstTheTimeQuizLayoutState();
}

class _AgainstTheTimeQuizLayoutState extends State<AgainstTheTimeQuizLayout>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  AudioCache _audioCache;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 3400), vsync: this);

    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        /// Starting the stopwatch after the animation completed
        // TODO: Fix Stopwatch
        //widget.stopWatch.onExecute.add(StopWatchExecute.start);
      }
    });

    //_audioCache = AudioCache(
    //fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));

    /// Play the countdown sound
    //_audioCache.play('assets/sounds/countdown.wav');

    /// Show the animation to the user
    BotToast.showAttachedWidget(
        attachedBuilder: (_) => Stack(children: [
              Positioned(
                top: 0,
                left: 0,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.white.withOpacity(0.1),
                    height: Controller.getHeight(widget.gameContext) * 1.1,
                    width: Controller.getSize(widget.gameContext).width,
                    child: Lottie.asset(
                        'assets/animations/Quizbase_Countdown_Animation.json',
                        controller: controller, onLoaded: (composition) {
                      controller.forward();
                    }, repeat: false),
                  ),
                ),
              ),
            ]),
        duration: Duration(milliseconds: 3400),
        target: Offset(0, 0));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// Shows the current number of the question
        widget.questionScore + 1 == 1
            ? Center(
                child: Text(
                  (widget.questionScore + 1).toString() + " Frage",
                  style: TextStyle(fontSize: 25),
                ),
              )
            : Center(
                child: Text(
                  (widget.questionScore + 1).toString() + " Fragen",
                  style: TextStyle(fontSize: 25),
                ),
              ),
        SizedBox(height: Controller.getHeight(context) * 0.02),

        StreamBuilder(
            stream: widget.stopWatch.rawTime,
            initialData: widget.stopWatch.rawTime.value,
            builder: (context, snapshot) {
              final value = snapshot.data;
              final minuteTime = StopWatchTimer.getDisplayTime(value,
                  hours: false, second: false, milliSecond: false);
              final secondTime = StopWatchTimer.getDisplayTime(value,
                  hours: false, minute: false);
              return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.centerRight,
                        width: Controller.getSize(context).width * 0.175,
                        child: Text(minuteTime,
                            style: TextStyle(fontSize: 35, color: timerColor))),
                    Text(":",
                        style: TextStyle(fontSize: 35, color: timerColor)),
                    Container(
                        width: Controller.getSize(context).width * 0.3,
                        child: Text(secondTime,
                            style: TextStyle(fontSize: 35, color: timerColor)))
                  ]);
            }),

        SizedBox(height: Controller.getSize(context).height * 0.01),

        Center(
          child: Container(
              width: Controller.getSize(context).width * 0.9,
              height: Controller.getHeight(context) * 0.8,
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Controller.getHeight(context) * 0.01),
                  child: _createQuestionCard(context))),
        ),
      ],
    );
  }

  /// Method that return a question card
  Card _createQuestionCard(BuildContext context) {
    int correctAnswerChoiceIndex = 0;

    List<List<dynamic>> answerChoices = [
      [widget.questions[widget.questionIndex].correctAnswer, 0],
      [widget.questions[widget.questionIndex].incorrectAnswer1, -1],
      [widget.questions[widget.questionIndex].incorrectAnswer2, -1],
      [widget.questions[widget.questionIndex].incorrectAnswer3, -1]
    ];

    answerChoices.shuffle();

    /// Figuring out the correct answer index
    answerChoices.forEach((element) {
      if (element[1] == 0) {
        correctAnswerChoiceIndex = answerChoices.indexOf(element);
      }
    });
    return Card(
      elevation: 10,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
                0, Controller.getSize(context).height * 0.04, 0, 0),
            child: Container(
                height: Controller.getHeight(context) * 0.2,
                width: Controller.getSize(context).width * 0.9,
                child:
                    Question(widget.questions[widget.questionIndex].question)),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                0, Controller.getHeight(context) * 0.04, 0, 0),
            child: Container(
              width: Controller.getSize(context).width * 0.9,
              height: Controller.getHeight(context) * 0.45,
              child: AgainstTheTimeAnswerList(
                  questions: widget.questions,
                  questionIndex: widget.questionIndex,
                  answerQuestion: widget.answerQuestion,
                  stopwatch: widget.stopWatch,
                  answerChoices: answerChoices,
                  correctAnswerChoiceIndex: correctAnswerChoiceIndex,
                  wrongQuestions: widget.wrongQuestions),
            ),
          ),
        ],
      ),
    );
  }
}
