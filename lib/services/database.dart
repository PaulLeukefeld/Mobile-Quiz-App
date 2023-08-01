import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_quiz_app/models/quiz_item.dart';
import 'package:mobile_quiz_app/models/quiz_question.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/models/store_item.dart';
import 'package:mobile_quiz_app/services/analytics_service.dart';
import 'package:mobile_quiz_app/shared/controller.dart';

class DatabaseService {
  final String uid;
  final String questionUid;
  DatabaseService({this.uid, this.questionUid});

  ///Collection references to all the collections used in the firestore
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference storeItemsCollection =
      FirebaseFirestore.instance.collection('shop');

  final CollectionReference quizItemsCollection =
      FirebaseFirestore.instance.collection('quiz');

  final CollectionReference questionsDECollection =
      FirebaseFirestore.instance.collection("questions_de");

  /// Updating all of the user data
  Future updateUserData(
      String name,
      int profileImage,
      String state,
      String time,
      bool guestUser,
      bool proUser,
      String levelOneStatus,
      String levelTwoStatus,
      String levelThreeStatus,
      String levelOneTime,
      String levelTwoTime,
      String levelThreeTime,
      int alltimeAgainstTheTimeScore,
      DateTime timeOfalltimeAgainstTheTimeHighscore,
      int monthlyAgainstTheTimeScore,
      DateTime timeOfMonthlyAgainstTheTimeHighscore,
      int dailyAgainstTheTimeScore,
      DateTime timeOfDailyAgainstTheTimeHighscore,
      String guestUserPassword) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'profile_image': profileImage,
      'state': state,
      'time': time,
      'guestUser': guestUser,
      'proUser': proUser,
      'levelOneStatus': levelOneStatus,
      'levelTwoStatus': levelTwoStatus,
      'levelThreeStatus': levelThreeStatus,
      'levelOneTime': levelOneTime,
      'levelTwoTime': levelTwoTime,
      'levelThreeTime': levelThreeTime,
      'alltimeAgainstTheTimeScore': alltimeAgainstTheTimeScore,
      'timeOfalltimeAgainstTheTimeHighscore':
          timeOfalltimeAgainstTheTimeHighscore,
      'monthlyAgainstTheTimeScore': monthlyAgainstTheTimeScore,
      'timeOfMonthlyAgainstTheTimeHighscore':
          timeOfMonthlyAgainstTheTimeHighscore,
      'dailyAgainstTheTimeScore': dailyAgainstTheTimeScore,
      'timeOfDailyAgainstTheTimeHighscore': timeOfDailyAgainstTheTimeHighscore,
      'guestUserPassword': guestUserPassword
    });
  }

  Future addUserData(String name) async {
    return userCollection
      ..add({'name': name})
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
  }

  /// Updating the userName
  Future updateUsername(String name) async {
    /// Logging the user changing their username
    AnalyticsService().logUsernameChange(username: name);
    return await userCollection.doc(uid).update({'name': name});
  }

  /// Updating the user time for a specific level
  Future updateUserTime(String level, String time) async {
    if (level == "Level 1") {
      return await userCollection.doc(uid).update({'levelOneTime': time});
    }
    if (level == "Level 2") {
      return await userCollection.doc(uid).update({'levelTwoTime': time});
    }
    if (level == "Level 3") {
      return await userCollection.doc(uid).update({'levelThreeTime': time});
    }
  }

  /// Updating the profile image of the user
  Future updateProfileImage(int profileImage) async {
    /// Logging the user changing their profile image
    AnalyticsService().logAvatarChange(profileImage: profileImage);
    return await userCollection
        .doc(uid)
        .update({'profile_image': profileImage});
  }

  /// Updating the users state
  Future updateUserState(String state) async {
    /// Logging the user changing their state
    AnalyticsService().logStateChange(state: state);
    return await userCollection.doc(uid).update({'state': state});
  }

  /// Updating the pro user status of the user
  Future updateProUserStatus(bool proUser) async {
    return await userCollection.doc(uid).update({'proUser': proUser});
  }

  /// Updating the guest user status of the user
  Future updateGuestUserStatus() async {
    return await userCollection.doc(uid).update({'guestUser': false});
  }

  ///Method to retrive account relevant userData from snapshot
  UserModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
        uid: uid,
        //userName: snapshot.data()['name'],
        userName: snapshot.get("name"),
        state: snapshot.get("state"),
        profileImage: snapshot.get('profile_image'),
        proUser: snapshot.get('proUser'),
        guestUser: snapshot.get('guestUser'),
        time: snapshot.get('time'),
        levelOneStatus: snapshot.get('levelOneStatus'),
        levelTwoStatus: snapshot.get('levelTwoStatus'),
        levelThreeStatus: snapshot.get('levelThreeStatus'),
        levelOneTime: snapshot.get('levelOneTime'),
        levelTwoTime: snapshot.get('levelTwoTime'),
        levelThreeTime: snapshot.get('levelThreeTime'),
        alltimeAgainstTheTimeScore:
            snapshot.get('alltimeAgainstTheTimeScore') != null
                ? snapshot.get('alltimeAgainstTheTimeScore')
                : 0,
        timeOfalltimeAgainstTheTimeHighscore:
            snapshot.get('timeOfalltimeAgainstTheTimeHighscore') == null
                ? snapshot.get('timeOfalltimeAgainstTheTimeHighscore').toDate()
                : DateTime.now(),
        monthlyAgainstTheTimeScore:
            snapshot.get('monthlyAgainstTheTimeScore') != null
                ? snapshot.get('monthlyAgainstTheTimeScore')
                : 0,
        timeOfMonthlyAgainstTheTimeHighscore:
            snapshot.get('timeOfMonthlyAgainstTheTimeHighscore') != null
                ? snapshot.get('timeOfMonthlyAgainstTheTimeHighscore').toDate()
                : DateTime.now(),
        dailyAgainstTheTimeScore:
            snapshot.get('dailyAgainstTheTimeScore') != null
                ? snapshot.get('dailyAgainstTheTimeScore')
                : 0,
        timeOfDailyAgainstTheTimeHighscore:
            snapshot.get('timeOfDailyAgainstTheTimeHighscore') != null
                ? snapshot.get('timeOfDailyAgainstTheTimeHighscore').toDate()
                : DateTime.now(),
        password: snapshot.get('guestUserPassword') != null
            ? snapshot.get('guestUserPassword')
            : '');
  }

  ///Method that returns a list of all users from snapshot
  List<UserModel> _userDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserModel(
          userName: doc.get('name'),
          profileImage: doc.get('profile_image'),
          state: doc.get('state'),
          time: doc.get('time'),
          levelOneTime: doc.get('levelOneTime'),
          levelTwoTime: doc.get('levelTwoTime'),
          levelThreeTime: doc.get('levelThreeTime'),
          alltimeAgainstTheTimeScore:
              doc.get('alltimeAgainstTheTimeScore') != null
                  ? doc.get('alltimeAgainstTheTimeScore')
                  : 0,
          timeOfalltimeAgainstTheTimeHighscore:
              doc.get('timeOfAgainstTheTimeHighscore') != null
                  ? doc.get('timeOfAgainstTheTimeHighscore').toDate()
                  : DateTime.now(),
          monthlyAgainstTheTimeScore: doc.get('monthlyAgainstTheTimeScore'),
          timeOfMonthlyAgainstTheTimeHighscore:
              doc.get('timeOfMonthlyAgainstTheTimeHighscore').toDate(),
          dailyAgainstTheTimeScore: doc.get('dailyAgainstTheTimeScore'),
          timeOfDailyAgainstTheTimeHighscore:
              doc.get('timeOfDailyAgainstTheTimeHighscore').toDate());
    }).toList();
  }

  ///Method that returns all the store items as a list from snapshot
  List<StoreItem> _shopItemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return StoreItem(
          name: doc.get('name') ?? '',
          description: doc.get('description') ?? '',
          subName: doc.get('subName'),
          subValue: doc.get('subValue'),
          hint: doc.get('hint'));
    }).toList();
  }

  ///Method that returns all Quiz items as a list from snapshot
  List<QuizItem> _quizItemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return QuizItem(
          name: doc.get('name') ?? '',
          color: doc.get('color') ?? '',
          numberOfQuestions: doc.get('number_of_questions') ?? 0,
          difficulty: doc.get('difficulty') ?? '',
          image: doc.get('image') ?? '');
    }).toList();
  }

  /// Method that returns a random number of german quiz questions from snapshot
  List<QuizQuestion> _germanQuizQuestionListFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return QuizQuestion(
        question: doc.get('question') ?? '',
        correctAnswer: doc.get("correct_answer") ?? '',
        incorrectAnswer1: doc.get('incorrect_answer_1') ?? '',
        incorrectAnswer2: doc.get('incorrect_answer_2') ?? '',
        incorrectAnswer3: doc.get('incorrect_answer_3') ?? '',
        negativeScore: doc.get('negative_score') ?? '0',
        questionUid: doc.id,
        correctlyAnswered: doc.get('correctly_answered') ?? '0',
        falselyAnswered: doc.get('falsely_answered') ?? '0',
        amountAnswered: doc.get('amount_answered') ?? '0',
        difficulty: doc.get('difficulty'),
      );
    }).toList();
  }

  /// Method that returns a speific QuizQuestion from snapshot
  QuizQuestion _getSpecficQuestionFromSnapshot(DocumentSnapshot snapshot) {
    return QuizQuestion(
        question: snapshot.get('question'),
        correctlyAnswered: snapshot.get('correctly_answered'),
        falselyAnswered: snapshot.get('falsely_answered'),
        amountAnswered: snapshot.get('amount_answered'),
        negativeScore: snapshot.get('negative_score'));
  }

  /// Method that gets a specific german quiz question from stream
  Stream<QuizQuestion> get specificGermanQuizQuestion {
    return questionsDECollection
        .doc(questionUid)
        .snapshots()
        .map(_getSpecficQuestionFromSnapshot);
  }

  /// Method that gets a list of quiz questions from stream
  Stream<List<QuizQuestion>> get germanQuizQuestions {
    return questionsDECollection
        .snapshots()
        .map(DatabaseService()._germanQuizQuestionListFromSnapshot);
  }

  ///Method that gets a specific user from stream
  Stream<UserModel> get userMetaData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  ///Method that gets the store items data from stream
  Stream<List<StoreItem>> get storeItemsData {
    return storeItemsCollection.snapshots().map(_shopItemListFromSnapshot);
  }

  ///Method that get the quiz items data from stream
  Stream<List<QuizItem>> get quizItemsData {
    return quizItemsCollection.snapshots().map(_quizItemListFromSnapshot);
  }

  ///Method that gets all of the users from stream
  Stream<List<UserModel>> get userItemData {
    return userCollection.snapshots().map(_userDataListFromSnapshot);
  }

  /// Method that gets the 20 highest scoring users from stream
  Stream<List<UserModel>> get userRankingData {
    /// Sorting the users and returning the top 20 results
    return userCollection
        .orderBy("alltimeAgainstTheTimeScore", descending: true)
        .limit(20)
        .snapshots()
        .map(_userDataListFromSnapshot);
  }

  /// Method that delete the user data from the firestore
  Future deleteUser() {
    return userCollection.doc(uid).delete();
  }

  /// Method that updates the level status for a user
  Future updateUserLevelStatus(String level, String newStatus) async {
    return await userCollection.doc(uid).update({level: newStatus});
  }

  /// Method that increases the correctly answered question count by 1
  Future incrementCorrectlyAnswered() {
    /// Creating a reference to the document that will be used
    DocumentReference questionRef = questionsDECollection.doc(questionUid);
    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          /// Getting the document
          DocumentSnapshot snapshot = await transaction.get(questionRef);
          if (!snapshot.exists) {
            throw Exception("Question does not exist!");
          }

          /// Increasing the count by one
          int newCorrectCount =
              int.parse(snapshot.get('correctly_answered')) + 1;

          /// Performing an update on the field
          transaction.update(
              questionRef, {'correctly_answered': newCorrectCount.toString()});

          /// Returning the new count
          return newCorrectCount;
        })
        .then((value) => print("Correct question count updated to $value"))
        .catchError((error) =>
            print("Failed to update correct question count: $error"));
  }

  /// Method that increases the falsely answered question count by 1
  Future incrementFalselyAnswered() {
    /// Creating a reference to the document that will be used
    DocumentReference questionRef = questionsDECollection.doc(questionUid);
    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          /// Getting the document
          DocumentSnapshot snapshot = await transaction.get(questionRef);
          if (!snapshot.exists) {
            throw Exception("Question does not exist!");
          }

          /// Increasing the count by one
          int newFalseCount = int.parse(snapshot.get('falsely_answered')) + 1;

          /// Performing an update on the field
          transaction.update(
              questionRef, {'falsely_answered': newFalseCount.toString()});

          /// Returning the new count
          return newFalseCount;
        })
        .then((value) => print("False question count updated to $value"))
        .catchError(
            (error) => print("Failed to update false question count: $error"));
  }

  /// Method that increases the negativity score by one
  Future incrementNegativityScore() {
    /// Creating a reference to the document that will be used
    DocumentReference questionRef = questionsDECollection.doc(questionUid);
    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          /// Getting the document
          DocumentSnapshot snapshot = await transaction.get(questionRef);
          if (!snapshot.exists) {
            throw Exception("Question does not exist!");
          }

          /// Increasing the count by one
          int newNegativeScore = int.parse(snapshot.get('negative_score')) + 1;

          /// Performing an update on the field
          transaction.update(
              questionRef, {'negative_score': newNegativeScore.toString()});

          /// Returning the new count
          return newNegativeScore;
        })
        .then((value) => print("Negative question score updated to $value"))
        .catchError((error) =>
            print("Failed to update negative question score: $error"));
  }

  /// Method that saves the new against the time score
  Future updateAgainstTheTimeScore(int newScore) {
    /// Creating a reference to the document that will be used
    DocumentReference userRef = userCollection.doc(uid);
    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          /// Getting the document
          DocumentSnapshot snapshot = await transaction.get(userRef);
          if (!snapshot.exists) {
            throw Exception("User does not exist!");
          }

          /// Getting the current against the time score of the user
          int currentScore = snapshot.get('alltimeAgainstTheTimeScore');

          /// Adding both the current and new score into a list
          List<int> rankingTimes = [newScore, currentScore];

          /// Sorting the items in the list
          rankingTimes.sort((a, b) => b.compareTo(a));

          /// Performing an update on the field only if the scorer is higher
          if (rankingTimes[0] > rankingTimes[1]) {
            transaction.update(userRef, {
              'alltimeAgainstTheTimeScore': rankingTimes[0],
              'timeOfalltimeAgainstTheTimeHighscore': DateTime.now()
            });
          }
          //Fields:
          // DailyHighScore
          // timeOfDailyHighScore
          //  => If newest time is not today dont't show
          //  => If newest time is today but score isn't higher, don't update
          //  => If newest time is the first of the day and score is lower, update
          // MonthlyHighScore
          // timeOfMonthlyHighScore
          //  => If newest time is not this month dont't show
          //  => If newest time is this month but score isn't higher, don't update
          //  => If newest time is the first of the month and score is lower, update
          // AllTimeHighScore
          // AllTimeHighScoreTime
          //  => If score is higher than all time, update all fields

          // Score is higher than all time => Update all - time score stays
          // Score is higher than montly => Update monthly - score gets removed
          // Score is higher than daily => Update daily - score gets removed

          // If score is higher than all time score, update all scores
          // If score is higher than monthly score, update monthly and daily score
          // if score is higher than daily score, update daily score

          /// Returning the new score
          return rankingTimes[0];
        })
        .then((value) => print("Against the time score updated to $value"))
        .catchError((error) =>
            print("Failed to update against the time score: $error"));
  }

  /// Method that increments the amount of times a question has been answered
  Future incrementQuestionAnswered() {
    /// Creating a reference to the document that will be used
    DocumentReference questionRef = questionsDECollection.doc(questionUid);
    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          /// Getting the document
          DocumentSnapshot snapshot = await transaction.get(questionRef);
          if (!snapshot.exists) {
            throw Exception("Question does not exist!");
          }

          /// Increasing the amount by one
          int newAmountAnswered =
              int.parse(snapshot.get('amount_answered')) + 1;

          /// Performing an update on the field
          transaction.update(
              questionRef, {'amount_answered': newAmountAnswered.toString()});

          /// Returning the new amount
          return newAmountAnswered;
        })
        .then((value) =>
            print("Question amount answered score updated to $value"))
        .catchError(
            (error) => print("Failed to update question amount score: $error"));
  }

  /// Method that returns easy questions from the questions_de collection
  Future<List<QuizQuestion>> getEasyGermanQuestions(
      int numberOfQuestions) async {
    List<QuizQuestion> easyQuestions = [];
    await FirebaseFirestore.instance
        .collection('questions_de')
        .where('difficulty', isEqualTo: "0")
        .where(FieldPath.documentId,
            isGreaterThanOrEqualTo: Controller.getRandomGeneratedId())
        .limit(numberOfQuestions)
        .get()
        .then((snapshot) =>
            easyQuestions = _germanQuizQuestionListFromSnapshot(snapshot));
    return easyQuestions;
  }

  /// Method that returns hard questions from the questions_de collection
  Future<List<QuizQuestion>> getHardGermanQuestions(
      int numberOfQuestions) async {
    List<QuizQuestion> hardQuestions = [];
    await FirebaseFirestore.instance
        .collection('questions_de')
        .where('difficulty', isEqualTo: "10")
        .where(FieldPath.documentId,
            isGreaterThanOrEqualTo: Controller.getRandomGeneratedId())
        .limit(numberOfQuestions)
        .get()
        .then((snapshot) =>
            hardQuestions = _germanQuizQuestionListFromSnapshot(snapshot));
    return hardQuestions;
  }
}
