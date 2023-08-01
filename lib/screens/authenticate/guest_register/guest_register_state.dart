import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/buttons/next_button.dart';
import 'package:mobile_quiz_app/screens/authenticate/guest_register/guest_register_email.dart';
import 'package:mobile_quiz_app/models/guest_user.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class GuestRegisterState extends StatefulWidget {
  const GuestRegisterState({
    @required this.user,
    @required this.guestUserData,
  });
  final UserModel user;
  final GuestUser guestUserData;

  @override
  _GuestRegisterStateState createState() =>
      _GuestRegisterStateState(user: user, guestUserData: guestUserData);
}

class _GuestRegisterStateState extends State<GuestRegisterState> {
  _GuestRegisterStateState({this.user, this.guestUserData});
  final UserModel user;
  final GuestUser guestUserData;

  /// Focusnode that disables the keyboard
  FocusNode guestRegisterFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    /// Setting the prefered device orientation
    Controller.setPreferedOrientation();

    /// Removing any focus
    guestRegisterFocusNode.requestFocus(null);
    guestRegisterFocusNode.unfocus();

    /// Setting the initial user state to Bayern
    guestUserData.setUserState(statesList[1]);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [],
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(10, 122, 255, 1)),
          onPressed: () {
            Controller.resetAllTextEditControllers();
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, Controller.getHeight(context) * 0.05, 0,
            Controller.getHeight(context) * 0.15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("In welchem Staat lebst du?",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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
                        guestUserData.setUserState(statesList[value]);
                      },
                      children: scrollStates),
                ),
              ),
              NextButton(onPressed: () {
                pageController == null
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GuestRegisterEmail(
                                user: user, guestUserData: guestUserData),
                            settings:
                                RouteSettings(name: 'GuestRegisterEmail')),
                      )
                    : pageController.animateToPage(1,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.linear);
              })
            ]),
      ),
    );
  }
}
