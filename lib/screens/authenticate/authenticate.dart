import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/buttons/LoginNavigationButton.dart';
import 'package:mobile_quiz_app/models/buttons/create_account_button.dart';
import 'package:mobile_quiz_app/models/information/onboarding/first_onboarding_page.dart';
import 'package:mobile_quiz_app/models/information/onboarding/fourth_onboarding_page.dart';
import 'package:mobile_quiz_app/models/information/onboarding/second_onboarding_page.dart';
import 'package:mobile_quiz_app/models/information/onboarding/third_onboarding_page.dart';

import 'package:mobile_quiz_app/screens/authenticate/register/register.dart';
import 'package:mobile_quiz_app/screens/authenticate/sign_in/sign_in.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  /// Variable used to toggle between the sign in and onboarding screen
  bool showSignIn = false;

  /// Variable used to toggle between the register and onboarding screen
  bool showRegister = false;

  /// Method used to toggle between sign in and onboarding screen
  void toggleSignIn() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  /// Method used to toggle between register and onboarding screen
  void toggleRegister() {
    setState(() {
      showRegister = !showRegister;
    });
  }

  /// List of pages that are being displayed
  List<Widget> pages = [
    FirstOnboardingPage(),
    SecondOnboardingPage(),
    ThirdOnboardingPage(),
    FourthOnboardingPage()
  ];

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleSignIn);
    } else if (showRegister) {
      return Register(toggleView: toggleRegister);
    } else {
      return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Controller.getHeight(context) * 0.05),
              Container(
                height: Controller.getHeight(context) * 0.6,
                child: PageView(
                  children: pages,
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      Controller.pageChanged(index.toDouble());
                    });
                  },
                ),
              ),
              SizedBox(height: Controller.getHeight(context) * 0.08),
              DotsIndicator(
                dotsCount: totalOnboardingDots,
                position: currentOnboardingIndex.toInt(),
                decorator: DotsDecorator(
                  color: Colors.lightBlue[100],
                  activeColor: Color.fromRGBO(10, 122, 255, 1),
                ),
              ),
              SizedBox(height: Controller.getHeight(context) * 0.03),
              CreateAccountButton(onPressed: () {
                toggleRegister();
              }),
              SizedBox(height: Controller.getHeight(context) * 0.01),
              LoginNavigationButton(onPressed: () {
                toggleSignIn();
              })
            ],
          ));
    }
  }
}
