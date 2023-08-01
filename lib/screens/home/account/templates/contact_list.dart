import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/buttons/contact_button.dart';
import 'package:mobile_quiz_app/models/buttons/faq_button.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class ContactList extends StatelessWidget {
  const ContactList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Controller.getSize(context).width * 0.9,
      child: DataTable(horizontalMargin: 1, columns: [
        DataColumn(
          label: Text(
            'KONTAKT',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ], rows: [
        DataRow(
          cells: <DataCell>[
            DataCell(ContactButton(
              onPressed: () => Controller.launchContactPage(),
            )),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(FAQButton(
              onPressed: () => Controller.launchFAQPage(),
            )),
          ],
        ),
      ]),
    );
  }
}
