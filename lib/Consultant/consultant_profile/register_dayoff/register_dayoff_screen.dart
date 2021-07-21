import 'package:flutter/material.dart';

import 'components/body.dart';

class RegisterDayOffScreen extends StatefulWidget {
  @override
  _RegisterDayOffState createState() => _RegisterDayOffState();
}

class _RegisterDayOffState extends State<RegisterDayOffScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Đăng ký ngày nghỉ"),
      ),
      body: Body(),
    );
  }
}
