import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/buttons/next_skip_buttons.dart';
import 'package:mobile_quiz_app/models/new_user.dart';
import 'package:mobile_quiz_app/screens/authenticate/register/enter_email_screen.dart';
import 'package:mobile_quiz_app/services/auth.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

// ignore: must_be_immutable
class PickState extends StatefulWidget {
  PickState({this.newUser, this.toggleView, this.pageController});
  dynamic newUser;
  final PageController pageController;
  final Function toggleView;

  @override
  _PickStateState createState() => _PickStateState(
      newUser: newUser, toggleView: toggleView, pageController: pageController);
}

class _PickStateState extends State<PickState> {
  _PickStateState({this.newUser, this.toggleView, this.pageController});
  final NewUser newUser;
  final Function toggleView;
  final PageController pageController;

  /// The [AuthService] variable that is used for user authentication.
  final AuthService _auth = AuthService();

  /// Initializing a focusnode to hide the keyboard
  FocusNode stateFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Controller.resetOnboardingIndex();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    stateFocusNode.requestFocus(null);
    stateFocusNode.unfocus();

    ///Setting the prefered orientation to portrait mode
    Controller.setPreferedOrientation();

    /// Setting the default state as Bayern
    newUser != null
        ? newUser.setUserState(statesList[1])
        : NewUser().setUserState(statesList[1]);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [],
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(10, 122, 255, 1)),
          onPressed: () {
            widget.pageController.animateToPage(1,
                duration: Duration(milliseconds: 200), curve: Curves.linear);
          },
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, Controller.getHeight(context) * 0.05, 0,
            Controller.getHeight(context) * 0.09),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("In welchem Staat lebst du?",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Controller.getSize(context).width * 0.1),
                child: Container(
                  height: Controller.getHeight(context) * 0.2,
                  child: CupertinoPicker(
                      itemExtent: 30,
                      scrollController:
                          FixedExtentScrollController(initialItem: 1),
                      onSelectedItemChanged: (value) {
                        newUser.setUserState(statesList[value]);
                      },
                      children: scrollStates),
                ),
              ),
              NextSkipButtons(onPressedNext: () {
                widget.pageController == null
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EnterEmail(
                                newUser: newUser,
                                pageController: pageController),
                            settings:
                                RouteSettings(name: 'EnterEmailRegister')),
                      )
                    : widget.pageController.animateToPage(3,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.linear);
              }, onPressedSkip: () async {
                await _auth.createGuestUser();
              }),
            ]),
      ),
    );
  }
}
