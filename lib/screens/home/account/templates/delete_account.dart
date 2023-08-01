import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/alerts/connectivity_alert.dart';
import 'package:mobile_quiz_app/models/alerts/input_alert.dart';
import 'package:mobile_quiz_app/models/buttons/confirm_delete_account_button.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/services/auth.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class DeleteAccount extends StatefulWidget {
  DeleteAccount({
    @required this.user,
  });
  final UserModel user;

  @override
  _DeleteAccountState createState() => _DeleteAccountState(user: user);
}

class _DeleteAccountState extends State<DeleteAccount> {
  FocusNode deleteAccountFocusNode = FocusNode();
  final UserModel user;

  _DeleteAccountState({@required this.user});

  @override
  void initState() {
    super.initState();
    deleteAccountFocusNode.requestFocus();
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
              deleteAccountFocusNode.requestFocus(null);
              deleteAccountFocusNode.unfocus();
              Navigator.pop(context);
            },
          ),
          elevation: 0.0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  'Account löschen',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Controller.getHeight(context) * 0.02,
                      horizontal: Controller.getSize(context).width * 0.125),
                  child: Text(
                    "Gib deine Email Adresse und Passwort ein um deinen Account zu löschen. \n \nDiese Aktion kann nicht rückgängig gemacht werden!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Controller.getHeight(context) * 0.0125,
                      horizontal: Controller.getSize(context).width * 0.125),
                  child: Material(
                    elevation: 10.0,
                    child: Container(
                      child: TextField(
                        autofocus: true,
                        focusNode: deleteAccountFocusNode,
                        controller: deleteAccountEmailTextController,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Controller.getHeight(context) * 0.0125,
                      horizontal: Controller.getSize(context).width * 0.125),
                  child: Material(
                    elevation: 10.0,
                    child: Container(
                      child: TextField(
                        obscureText: true,
                        controller: deleteAccountPasswordTextController,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Passwort'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0, Controller.getHeight(context) * 0.0125, 0, 0),
              child: ConfirmDeleteAccountButton(onPressed: () {
                /// Checking if the email field is empty
                if (deleteAccountEmailTextController.text.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return InputAlert(
                            alertText: "Bitte gib deine Email Adresse ein.");
                      });
                }

                /// Checking if the password field is empty
                else if (deleteAccountPasswordTextController.text.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return InputAlert(
                            alertText: "Bitte gib dein Passwort ein.");
                      });
                } else {
                  /// Deleting the user account and resetting the text editing controller
                  Controller.checkInternetConnection().then((result) => result
                      ? AuthService()
                          .deleteUser(deleteAccountEmailTextController.text,
                              deleteAccountPasswordTextController.text)
                          .then((value) => value == null
                              ? false
                              : value
                                  ? Navigator.pop(context)
                                  : showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return InputAlert(
                                            alertText:
                                                "Deine Email Adresse/Passwort stimmen nicht überein.");
                                      }))
                          .then((value) =>
                              Controller.resetAllTextEditControllers())
                      : showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return ConnectivityAlert(
                                alertText:
                                    'Verbinde dich mit dem Internet um deinen Account zu löschen.');
                          }));
                }
              }),
            )
          ],
        ));
  }
}
