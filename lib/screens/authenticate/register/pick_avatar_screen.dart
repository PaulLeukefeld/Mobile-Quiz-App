import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/alerts/input_alert.dart';
import 'package:mobile_quiz_app/models/buttons/create_account_button.dart';
import 'package:mobile_quiz_app/models/new_user.dart';
import 'package:mobile_quiz_app/services/auth.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';
import 'package:mobile_quiz_app/shared/loading.dart';

// ignore: must_be_immutable
class PickAvatar extends StatefulWidget {
  PickAvatar({this.newUser, this.pageController});
  dynamic newUser;
  final PageController pageController;
  @override
  _PickAvatarState createState() =>
      _PickAvatarState(newUser: newUser, pageController: pageController);
}

class _PickAvatarState extends State<PickAvatar> {
  _PickAvatarState({this.newUser, this.pageController});
  final NewUser newUser;
  final PageController pageController;

  /// The [AuthService] variable that is used for user authentication.
  final AuthService _auth = AuthService();

  /// The [Loading] widget is displayed if this variable is set to true.
  bool loading = false;

  /// Variable that determines wheater or not an avatar has been picked
  bool avatarPicked = false;

  /// Creating a new focus node that hides the keyboard
  FocusNode avatarFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Setting the prefered device orientation
    Controller.setPreferedOrientation();

    avatarFocusNode.requestFocus(null);
    avatarFocusNode.unfocus();

    return loading
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
                  /// Resetting the avatar selection
                  Controller.resetAvatarSelection();

                  /// Navigating back to the previous screen
                  pageController.animateToPage(5,
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
                  Controller.getHeight(context) * 0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Wähle deinen Quizbase \n Avatar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: '',
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            0,
                            Controller.getHeight(context) * 0.05,
                            0,
                            Controller.getHeight(context) * 0.05),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        newUser == null
                                            ? NewUser().setUserProfileimage(1)
                                            : newUser.setUserProfileimage(1);
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
                                              vertical: Controller.getHeight(
                                                      context) *
                                                  0.02),
                                          child: Image(
                                              image: AssetImage(
                                                  "assets/profile_images/profile_image_1.png")),
                                        )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Controller.getSize(context).width *
                                          0.01,
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        newUser.setUserProfileimage(2);
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
                                              vertical: Controller.getHeight(
                                                      context) *
                                                  0.02),
                                          child: Image(
                                              image: AssetImage(
                                                  "assets/profile_images/profile_image_2.png")),
                                        )),
                                      ),
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
                                        newUser.setUserProfileimage(3);
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
                                              vertical: Controller.getHeight(
                                                      context) *
                                                  0.02),
                                          child: Image(
                                              image: AssetImage(
                                                  "assets/profile_images/profile_image_3.png")),
                                        )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Controller.getSize(context).width *
                                          0.01,
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        newUser.setUserProfileimage(4);
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
                                              vertical: Controller.getHeight(
                                                      context) *
                                                  0.02),
                                          child: Image(
                                              image: AssetImage(
                                                  "assets/profile_images/profile_image_4.png")),
                                        )),
                                      ),
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
                                        newUser.setUserProfileimage(5);
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
                                              vertical: Controller.getHeight(
                                                      context) *
                                                  0.02),
                                          child: Image(
                                              image: AssetImage(
                                                  "assets/profile_images/profile_image_5.png")),
                                        )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Controller.getSize(context).width *
                                          0.01,
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        newUser.setUserProfileimage(6);
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
                                              vertical: Controller.getHeight(
                                                      context) *
                                                  0.02),
                                          child: Image(
                                              image: AssetImage(
                                                  "assets/profile_images/profile_image_6.png")),
                                        )),
                                      ),
                                    )
                                  ]),
                            ]),
                      ),
                    ),
                    Center(
                      child: CreateAccountButton(onPressed: () async {
                        /// Creating a new user account with the provided data
                        if (newUser.getUserEmail() != null &&
                            newUser.getUserPassword() != null &&
                            avatarPicked) {
                          setState(() {
                            loading = true;
                          });

                          /// Resetting the text editing controllers
                          Controller.resetAllTextEditControllers();

                          /// Registering the user with email and password
                          dynamic result =
                              await _auth.registerWithEmailandPassword(
                                  newUser.getUserEmail(),
                                  newUser.getUserPassword(),
                                  newUser.getUserState(),
                                  newUser.getUsername(),
                                  newUser.getProfileImage(),
                                  false);

                          /// Displays and error message if the user
                          /// coudln't be signed in because the email is
                          /// already in use
                          if (result == "EMAIL_IN_USE" && avatarPicked) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return InputAlert(
                                    alertText:
                                        '''Es existiert bereits einen account\n mit dieser Email Adresse.''',
                                  );
                                });

                            setState(() {
                              loading = false;
                            });
                          } else if (result == null && avatarPicked) {
                            /// Displays and error message if the user
                            /// coudln't be signed in with the
                            /// provided email and password.
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return InputAlert(
                                    alertText:
                                        '''Es ist ein Fehler aufgetreten, bitte versuche es nochmal.''',
                                  );
                                });

                            setState(() {
                              loading = false;
                            });
                          }
                        }

                        /// Displayes an error message if the user didn't
                        /// pick an avatar
                        if (!avatarPicked) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return InputAlert(
                                    alertText: "Wähle einen Avatar aus.");
                              });
                          setState(() {
                            loading = false;
                          });
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ));
  }
}
