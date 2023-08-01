import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/screens/authenticate/authenticate.dart';
import 'home/home.dart';

// ignore: must_be_immutable
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Provider variable used for user authentication
    UserModel user = Provider.of<UserModel>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home(user: user);
    }
  }
}
