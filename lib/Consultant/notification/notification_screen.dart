import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/constants.dart';

import 'components/body.dart';

class ConsultantNotificationScreen extends StatefulWidget {
  static String routeName = "/notification_screenConsultant";
  @override
  _StaffNotificationState createState() => _StaffNotificationState();
}

class _StaffNotificationState extends State<ConsultantNotificationScreen> {
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
