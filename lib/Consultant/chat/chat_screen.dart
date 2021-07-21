import 'package:flutter/material.dart';

import 'components/body.dart';

class ConsultantChatScreen extends StatefulWidget {
  static String routeName = "/chat_screen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ConsultantChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
