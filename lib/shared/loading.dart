import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

///Loading Widget that is display everytime the app is loading data
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
            child: SpinKitChasingDots(
          color: Color.fromRGBO(10, 122, 255, 1),
          size: 50.0,
        )));
  }
}
