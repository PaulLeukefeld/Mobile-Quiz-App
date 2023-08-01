import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/screens/authenticate/guest_register/guest_register.dart';
import 'package:mobile_quiz_app/models/user_model.dart';

class GuestCreateAccountButton extends StatefulWidget {
  GuestCreateAccountButton({@required this.user, @required this.userData});
  final UserModel user;
  final UserModel userData;

  @override
  _GuestCreateAccountButtonState createState() =>
      _GuestCreateAccountButtonState();
}

class _GuestCreateAccountButtonState extends State<GuestCreateAccountButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Account erstellen",
            style: TextStyle(color: Colors.black),
          ),
          Icon(Icons.keyboard_arrow_right_sharp, color: Colors.grey)
        ],
      ),
      onPressed: () {
        widget.userData.guestUser
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GuestRegister(user: widget.user),
                    settings: RouteSettings(name: 'GuestRegister')))
            : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                "Du hast bereits einen Account erstellt",
                textAlign: TextAlign.center,
              )));
      },
    );
  }
}
