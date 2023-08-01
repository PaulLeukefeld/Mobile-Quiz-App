import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///Store item button that when clicked, makes the user buy the given store item
class StoreItemButton extends StatelessWidget {
  StoreItemButton({@required this.onPressed, this.name, this.value});
  final GestureTapCallback onPressed;
  final String name;
  final double value;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        color: Colors.white,
        onPressed: onPressed,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(name, style: TextStyle(color: Colors.black))]));
  }
}
