import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/alerts/input_alert.dart';
import 'package:mobile_quiz_app/models/buttons/forgot_password_button.dart';
import 'package:mobile_quiz_app/models/buttons/login_button.dart';
import 'package:mobile_quiz_app/models/textfields/email_textfield.dart';
import 'package:mobile_quiz_app/models/textfields/password_textfield.dart';
import 'package:mobile_quiz_app/screens/authenticate/sign_in/forgot_password.dart';
import 'package:mobile_quiz_app/services/auth.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';
import 'package:mobile_quiz_app/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  /// Authservice variable used for handleing user authentication
  final AuthService _auth = AuthService();

  /// Variable used for loading widget
  bool loading = false;

  /// Focus node that places the cursor on the email textfield
  FocusNode signInFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    signInFocusNode.requestFocus();
    Controller.resetOnboardingIndex();
  }

  @override
  Widget build(BuildContext context) {
    /// Setting the prefered orientation
    Controller.setPreferedOrientation();

    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: [],
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back,
                    color: Color.fromRGBO(10, 122, 255, 1)),
                onPressed: () {
                  setState(() {
                    widget.toggleView();
                  });
                },
              ),
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        child: Column(
                      children: [
                        Container(
                            width: Controller.getSize(context).width * 0.15,
                            height: Controller.getSize(context).width * 0.15,
                            child: Image.asset(
                              "assets/icons/app_icon.png",
                              scale: 2.0,
                            )),
                        SizedBox(height: Controller.getHeight(context) * 0.05),
                        EmailTextfield(
                          focusNode: signInFocusNode,
                        ),
                        PasswordTextfield(),
                      ],
                    )),
                    SizedBox(height: Controller.getHeight(context) * 0.055),
                    Container(
                        child: Column(
                      children: [
                        LoginButton(onPressed: () async {
                          /// Checking if the email text field is empty
                          if (signInEmailController.text.isEmpty) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return InputAlert(
                                      alertText:
                                          'Bitte gib deine Email Addresse ein.');
                                });
                          }

                          /// Checking if the password text field is empty
                          else if (signInPasswordController.text.isEmpty) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return InputAlert(
                                      alertText:
                                          'Bitte gib dein Passwort ein.');
                                });
                          } else {
                            /// Showing the user the loading widget
                            setState(() {
                              loading = true;
                            });

                            /// Signing in the user with the provided credentials
                            dynamic result =
                                await _auth.signInWithEmailandPassword(
                                    signInEmailController.text,
                                    signInPasswordController.text);

                            /// Resetting the sign in password controller
                            Controller.resetSignInPasswordController();

                            /// No longer showing the sign in widget if the
                            /// user ccouldn't be logged in and communicating
                            /// the error to the user
                            if (result == null) {
                              setState(() {
                                loading = false;
                              });

                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return InputAlert(
                                        alertText:
                                            'Dein Username/Passwort stimmt nicht.');
                                  });
                            }
                          }
                        }),
                        SizedBox(height: Controller.getHeight(context) * 0.01),
                        ForgotPasswordButton(onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword(),
                                  settings:
                                      RouteSettings(name: 'ForgotPassword')));
                        }),
                      ],
                    )),
                  ],
                ),
              ),
            ));
  }
}
