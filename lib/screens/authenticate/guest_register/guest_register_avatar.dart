import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/alerts/input_alert.dart';
import 'package:mobile_quiz_app/models/alerts/success_alert.dart';
import 'package:mobile_quiz_app/models/buttons/create_account_button.dart';
import 'package:mobile_quiz_app/models/guest_user.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/services/auth.dart';
import 'package:mobile_quiz_app/services/database.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';
import 'package:mobile_quiz_app/shared/loading.dart';

class GuestRegisterAvatar extends StatefulWidget {
  GuestRegisterAvatar({
    @required this.user,
    @required this.guestUserData,
  });
  final UserModel user;
  final GuestUser guestUserData;

  @override
  _GuestRegisterAvatarState createState() =>
      _GuestRegisterAvatarState(user: user);
}

class _GuestRegisterAvatarState extends State<GuestRegisterAvatar> {
  /// The [Loading] widget is displayed if this variable is set to true.
  bool loading = false;
  UserModel user;

  _GuestRegisterAvatarState({@required this.user});

  bool guestRegisterLoading = false;

  /// Variable that determines wheater or not an avatar has been picked
  bool avatarPicked = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
        stream: DatabaseService(uid: user.uid).userMetaData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return guestRegisterLoading
                ? Loading()
                : Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      actions: [],
                      backgroundColor: Colors.white,
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back,
                            color: Color.fromRGBO(10, 122, 255, 1)),
                        onPressed: () {
                          Controller.resetAvatarSelection();
                          pageController.animateToPage(3,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.linear);
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
                          Text("Wähle deinen Speedquiz \n Avatar",
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
                                          widget.guestUserData
                                              .setUserProfileimage(1);
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
                                            radius: Controller.getSize(context)
                                                    .width *
                                                avatarOneSize,
                                            child: ClipOval(
                                                child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      Controller.getHeight(
                                                              context) *
                                                          0.02),
                                              child: Image(
                                                  image: AssetImage(
                                                      "assets/profile_image_1.png")),
                                            ))),
                                      ),
                                      SizedBox(
                                        width:
                                            Controller.getSize(context).width *
                                                0.01,
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          widget.guestUserData
                                              .setUserProfileimage(2);
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
                                            radius: Controller.getSize(context)
                                                    .width *
                                                avatarTwoSize,
                                            child: ClipOval(
                                                child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      Controller.getHeight(
                                                              context) *
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
                                          widget.guestUserData
                                              .setUserProfileimage(3);
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
                                            radius: Controller.getSize(context)
                                                    .width *
                                                avatarThreeSize,
                                            child: ClipOval(
                                                child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      Controller.getHeight(
                                                              context) *
                                                          0.02),
                                              child: Image(
                                                  image: AssetImage(
                                                      "assets/profile_image_3.png")),
                                            ))),
                                      ),
                                      SizedBox(
                                        width:
                                            Controller.getSize(context).width *
                                                0.01,
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          widget.guestUserData
                                              .setUserProfileimage(4);
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
                                            radius: Controller.getSize(context)
                                                    .width *
                                                avatarFourSize,
                                            child: ClipOval(
                                                child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      Controller.getHeight(
                                                              context) *
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
                                          widget.guestUserData
                                              .setUserProfileimage(5);
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
                                            radius: Controller.getSize(context)
                                                    .width *
                                                avatarFiveSize,
                                            child: ClipOval(
                                                child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      Controller.getHeight(
                                                              context) *
                                                          0.02),
                                              child: Image(
                                                  image: AssetImage(
                                                      "assets/profile_image_5.png")),
                                            ))),
                                      ),
                                      SizedBox(
                                        width:
                                            Controller.getSize(context).width *
                                                0.01,
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          widget.guestUserData
                                              .setUserProfileimage(6);
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
                                            radius: Controller.getSize(context)
                                                    .width *
                                                avatarSixSize,
                                            child: ClipOval(
                                                child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      Controller.getHeight(
                                                              context) *
                                                          0.02),
                                              child: Image(
                                                  image: AssetImage(
                                                      "assets/profile_image_6.png")),
                                            ))),
                                      )
                                    ]),
                              ]),
                          CreateAccountButton(onPressed: () async {
                            if (avatarPicked) {
                              /// Enabeling the loading screen
                              setState(() {
                                guestRegisterLoading = true;
                              });

                              /// Reauthenticating the current user
                              await AuthService()
                                  .reauthenticateUser(snapshot.data.password);

                              /// Updating the email and password of the user
                              await AuthService()
                                  .updateGuestUserEmailAndPassword(
                                      widget.guestUserData.getUserEmail(),
                                      widget.guestUserData.getUserPassword())
                                  .then((value) {
                                if (value == "SUCCESS") {
                                  /// Disabeling the loading screen
                                  setState(() {
                                    guestRegisterLoading = false;
                                  });

                                  /// Resetting the textediting controller
                                  Controller.resetAllTextEditControllers();

                                  /// Resetting the avatar selection
                                  Controller.resetAvatarSelection();

                                  /// Updating the profile image
                                  DatabaseService(uid: widget.user.uid)
                                      .updateProfileImage(widget.guestUserData
                                          .getProfileImage());

                                  /// Updating the username
                                  DatabaseService(uid: widget.user.uid)
                                      .updateUsername(
                                          widget.guestUserData.getUsername());

                                  /// Updating the state
                                  DatabaseService(uid: widget.user.uid)
                                      .updateUserState(
                                          widget.guestUserData.getUserState());

                                  /// Updating the guest user status
                                  DatabaseService(uid: widget.user.uid)
                                      .updateGuestUserStatus();

                                  /// Naviagting the user back to the home screen
                                  Navigator.pop(context);

                                  /// Communicating to the user the successfull account
                                  /// creation
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return SuccesssAlert(
                                            alertText:
                                                'Du hast erfolgreich deinen Account erstellt');
                                      });
                                } else if (value == "EMAIL_IN_USE") {
                                  /// Disabeling the loading screen
                                  setState(() {
                                    guestRegisterLoading = false;
                                  });
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return InputAlert(
                                            alertText:
                                                "Es existiert bereits ein Account mit dieser Email Adresse");
                                      });
                                } else {
                                  /// Disabeling the loading screen
                                  setState(() {
                                    guestRegisterLoading = false;
                                  });

                                  /// Notifiying the user that the account creation
                                  /// was unsuccesfull
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return InputAlert(
                                            alertText:
                                                "Dein Account konnte nicht erstellt werden. Bitte versuche es nochmal");
                                      });
                                }
                              });
                            } else {
                              /// Notifiying the user to pick an avatar
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
