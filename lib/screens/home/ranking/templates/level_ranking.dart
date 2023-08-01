import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/screens/home/ranking/templates/levelOneRanking.dart';
import 'package:mobile_quiz_app/screens/home/ranking/templates/levelThreeRanking.dart';
import 'package:mobile_quiz_app/screens/home/ranking/templates/levelTwoRanking.dart';

class LevelRanking extends StatefulWidget {
  @override
  _LevelRankingState createState() => _LevelRankingState();
}

class _LevelRankingState extends State<LevelRanking> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        LevelOneRanking(),
        SizedBox(height: size.height * 0.05),
        LevelTwoRanking(),
        SizedBox(height: size.height * 0.05),
        LevelThreeRanking(),
        SizedBox(height: size.height * 0.02),
      ],
    );
  }
}
