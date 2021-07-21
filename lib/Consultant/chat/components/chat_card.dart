import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spa_and_beauty_staff/Service/firebase.dart';
import 'package:spa_and_beauty_staff/Staff/following/components/customer_detail.dart';

import 'conversation_screen.dart';

class ChatCard extends StatefulWidget {
   String customerId = "";
   String chatRoomId = "";
   String customerImage = "";
   String customerName = "";
   String customerPhone = "";


   ChatCard(
      {this.customerId,
      this.chatRoomId,
      this.customerImage,
      this.customerName,
      this.customerPhone});

  @override
  _ChatCardState createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {

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
                        customerPhone: widget.customerPhone,
                        customerName: widget.customerName,
                        customerImage: widget.customerImage,
                      )
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
                      backgroundImage: NetworkImage(widget.customerImage),
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
                              widget.customerName,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              widget.customerPhone,
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
