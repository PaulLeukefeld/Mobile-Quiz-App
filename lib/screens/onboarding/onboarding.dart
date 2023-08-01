import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/buttons/LoginNavigationButton.dart';
import 'package:mobile_quiz_app/models/buttons/create_account_button.dart';
import 'package:mobile_quiz_app/models/information/onboarding/first_onboarding_page.dart';
import 'package:mobile_quiz_app/models/information/onboarding/fourth_onboarding_page.dart';
import 'package:mobile_quiz_app/models/information/onboarding/second_onboarding_page.dart';
import 'package:mobile_quiz_app/models/information/onboarding/third_onboarding_page.dart';
import 'package:mobile_quiz_app/screens/authenticate/register/pick_state_screen.dart';

/// Onboarding class that handles the user onboarding
class Onboarding extends StatefulWidget {
  final Function toggleView;
  Onboarding({this.toggleView});

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  /// Specifies the amount of dots
  final _totalDots = 4;

  /// Pagecontroller that is used to switch the pages
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  /// Index that specifies, which page is currently selected
  double _currentindex = 0.0;

  /// Method that changes the bottomSelectIndex, which ultimately changes the page
  void pageChanged(double index) {
    setState(() {
      _currentindex = index;
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
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: PageView(
            children: pages,
            controller: pageController,
            onPageChanged: (index) {
              pageChanged(index.toDouble());
            },
          ),
        ),
        DotsIndicator(
          dotsCount: _totalDots,
          position: _currentindex.toInt(),
          decorator: DotsDecorator(
            color: Colors.lightBlue[100], // Inactive color
            activeColor: Color.fromRGBO(10, 122, 255, 1),
          ),
        ),
        SizedBox(height: 10),
        Center(
            child: CreateAccountButton(
                onPressed: () => {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => PickState()))
                    })),
        LoginNavigationButton(onPressed: () {
          widget.toggleView();
        }),
        SizedBox(height: 20)
      ],
    ));
  }
}
