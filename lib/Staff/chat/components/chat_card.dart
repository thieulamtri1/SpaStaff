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
  String customerImage =
      "https://www.chapter3d.com/wp-content/uploads/2020/08/anh-chan-dung.jpg";



  @override
  void initState() {
    super.initState();
    getUserInfo();
  }


  getUserInfo() async {
    await FirebaseMethod().getUserById(widget.customerId).then((value) {
      setState(() {
        // customerName = value.documents[0]["name"];
        // customerPhone = value.documents[0]["phone"];
        customerName = "Cường";
        customerPhone = "06040352";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ConversationScreen(
                      chatRoomId: widget.chatRoomId,
                      phone: customerPhone,
                      name: customerName,
                      image: customerImage,
                    )
                //ChatScreenNe(),
            ));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(customerImage),
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
