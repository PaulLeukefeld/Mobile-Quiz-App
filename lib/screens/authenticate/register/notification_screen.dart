import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/buttons/accept_not_now_buttons.dart';
import 'package:mobile_quiz_app/models/new_user.dart';
import 'package:mobile_quiz_app/screens/authenticate/register/pick_state_screen.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class NotificationScreen extends StatefulWidget {
  final NewUser newUser;
  final PageController pageController;

  NotificationScreen({@required this.newUser, @required this.pageController});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void dispose() {
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
            widget.pageController.animateToPage(0,
                duration: Duration(milliseconds: 200), curve: Curves.linear);
          },
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding:
            EdgeInsets.fromLTRB(0, Controller.getHeight(context) * 0.05, 0, 0),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Controller.getSize(context).width * 0.15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                        width: Controller.getSize(context).width * 0.65,
                        height: Controller.getSize(context).width * 0.65,
                        child: Image.asset(
                          "assets/icons/app_icon.png",
                          scale: 1.5,
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Controller.getHeight(context) * 0.01),
                      child: Text("Verpasse nichts",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ),
                    Text(
                        '''Werde benachrichtigt, wenn ein neues Quiz verfügbar ist oder wenn jemand deinen Highscore knackt.''',
                        textAlign: TextAlign.center),
                  ],
                ),
                AcceptNotNowButtons(
                    onPressedAccept: () {
                      /// Getting notification permissions
                      Controller.getNotificationPermissions();

                      /// Navigating to the next screen
                      widget.pageController == null
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PickState(
                                      newUser: widget.newUser,
                                      pageController: widget.pageController),
                                  settings:
                                      RouteSettings(name: 'PickStateRegister')),
                            )
                          : widget.pageController.animateToPage(2,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.linear);
                    },
                    onPressedNotNow: () => {
                          widget.pageController == null
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PickState(
                                          newUser: widget.newUser,
                                          pageController:
                                              widget.pageController),
                                      settings: RouteSettings(
                                          name: 'PickStateRegister')),
                                )
                              : widget.pageController.animateToPage(2,
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.linear)
                        })
              ]),
        ),
      ),
    );
  }
}
