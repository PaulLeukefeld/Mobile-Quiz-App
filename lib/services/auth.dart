import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz_app/screens/wrapper.dart';
import 'package:mobile_quiz_app/services/analytics_service.dart';
import 'package:mobile_quiz_app/services/database.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/shared/constants.dart';
import 'package:mobile_quiz_app/shared/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  /// Variable that references the FirebaseAuth instances
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Setting the language code to german
  setLanguageCode(String language) {
    _auth.setLanguageCode(language);
  }

  /// Method that creates user object based on firebase user
  UserModel userFromFirebaseUser(User user) {
    return user != null
        ? UserModel(
            uid: user.uid,
            userName: "Guest",
            profileImage: 1,
            state: "",
            time: "1:00:00",
            guestUser: false,
            proUser: false,
            levelOneStatus: "Aktuelles Quiz",
            levelTwoStatus: "Gesperrt",
            levelThreeStatus: "Gesperrt")
        : null;
  }

  /// Method that gets the current firebase user
  User getCurrentFirebaseUser() {
    return _auth.currentUser;
  }

  /// Method that processes the user email verification verified
  processEmailVerification() async {
    /// Getting the current firebase user
    User user = getCurrentFirebaseUser();

    /// Getting up to date data on the current user
    await user.reload();

    /// Checking if the user is verfied
    if (user.emailVerified) {
      /// Setting the user as verfied
      setEmailVerification(user);

      /// Returning true which signals the frontend to close the dialog
      return true;
    }
  }

  /// Method that sends a verification email to the user
  void sendVerifcationEmail() {
    /// Getting the current firebase user
    User user = getCurrentFirebaseUser();

    /// Sending the verification email
    user.sendEmailVerification();
  }

  /// Method that checks if the user email has been verified
  Future<dynamic> checkEmailVerification(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('email_verified_' + user.email.toString()) ?? false;
  }

  /// Method that sets the email verification
  void setEmailVerification(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('email_verified_' + user.email.toString(), true);
  }

  ///User stream that listens for authentication changes
  Stream<UserModel> get user {
    return _auth.authStateChanges().map(userFromFirebaseUser);
  }

  ///Sign in withs email and password method
  Future signInWithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      /// Setting firebase analytics user properties for the returning user
      if (trackUser) {
        await AnalyticsService()
            .setUserProperties(userID: user.uid, userRole: 'Regular User');

        /// Logging the sign in event
        await AnalyticsService().logLogin();
      }
      return userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  ///Register with email and password method
  Future registerWithEmailandPassword(String email, String password,
      String state, String userName, int profileImage, bool guestUser) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      ///Creating a new Firestore document with the uid of the [FirebaseUser].
      await DatabaseService(uid: user.uid).updateUserData(
          userName,
          profileImage,
          state,
          "1:00:00",
          guestUser,
          null,
          "Aktuelles Quiz",
          "Gesperrt",
          "Gesperrt",
          "1:00:00",
          "1:00:00",
          "1:00:00",
          0,
          DateTime.now(),
          0,
          DateTime.now(),
          0,
          DateTime.now(),
          password);

      /// Setting firebase analytics user properties for the new user
      if (trackUser) {
        AnalyticsService().setUserProperties(
            userID: user.uid,
            userRole: guestUser ? 'Guest User' : 'Regular User');

        /// Logging either a guest account creation or a regular account creation
        guestUser
            ? AnalyticsService().logGuestAccountRegistration()
            : AnalyticsService().logRegularRegistration();
      }
      return userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      if (e.toString() ==
          "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
        return "EMAIL_IN_USE";
      } else {
        return null;
      }
    }
  }

  ///Sign out method
  Future signOut(BuildContext context) async {
    try {
      _auth.signOut().then((res) {
        /// Logging sign out
        if (trackUser) {
          AnalyticsService().logSignOut();
        }
        return Wrapper();
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /// Reset Password method
  Future sendResetPasswordEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  /// Method that reauthenticates the user
  Future reauthenticateUser(String password) async {
    User user = _auth.currentUser;

    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: user.email, password: password);
      UserCredential result =
          await user.reauthenticateWithCredential(credential);
      return result;
    } on Exception catch (exception) {
      return exception;
    } catch (error) {
      return error;
    }
  }

  /// Method that updates the guest users email and password
  Future updateGuestUserEmailAndPassword(String email, String password) async {
    User user = _auth.currentUser;
    try {
      await user.updateEmail(email);
      await user.updatePassword(password);
      return "SUCCESS";
    } on Exception catch (exception) {
      if (exception.toString() ==
          '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
        return "EMAIL_IN_USE";
      } else {
        return "ERROR";
      }
    } catch (error) {
      print(error);
      return "ERROR";
    }
  }

  /// Method that deletes all user data
  Future deleteUser(String email, String password) async {
    try {
      /// Reautheticating the user

      User user = _auth.currentUser;

      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      UserCredential result =
          await user.reauthenticateWithCredential(credential);

      if (result != null) {
        /// Deleting the user from the user management
        await result.user.delete();

        /// Deleting the user from the firestore
        await DatabaseService(uid: user.uid).deleteUser();
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      if (e.toString() ==
          "[firebase_auth/user-mismatch] The supplied credentials do not correspond to the previously signed in user.") {
        return false;
      }
    }
  }

  /// Method that creates a guest user and loggs the user in
  Future createGuestUser() async {
    await registerWithEmailandPassword(
        Controller.getRandomString(5) + "@example.com",
        Controller.getRandomString(10),
        "Deutschland",
        "Guest-" + Controller.getRandomString(5),
        1,
        true);
  }
}
