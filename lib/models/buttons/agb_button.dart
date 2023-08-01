import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///Button that when clicked directs the user to the terms and conditions page
class AGBButton extends StatelessWidget {
  AGBButton({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        color: Colors.white,
        onPressed: onPressed,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text("AGB", style: TextStyle(color: Colors.black))]));
  }
}
