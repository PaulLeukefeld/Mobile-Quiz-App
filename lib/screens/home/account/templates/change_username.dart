import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/alerts/input_alert.dart';
import 'package:mobile_quiz_app/models/buttons/save_button.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/services/analytics_service.dart';
import 'package:mobile_quiz_app/services/database.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class ChangeUsername extends StatefulWidget {
  ChangeUsername({
    @required this.user,
  });
  final UserModel user;

  @override
  _ChangeUsernameState createState() => _ChangeUsernameState(user: user);
}

class _ChangeUsernameState extends State<ChangeUsername> {
  FocusNode changeUsernameFocusNode = FocusNode();
  final UserModel user;

  _ChangeUsernameState({@required this.user});

  @override
  void initState() {
    super.initState();
    changeUsernameFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    /// Setting the value of the textfield to be the current username
    accountChangeUsernameController.text =
        user.userName == null ? "" : user.userName;

    /// Setting the text editing controller to be at the end
    accountChangeUsernameController.selection = TextSelection(
        baseOffset: user.userName.length, extentOffset: user.userName.length);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [],
          backgroundColor: Colors.white,
          leading: IconButton(
            icon:
                Icon(Icons.arrow_back, color: Color.fromRGBO(10, 122, 255, 1)),
            onPressed: () {
              Navigator.pop(context);
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
              Text("Wähle deinen neuen \n Speedquiz Benutzernamen",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Controller.getSize(context).width * 0.125),
                child: Material(
                  elevation: 10.0,
                  child: TextField(
                    focusNode: changeUsernameFocusNode,
                    controller: accountChangeUsernameController,
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Benutzername'),
                  ),
                ),
              ),
              SaveButton(onPressed: () async {
                if (accountChangeUsernameController.text.isEmpty) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return InputAlert(
                            alertText: "Gib einen Benutzernamen ein.");
                      });
                } else if (accountChangeUsernameController.text.isNotEmpty &&
                    accountChangeUsernameController.text.length < 3) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return InputAlert(
                            alertText:
                                "Dein Benutzername ist zu kurz (3 Zeichen min.)");
                      });
                } else if (accountChangeUsernameController.text.isNotEmpty &&
                    accountChangeUsernameController.text.length > 12) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return InputAlert(
                            alertText:
                                'Dein Benutzername ist zu lang \n(12 Zeichen max.)');
                      });
                } else {
                  /// Setting the email value of the user
                  DatabaseService(uid: widget.user.uid)
                      .updateUsername(accountChangeUsernameController.text);

                  /// Resetting the text editing controller
                  Controller.resetAllTextEditControllers();

                  /// Logging the username change
                  AnalyticsService().logUsernameChange();

                  /// Closing the dialog and unfocusing the textfield
                  Navigator.of(context).pop();
                  changeUsernameFocusNode.requestFocus(null);
                  changeUsernameFocusNode.unfocus();
                }
              })
            ],
          ),
        ));
  }
}
