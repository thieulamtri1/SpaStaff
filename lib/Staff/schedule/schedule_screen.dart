import 'package:flutter/material.dart';

import 'components/calendar_page.dart';


class Schedule extends StatelessWidget {
  static String routeName = "/schedule_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: calendarPage(),
    );
  }
}
