import 'package:flutter/material.dart';

class FAQButton extends StatelessWidget {
  FAQButton({@required this.onPressed});
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "FAQ",
            style: TextStyle(color: Colors.black),
          ),
          Icon(Icons.keyboard_arrow_right_sharp, color: Colors.grey)
        ],
      ),
      onPressed: onPressed,
    );
  }
}
