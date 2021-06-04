import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:spa_and_beauty_staff/Staff/bottom_navigation/bottom_navigation.dart';
import 'package:spa_and_beauty_staff/Staff/sign_in/sign_in_screen.dart';
import 'routs.dart';
import 'package:spa_and_beauty_staff/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final LocalStorage storage = new LocalStorage('localstorage_app');
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spa, Beauty Staff',
      theme: theme(),
      // home: SplashScreen()
      initialRoute: SignIn.routeName,
      routes: routes,
    );
  }
}
