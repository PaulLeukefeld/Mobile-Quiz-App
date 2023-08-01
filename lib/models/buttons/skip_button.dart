import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  SkipButton({@required this.onPressed});
  final GestureTapCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          primary: Color.fromRGBO(10, 122, 255, 1),
        ),
        child: Text("Überspringen", style: TextStyle(fontSize: 15)));
  }
}
