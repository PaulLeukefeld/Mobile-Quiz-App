import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_quiz_app/models/alerts/input_alert.dart';
import 'package:mobile_quiz_app/models/buttons/send_again_button.dart';
import 'package:mobile_quiz_app/models/new_user.dart';
import 'package:mobile_quiz_app/services/auth.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class ConfirmEmail extends StatefulWidget {
  final NewUser newUser;
  final PageController pageController;

  ConfirmEmail({@required this.newUser, @required this.pageController});

  @override
  _ConfirmEmailState createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
  /// The [Loading] widget is displayed if this variable is set to true.
  bool loading = false;

  /// The [auth] instance that accesses Firebase auth
  final auth = FirebaseAuth.instance;

  /// The [user] instance that accesses data about the user
  User user;

  /// The [Timer] instance used to periodically call checkUserEmailVerified
  /// method
  Timer timer;

  @override
  void initState() {
    user = auth.currentUser;

    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified(widget.newUser);
    });

    super.initState();
  }

  @override
  void dispose() {
    //pageController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///Setting the prefered orientation to portrait mode
    Controller.setPreferedOrientation();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [],
          backgroundColor: Colors.white,
          leading: IconButton(
            icon:
                Icon(Icons.arrow_back, color: Color.fromRGBO(10, 122, 255, 1)),
            onPressed: () {
              widget.pageController.animateToPage(6,
                  duration: Duration(milliseconds: 200), curve: Curves.linear);
            },
          ),
          elevation: 0.0,
        ),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Center(
            child: Container(
                child: Lottie.asset('assets/email_confirmation.json',
                    height: Controller.getHeight(context) * 0.45,
                    fit: BoxFit.contain,
                    repeat: true)),
          ),
          Text("Email bestätigen",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          Text(
              '''Wir haben dir einen Link an deine Email \n Adresse geschickt. Bitte klicke auf den \n Link um deine Email Adresse \n zu bestätigen.''',
              textAlign: TextAlign.center),
          SendAgainButton(onPressed: () {
            user.sendEmailVerification();
          })
        ]));
  }

  /// Method that checks if the email has been verified
  Future checkEmailVerified(NewUser newUser) async {
    User user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      /// Canceling the timer instance
      timer.cancel();

      /// Registering the user with email and password
      dynamic result = await AuthService().registerWithEmailandPassword(
          newUser.getUserEmail(),
          newUser.getUserPassword(),
          newUser.getUserState(),
          newUser.getUsername(),
          newUser.getProfileImage(),
          false);

      /// Showing the user an alert if the email is already in use
      /// Move this to the email screen
      if (result == "EMAIL_IN_USE") {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return InputAlert(
                alertText:
                    '''Es existiert bereits einen account\n mit dieser Email Adresse.''',
              );
            });

        setState(() {
          loading = false;
        });
      } else if (result == null) {
        /// Displays and error message if the user
        /// coudln't be signed in with the
        /// provided email and password.
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return InputAlert(
                alertText:
                    '''Es ist ein Fehler aufgetreten, bitte versuche es nochmal.''',
              );
            });

        setState(() {
          loading = false;
        });
      }
    }
  }
}
