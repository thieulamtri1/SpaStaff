import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Staff/following/components/body.dart';

class StaffFollowingScreen extends StatefulWidget {
  //static String routeName = "/following_screen";
  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<StaffFollowingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
