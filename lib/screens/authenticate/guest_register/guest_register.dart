import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/screens/authenticate/guest_register/guest_register_avatar.dart';
import 'package:mobile_quiz_app/screens/authenticate/guest_register/guest_register_email.dart';
import 'package:mobile_quiz_app/screens/authenticate/guest_register/guest_register_password.dart';
import 'package:mobile_quiz_app/screens/authenticate/guest_register/guest_register_state.dart';
import 'package:mobile_quiz_app/screens/authenticate/guest_register/guest_register_username.dart';
import 'package:mobile_quiz_app/models/guest_user.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class GuestRegister extends StatefulWidget {
  const GuestRegister({@required this.user});
  final UserModel user;

  @override
  _GuestRegisterState createState() => _GuestRegisterState(user: user);
}

class _GuestRegisterState extends State<GuestRegister> {
  _GuestRegisterState({this.user});
  final UserModel user;

  ///Variable used for loading widget
  bool loading = false;

  /// Variable that holds the new user object
  GuestUser guestUser = new GuestUser();

  @override
  Widget build(BuildContext context) {
    /// Setting the prefered orientation to portrait mode
    Controller.setPreferedOrientation();

    /// List of Screens used in this screen
    List<Widget> _guestScreens = [
      GuestRegisterState(user: user, guestUserData: guestUser),
      GuestRegisterEmail(user: user, guestUserData: guestUser),
      GuestRegisterPassword(user: user, guestUserData: guestUser),
      GuestRegisterUsername(user: user, guestUserData: guestUser),
      GuestRegisterAvatar(user: user, guestUserData: guestUser),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: new NeverScrollableScrollPhysics(),
              children: _guestScreens,
              controller: pageController,
            ),
          )
        ],
      ),
    );
  }
}
