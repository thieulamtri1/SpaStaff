import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Model/Message.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final Message messagesObject = new Message();
  bool hasData = false;


  getToken() async {
    await Firebase.initializeApp();
    _firebaseMessaging.getToken().then((value) {
      print("Device Token: $value");
    });
  }


  @override
  void initState() {
    super.initState();
    getToken();
    _firebaseMessaging.configure(

      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        setState(() {
          messagesObject.title = message['notification']['title'];
          messagesObject.body = message['notification']['body'];
          messagesObject.message = message['data']['message'];
          hasData = true;
        });
      },

      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        final data = message['data'];
        String mMessage = data['message'];
        setState(() {
          messagesObject.title = message['notification']['title'];
          messagesObject.body = message['notification']['body'];
          messagesObject.message = message['data']['message'];
          hasData = true;
        });
      },

      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        final data = message['data']['message'];
        String mMessage = data['message'];
        setState(() {
          messagesObject.title = message['notification']['title'];
          messagesObject.body = message['notification']['body'];
          messagesObject.message = message['data']['message'];
          hasData = true;
        });
      },

    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          hasData ? Text("Message: " + messagesObject.message) : Text("Chưa có thông báo nào"),
          SizedBox(height: 20)
        ],
      ),
    );


    // return Column(
    //   children: [
    //     NotificationServiceAssignedItem(
    //       image: "assets/images/beauty.png",
    //       companyName: "Eri international",
    //       serviceName: "BIO ACNE",
    //       date: "25/03/2021",
    //     ),
    //     NotificationServiceAssignedItem(
    //       image: "assets/images/body.png",
    //       companyName: "Eri international",
    //       serviceName: "Massage JiaczHoiz",
    //       date: "26/03/2021",
    //     ),
    //     NotificationServiceAssignedItem(
    //       image: "assets/images/Skin.png",
    //       companyName: "Eri international",
    //       serviceName: "AQUA DETOX",
    //       date: "27/03/2021",
    //     ),
    //   ],
    // );

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
        color: Colors.grey.withOpacity(0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          children: [
            Container(
              child: Image.asset(
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
            Icon(Icons.more_horiz),
          ],
        ),
      ),
    );
  }
}
