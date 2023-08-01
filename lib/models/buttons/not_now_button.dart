import 'package:flutter/material.dart';

class NotNowButton extends StatelessWidget {
  NotNowButton({@required this.onPressed});
  final GestureTapCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          primary: Color.fromRGBO(10, 122, 255, 1),
        ),
        child: Text("Nicht jetzt", style: TextStyle(fontSize: 15)));
  }
}
