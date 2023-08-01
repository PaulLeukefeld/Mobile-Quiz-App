import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class FourthIntroPage extends StatefulWidget {
  @override
  _FourthIntroPageState createState() => _FourthIntroPageState();
}

class _FourthIntroPageState extends State<FourthIntroPage> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Container(
        height: Controller.getSize(context).height * 0.45,
        width: Controller.getSize(context).width,
        child: Image.asset(
          "assets/tutorial/agt_onboarding_image_4.png",
          fit: BoxFit.cover,
          scale: 3,
        ),
      ),
    ]);
  }
}
