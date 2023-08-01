import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_quiz_app/models/information/profile_image.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class ResultProfile extends StatelessWidget {
  final UserModel user;

  ResultProfile({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Positioned(
          child: ProfileImage(
              user: user, size: Controller.getSize(context).width * 0.3)),
      Positioned(
        child: Lottie.asset('assets/animations/Quizbase_result_3.json',
            repeat: false),
      ),
    ]);
  }
}
