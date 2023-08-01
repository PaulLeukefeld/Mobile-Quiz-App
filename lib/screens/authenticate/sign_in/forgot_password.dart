import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/alerts/input_alert.dart';
import 'package:mobile_quiz_app/models/alerts/success_alert.dart';
import 'package:mobile_quiz_app/models/buttons/reset_password_buttton.dart';
import 'package:mobile_quiz_app/services/auth.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

/// Focusnode that sets the cursor onto the email textfield
FocusNode forgotPasswordFocusNode = FocusNode();

class _ForgotPasswordState extends State<ForgotPassword> {
  ///Authservice variable to handle user authentication
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();

    /// Setting the language code to german for the reset email
    _auth.setLanguageCode("de");
  }

  @override
  Widget build(BuildContext context) {
    /// Setting the prefered orientation
    Controller.setPreferedOrientation();

    forgotPasswordFocusNode.requestFocus();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Passwort Reset", style: TextStyle(color: Colors.black)),
        actions: [],
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(10, 122, 255, 1)),
          onPressed: () {
            /// Resetting the forget password controller
            Controller.resetForgetPasswordController();

            /// Navigating the user back to the login screen
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Controller.getSize(context).width * 0.1,
                vertical: Controller.getHeight(context) * 0.025),
            child: Text(
              "Bitte gib die Email Adresse ein, welche du für diesen Account verwendet hast.",
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Controller.getSize(context).width * 0.1,
                vertical: Controller.getHeight(context) * 0.025),
            child: Text(
              "Wir werden dir eine Anleitung an deine Email addresse senden, wie du dein Passwort zurücksetzen kannst.",
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Controller.getSize(context).width * 0.1,
                vertical: Controller.getHeight(context) * 0.025),
            child: Material(
              elevation: 10.0,
              child: TextField(
                controller: forgotPasswordEmailController,
                focusNode: forgotPasswordFocusNode,
                decoration:
                    textInputDecoration.copyWith(hintText: 'Email Adresse'),
              ),
            ),
          ),
          ResetPasswordButton(onPressed: () {
            /// Checking if the email field is empty
            if (forgotPasswordEmailController.text.isEmpty) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return InputAlert(
                        alertText: 'Bitte gib deine Email Addresse ein.');
                  });
            }

            /// Checcking if the entered email address is valid
            else if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(forgotPasswordEmailController.text)) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return InputAlert(
                        alertText: 'Bitte gib eine gültge Email Addresse ein.');
                  });
            }

            /// Sending the reset email and notifying the user that the
            /// reset email has been sent
            else {
              _auth
                  .sendResetPasswordEmail(forgotPasswordEmailController.text)
                  .then((value) => showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return SuccesssAlert(
                            alertText:
                                'Wir haben die Anleitung an deine Email Adresse gesendet.');
                      }));
            }
          })
        ],
      ),
    );
  }
}
