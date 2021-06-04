import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Staff/notification/components/body.dart';
import 'package:spa_and_beauty_staff/constants.dart';

class StaffNotification extends StatefulWidget {
  static String routeName = "/notification_screen";
  @override
  _StaffNotificationState createState() => _StaffNotificationState();
}

class _StaffNotificationState extends State<StaffNotification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: kPrimaryColor,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                Icon(
                  Icons.chat,
                  color: Colors.white,
                ),
                Text(
                  "Chat",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
              ],
            )),
        body: Body(),
      ),
    );
  }
}
