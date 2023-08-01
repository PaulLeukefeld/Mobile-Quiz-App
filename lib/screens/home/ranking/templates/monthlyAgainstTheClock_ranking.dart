import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_quiz_app/models/user_model.dart';

class MonthlyAgainstTheClockRanking extends StatefulWidget {
  @override
  _MonthlyAgainstTheClockRankingState createState() =>
      _MonthlyAgainstTheClockRankingState();
}

class _MonthlyAgainstTheClockRankingState
    extends State<MonthlyAgainstTheClockRanking> {
  List<UserModel> _users;
  List<UserModel> _todaysUsers;
  int _currentSortColumn = 0;
  bool _isAscending = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final rankingItems = (Provider.of<List<UserModel>>(context) == null)
        ? []
        : Provider.of<List<UserModel>>(context);
    _users = rankingItems;

    /// Sorting the users in decending order
    _users.sort((a, b) =>
        b.monthlyAgainstTheTimeScore.compareTo(a.monthlyAgainstTheTimeScore));

    /// Method that calculates the monthly difference of two dates (Move in clean up)
    int calculateMonthlyDifference(DateTime date) {
      DateTime now = DateTime.now();
      return DateTime(date.year, date.month)
          .difference(DateTime(now.year, now.month))
          .inDays;
    }

    /// Only select the users that had a highscore this month
    _todaysUsers = _users
        .where((user) =>
            calculateMonthlyDifference(
                user.timeOfMonthlyAgainstTheTimeHighscore) ==
            0)
        .toList();

    /// Only taking the 50 highest scoring users
    if (_todaysUsers.length > 50) {
      _todaysUsers.sort((a, b) =>
          b.monthlyAgainstTheTimeScore.compareTo(a.monthlyAgainstTheTimeScore));
      setState(() {
        _todaysUsers = _todaysUsers.take(50).toList();
      });
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: size.width * 0.1),
            Text("Gegen die Zeit",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        DataTable(
            sortColumnIndex: _currentSortColumn,
            sortAscending: _isAscending,
            dataRowHeight: size.height * 0.06,
            horizontalMargin: 0,
            columnSpacing: size.width * 0.08,
            columns: [
              DataColumn(label: Text('Avatar')),
              DataColumn(label: Text('Name')),
              DataColumn(
                label: Text('Fragen'),
              ),
              DataColumn(label: Text('Ort'))
            ],
            rows: List<DataRow>.generate(
              _todaysUsers.length,
              (index) => DataRow(cells: [
                DataCell(CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: size.width * 0.05,
                    backgroundImage: rankingItems[0] != null
                        ? AssetImage("assets/profile_image_" +
                            _todaysUsers[index].profileImage.toString() +
                            ".png")
                        : AssetImage("assets/profile_image_" + "1" + ".png"))),
                DataCell(_todaysUsers[index] != null
                    ? Text(_todaysUsers[index].userName)
                    : Text("Guest")),
                DataCell(_todaysUsers[index] != null
                    ? Center(
                        child: Text(_todaysUsers[index]
                            .monthlyAgainstTheTimeScore
                            .toString()))
                    : Center(child: Text("0"))),
                DataCell(_todaysUsers[index] != null
                    ? Image(
                        width: size.width * 0.07,
                        image: _todaysUsers[index].state == null
                            ? AssetImage("assets/Deutschland.png")
                            : AssetImage(
                                "assets/" + _todaysUsers[index].state + ".png"))
                    : Image(
                        width: size.width * 0.07,
                        image: AssetImage("assets/Deutschland.png"))),
              ]),
            ))
      ],
    );
  }
}
