import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mobile_quiz_app/models/alerts/input_alert.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/screens/home/account/templates/change_avatar.dart';

class ChangeAvatarButton extends StatelessWidget {
  ChangeAvatarButton({this.user, this.userData});
  final UserModel user;
  final UserModel userData;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Meinen Avatar wechseln",
              style: TextStyle(color: Colors.black),
            ),
            Icon(Icons.keyboard_arrow_right_sharp, color: Colors.grey)
          ],
        ),
        onPressed: () {
          !userData.guestUser
              ? Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: ChangeAvatar(user: user)))
              : showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return InputAlert(
                        alertText:
                            "Erstelle einen Account um deinen Avatar wechseln zu können");
                  });
        });
  }
}
