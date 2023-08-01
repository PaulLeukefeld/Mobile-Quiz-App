import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/alerts/email_verification_alert.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/screens/home/quiz/templates/against_the_time_quiz/against_the_time_item_list.dart';
import 'package:mobile_quiz_app/services/auth.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

///Pages that displays all quizzes that are available
class QuizOverview extends StatefulWidget {
  final UserModel user;
  QuizOverview({@required this.user});

  @override
  _QuizOverviewState createState() => _QuizOverviewState(user: user);
}

class _QuizOverviewState extends State<QuizOverview> {
  _QuizOverviewState({this.user});

  @override
  void initState() {
    super.initState();

    /// Checking if the users email has been verfied
    AuthService()
        .checkEmailVerification(AuthService().getCurrentFirebaseUser())
        .then((result) {
      if (!result) {
        /// Send verification email to user
        AuthService().sendVerifcationEmail();

        /// Launch verify email dialog
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return EmailVerificationAlert();
            });
      }
    });

    /// Showing the review dialog to the user
    Controller.launchReviewDialog();
  }

  UserModel user;

  @override
  Widget build(BuildContext context) {
    ///Setting the device orientation to portrait mode
    Controller.setPreferedOrientation();
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      Controller.getSize(context).width * 0.07,
                      Controller.getHeight(context) * 0.1,
                      0,
                      Controller.getHeight(context) * 0.03),
                  child: Text("Quiz",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                )
              ]),
              AgainstTheTimeTile(user: user),
            ],
          ),
        ));
  }
}
