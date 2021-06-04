import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Service/firebase.dart';

import 'conversation_screen.dart';

class ChatCard extends StatefulWidget {
  final String customerId;
  final String chatRoomId;

  ChatCard({this.customerId, this.chatRoomId});

  @override
  _ChatCardState createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  String customerName;
  String customerPhone;
  String image =
      "https://scontent.fsgn5-3.fna.fbcdn.net/v/t1.6435-9/118772265_1498946380291014_420621456254103894_n.jpg?_nc_cat=111&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=Lddit53dbaIAX-mN6gh&_nc_ht=scontent.fsgn5-3.fna&oh=13788629bb9d8a9db14d59a61636482c&oe=608D99AF";
  QuerySnapshot querySnapshot;

  getUserInfo() async {
    await FirebaseMethod().getUserById(widget.customerId).then((value) {
      setState(() {
        customerName = value.documents[0].data["name"];
        customerPhone = value.documents[0].data["phone"];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(
                      chatRoomId: widget.chatRoomId,
                      phone: customerPhone,
                      name: customerName,
                      image: image,
                    )));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(image),
                    maxRadius: 30,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            customerName,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            customerPhone,
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey.shade500),
                          ),
                        ],
                      ),
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
