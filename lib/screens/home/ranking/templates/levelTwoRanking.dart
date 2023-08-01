import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_quiz_app/models/user_model.dart';

class LevelTwoRanking extends StatefulWidget {
  @override
  _LevelTwoRankingState createState() => _LevelTwoRankingState();
}

class _LevelTwoRankingState extends State<LevelTwoRanking> {
  List<UserModel> _users;
  int _currentSortColumn = 0;
  bool _isAscending = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final rankingItems = (Provider.of<List<UserModel>>(context) == null)
        ? []
        : Provider.of<List<UserModel>>(context);
    _users = rankingItems;

    /// Sorting the users in decending order
    _users.sort((a, b) => a.levelTwoTime.compareTo(b.levelTwoTime));

    /// Only taking the fastest 20 users
    if (_users.length > 20) {
      _users.sort((a, b) => a.levelTwoTime.compareTo(b.levelTwoTime));
      setState(() {
        _users = _users.take(20).toList();
      });
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: size.width * 0.1),
            Text("Level 2",
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
            columnSpacing: size.width * 0.07,
            columns: [
              DataColumn(label: Text('Avatar')),
              DataColumn(label: Text('Name')),
              DataColumn(
                label: Text('Zeit'),
              ),
              DataColumn(label: Text('Ort'))
            ],
            rows: List<DataRow>.generate(
              rankingItems.length,
              (index) => DataRow(cells: [
                DataCell(CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: size.width * 0.05,
                    backgroundImage: rankingItems[0] != null
                        ? AssetImage("assets/profile_image_" +
                            rankingItems[index].profileImage.toString() +
                            ".png")
                        : AssetImage("assets/profile_image_" + "1" + ".png"))),
                DataCell(rankingItems[index] != null
                    ? Text(rankingItems[index].userName)
                    : Text("Guest")),
                DataCell(rankingItems[index] != null
                    ? Text(rankingItems[index].levelTwoTime.toString())
                    : Text("1:00:00")),
                DataCell(rankingItems[index] != null
                    ? Image(
                        width: size.width * 0.07,
                        image: rankingItems[index].state == null
                            ? AssetImage("assets/Deutschland.png")
                            : AssetImage(
                                "assets/" + rankingItems[index].state + ".png"))
                    : Image(
                        width: size.width * 0.07,
                        image: AssetImage("assets/Deutschland.png"))),
              ]),
            ))
      ],
    );
  }
}
