import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/alerts/input_alert.dart';
import 'package:mobile_quiz_app/models/buttons/next_button.dart';
import 'package:mobile_quiz_app/models/new_user.dart';
import 'package:mobile_quiz_app/screens/authenticate/register/enter_password_screen.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

// ignore: must_be_immutable
class EnterEmail extends StatefulWidget {
  EnterEmail({this.newUser, this.pageController});
  dynamic newUser;
  final PageController pageController;

  @override
  _EnterEmailState createState() =>
      _EnterEmailState(newUser: newUser, pageController: pageController);
}

class _EnterEmailState extends State<EnterEmail> {
  _EnterEmailState({this.newUser, this.pageController});

  final NewUser newUser;

  PageController pageController;

  /// Creating a new focus node that puts the cursor on the email field
  FocusNode registerEmailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    registerEmailFocusNode.requestFocus();
  }

  @override
  void dispose() {
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
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(10, 122, 255, 1)),
          onPressed: () {
            registerEmailFocusNode.requestFocus(null);
            registerEmailFocusNode.unfocus();

            pageController.animateToPage(2,
                duration: Duration(milliseconds: 200), curve: Curves.linear);
          },
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, Controller.getHeight(context) * 0.05, 0,
            Controller.getHeight(context) * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Was ist deine Email Adresse?",
                style: TextStyle(
                    fontFamily: '', fontSize: 22, fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Controller.getSize(context).width * 0.125),
              child: Material(
                elevation: 10.0,
                child: Container(
                  child: TextField(
                    autofocus: true,
                    focusNode: registerEmailFocusNode,
                    controller: registerEnterEmailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  ),
                ),
              ),
            ),
            NextButton(onPressed: () async {
              /// Checking if the text field is empty
              if (registerEnterEmailController.text.isEmpty) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return InputAlert(
                          alertText: 'Bitte gib eine Email Addresse ein.');
                    });
              }

              /// Checking if the user entered a valid email address
              else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(registerEnterEmailController.text) &&
                  registerEnterEmailController.text.isNotEmpty) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return InputAlert(
                          alertText:
                              'Bitte gib eine gültige Email Addresse ein.');
                    });
              } else {
                /// Setting the email value of the user
                setState(() {
                  newUser == null
                      ? NewUser()
                          .setUserEmail(registerEnterEmailController.text)
                      : newUser.setUserEmail(registerEnterEmailController.text);
                });

                /// Navigating to the next page
                pageController == null
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EnterPassword(
                                newUser: newUser,
                                pageController: pageController),
                            settings:
                                RouteSettings(name: 'EnterPasswordRegister')),
                      )
                    : pageController.animateToPage(4,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.linear);
              }
            })
          ],
        ),
      ),
    );
  }
}
