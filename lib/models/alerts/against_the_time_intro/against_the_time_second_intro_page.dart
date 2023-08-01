import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class SecondIntroPage extends StatefulWidget {
  @override
  _SecondIntroPageState createState() => _SecondIntroPageState();
}

class _SecondIntroPageState extends State<SecondIntroPage> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Container(
        height: Controller.getSize(context).height * 0.45,
        width: Controller.getSize(context).width,
        child: Image.asset(
          "assets/tutorial/agt_onboarding_image_2.png",
          fit: BoxFit.cover,
          scale: 3,
        ),
      ),
    ]);
  }
}
