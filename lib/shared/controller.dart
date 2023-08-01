import 'dart:io';
import 'dart:math';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_quiz_app/models/alerts/against_the_time_intro/against_the_time_intro_alert.dart';
import 'package:mobile_quiz_app/models/quiz_question.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:notification_permissions/notification_permissions.dart';

class Controller {
  /// Methods that checks if the user has seen the intro dialog before
  Future checkIntroDialog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('against_the_time_intro_dialog') ?? false;
  }

  /// Methods that sets the intro dialog as seen
  void setIntroDialog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('against_the_time_intro_dialog', true);
  }

  /// Method that launches the intro dialog
  void launchIntroDialog(BuildContext context) {
    checkIntroDialog().then((value) {
      if (!value) {
        /// Showing the intro alert to the user
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AgainstTheTimeIntroAlert();
            });

        /// Setting the dialog as seen
        setIntroDialog();
      }
    });
  }

  /// Method that launches the review dialog
  static void launchReviewDialog() {
    /// Checking if the review dialog should be shown
    checkReviewDialog().then((value) async {
      if (value) {
        /// In app review instance
        final InAppReview inAppReview = InAppReview.instance;

        /// Showing the review dialog to the user
        if (await inAppReview.isAvailable()) {
          inAppReview.requestReview();
        }

        /// Marking the review dialog as seen
        setReviewStatus();
      }
    });
  }

  /// Method that checks if the user should be shown the review dialog
  static Future checkReviewDialog() async {
    /// Initializing shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    /// Variable that keeps track of the number of games completed
    int completedGames = prefs.getInt('completed_games_amount') == null
        ? 1
        : prefs.getInt('completed_games_amount');

    /// Variable that keeps track of the review status
    bool reviewStatus = prefs.getBool('review_alert_seen') == null
        ? false
        : prefs.getBool('review_alert_seen');

    /// Checking if the user has seen the review alert before
    /// and if the user has played at least 5 games
    if (reviewStatus == false && completedGames % 5 == 0) {
      return true;
    } else {
      return false;
    }
  }

  /// Method that sets the staus of review dialog as seen
  static void setReviewStatus() async {
    /// Initializing shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    /// Setting the status of the review dialog as seen
    prefs.setBool('review_alert_seen', true);
  }

  /// Method that incrments the amount of games that have been completed
  static void incrementCompletedGames() async {
    /// Initializing shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int completedGames = prefs.getInt('completed_games_amount') == null
        ? 0
        : prefs.getInt('completed_games_amount');

    /// Incrementing the amount of completed games by 1
    prefs.setInt('completed_games_amount', completedGames += 1);
  }

  /// Method that always launches the AGT intro dialog without checking
  static void launchIntroDialogRequest(BuildContext context) {
    /// Showing the intro alert to the user
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AgainstTheTimeIntroAlert();
        });
  }

  /// Method that requests tracking authorization from the user
  static void requestTrackingAuthorization() async {
    // Show tracking authorization dialog and ask for permission
    final status = await AppTrackingTransparency.requestTrackingAuthorization();

    /// Setting the tracking constant if the user allowed tracking
    if (status == TrackingStatus.authorized) {
      trackUser = true;
    } else if (status == TrackingStatus.denied) {
      trackUser = false;
    }
    print(status);
  }

  /// Method that resets the current intro page dialog index
  static void resetIntroDialogIndex() {
    currentIntroIndex = 0.0;
  }

  /// Method that is used to determin the screen dimensionss
  static Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// Method that is used to get the height of the screen without the safearea
  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
  }

  /// Method that changes the bottomSelectIndex, which ultimately changes the page
  static void pageChanged(double index) {
    currentOnboardingIndex = index;
  }

  /// Method that changes the bottomIntroSelectIndex, which changes the page
  static void introPageChanged(double index) {
    currentIntroIndex = index;
  }

  /// Method that resets the current page index for the onboarding page
  static void resetOnboardingIndex() {
    currentOnboardingIndex = 0.0;
  }

  /// Method that resets the current page index for the intro dialog
  static void resetIntroIndex() {
    currentIntroIndex = 0.0;
  }

  /// Method that sets the prefered orientation to portrait mode
  static void setPreferedOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  /// Method that creates a random string of a given lenght
  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));

  /// Method that resets all values of text editing controllers
  static void resetAllTextEditControllers() {
    //signInEmailController = TextEditingController();
    signInEmailController.clear();

    //signInPasswordController = TextEditingController();
    signInPasswordController.clear();

    //forgotPasswordEmailController = TextEditingController();
    forgotPasswordEmailController.clear();

    //registerEnterEmailController = TextEditingController();
    registerEnterEmailController.clear();

    //registerEnterPasswordController = TextEditingController();
    registerEnterPasswordController.clear();

    //registerEnterUsernameController = TextEditingController();
    registerEnterUsernameController.clear();

    //guestRegisterEnterEmailController = TextEditingController();
    guestRegisterEnterEmailController.clear();

    //guestRegisterEnterPasswordController = TextEditingController();
    guestRegisterEnterPasswordController.clear();

    //guestRegisterEnterUsernameController = TextEditingController();
    guestRegisterEnterUsernameController.clear();

    //accountChangeUsernameController = TextEditingController();
    accountChangeUsernameController.clear();

    //deleteAccountEmailTextController = TextEditingController();
    deleteAccountEmailTextController.clear();

    //deleteAccountPasswordTextController = TextEditingController();
    deleteAccountPasswordTextController.clear();
  }

  /// Method that resets the sign in password text editing controller
  static void resetSignInPasswordController() {
    //signInPasswordController = TextEditingController();
    signInPasswordController.clear();
  }

  /// Method that resetes the forget password text editing controller
  static void resetForgetPasswordController() {
    forgotPasswordEmailController.clear();
  }

  /// Method that resets all avatar selections
  static void resetAvatarSelection() {
    avatarOneSize = 0.15;
    avatarTwoSize = 0.15;
    avatarThreeSize = 0.15;
    avatarFourSize = 0.15;
    avatarFiveSize = 0.15;
    avatarSixSize = 0.15;
  }

  /// Method used for launching the privacy information in the browser
  static void launchPrivacyInformation() async {
    String url = "";
    if (Platform.isIOS) {
      url = "https://www.quizbase-app.com/ios-impressum/";
    } else {
      url = "https://www.quizbase-app.com/impressum/";
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  /// Method that launches the Contact page in the browser
  static void launchContactPage() async {
    String url = "";

    if (Platform.isIOS) {
      url = "https://www.quizbase-app.com/ios-kontakt/";
    } else {
      url = "https://www.quizbase-app.com/kontakt/";
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  /// Method that launches the FAQ page in the browser
  static void launchFAQPage() async {
    String url = "";
    if (Platform.isIOS) {
      url = "https://www.quizbase-app.com/faq/";
    } else {
      url = "https://www.quizbase-app.com/faq/";
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  /// Method that launches the Imprint page in the browser
  static void launchImprintPage() async {
    String url = "";
    if (Platform.isIOS) {
      url = "https://www.quizbase-app.com/ios-impressum/";
    } else {
      url = "https://www.quizbase-app.com/impressum/";
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  /// Method that launches the Terms & Conditions page in the browser
  static void launchTermsAndCondirionsPage() async {
    String url = "";
    if (Platform.isIOS) {
      url = "https://www.quizbase-app.com/ios-impressum/";
    } else {
      url = "https://www.quizbase-app.com/impressum/";
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  /// Method that launches the get notification permission dialog
  static Future<PermissionStatus> getNotificationPermissions() {
    return NotificationPermissions.requestNotificationPermissions(
        iosSettings: const NotificationSettingsIos(
            sound: true, badge: true, alert: true));
  }

  /// Checks the notification permission status
  Future<String> getCheckNotificationPermStatus() {
    return NotificationPermissions.getNotificationPermissionStatus()
        .then((status) {
      switch (status) {
        case PermissionStatus.denied:
          return permDenied;
        case PermissionStatus.granted:
          return permGranted;
        case PermissionStatus.unknown:
          return permUnknown;
        case PermissionStatus.provisional:
          return permProvisional;
        default:
          return null;
      }
    });
  }

  /// Method that takes in a list of questions and shuffles them
  static List<QuizQuestion> shuffleQuizQuestions(List<QuizQuestion> questions) {
    List<QuizQuestion> shuffledQuestions = questions;
    shuffledQuestions.shuffle();
    return shuffledQuestions;
  }

  /// Method that takes in a list of questions and orders them
  static List<QuizQuestion> generateOrderedQuestions(
      List<QuizQuestion> questions) {
    /// Set that contains the easy questions
    Set<QuizQuestion> easyQuestions = {};

    /// Set that contains the hard questions
    Set<QuizQuestion> hardQuestions = {};

    /// List that contains the final questions
    List<QuizQuestion> finalQuestions = [];

    /// Ordering the questions to the right set
    shuffleQuizQuestions(questions).forEach((question) {
      question.difficulty == "0" && easyQuestions.length < 10
          ? easyQuestions.add(question)
          : hardQuestions.add(question);
    });

    /// Converting the easy questions set to a list
    finalQuestions = easyQuestions.toList();

    /// Combining hard and easy questions to one list
    finalQuestions.addAll(hardQuestions.toList());

    return finalQuestions;
  }

  /// Method that returns the amount of time thats being deducted
  static int calculateTimeDeduction(questionIndex, wrongQuestions) {
    return (questionIndex + 1 + (wrongQuestions).ceil()) * 1000;
  }

  /// Method that return an alternative amount of time deduction
  static int calculateAlternativeTimeDeduction(questionIndex) {
    return pow(questionIndex, 1.25).round() * 2500;
  }

  /// Method that generates generated a random autoID
  static String getRandomGeneratedId() {
    const int AUTO_ID_LENGTH = 20;
    const String AUTO_ID_ALPHABET =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

    const int maxRandom = AUTO_ID_ALPHABET.length;
    final Random randomGen = Random();

    String id = '';
    for (int i = 0; i < AUTO_ID_LENGTH; i++) {
      id = id + AUTO_ID_ALPHABET[randomGen.nextInt(maxRandom)];
    }
    return id;
  }

  /// Method that returns true if the user is connected to the internet
  /// and false otherwise
  static checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  /// Method that returns the circle avatar for the ranking screen
  static Widget createRankingAvatar(
      BuildContext context, List<dynamic> rankingItems, int index) {
    if (index == 0) {
      return Container(
        width: Controller.getSize(context).width * 0.15,
        height: Controller.getHeight(context) * 0.06,
        child: Stack(
          children: [
            CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: Controller.getSize(context).width * 0.05,
                child: ClipOval(
                    child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Controller.getHeight(context) * 0.0075),
                  child: Image(
                      image: rankingItems[0] != null
                          ? AssetImage("assets/profile_images/profile_image_" +
                              rankingItems[index].profileImage.toString() +
                              ".png")
                          : AssetImage("assets/profile_images/profile_image_" +
                              "1" +
                              ".png")),
                ))),
            Positioned(
                top: Controller.getHeight(context) * 0.025,
                left: Controller.getSize(context).width * 0.055,
                child: Image.asset(
                  "assets/ranking/first_place.png",
                  height: Controller.getHeight(context) * 0.035,
                ))
          ],
        ),
      );
    } else if (index == 1) {
      return Container(
        width: Controller.getSize(context).width * 0.15,
        height: Controller.getHeight(context) * 0.06,
        child: Stack(
          children: [
            CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: Controller.getSize(context).width * 0.05,
                child: ClipOval(
                    child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Controller.getHeight(context) * 0.0075),
                  child: Image(
                      image: rankingItems[0] != null
                          ? AssetImage("assets/profile_images/profile_image_" +
                              rankingItems[index].profileImage.toString() +
                              ".png")
                          : AssetImage("assets/profile_images/profile_image_" +
                              "1" +
                              ".png")),
                ))),
            Positioned(
                top: Controller.getHeight(context) * 0.025,
                left: Controller.getSize(context).width * 0.055,
                child: Image.asset(
                  "assets/ranking/second_place.png",
                  height: Controller.getHeight(context) * 0.035,
                ))
          ],
        ),
      );
    } else if (index == 2) {
      return Container(
        width: Controller.getSize(context).width * 0.15,
        height: Controller.getHeight(context) * 0.06,
        child: Stack(
          children: [
            CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: Controller.getSize(context).width * 0.05,
                child: ClipOval(
                    child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Controller.getHeight(context) * 0.0075),
                  child: Image(
                      image: rankingItems[0] != null
                          ? AssetImage("assets/profile_images/profile_image_" +
                              rankingItems[index].profileImage.toString() +
                              ".png")
                          : AssetImage("assets/profile_images/profile_image_" +
                              "1" +
                              ".png")),
                ))),
            Positioned(
                top: Controller.getHeight(context) * 0.025,
                left: Controller.getSize(context).width * 0.055,
                child: Image.asset(
                  "assets/ranking/third_place.png",
                  height: Controller.getHeight(context) * 0.035,
                ))
          ],
        ),
      );
    } else {
      return CircleAvatar(
          backgroundColor: Colors.grey[300],
          radius: Controller.getSize(context).width * 0.05,
          child: ClipOval(
              child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Controller.getHeight(context) * 0.0075),
            child: Image(
                image: rankingItems[0] != null
                    ? AssetImage("assets/profile_images/profile_image_" +
                        rankingItems[index].profileImage.toString() +
                        ".png")
                    : AssetImage(
                        "assets/profile_images/profile_image_" + "1" + ".png")),
          )));
    }
  }

  /// Method that creates the bottom navigation bars
  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: new Icon(CupertinoIcons.person),
        label: "Account",
      ),
      BottomNavigationBarItem(
        icon: new Icon(CupertinoIcons.game_controller),
        label: "Quiz",
      ),
      // BottomNavigationBarItem(icon: Icon(CupertinoIcons.cart), label: 'Shop'),
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.chart_bar), label: 'Ranking'),
    ];
  }
}
