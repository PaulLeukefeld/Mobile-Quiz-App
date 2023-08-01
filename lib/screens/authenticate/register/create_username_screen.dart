import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/alerts/input_alert.dart';
import 'package:mobile_quiz_app/models/buttons/next_button.dart';
import 'package:mobile_quiz_app/models/new_user.dart';
import 'package:mobile_quiz_app/screens/authenticate/register/pick_avatar_screen.dart';
import 'package:mobile_quiz_app/services/database.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

// ignore: must_be_immutable
class CreateUsername extends StatefulWidget {
  CreateUsername({this.newUser, this.pageController});
  dynamic newUser;
  final PageController pageController;
  @override
  _CreateUsernameState createState() =>
      _CreateUsernameState(newUser: newUser, pageController: pageController);
}

class _CreateUsernameState extends State<CreateUsername> {
  _CreateUsernameState({this.newUser, this.pageController});
  final NewUser newUser;
  final PageController pageController;

  /// Focusnode that show a cursor on the username text field
  FocusNode enterUsernameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    enterUsernameFocusNode.requestFocus();
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
            icon:
                Icon(Icons.arrow_back, color: Color.fromRGBO(10, 122, 255, 1)),
            onPressed: () {
              pageController.animateToPage(4,
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
              Text("Erstelle deinen Quizbase \n Benutzernamen",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: '',
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Controller.getSize(context).width * 0.125),
                child: Material(
                  elevation: 10.0,
                  child: TextField(
                    focusNode: enterUsernameFocusNode,
                    controller: registerEnterUsernameController,
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Benutzername'),
                  ),
                ),
              ),
              NextButton(onPressed: () async {
                /// Checking if the username field is empty
                if (registerEnterUsernameController.text.isEmpty) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return InputAlert(
                            alertText: "Gib einen Benutzernamen ein.");
                      });
                }

                /// Checking if the entered username is too short
                else if (registerEnterUsernameController.text.isNotEmpty &&
                    registerEnterUsernameController.text.length < 3) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return InputAlert(
                            alertText:
                                "Dein Benutzername ist zu kurz (3 Zeichen min.)");
                      });
                }

                /// Checking if the entered username is too long
                else if (registerEnterUsernameController.text.isNotEmpty &&
                    registerEnterUsernameController.text.length > 12) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return InputAlert(
                            alertText:
                                'Dein Benutzername ist zu lang \n(12 Zeichen max.)');
                      });
                } else if (await DatabaseService()
                    .userCollection
                    .where("name",
                        isEqualTo: registerEnterUsernameController.text)
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
                  setState(() {
                    newUser == null
                        ? NewUser()
                            .setUsername(registerEnterUsernameController.text)
                        : newUser
                            .setUsername(registerEnterUsernameController.text);
                  });

                  if (pageController == null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PickAvatar(
                                newUser: newUser,
                                pageController: pageController),
                            settings:
                                RouteSettings(name: 'PickAvatarRegister')));
                  } else {
                    /// Removing the focus
                    enterUsernameFocusNode.requestFocus(null);
                    enterUsernameFocusNode.unfocus();

                    /// Navigating to the next page
                    pageController.animateToPage(6,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.linear);
                  }
                }
              })
            ],
          ),
        ));
  }
}
