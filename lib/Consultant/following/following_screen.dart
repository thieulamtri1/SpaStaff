import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Staff/following/components/body.dart';

class ConsultantFollowingScreen extends StatefulWidget {
  //static String routeName = "/following_screen";
  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<ConsultantFollowingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
