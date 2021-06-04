


import 'package:flutter/widgets.dart';
import 'package:spa_and_beauty_staff/Staff/bottom_navigation/bottom_navigation.dart';
import 'package:spa_and_beauty_staff/Staff/following/following_screen.dart';
import 'package:spa_and_beauty_staff/Staff/notification/notification_screen.dart';
import 'package:spa_and_beauty_staff/Staff/sign_in/sign_in_screen.dart';

import 'Staff/schedule/schedule_screen.dart';

final Map<String, WidgetBuilder> routes = {
  Schedule.routeName: (context) => Schedule(),
  BottomNavigation.routeName: (context) => BottomNavigation(),
  StaffNotification.routeName: (context) => StaffNotification(),
  SignIn.routeName: (context) => SignIn(),
  //FollowingScreen.routeName: (context) => FollowingScreen(),
};