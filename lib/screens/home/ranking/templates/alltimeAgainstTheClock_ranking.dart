import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class AllTimeAgainstTheClockRanking extends StatefulWidget {
  @override
  _AllTimeAgainstTheClockRankingState createState() =>
      _AllTimeAgainstTheClockRankingState();
}

class _AllTimeAgainstTheClockRankingState
    extends State<AllTimeAgainstTheClockRanking> {
  List<UserModel> _users;

  @override
  Widget build(BuildContext context) {
    final rankingItems = (Provider.of<List<UserModel>>(context) == null)
        ? []
        : Provider.of<List<UserModel>>(context);
    _users = rankingItems;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: Controller.getSize(context).width * 0.09),
            Text("Gegen die Zeit",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        DataTable(
            sortColumnIndex: currentRankingSortColumn,
            sortAscending: rankingIsAscending,
            dataRowHeight: Controller.getHeight(context) * 0.085,
            horizontalMargin: 0,
            columnSpacing: Controller.getSize(context).width * 0.08,
            columns: [
              DataColumn(label: Text('Avatar')),
              DataColumn(label: Text('Name')),
              DataColumn(
                label: Text('Fragen'),
              ),
              DataColumn(label: Text('Ort'))
            ],
            rows: List<DataRow>.generate(
              _users.length,
              (index) => DataRow(cells: [
                DataCell(Controller.createRankingAvatar(
                    context, rankingItems, index)),
                DataCell(rankingItems[index] != null
                    ? Text(rankingItems[index].userName)
                    : Text("Guest")),
                DataCell(rankingItems[index] != null
                    ? Center(
                        child: Text(rankingItems[index]
                            .alltimeAgainstTheTimeScore
                            .toString()))
                    : Center(child: Text("0"))),
                DataCell(rankingItems[index] != null
                    ? Image(
                        width: Controller.getSize(context).width * 0.07,
                        image: rankingItems[index].state == null
                            ? AssetImage("assets/states/Deutschland.png")
                            : AssetImage("assets/states/" +
                                rankingItems[index].state +
                                ".png"))
                    : Image(
                        width: Controller.getSize(context).width * 0.07,
                        image: AssetImage("assets/states/Deutschland.png"))),
              ]),
            ))
      ],
    );
  }
}
