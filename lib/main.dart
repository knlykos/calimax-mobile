import 'package:calimax/data/app_state.dart';
import 'package:calimax/data/preferences.dart';
import 'package:flutter/material.dart';
import 'package:calimax/ios_app/screens/login.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:scoped_model/scoped_model.dart';
import './ios_app/screens/home.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(ScopedModel<AppState>(
    model: AppState(),
    child: ScopedModel<Preferences>(
      model: Preferences(),
      child: MyAppIOS(),
    ),
  ));
}

class MyAppIOS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen()
      },
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          navLargeTitleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 70.0,
            color: CupertinoColors.activeBlue,
          ),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
