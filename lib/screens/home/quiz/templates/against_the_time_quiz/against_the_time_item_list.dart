import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_quiz_app/models/quiz_question.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/screens/home/quiz/templates/against_the_time_quiz/against_the_time_quiz_game/against_the_time_information.dart';
import 'package:mobile_quiz_app/services/database.dart';
import 'package:mobile_quiz_app/shared/controller.dart';
import 'against_the_time_quiz_game/against_the_time_properties.dart';

class AgainstTheTimeTile extends StatefulWidget {
  AgainstTheTimeTile({this.user});
  final UserModel user;
  @override
  _AgainstTheTimeTileState createState() => _AgainstTheTimeTileState(user);
}

class _AgainstTheTimeTileState extends State<AgainstTheTimeTile> {
  _AgainstTheTimeTileState(this.user);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Controller.getHeight(context) * 0.55,
      child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 400),
                settings: RouteSettings(name: 'AgainstTheTimeQuizInformation'),
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return StreamProvider<List<QuizQuestion>>.value(
                      initialData: [],
                      value: DatabaseService().germanQuizQuestions.take(462),
                      child: AgainstTheTimeQuizInformation(user: user));
                },
                transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) {
                  return Align(
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
              ),
            );
          },
          child: Card(
            margin: EdgeInsets.fromLTRB(
                Controller.getSize(context).width * 0.08,
                Controller.getHeight(context) * 0.01,
                Controller.getSize(context).width * 0.08,
                Controller.getHeight(context) * 0.0),
            elevation: 4.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Hero(
                    tag: 'background',
                    child: Container(
                      color: Colors.white,
                    )),
                Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Hero(
                      tag: 'image',
                      child: Image.asset(
                        "assets/against_the_time_quiz/agt_title_image_1.png",
                        fit: BoxFit.cover,
                        height: Controller.getHeight(context) * 0.35,
                        width: Controller.getSize(context).width,
                      ),
                    )),
                Positioned(
                    top: Controller.getHeight(context) * 0.375,
                    left: Controller.getSize(context).width * 0.075,
                    child: Material(
                      color: Colors.transparent,
                      child: Hero(
                        tag: 'title',
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            "Gegen die Zeit",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )),
                Positioned(
                    top: Controller.getHeight(context) * 0.44,
                    left: Controller.getSize(context).width * 0.075,
                    child: Hero(
                      tag: 'subTitle',
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          '''Wie viele Fragen kannst du \nrichtig beantworten?''',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )),
                Positioned(
                    top: Controller.getHeight(context),
                    left: Controller.getSize(context).width * 0.05,
                    child: Hero(
                      tag: 'properties',
                      child: Material(
                          color: Colors.transparent,
                          child: AgainstTheTimeQuizProperties()),
                    )),
                Positioned(
                  top: Controller.getHeight(context) * 1.9,
                  left: Controller.getSize(context).width * 0.2,
                  child: Hero(
                    tag: 'button',
                    child: Material(
                      child: Container(
                        width: Controller.getSize(context).width * 0.7,
                        height: Controller.getHeight(context) * 0.07,
                        child: CupertinoButton(
                            color: Color.fromRGBO(10, 122, 255, 1),
                            child: Text("Quiz starten"),
                            onPressed: () {}),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
