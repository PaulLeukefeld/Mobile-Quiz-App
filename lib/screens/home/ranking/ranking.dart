import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/screens/home/ranking/templates/alltimeAgainstTheClock_ranking.dart';
import 'package:mobile_quiz_app/services/database.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

///Rankings pages, where the user can filter rankings
class Ranking extends StatefulWidget {
  Ranking({@required this.user});

  final UserModel user;

  @override
  _RankingState createState() => _RankingState(user: user);
}

class _RankingState extends State<Ranking> {
  _RankingState({@required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    ///Setting the device orientation to portrait mode
    Controller.setPreferedOrientation();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  Controller.getSize(context).width * 0.09,
                  Controller.getHeight(context) * 0.1,
                  0,
                  Controller.getHeight(context) * 0.03),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text("Ranking",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold))
              ]),
            ),
            StreamProvider<List<UserModel>>.value(
                initialData: [null],
                value: DatabaseService().userRankingData,
                child: AllTimeAgainstTheClockRanking())
          ],
        ),
      ),
    );
  }
}
