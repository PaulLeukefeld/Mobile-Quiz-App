import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_quiz_app/models/alerts/connectivity_alert.dart';
import 'package:mobile_quiz_app/models/buttons/start_quiz_button.dart';
import 'package:mobile_quiz_app/models/quiz_question.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/screens/home/quiz/templates/against_the_time_quiz/against_the_time_quiz_game/against_the_time_properties.dart';
import 'package:mobile_quiz_app/screens/home/quiz/templates/against_the_time_quiz/against_the_time_quiz_game/against_the_time_quiz_game.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class AgainstTheTimeQuizInformation extends StatefulWidget {
  final List<QuizQuestion> questions;
  AgainstTheTimeQuizInformation({this.questions, this.user});

  final UserModel user;

  @override
  _AgainstTheTimeQuizInformationState createState() =>
      _AgainstTheTimeQuizInformationState();
}

class _AgainstTheTimeQuizInformationState
    extends State<AgainstTheTimeQuizInformation> {
  @override
  void initState() {
    super.initState();

    /// Launching intro alert for first time users
    Controller().launchIntroDialog(context);

    /// Getting 10 easy question from firestore
    // DatabaseService()
    //     .getEasyGermanQuestions(10)
    //     .then((questions) => print(questions));
  }

  Set<QuizQuestion> easyQuizQuestions = {};

  Set<QuizQuestion> hardQuizQuestions = {};

  List<QuizQuestion> finalQuizQuestions = [];

  @override
  Widget build(BuildContext context) {
    Controller.setPreferedOrientation();

    /// Getting the quiz questions from the provider
    final quizQuestions = (Provider.of<List<QuizQuestion>>(context) == null)
        ? []
        : Provider.of<List<QuizQuestion>>(context);

    return Scaffold(
      body: Stack(children: [
        Hero(
            tag: 'background',
            child: Container(
              color: Colors.white,
            )),
        Positioned(
            top: 0,
            left: 0,
            child: Hero(
              tag: 'image',
              child: Container(
                height: Controller.getHeight(context) * 0.6,
                width: Controller.getSize(context).width,
                child: Image.asset(
                  "assets/against_the_time_quiz/agt_title_image_1.png",
                  fit: BoxFit.cover,
                ),
              ),
            )),
        Positioned(
          top: Controller.getHeight(context) * 0.06,
          left: Controller.getSize(context).width * 0.01,
          child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                /// Resetting the intro index
                Controller.resetIntroIndex();

                /// Navigating the user back to the homescreen
                Navigator.of(context).pop();
              }),
        ),
        Positioned(
            top: Controller.getHeight(context) * 0.06,
            left: Controller.getSize(context).width * 0.85,
            child: IconButton(
                color: Colors.white,
                icon: Icon(CupertinoIcons.question_circle),
                onPressed: () {
                  Controller.launchIntroDialogRequest(context);
                })),
        Positioned(
          top: Controller.getHeight(context) * 0.65,
          left: Controller.getSize(context).width * 0.16,
          width: Controller.getSize(context).width,
          height: Controller.getHeight(context) * 0.1,
          child: Hero(
            tag: 'title',
            child: Material(
              color: Colors.transparent,
              child: Text(
                "Gegen die Zeit",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Positioned(
            top: Controller.getHeight(context) * 0.73,
            left: Controller.getSize(context).width * 0.165,
            width: Controller.getSize(context).width,
            height: Controller.getHeight(context) * 0.1,
            child: Hero(
              tag: 'subTitle',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  '''Wie viele Fragen kannst du \nrichtig beantworten?''',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
            )),
        Positioned(
          top: Controller.getHeight(context) * 0.83,
          left: Controller.getSize(context).width * 0.01,
          child: Hero(
              tag: 'properties',
              child: Material(
                  color: Colors.transparent,
                  child: AgainstTheTimeQuizProperties())),
        ),
        Positioned(
          top: Controller.getHeight(context) * 0.98,
          left: Controller.getSize(context).width * 0.15,
          child: Hero(
            tag: 'button',
            child: Material(
              color: Colors.transparent,
              child: StartQuizButton(onPressed: () {
                Controller.checkInternetConnection().then((result) => result
                    ? Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AgainstTheTimeQuizGame(
                              user: widget.user,
                              questions: Controller.generateOrderedQuestions(
                                  quizQuestions),
                            ),
                        settings:
                            RouteSettings(name: 'AgainstTheTimeQuizGame')))
                    : showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return ConnectivityAlert(
                              alertText:
                                  'Verbinde dich mit dem Internet um Gegen die Zeit spielen zu können.');
                        }));
              }),
            ),
          ),
        ),
      ]),
    );
  }
}
