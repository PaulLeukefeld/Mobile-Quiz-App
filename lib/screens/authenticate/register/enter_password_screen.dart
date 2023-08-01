import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/alerts/input_alert.dart';
import 'package:mobile_quiz_app/models/buttons/next_button.dart';
import 'package:mobile_quiz_app/models/new_user.dart';
import 'package:mobile_quiz_app/screens/authenticate/register/create_username_screen.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

// ignore: must_be_immutable
class EnterPassword extends StatefulWidget {
  EnterPassword({this.newUser, this.pageController});
  dynamic newUser;
  final PageController pageController;
  @override
  _EnterPasswordState createState() =>
      _EnterPasswordState(newUser: newUser, pageController: pageController);
}

class _EnterPasswordState extends State<EnterPassword> {
  _EnterPasswordState({this.newUser, this.pageController});
  final NewUser newUser;
  final PageController pageController;

  /// Creating a focus node so that the cursor shows up on the password field
  FocusNode registerPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///Setting the prefered orientation to portrait mode
    Controller.setPreferedOrientation();

    /// Requesting a cursor focus on the text field
    registerPasswordFocusNode.requestFocus();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [],
          backgroundColor: Colors.white,
          leading: IconButton(
            icon:
                Icon(Icons.arrow_back, color: Color.fromRGBO(10, 122, 255, 1)),
            onPressed: () {
              pageController.animateToPage(3,
                  duration: Duration(milliseconds: 200), curve: Curves.linear);
            },
          ),
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(0, Controller.getHeight(context) * 0.05,
              0, Controller.getHeight(context) * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Wähle dein Passwort",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Controller.getSize(context).width * 0.125),
                child: Material(
                  elevation: 10.0,
                  child: TextField(
                    focusNode: registerPasswordFocusNode,
                    controller: registerEnterPasswordController,
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Passwort'),
                    obscureText: true,
                  ),
                ),
              ),
              NextButton(onPressed: () async {
                /// Checking if the password field is empty
                if (registerEnterPasswordController.text.isEmpty) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return InputAlert(
                            alertText: 'Bitte wähle ein Passwort');
                      });
                }

                /// Checking if the password is long enough
                else if (registerEnterPasswordController.text.isNotEmpty &&
                    registerEnterPasswordController.text.length < 6) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return InputAlert(
                            alertText:
                                "Dein Passwort ist zu kurz (6 Zeichen min.)");
                      });
                } else {
                  /// Setting the email value of the user
                  setState(() {
                    newUser == null
                        ? NewUser().setUserPassword(
                            registerEnterPasswordController.text)
                        : newUser.setUserPassword(
                            registerEnterPasswordController.text);
                  });

                  /// Navigating the user to the next page
                  pageController == null
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateUsername(
                                  newUser: newUser,
                                  pageController: pageController),
                              settings: RouteSettings(name: 'CreateUsername')),
                        )
                      : pageController.animateToPage(5,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.linear);
                }
              })
            ],
          ),
        ));
  }
}
