import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool hasData = false;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // getToken() async {
  //   await Firebase.initializeApp();
  //   _firebaseMessaging.getToken().then((value) {
  //     print("Device Token: $value");
  //   });
  // }
  //
  // Future showNotification(NotiTitle, NotiBody) async {
  //   var androidDetails = new AndroidNotificationDetails(
  //       "channelId", "Local Notification", "channelDescription",
  //       importance: Importance.high);
  //   var iosDetails = new IOSNotificationDetails();
  //   var generalNotification =
  //       new NotificationDetails(android: androidDetails, iOS: iosDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       0, NotiTitle, NotiBody, generalNotification);
  // }
  //
  // getNotification(){
  //   getToken();
  //
  //   var initialzationSettingsAndroid =
  //   AndroidInitializationSettings('@mipmap/ic_launcher');
  //   var initializationSettings =
  //   InitializationSettings(android: initialzationSettingsAndroid);
  //   flutterLocalNotificationsPlugin.initialize(initializationSettings);
  //
  //   _firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       print("onMessage: $message");
  //       setState(() {
  //         hasData = true;
  //       });
  //       showNotification(
  //           message['notification']['title'], message['notification']['body']);
  //       showNotification("123", "123");
  //     },
  //     onLaunch: (Map<String, dynamic> message) async {
  //       print("onLaunch: $message");
  //       final data = message['data'];
  //       String mMessage = data['message'];
  //       setState(() {
  //         hasData = true;
  //       });
  //     },
  //     onResume: (Map<String, dynamic> message) async {
  //       print("onResume: $message");
  //       final data = message['data']['message'];
  //       String mMessage = data['message'];
  //       setState(() {
  //         hasData = true;
  //       });
  //     },
  //   );
  //   _firebaseMessaging.requestNotificationPermissions(
  //       const IosNotificationSettings(sound: true, badge: true, alert: true));
  // }

  @override
  void initState() {
    super.initState();
    // getToken();
    // getNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            return NotificationServiceAssignedItem(
                image: "https://bizweb.dktcdn.net/100/110/917/files/ms-da-nong.jpg?v=1568863806870",
                companyName: "test",
                date: index.toString(),
                serviceName: "test");
          },
        ),

      ],
    );
  }
}

class NotificationServiceAssignedItem extends StatelessWidget {
  const NotificationServiceAssignedItem({
    Key key,
    @required this.image,
    @required this.companyName,
    @required this.serviceName,
    @required this.date,
  }) : super(key: key);

  final String image, companyName, serviceName, date;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: Colors.white,
              width: 5
          ),
        ),
        color: Colors.grey.withOpacity(0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          children: [
            Container(
              child: Image.network(
                image,
              ),
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
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Dịch vụ ",
                          ),
                          TextSpan(
                            text: serviceName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: " tại ",
                          ),
                          TextSpan(
                            text: companyName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                " đã được đặt thành công, vui lòng đợi xác nhận từ phía cửa hàng",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: double.infinity,
                    child: Text(
                      date,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
