import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Staff/notification/components/body.dart';
import 'package:spa_and_beauty_staff/constants.dart';

class StaffNotificationScreen extends StatefulWidget {
  static String routeName = "/notification_screenStaff";
  @override
  _StaffNotificationState createState() => _StaffNotificationState();
}

class _StaffNotificationState extends State<StaffNotificationScreen> {
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
                  Icons.notifications_active,
                  color: Colors.white,
                ),
                SizedBox(width: 20),
                Text(
                  "Thông báo",
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
