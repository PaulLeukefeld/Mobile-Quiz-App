import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:mobile_quiz_app/models/quiz_item.dart';
import 'package:mobile_quiz_app/models/quiz_question.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/screens/home/quiz/templates/against_the_time_quiz/against_the_time_quiz_game/against_the_time_quiz_layout.dart';
import 'package:mobile_quiz_app/screens/home/quiz/templates/against_the_time_quiz/against_the_time_quiz_game/against_the_time_result.dart';
import 'package:mobile_quiz_app/services/analytics_service.dart';
import 'package:mobile_quiz_app/services/database.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class AgainstTheTimeQuizGame extends StatefulWidget {
  final List<QuizQuestion> questions;
  final UserModel user;

  AgainstTheTimeQuizGame({
    @required this.questions,
    this.user,
  });

  @override
  _AgainstTheTimeQuizGameState createState() =>
      _AgainstTheTimeQuizGameState(questions: questions, user: user);
}

class _AgainstTheTimeQuizGameState extends State<AgainstTheTimeQuizGame> {
  QuizItem quizItemData;
  List<QuizQuestion> questions;
  UserModel user;

  _AgainstTheTimeQuizGameState({
    @required this.questions,
    this.user,
  });

  /// Keeps track of the current question
  int questionIndex = 0;

  /// Keeps track of the amount of wrong questions
  int wrongQuestions = 0;

  /// Keeps track of how many questions have been answered
  int questionScore = 0;

  /// Variable that keep track if the user ran out of time
  bool outOfTime = false;

  /// Resets all quiz related variables
  void _resetQuiz() {
    setState(() {
      questionIndex = 0;
      questionScore = 0;
      wrongQuestions = 0;
    });
  }

  /// Method that gets called after a question has been answered
  void _answerQuestion(int score, bool outOfTimeValue) async {
    setState(() {
      if (!outOfTime) {
        questionIndex += 1;
        questionScore += 1;
      }
    });

    if (score == 0) {
      /// Update the correctly answered field
      await DatabaseService(
              questionUid: questions[questionIndex - 1].questionUid)
          .incrementCorrectlyAnswered();

      /// Incrementing the amount of time the question has been answered
      await DatabaseService(
              questionUid: questions[questionIndex - 1].questionUid)
          .incrementQuestionAnswered();
    } else if (score == -1) {
      /// Update the falsely answered field
      await DatabaseService(
              questionUid: questions[questionIndex - 1].questionUid)
          .incrementFalselyAnswered();

      /// Incrementing the amount of time the question has been answered
      await DatabaseService(
              questionUid: questions[questionIndex - 1].questionUid)
          .incrementQuestionAnswered();

      /// Incrementing the amount of falsely answered questions
      wrongQuestions += 1;
    }
  }

  /// Creating a new stopwatch instance
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
  );

  @override
  void dispose() {
    super.dispose();
    _stopWatchTimer.dispose();
  }

  @override
  void initState() {
    super.initState();

    /// Setting the preset time to 30 seconds
    _stopWatchTimer.setPresetSecondTime(30);
  }

  @override
  Widget build(BuildContext context) {
    /// Setting the preferred device orientation
    Controller.setPreferedOrientation();

    /// Logging against the time game start
    if (trackUser) {
      AnalyticsService().logAgainstTheTimeStart();
    }

    /// Listening to the stopwatch stream and terminatinig when the timer hits 0
    Timer(Duration(milliseconds: 300), () {
      _stopWatchTimer.rawTime.listen(
          (value) => value < 20 ? setState(() => outOfTime = true) : false);
    });

    return WillPopScope(
        onWillPop: () async {
          if (Navigator.of(context).userGestureInProgress)
            return false;
          else
            return true;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                !outOfTime
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, 0, Controller.getSize(context).width * 0.02, 0),
                        child: IconButton(
                          icon: Icon(CupertinoIcons.exclamationmark_circle,
                              color: Color.fromRGBO(10, 122, 255, 1)),
                          onPressed: () {
                            /// Increment the negativity score
                            DatabaseService(
                                    questionUid:
                                        questions[questionIndex].questionUid)
                                .incrementNegativityScore();

                            /// Giving the user feedback
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text(
                                  "Die Frage wurde erfolgreich als ungültig markiert",
                                  textAlign: TextAlign.center,
                                )));
                          },
                        ),
                      )
                    : Container(),
              ],
              leading: !outOfTime
                  ? IconButton(
                      icon: Icon(Icons.arrow_back,
                          color: Color.fromRGBO(10, 122, 255, 1)),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  : Container(),
            ),
            body: (!outOfTime
                ? AgainstTheTimeQuizLayout(
                    answerQuestion: _answerQuestion,
                    questionIndex: questionIndex,
                    questionScore: questionScore,
                    questions: questions,
                    stopWatch: _stopWatchTimer,
                    gameContext: context,
                    wrongQuestions: wrongQuestions)
                : AgainstTheTimeResult(
                    resultScore: questionScore.toString(),
                    resetHandler: _resetQuiz,
                    user: user,
                    stopwatch: _stopWatchTimer,
                  ))));
  }
}
