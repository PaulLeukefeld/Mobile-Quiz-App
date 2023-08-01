import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/alerts/input_alert.dart';
import 'package:mobile_quiz_app/models/buttons/next_button.dart';
import 'package:mobile_quiz_app/screens/authenticate/guest_register/guest_register_username.dart';
import 'package:mobile_quiz_app/models/guest_user.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class GuestRegisterPassword extends StatefulWidget {
  GuestRegisterPassword({
    @required this.user,
    @required this.guestUserData,
  });
  final UserModel user;
  final GuestUser guestUserData;

  @override
  _GuestRegisterPasswordState createState() => _GuestRegisterPasswordState();
}

class _GuestRegisterPasswordState extends State<GuestRegisterPassword> {
  /// Creating a focus node that puts the cursor on the password field
  FocusNode guestRegisterPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    guestRegisterPasswordFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [],
          backgroundColor: Colors.white,
          leading: IconButton(
            icon:
                Icon(Icons.arrow_back, color: Color.fromRGBO(10, 122, 255, 1)),
            onPressed: () {
              pageController.animateToPage(1,
                  duration: Duration(milliseconds: 200), curve: Curves.linear);
            },
          ),
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              0,
              Controller.getSize(context).height * 0.05,
              0,
              Controller.getSize(context).height * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Erstelle dein Speedquiz \n Passwort",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Controller.getSize(context).width * 0.125),
                child: Material(
                  elevation: 10.0,
                  child: Container(
                    child: TextField(
                      autofocus: true,
                      obscureText: true,
                      focusNode: guestRegisterPasswordFocusNode,
                      controller: guestRegisterEnterPasswordController,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Passwort'),
                    ),
                  ),
                ),
              ),
              NextButton(onPressed: () async {
                /// Checking if the user ented a password
                if (guestRegisterEnterPasswordController.text.isEmpty) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return InputAlert(
                            alertText: 'Bitte wähle ein Passwort');
                      });
                }

                /// Checking if the user enter a valid password
                else if (guestRegisterEnterPasswordController.text.isNotEmpty &&
                    guestRegisterEnterPasswordController.text.length < 6) {
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
                  widget.guestUserData.setUserPassword(
                      guestRegisterEnterPasswordController.text);

                  /// Navigating to the username page
                  pageController == null
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GuestRegisterUsername(
                                  user: widget.user,
                                  guestUserData: widget.guestUserData),
                              settings:
                                  RouteSettings(name: 'GuestRegisterUsername')),
                        )
                      : pageController.animateToPage(3,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.linear);
                }
              })
            ],
          ),
        ));
  }
}
