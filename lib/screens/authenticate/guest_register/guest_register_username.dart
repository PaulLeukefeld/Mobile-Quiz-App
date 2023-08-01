import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/alerts/input_alert.dart';
import 'package:mobile_quiz_app/models/buttons/next_button.dart';
import 'package:mobile_quiz_app/screens/authenticate/guest_register/guest_register_avatar.dart';
import 'package:mobile_quiz_app/models/guest_user.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/services/database.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class GuestRegisterUsername extends StatefulWidget {
  GuestRegisterUsername({@required this.user, @required this.guestUserData});
  final UserModel user;
  final GuestUser guestUserData;

  @override
  _GuestRegisterUsernameState createState() => _GuestRegisterUsernameState();
}

class _GuestRegisterUsernameState extends State<GuestRegisterUsername> {
  /// Creating a focus node to put the cursor on the username textfield
  FocusNode guestRegisterUsernameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    guestRegisterUsernameFocusNode.requestFocus();
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
              pageController.animateToPage(2,
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
              Text("Erstelle deinen Speedquiz \n Benutzernamen",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Controller.getSize(context).width * 0.125),
                child: Material(
                  elevation: 10.0,
                  child: TextField(
                    focusNode: guestRegisterUsernameFocusNode,
                    controller: guestRegisterEnterUsernameController,
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Benutzername'),
                  ),
                ),
              ),
              NextButton(onPressed: () async {
                /// Checking if the username field is empty
                if (guestRegisterEnterUsernameController.text.isEmpty) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return InputAlert(
                            alertText: "Gib einen Benutzernamen ein.");
                      });
                }

                /// Checking if the username is too short
                else if (guestRegisterEnterUsernameController.text.isNotEmpty &&
                    guestRegisterEnterUsernameController.text.length < 3) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return InputAlert(
                            alertText:
                                "Dein Benutzername ist zu kurz \n(min. 3 Zeichen)");
                      });
                }

                /// Checking if the username is too long
                else if (guestRegisterEnterUsernameController.text.isNotEmpty &&
                    guestRegisterEnterUsernameController.text.length > 12) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return InputAlert(
                            alertText:
                                'Dein Benutzername ist zu lang \n(max. 12 Zeichen)');
                      });
                } else if (await DatabaseService()
                    .userCollection
                    .where("name",
                        isEqualTo: guestRegisterEnterUsernameController.text)
                    .get()
                    .then((value) => value.size > 0 ? true : false)) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return InputAlert(
                            alertText:
                                'Dein Benutzername existiert bereits. Wähle einen anderen Benutzernamen.');
                      });
                } else {
                  /// Setting the email value of the user
                  widget.guestUserData
                      .setUsername(guestRegisterEnterUsernameController.text);

                  /// Closing the keyboard
                  guestRegisterUsernameFocusNode.requestFocus(null);
                  guestRegisterUsernameFocusNode.unfocus();

                  /// Navigating the user to the next page
                  pageController == null
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GuestRegisterAvatar(
                                  user: widget.user,
                                  guestUserData: widget.guestUserData),
                              settings:
                                  RouteSettings(name: 'GuestRegisterAvatar')),
                        )
                      : pageController.animateToPage(4,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.linear);
                }
              })
            ],
          ),
        ));
  }
}
