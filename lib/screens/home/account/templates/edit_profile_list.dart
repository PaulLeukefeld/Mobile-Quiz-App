import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_quiz_app/models/buttons/change_avatar_button.dart';
import 'package:mobile_quiz_app/models/buttons/change_state_buttton.dart';
import 'package:mobile_quiz_app/models/buttons/delete_account_button.dart';
import 'package:mobile_quiz_app/models/buttons/guest_create_account_button.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

// ignore: must_be_immutable
class EditProfileList extends StatelessWidget {
  EditProfileList({
    @required this.user,
  });
  final UserModel user;

  UserModel _userAccountData;

  @override
  Widget build(BuildContext context) {
    final userMetaData = (Provider.of<UserModel>(context) == null)
        ? new UserModel()
        : Provider.of<UserModel>(context);
    _userAccountData = userMetaData;

    return SizedBox(
      width: Controller.getSize(context).width * 0.9,
      child: DataTable(horizontalMargin: 1, columns: [
        DataColumn(
          label: Text(
            'PROFIL BEARBEITEN',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ], rows: [
        DataRow(
          cells: <DataCell>[
            DataCell(
                ChangeAvatarButton(user: user, userData: _userAccountData)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(ChangeStateButton(user: user, userData: _userAccountData)),
          ],
        ),

        /// Checking if the user is a guest user
        _userAccountData.guestUser
            ? DataRow(
                cells: <DataCell>[
                  DataCell(GuestCreateAccountButton(
                      user: user, userData: _userAccountData)),
                ],
              )
            : DataRow(
                cells: <DataCell>[
                  DataCell(DeleteAccountButton(user: user)),
                ],
              )
      ]),
    );
  }
}
