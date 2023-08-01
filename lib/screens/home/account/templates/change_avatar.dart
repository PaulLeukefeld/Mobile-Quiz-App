import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/alerts/connectivity_alert.dart';
import 'package:mobile_quiz_app/models/alerts/input_alert.dart';
import 'package:mobile_quiz_app/models/buttons/save_button.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/services/analytics_service.dart';
import 'package:mobile_quiz_app/services/database.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';
import 'package:mobile_quiz_app/shared/loading.dart';

class ChangeAvatar extends StatefulWidget {
  final UserModel user;

  ChangeAvatar({@required this.user});

  @override
  _ChangeAvatarState createState() => _ChangeAvatarState();
}

class _ChangeAvatarState extends State<ChangeAvatar> {
  /// Variable that determines wheater or not an avatar has been picked
  bool avatarPicked = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
        stream: DatabaseService(uid: widget.user.uid).userMetaData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                actions: [],
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: Color.fromRGBO(10, 122, 255, 1)),
                  onPressed: () {
                    /// Resetting the avatar selection
                    Controller.resetAvatarSelection();

                    /// Navigating the user back to the account page
                    Navigator.pop(context);
                  },
                ),
                elevation: 0.0,
              ),
              body: Padding(
                padding: EdgeInsets.fromLTRB(
                    0,
                    Controller.getHeight(context) * 0.05,
                    0,
                    Controller.getHeight(context) * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Wähle deinen neuen \n Quizbase Avatar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    widget.user.setUserProfileimage(1);
                                    setState(() {
                                      avatarOneSize = 0.2;
                                      avatarTwoSize = 0.15;
                                      avatarThreeSize = 0.15;
                                      avatarFourSize = 0.15;
                                      avatarFiveSize = 0.15;
                                      avatarSixSize = 0.15;
                                      avatarPicked = true;
                                    });
                                  },
                                  child: CircleAvatar(
                                      backgroundColor: Colors.grey[300],
                                      radius:
                                          Controller.getSize(context).width *
                                              avatarOneSize,
                                      child: ClipOval(
                                          child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                Controller.getHeight(context) *
                                                    0.02),
                                        child: Image(
                                            image: AssetImage(
                                                "assets/profile_image_1.png")),
                                      ))),
                                ),
                                SizedBox(
                                  width:
                                      Controller.getSize(context).width * 0.01,
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    widget.user.setUserProfileimage(2);
                                    setState(() {
                                      avatarOneSize = 0.15;
                                      avatarTwoSize = 0.2;
                                      avatarThreeSize = 0.15;
                                      avatarFourSize = 0.15;
                                      avatarFiveSize = 0.15;
                                      avatarSixSize = 0.15;
                                      avatarPicked = true;
                                    });
                                  },
                                  child: CircleAvatar(
                                      backgroundColor: Colors.grey[300],
                                      radius:
                                          Controller.getSize(context).width *
                                              avatarTwoSize,
                                      child: ClipOval(
                                          child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                Controller.getHeight(context) *
                                                    0.02),
                                        child: Image(
                                            image: AssetImage(
                                                "assets/profile_image_2.png")),
                                      ))),
                                )
                              ]),
                          SizedBox(
                            height: Controller.getHeight(context) * 0.01,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    widget.user.setUserProfileimage(3);
                                    setState(() {
                                      avatarOneSize = 0.15;
                                      avatarTwoSize = 0.15;
                                      avatarThreeSize = 0.2;
                                      avatarFourSize = 0.15;
                                      avatarFiveSize = 0.15;
                                      avatarSixSize = 0.15;
                                      avatarPicked = true;
                                    });
                                  },
                                  child: CircleAvatar(
                                      backgroundColor: Colors.grey[300],
                                      radius:
                                          Controller.getSize(context).width *
                                              avatarThreeSize,
                                      child: ClipOval(
                                          child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                Controller.getHeight(context) *
                                                    0.02),
                                        child: Image(
                                            image: AssetImage(
                                                "assets/profile_image_3.png")),
                                      ))),
                                ),
                                SizedBox(
                                  width:
                                      Controller.getSize(context).width * 0.01,
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    widget.user.setUserProfileimage(4);
                                    setState(() {
                                      avatarOneSize = 0.15;
                                      avatarTwoSize = 0.15;
                                      avatarThreeSize = 0.15;
                                      avatarFourSize = 0.2;
                                      avatarFiveSize = 0.15;
                                      avatarSixSize = 0.15;
                                      avatarPicked = true;
                                    });
                                  },
                                  child: CircleAvatar(
                                      backgroundColor: Colors.grey[300],
                                      radius:
                                          Controller.getSize(context).width *
                                              avatarFourSize,
                                      child: ClipOval(
                                          child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                Controller.getHeight(context) *
                                                    0.02),
                                        child: Image(
                                            image: AssetImage(
                                                "assets/profile_image_4.png")),
                                      ))),
                                )
                              ]),
                          SizedBox(
                            height: Controller.getHeight(context) * 0.01,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    widget.user.setUserProfileimage(5);
                                    setState(() {
                                      avatarOneSize = 0.15;
                                      avatarTwoSize = 0.15;
                                      avatarThreeSize = 0.15;
                                      avatarFourSize = 0.15;
                                      avatarFiveSize = 0.2;
                                      avatarSixSize = 0.15;
                                      avatarPicked = true;
                                    });
                                  },
                                  child: CircleAvatar(
                                      backgroundColor: Colors.grey[300],
                                      radius:
                                          Controller.getSize(context).width *
                                              avatarFiveSize,
                                      child: ClipOval(
                                          child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                Controller.getHeight(context) *
                                                    0.02),
                                        child: Image(
                                            image: AssetImage(
                                                "assets/profile_image_5.png")),
                                      ))),
                                ),
                                SizedBox(
                                  width:
                                      Controller.getSize(context).width * 0.01,
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    widget.user.setUserProfileimage(6);
                                    setState(() {
                                      avatarOneSize = 0.15;
                                      avatarTwoSize = 0.15;
                                      avatarThreeSize = 0.15;
                                      avatarFourSize = 0.15;
                                      avatarFiveSize = 0.15;
                                      avatarSixSize = 0.2;
                                      avatarPicked = true;
                                    });
                                  },
                                  child: CircleAvatar(
                                      backgroundColor: Colors.grey[300],
                                      radius:
                                          Controller.getSize(context).width *
                                              avatarSixSize,
                                      child: ClipOval(
                                          child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                Controller.getHeight(context) *
                                                    0.02),
                                        child: Image(
                                            image: AssetImage(
                                                "assets/profile_image_6.png")),
                                      ))),
                                )
                              ]),
                        ]),
                    SaveButton(onPressed: () async {
                      if (avatarPicked) {
                        Controller.checkInternetConnection().then((result) =>
                            result
                                ? DatabaseService(uid: widget.user.uid)
                                    .updateProfileImage(
                                        widget.user.profileImage)
                                    .then((value) => trackUser
                                        ? AnalyticsService().logAvatarChange()
                                        : false)
                                    .then((value) =>
                                        Controller.resetAvatarSelection())
                                    .then((value) => Navigator.pop(context))
                                : showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return ConnectivityAlert(
                                          alertText:
                                              'Verbinde dich mit dem Internet um deinen Avatar zu ändern.');
                                    }));
                      } else {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return InputAlert(
                                  alertText: "Wähle einen Avatar aus.");
                            });
                      }
                    })
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
