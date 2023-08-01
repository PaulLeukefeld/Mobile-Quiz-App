import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {
  ForgotPasswordButton({@required this.onPressed});
  final GestureTapCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          primary: Color.fromRGBO(10, 122, 255, 1),
        ),
        child: Text("Passwort vergessen?", style: TextStyle(fontSize: 15)));
  }
}
