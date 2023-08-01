import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///Button that when clicked logs the user in
class LoginNavigationButton extends StatelessWidget {
  LoginNavigationButton({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text("Log in",
          style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'SFPro',
              color: Color.fromRGBO(10, 122, 255, 1))),
      onPressed: onPressed,
    );
  }
}
