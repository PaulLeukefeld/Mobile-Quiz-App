import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:mobile_quiz_app/models/user_model.dart';
import 'package:mobile_quiz_app/screens/wrapper.dart';
import 'package:mobile_quiz_app/services/analytics_service.dart';
import 'package:mobile_quiz_app/services/auth.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'dart:ui' as ui;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  RenderErrorBox.backgroundColor = Colors.transparent;
  RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /// Root Widget of the speedquiz app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      navigatorObservers: [
        AnalyticsService().getAnalyticsObserver(),
        BotToastNavigatorObserver()
      ],
      home: SplashScreen(
        useLoader: false,
        seconds: 3,
        photoSize: 175.0,
        navigateAfterSeconds: new StreamProvider<UserModel>.value(
          initialData: null,
          value: AuthService().user,
          child: Scaffold(
            body: Wrapper(),
          ),
        ),
        image: new Image.asset(
          "assets/icons/app_icon.png",
          scale: 2.0,
        ),
        backgroundColor: Colors.white,
        loaderColor: Color.fromRGBO(10, 122, 255, 1),
      ),
    );
  }
}
