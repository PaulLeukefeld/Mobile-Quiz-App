import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/buttons/accept_button.dart';
import 'package:mobile_quiz_app/models/new_user.dart';
import 'package:mobile_quiz_app/screens/authenticate/register/notification_screen.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class PrivacyScreen extends StatefulWidget {
  final Function toggleView;
  final NewUser newUser;
  final PageController pageController;

  PrivacyScreen({@required this.toggleView, this.newUser, this.pageController});

  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///Setting the prefered orientation to portrait mode
    Controller.setPreferedOrientation();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [],
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(10, 122, 255, 1)),
          onPressed: () {
            widget.toggleView();
          },
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Controller.getSize(context).width * 0.15,
            vertical: Controller.getHeight(context) * 0.05),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Container(
              width: Controller.getSize(context).width * 0.65,
              height: Controller.getSize(context).width * 0.4,
              child: Image.asset(
                "assets/icons/app_icon.png",
                scale: 1.5,
              )),
          Text("Deine Privatsphäre \nist uns wichtig!",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          Text(
              '''Wenn du deine Daten uns anvertraust, bleibst du der Eigentümer deiner Daten.\n \nWir haben unsere Datenschutzerklärung aktualisiert damit du einsehen kannst welche Daten wir sammeln und wie wir diese Daten verwenden. Dies kannst du hier nachschauen.'''),
          Row(
            children: [
              InkWell(
                child: Text(
                  "Mehr erfahren",
                  style: TextStyle(
                    color: Color.fromRGBO(10, 122, 255, 1),
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () => Controller.launchPrivacyInformation(),
              ),
            ],
          ),
          AcceptButton(
            onPressed: () {
              /// Asking the user for tracking permission
              Controller.requestTrackingAuthorization();

              /// Navigating the user to the next screen
              pageController == null
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationScreen(
                              newUser: widget.newUser,
                              pageController: pageController),
                          settings: RouteSettings(name: 'NotificationScreen')),
                    )
                  : pageController.animateToPage(1,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.linear);
            },
          )
        ]),
      ),
    );
  }
}
