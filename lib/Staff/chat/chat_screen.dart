import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Staff/chat/components/body.dart';
import 'package:spa_and_beauty_staff/constants.dart';

class ChatScreen extends StatefulWidget {
  static String routeName = "/chat_screen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
