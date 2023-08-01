import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class FifthIntroPage extends StatefulWidget {
  @override
  _FifthIntroPageState createState() => _FifthIntroPageState();
}

class _FifthIntroPageState extends State<FifthIntroPage> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Container(
        height: Controller.getSize(context).height * 0.45,
        width: Controller.getSize(context).width,
        child: Image.asset(
          "assets/tutorial/agt_onboarding_image_5.png",
          fit: BoxFit.cover,
          scale: 3,
        ),
      ),
    ]);
  }
}
