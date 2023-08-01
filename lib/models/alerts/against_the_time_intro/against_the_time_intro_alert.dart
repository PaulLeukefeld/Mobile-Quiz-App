import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/alerts/against_the_time_intro/against_the_time_fifth_intro_page.dart';
import 'package:mobile_quiz_app/models/alerts/against_the_time_intro/against_the_time_first_intro_page.dart';
import 'package:mobile_quiz_app/models/alerts/against_the_time_intro/against_the_time_fourth_intro_page.dart';
import 'package:mobile_quiz_app/models/alerts/against_the_time_intro/against_the_time_second_intro_page.dart';
import 'package:mobile_quiz_app/models/alerts/against_the_time_intro/against_the_time_third_intro_page.dart';
import 'package:mobile_quiz_app/models/buttons/lets_go_button.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class AgainstTheTimeIntroAlert extends StatefulWidget {
  @override
  _AgainstTheTimeIntroAlertState createState() =>
      _AgainstTheTimeIntroAlertState();
}

class _AgainstTheTimeIntroAlertState extends State<AgainstTheTimeIntroAlert> {
  /// List of pages in the intro pageview
  List<Widget> introPages = [
    FirstIntroPage(),
    SecondIntroPage(),
    ThirdIntroPage(),
    FourthIntroPage(),
    FifthIntroPage()
  ];

  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: Controller.getSize(context).width * 0),
      content: Container(
        height: Controller.getSize(context).height * 0.6,
        width: Controller.getSize(context).width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: Controller.getSize(context).height * 0.5,
              child: PageView(
                children: introPages,
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    Controller.introPageChanged(index.toDouble());
                  });
                },
              ),
            ),
            currentIntroIndex.toInt() != totalIntroDots - 1
                ? DotsIndicator(
                    dotsCount: totalIntroDots,
                    position: currentIntroIndex.toInt(),
                    decorator: DotsDecorator(
                      color: Colors.lightBlue[100],
                      activeColor: Color.fromRGBO(10, 122, 255, 1),
                    ),
                  )
                : LetsGoButton(onPressed: () {
                    /// Resetting the intro index
                    Controller.resetIntroIndex();

                    /// Closing the dialog
                    Navigator.pop(context);
                  }),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
    );
  }
}
