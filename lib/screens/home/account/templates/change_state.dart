import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/models/alerts/connectivity_alert.dart';
import 'package:mobile_quiz_app/models/buttons/save_button.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/services/analytics_service.dart';
import 'package:mobile_quiz_app/services/database.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

// ignore: must_be_immutable
class ChangeState extends StatelessWidget {
  final UserModel user;

  ChangeState({@required this.user});

  /// Variable that represents the initial state
  String state = 'Deutschland';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [],
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(10, 122, 255, 1)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, Controller.getHeight(context) * 0.05, 0,
            Controller.getHeight(context) * 0.1),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Wähle deinen neuen Ort aus",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Controller.getSize(context).width * 0.1),
                child: Container(
                  height: Controller.getHeight(context) * 0.2,
                  child: CupertinoPicker(
                      itemExtent: 30,
                      scrollController: FixedExtentScrollController(
                          initialItem: statesList.indexOf(user.state)),
                      onSelectedItemChanged: (value) {
                        state = statesList[value];
                      },
                      children: scrollStates),
                ),
              ),
              SaveButton(onPressed: () async {
                /// Saving the newly selected state
                Controller.checkInternetConnection().then((result) async =>
                    result
                        ? await DatabaseService(uid: user.uid)
                            .updateUserState(state)
                            .then((value) => trackUser
                                ? AnalyticsService().logStateChange()
                                : false)
                            .then((value) => Navigator.pop(context))
                        : showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return ConnectivityAlert(
                                  alertText:
                                      'Verbinde dich mit dem Internet um dein Bundesland zu ändern.');
                            }));
              })
            ]),
      ),
    );
  }
}
