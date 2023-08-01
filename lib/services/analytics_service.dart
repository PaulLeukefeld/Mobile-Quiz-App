import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  /// User properties that provide us with information about the user
  Future setUserProperties({@required String userID, String userRole}) async {
    await _analytics.setUserId(id: userID);
    await _analytics.setUserProperty(name: 'user_type', value: userRole);
  }

  /// Analytics function that logs if the user sign ins
  Future logLogin() async {
    await _analytics.logLogin(loginMethod: 'email');
  }

  /// Analytics funnction that logs if the regular user registration is completed
  Future logRegularRegistration() async {
    await _analytics.logSignUp(signUpMethod: 'email');
  }

  /// Analytics function that logs if the guest user registrations is completed
  Future logGuestAccountRegistration() async {
    await _analytics.logEvent(name: 'GuestAccountCreation');
  }

  /// Analytiics function that logs if a guest user creates an account
  Future logGuestAccountCreation() async {
    await _analytics.logSignUp(signUpMethod: 'guest');
  }

  /// Analytics function that logs if a user signs out
  Future logSignOut() async {
    await _analytics.logEvent(name: 'SignOut');
  }

  /// Analytics function that logs if a user changes their state
  Future logStateChange({String state}) async {
    await _analytics
        .logEvent(name: 'StateChange', parameters: {'state': state});
  }

  /// Analytics function that logs if a user changes their avatar
  Future logAvatarChange({int profileImage}) async {
    await _analytics.logEvent(
        name: 'AvatarChange', parameters: {'profile_image': profileImage});
  }

  /// Analytics function that logs if a user changes their username
  Future logUsernameChange({String username}) async {
    await _analytics
        .logEvent(name: 'UsernameChange', parameters: {'username': username});
  }

  /// Analytics function that logs if a user starts a level 1 quiz
  Future logLevelOneStart() async {
    await _analytics.logLevelStart(levelName: 'Level_1');
  }

  /// Analytics function that logs if a user finishes a level 1 quiz
  Future logLevelOneEnd() async {
    await _analytics.logLevelEnd(levelName: 'Level_1');
  }

  /// Analytics function that logs if a user starts a level 2 quiz
  Future logLevelTwoStart() async {
    await _analytics.logLevelStart(levelName: 'Level_2');
  }

  /// Analytics function that logs if a user finishes a level 2 quiz
  Future logLevelTwoEnd() async {
    await _analytics.logLevelEnd(levelName: 'Level_2');
  }

  /// Analytics function that logs if a user starts a level 3 quiz
  Future logLevelThreeStart() async {
    await _analytics.logLevelStart(levelName: 'Level_3');
  }

  /// Analytics function that logs if a user finishes a level 3 quiz
  Future logLevelThreeEnd() async {
    await _analytics.logLevelEnd(levelName: 'Level_3');
  }

  /// Analytics function that logs if a user starts a against the time quiz
  Future logAgainstTheTimeStart() async {
    await _analytics.logLevelStart(levelName: 'AgainstTheTime');
  }

  /// Analytics function that logs if a user finishes a against the time quiz
  Future logAgainstTheTimeEnd() async {
    await _analytics.logLevelEnd(levelName: 'AgainstTheTime');
  }
}
