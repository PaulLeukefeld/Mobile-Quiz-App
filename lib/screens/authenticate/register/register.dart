import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/screens/authenticate/register/create_username_screen.dart';
import 'package:mobile_quiz_app/screens/authenticate/register/enter_email_screen.dart';
import 'package:mobile_quiz_app/screens/authenticate/register/enter_password_screen.dart';
import 'package:mobile_quiz_app/screens/authenticate/register/notification_screen.dart';
import 'package:mobile_quiz_app/screens/authenticate/register/pick_avatar_screen.dart';
import 'package:mobile_quiz_app/screens/authenticate/register/pick_state_screen.dart';
import 'package:mobile_quiz_app/models/new_user.dart';
import 'package:mobile_quiz_app/screens/authenticate/register/privacy_screen.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';
import 'package:mobile_quiz_app/shared/loading.dart';

class Register extends StatefulWidget {
  Register({this.toggleView});
  final Function toggleView;

  @override
  _RegisterState createState() => _RegisterState(toggleView: toggleView);
}

class _RegisterState extends State<Register> {
  _RegisterState({@required this.toggleView});
  final Function toggleView;

  /// Variable used for loading widget
  bool loading = false;

  /// Creating a new user instance that holds data about the user
  NewUser newUser = new NewUser();

  @override
  Widget build(BuildContext context) {
    /// Setting the prefered orientation to portrait mode
    Controller.setPreferedOrientation();

    /// List of Screens used in this screen
    List<Widget> _screens = [
      PrivacyScreen(toggleView: toggleView),
      NotificationScreen(
        pageController: pageController,
        newUser: newUser,
      ),
      PickState(
          newUser: this.newUser,
          pageController: pageController,
          toggleView: this.toggleView),
      EnterEmail(newUser: this.newUser, pageController: pageController),
      EnterPassword(newUser: this.newUser, pageController: pageController),
      CreateUsername(newUser: this.newUser, pageController: pageController),
      PickAvatar(newUser: this.newUser, pageController: pageController),
    ];

    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: PageView(
                      children: _screens,
                      controller: pageController,
                      physics: new NeverScrollableScrollPhysics()),
                ),
              ],
            ));
  }
}
