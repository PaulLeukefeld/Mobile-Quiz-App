import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class ThirdOnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: Controller.getSize(context).width * 0.9,
              height: Controller.getSize(context).width * 0.8,
              child: Image.asset(
                "assets/onboarding/onboarding_2.png",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: Controller.getHeight(context) * 0.01),
            Text("Spiele gegen die Zeit",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, fontFamily: '')),
            SizedBox(height: Controller.getHeight(context) * 0.01),
            Text("Wie schnell bist du?",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: '',
                ))
          ],
        ),
      ),
      color: Colors.white,
    );
  }
}
