import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/alerts/input_alert.dart';
import 'package:mobile_quiz_app/models/buttons/next_button.dart';
import 'package:mobile_quiz_app/screens/authenticate/guest_register/guest_register_password.dart';
import 'package:mobile_quiz_app/models/guest_user.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class GuestRegisterEmail extends StatefulWidget {
  GuestRegisterEmail({
    @required this.user,
    @required this.guestUserData,
  });
  final UserModel user;
  final GuestUser guestUserData;

  @override
  _GuestRegisterEmailState createState() => _GuestRegisterEmailState();
}

class _GuestRegisterEmailState extends State<GuestRegisterEmail> {
  /// Creating a FocusNode to put the cursor on the email field
  FocusNode guestRegisterEmailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    guestRegisterEmailFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [],
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(10, 122, 255, 1)),
          onPressed: () {
            guestRegisterEmailFocusNode.requestFocus(null);
            guestRegisterEmailFocusNode.unfocus();
            pageController.animateToPage(0,
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
            Text("Was ist deine \nEmail-Adresse?",
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
                    focusNode: guestRegisterEmailFocusNode,
                    controller: guestRegisterEnterEmailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  ),
                ),
              ),
            ),
            NextButton(onPressed: () async {
              /// Checking if the email field is empty
              if (guestRegisterEnterEmailController.text.isEmpty) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return InputAlert(
                          alertText: 'Bitte gib eine Email Addresse ein.');
                    });
              }

              /// Checking if a valid email address has been entered
              else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(guestRegisterEnterEmailController.text) &&
                  guestRegisterEnterEmailController.text.isNotEmpty) {
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
                widget.guestUserData
                    .setUserEmail(guestRegisterEnterEmailController.text);

                /// Navigating to the next page
                pageController == null
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GuestRegisterPassword(
                                user: widget.user,
                                guestUserData: widget.guestUserData),
                            settings:
                                RouteSettings(name: 'GuestRegisterPassword')),
                      )
                    : pageController.animateToPage(2,
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
