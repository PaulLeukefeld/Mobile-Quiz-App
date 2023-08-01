import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/screens/home/quiz/quiz_overview.dart';
import 'package:mobile_quiz_app/screens/home/ranking/ranking.dart';
import 'package:mobile_quiz_app/screens/home/account/account.dart';
import 'package:flutter/services.dart';
import 'package:mobile_quiz_app/shared/controller.dart';
import 'package:mobile_quiz_app/shared/constants.dart';

///Home Page Widget which contains all of the app pages
class Home extends StatefulWidget {
  Home({this.user});

  final UserModel user;

  @override
  _HomeState createState() => _HomeState(user: user);
}

class _HomeState extends State<Home> {
  _HomeState({this.user});

  final UserModel user;

  @override
  void initState() {
    super.initState();
    homeBottomSelectedIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    ///Setting the device orientation to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    ///Method that changes the bottomSelectIndex, which ultimately changes the page
    void pageChanged(int index) {
      setState(() {
        homeBottomSelectedIndex = index;
      });
    }

    ///Method that animates the bottom nav bar
    void bottomTapped(int index) {
      setState(() {
        homeBottomSelectedIndex = index;
        homePageController.animateToPage(index,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      });
    }

    ///User provider variable to read and update user data
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress)
          return false;
        else
          return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: PageView(
          children: <Widget>[
            Container(
              child: Account(user: user),
              color: Colors.white,
            ),
            Container(
              child: QuizOverview(user: user),
              color: Colors.white,
            ),
            Container(
              child: Ranking(user: user),
              color: Colors.white,
            ),
          ],
          controller: homePageController,
          onPageChanged: (index) {
            pageChanged(index);
          },
        )),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1,
                ),
              ],
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Color.fromRGBO(10, 122, 255, 1),
              currentIndex: homeBottomSelectedIndex,
              onTap: (index) {
                bottomTapped(index);
              },
              items: Controller().buildBottomNavBarItems(),
            )),
      ),
    );
  }
}
