import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/screens/home/account/templates/delete_account.dart';

class DeleteAccountButton extends StatelessWidget {
  DeleteAccountButton({@required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Account Löschen",
            style: TextStyle(color: Colors.black),
          ),
          Icon(Icons.keyboard_arrow_right_sharp, color: Colors.grey)
        ],
      ),
      onPressed: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop,
                child: DeleteAccount(user: user)));
      },
    );
  }
}
