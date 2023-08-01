import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///Button that when clicked logs the user out
class LogoutButton extends StatelessWidget {
  LogoutButton({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Sign out", style: TextStyle(color: Colors.red, fontSize: 17))
        ]));
  }
}
