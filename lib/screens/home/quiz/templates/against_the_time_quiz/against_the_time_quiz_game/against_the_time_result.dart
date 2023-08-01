import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/information/result_profile.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:mobile_quiz_app/models/buttons/done_button.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/services/analytics_service.dart';
import 'package:mobile_quiz_app/services/database.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class AgainstTheTimeResult extends StatefulWidget {
  final String resultScore;
  final Function resetHandler;
  final UserModel user;
  final StopWatchTimer stopwatch;

  AgainstTheTimeResult({
    @required this.resultScore,
    @required this.resetHandler,
    @required this.user,
    @required this.stopwatch,
  });

  @override
  _AgainstTheTimeResultState createState() => _AgainstTheTimeResultState(
        user: user,
        resultScore: resultScore,
        resetHandler: resetHandler,
        stopwatch: stopwatch,
      );
}

class _AgainstTheTimeResultState extends State<AgainstTheTimeResult>
    with SingleTickerProviderStateMixin {
  _AgainstTheTimeResultState({
    this.user,
    this.resultScore,
    this.resetHandler,
    this.stopwatch,
  });
  final UserModel user;
  final String resultScore;
  final Function resetHandler;
  final StopWatchTimer stopwatch;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 3400), vsync: this);

    /// Incrementing the number of completed games
    Controller.incrementCompletedGames();
  }

  @override
  Widget build(BuildContext context) {
    Controller.setPreferedOrientation();

    /// Stopping the stopwatch at the end of the quiz
    // TODO: Fix Stopwatch
    //stopwatch.onExecute.add(StopWatchExecute.stop);

    /// Logging against the time quiz end
    if (trackUser) {
      AnalyticsService().logAgainstTheTimeEnd();
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ResultProfile(user: user),
          resultScore == "1"
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Controller.getHeight(context) * 0.075,
                      horizontal: Controller.getSize(context).width * 0.1),
                  child: Text(
                    "Du hast $resultScore Frage beantwortet! ",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Controller.getHeight(context) * 0.075,
                      horizontal: Controller.getSize(context).width * 0.1),
                  child: Text(
                    "Du hast $resultScore Fragen beantwortet! ",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
          DoneButton(onPressed: () {
            DatabaseService(uid: user.uid)
                .updateAgainstTheTimeScore(int.parse(resultScore));

            Navigator.of(context).pop();
          }),
        ],
      ),
    );
  }
}
