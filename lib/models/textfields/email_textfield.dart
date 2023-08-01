import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class EmailTextfield extends StatelessWidget {
  EmailTextfield({@required this.focusNode});
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Controller.getSize(context).width * 0.775,
      height: Controller.getSize(context).height * 0.085,
      child: TextField(
        controller: signInEmailController,
        focusNode: focusNode,
        onEditingComplete: () => focusNode.nextFocus(),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.0, height: 2.0, color: Colors.black),
        decoration: textInputDecoration.copyWith(hintText: 'Email'),
      ),
    );
  }
}
