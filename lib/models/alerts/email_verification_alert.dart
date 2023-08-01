import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_quiz_app/models/buttons/send_again_button.dart';
import 'package:mobile_quiz_app/services/auth.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class EmailVerificationAlert extends StatefulWidget {
  @override
  _EmailVerificationAlertState createState() => _EmailVerificationAlertState();
}

class _EmailVerificationAlertState extends State<EmailVerificationAlert> {
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 2), (result) {
      AuthService().processEmailVerification().then((result) {
        if (result != null) {
          if (result) {
            Navigator.pop(context);
            timer.cancel();
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: EdgeInsets.symmetric(
            horizontal: Controller.getSize(context).width * 0.005),
        content: Container(
          height: Controller.getHeight(context) * 0.6,
          width: Controller.getSize(context).width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: Container(
                    child: Lottie.asset(
                        'assets/animations/email_confirmation.json',
                        height: Controller.getHeight(context) * 0.2,
                        fit: BoxFit.contain,
                        repeat: true)),
              ),
              Text("Email bestätigen",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              Text(
                  '''Wir haben dir einen Link an deine Email \n Adresse geschickt. Bitte klicke auf den \n Link um deine Email Adresse \n zu bestätigen.''',
                  textAlign: TextAlign.center),
              SendAgainButton(onPressed: () {
                AuthService().setEmailVerification(
                    AuthService().getCurrentFirebaseUser());
              })
            ],
          ),
        ));
  }
}
