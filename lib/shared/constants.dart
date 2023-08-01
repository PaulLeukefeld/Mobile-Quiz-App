import 'dart:math';

import 'package:flutter/material.dart';

/// Constant that is used as [textinputdecoration] for a [TextField] in the app
const textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: false,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 0.0)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 0.0)));

/// List that contains all of the states in it
const statesList = [
  "Deutschland",
  "Baden-Württenberg",
  "Bayern",
  "Berlin",
  "Brandenburg",
  "Bremen",
  "Hamburg",
  "Hessen",
  "Mecklenburg-Vorpommern",
  "Niedersachsen",
  "Nordrhein-Westphalen",
  "Rheinland-Pfalz",
  "Saarland",
  "Sachsen",
  "Sachsen-Anhalt",
  "Schleswig-Holstein",
  "Thüringen",
  "Mallorca"
];

/// List of text widgets that contain the state names
List<Widget> scrollStates = [
  Text("Deutschland"),
  Text('Baden-Württenberg'),
  Text('Bayern'),
  Text("Berlin"),
  Text('Brandenburg'),
  Text('Bremen'),
  Text('Hamburg'),
  Text("Hessen"),
  Text("Mecklenburg-Vorpommern"),
  Text("Niedersachsen"),
  Text("Nordrhein-Westphalen"),
  Text("Rheinland-Pfalz"),
  Text("Saarland"),
  Text('Sachsen'),
  Text("Sachsen-Anhalt"),
  Text("Schleswig-Holstein"),
  Text("Thüringen"),
  Text("Mallorca")
];

/// Variable used to determin the total number of onboarding dots
const totalOnboardingDots = 4;

/// Variable used to determin the total number of intro dots
const totalIntroDots = 5;

/// Varibale used to keep track of the current onboarding pageview index
double currentOnboardingIndex = 0.0;

/// Variable used to keep track of the current intro pageview index
double currentIntroIndex = 0.0;

/// Variable used to keep track of the current guest register pageview
double currentGuestIndex = 0.0;

/// Variable that specifies the pagecontroller
PageController pageController = PageController(
  initialPage: 0,
  keepPage: true,
);

/// Variable that specifies the home page controller
PageController homePageController = PageController(
  initialPage: 1,
  keepPage: true,
);

/// Home Index that specifies, which page is currently selected
int homeBottomSelectedIndex = 1;

/// Sign in email text editing controller
var signInEmailController = TextEditingController();

/// Sign in password text editing controller
var signInPasswordController = TextEditingController();

/// Forgot password email text editing controller
var forgotPasswordEmailController = TextEditingController();

/// Register enter email screen email text controller
var registerEnterEmailController = TextEditingController();

/// Register enter password screen password text controller
var registerEnterPasswordController = TextEditingController();

/// Register enter username screen username text controller
var registerEnterUsernameController = TextEditingController();

/// Guest register enter email screen email text controller
var guestRegisterEnterEmailController = TextEditingController();

/// Guest register enter password screen password text controller
var guestRegisterEnterPasswordController = TextEditingController();

/// Guest register enter username screeen username text controller
var guestRegisterEnterUsernameController = TextEditingController();

/// Account change username text controller
var accountChangeUsernameController = TextEditingController();

/// Delete account email text controller
var deleteAccountEmailTextController = TextEditingController();

/// Delete account password text controller
var deleteAccountPasswordTextController = TextEditingController();

/// List of chars that are used for the random email, password & username
final chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

/// Random variable
final Random random = Random();

/// Radius sizes for the avatars
double avatarOneSize = 0.15;
double avatarTwoSize = 0.15;
double avatarThreeSize = 0.15;
double avatarFourSize = 0.15;
double avatarFiveSize = 0.15;
double avatarSixSize = 0.15;

/// Different permission status
var permGranted = "granted";
var permDenied = "denied";
var permUnknown = "unknown";
var permProvisional = "provisional";

/// Current ranking sort column
int currentRankingSortColumn = 0;

/// Bool ranking acending variable
bool rankingIsAscending = false;

/// Color of the timer
Color timerColor = Colors.black;

/// Color of the quiz answer button when it gets tapped
Color textColor = Colors.black;
Color borderColor = Colors.grey;
Color buttonColor = Colors.white;
Color correctlyAnsweredColor = Colors.white;
Color correctlyAnsweredBorderColor = Colors.grey;
Color correctlyAnsweredTextColor = Colors.black;

Color firstAnswerButtonColor = Colors.white;
Color secondAnswerButtonColor = Colors.white;
Color thirdAnswerButtonColor = Colors.white;
Color fourthAnswerButtonColor = Colors.white;

Color firstAnswerButtonBorderColor = Colors.grey;
Color secondAnswerButtonBorderColor = Colors.grey;
Color thirdAnswerButtonBorderColor = Colors.grey;
Color fourthAnswerButtonBorderColor = Colors.grey;

Color firstAnswerTextColor = Colors.black;
Color secondAnswerTextColor = Colors.black;
Color thirdAnswerTextColor = Colors.black;
Color fourthAnswerTextColor = Colors.black;

double firstAnswerBorderWidth = 1.0;
double secondAnswerBorderWidth = 1.0;
double thirdAnswerBorderWidth = 1.0;
double fourthAnswerBorderWidth = 1.0;

/// Width of the answer choice border
double borderWidth = 1.0;

/// Correct animation
bool correctAnswer = false;

/// False animation
bool falseAnswer = false;

/// Duration for the correct or false time added
int responseTimeDuration = 2500;

/// Left offset for the correct or false time added
double topTimeOffset = 0.11;

/// Top offset for the correct of false time added
double leftTimeOffset = 0.7;

/// Response time font size
double responseTimeFontSize = 30;

/// User Tracking status
bool trackUser = true;
