import 'package:flutter/cupertino.dart';
import 'package:mobile_quiz_app/models/quiz_item.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class AgainstTheTimeQuizProperties extends StatelessWidget {
  const AgainstTheTimeQuizProperties({this.quizItemData});

  final QuizItem quizItemData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Controller.getSize(context).width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: Controller.getSize(context).width * 0.15),
              Icon(CupertinoIcons.question_square),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Controller.getSize(context).width * 0.02),
                child: Text(
                  "Fragen: ∞",
                  style: TextStyle(fontSize: 17),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: Controller.getSize(context).height * 0.03,
        ),
        Container(
          width: Controller.getSize(context).width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: Controller.getSize(context).width * 0.15),
              Icon(CupertinoIcons.dial),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Controller.getSize(context).width * 0.02),
                child: Text(
                  "Zeit: Unbegrenzt",
                  style: TextStyle(fontSize: 17),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
