import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/services/database.dart';
import 'package:mobile_quiz_app/shared/controller.dart';
import 'package:mobile_quiz_app/shared/loading.dart';

///Profile Image Widged used to display the users profile image
class ProfileImage extends StatelessWidget {
  final double size;
  final UserModel user;
  ProfileImage({@required this.size, @required this.user});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
      stream: DatabaseService(uid: user.uid).userMetaData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserModel userData = snapshot.data;
          int _currentProfileImage =
              userData.profileImage == null ? 1 : userData.profileImage;

          ///Setting the user name value inside of the text field
          return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: size,
                child: ClipOval(
                    child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Controller.getHeight(context) * 0.02),
                  child: Image(
                      image: AssetImage("assets/profile_images/profile_image_" +
                          _currentProfileImage.toString() +
                          ".png")),
                ))),
          ]);
        } else {
          return Loading();
        }
      },
    );
  }
}
