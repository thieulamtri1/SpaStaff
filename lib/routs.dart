


import 'package:flutter/widgets.dart';
import 'package:spa_and_beauty_staff/Staff/bottom_navigation/bottom_navigation.dart';
import 'package:spa_and_beauty_staff/Staff/following/following_screen.dart';
import 'package:spa_and_beauty_staff/Staff/notification/notification_screen.dart';
import 'package:spa_and_beauty_staff/sign_in/sign_in_screen.dart';

import 'Consultant/bottom_navigation/bottom_navigation.dart';
import 'Consultant/notification/notification_screen.dart';
import 'Consultant/schedule/schedule_screen.dart';
import 'Staff/schedule/schedule_screen.dart';

final Map<String, WidgetBuilder> routes = {
  StaffScheduleScreen.routeName: (context) => StaffScheduleScreen(),
  ConsultantScheduleScreen.routeName: (context) => ConsultantScheduleScreen(),
  BottomNavigationStaff.routeName: (context) => BottomNavigationStaff(),
  BottomNavigationConsultant.routeName: (context) => BottomNavigationConsultant(),
  StaffNotificationScreen.routeName: (context) => StaffNotificationScreen(),
  ConsultantNotificationScreen.routeName: (context) => ConsultantNotificationScreen(),
  SignIn.routeName: (context) => SignIn(),
  //FollowingScreen.routeName: (context) => FollowingScreen(),
};