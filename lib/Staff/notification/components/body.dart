import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spa_and_beauty_staff/Model/NotificationConsultant.dart';
import 'package:spa_and_beauty_staff/Service/staff_service.dart';
import 'package:spa_and_beauty_staff/constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  NotificationEmployee notification = NotificationEmployee();
  bool loading = true;
  String image = "";

  getNotificationConsultant() async {
    await StaffService.getNotificationStaff().then((value) => {
          setState(() {
            notification = value;
            loading = false;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    getNotificationConsultant();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(
          child: SpinKitWave(
        color: kPrimaryColor,
        size: 50,
      ));
    } else {
      return notification.data.length == 0
          ? Center(
              child: Text(
                "Chưa có thông báo nào",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            )
          : Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: notification.data.length,
                  itemBuilder: (context, index) {
                    if (notification.data[index].type == "ASSIGN") {
                      image = 'assets/notificationStaff/assign.jpg';
                    }else{
                      image = 'assets/notificationStaff/spa.jpg';
                    }
                    return NotificationBookingSuccessItem(
                      image: image,
                      title: notification.data[index].title,
                      message: notification.data[index].message,
                    );
                  },
                )
              ],
            );
    }
  }
}

class NotificationBookingSuccessItem extends StatelessWidget {
  const NotificationBookingSuccessItem({
    Key key,
    @required this.image,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  final String image, title, message;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white, width: 5),
        ),
        color: Colors.grey.withOpacity(0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          children: [
            Container(
              child: Image.asset(image),
              width: 80,
              height: 80,
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              child: Column(
                children: [
                  Container(
                    height: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          message,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
