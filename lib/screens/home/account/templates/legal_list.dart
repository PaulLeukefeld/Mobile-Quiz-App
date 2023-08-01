import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/buttons/impressum_button.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class LegalList extends StatelessWidget {
  const LegalList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Controller.getSize(context).width * 0.9,
      child: DataTable(horizontalMargin: 1, columns: [
        DataColumn(
          label: Text(
            'RECHTSTEXTE',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ], rows: [
        DataRow(
          cells: <DataCell>[
            DataCell(ImpressumButton(
                onPressed: () => Controller.launchImprintPage())),
          ],
        ),
      ]),
    );
  }
}
