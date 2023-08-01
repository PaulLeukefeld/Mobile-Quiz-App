import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_quiz_app/models/buttons/logout_button.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/screens/home/account/templates/contact_list.dart';
import 'package:mobile_quiz_app/screens/home/account/templates/edit_profile_list.dart';
import 'package:mobile_quiz_app/screens/home/account/templates/legal_list.dart';
import 'package:mobile_quiz_app/screens/home/account/templates/main_account.dart';
import 'package:mobile_quiz_app/services/auth.dart';
import 'package:mobile_quiz_app/services/database.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

///Account & Settings pages
class Account extends StatefulWidget {
  Account({@required this.user});

  final UserModel user;

  @override
  _AccountState createState() => _AccountState(user: user);
}

class _AccountState extends State<Account> {
  _AccountState({@required this.user});
  final UserModel user;

  /// Authservice variable
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    /// Setting the device orientation to portrait mode
    Controller.setPreferedOrientation();

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: Controller.getHeight(context) * 0.1),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Controller.getSize(context).width * 0.07,
                  ),
                  child: Text("Account",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                )
              ]),
              SizedBox(height: Controller.getHeight(context) * 0.02),
              StreamProvider<UserModel>.value(
                  initialData: null,
                  value: DatabaseService(uid: user.uid).userMetaData,
                  child: MainAccount()),
              SizedBox(height: Controller.getHeight(context) * 0.01),
              StreamProvider<UserModel>.value(
                  initialData: user,
                  value: DatabaseService(uid: user.uid).userMetaData,
                  child: EditProfileList(user: user)),
              ContactList(),
              LegalList(),
              LogoutButton(
                onPressed: () async {
                  await _auth.signOut(context);
                },
              ),
              SizedBox(height: Controller.getHeight(context) * 0.025),
            ],
          ),
        ));
  }
}
