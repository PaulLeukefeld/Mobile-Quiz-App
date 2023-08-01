import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_quiz_app/models/information/profile_image.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class MainAccount extends StatefulWidget {
  @override
  _MainAccountState createState() => _MainAccountState();
}

class _MainAccountState extends State<MainAccount> {
  UserModel _user;

  @override
  Widget build(BuildContext context) {
    final userMetaData = (Provider.of<UserModel>(context) == null)
        ? new UserModel()
        : Provider.of<UserModel>(context);

    _user = userMetaData;

    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.fromLTRB(Controller.getSize(context).width * 0.1, 0,
            Controller.getSize(context).width * 0.05, 0),
        child: ProfileImage(
            user: _user, size: Controller.getSize(context).width * 0.12),
      ),
      Text(_user.userName ?? '',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
    ]);
  }
}
