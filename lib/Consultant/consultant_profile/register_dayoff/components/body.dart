
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Service/consultant_service.dart';
import 'package:spa_and_beauty_staff/constants.dart';
import 'package:spa_and_beauty_staff/main.dart';
import '../register_dayoff_screen.dart';
import 'date_picker.dart';

class Body extends StatefulWidget {
  static String dateOff;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController reasonTextController = TextEditingController();

  addDateOff() async {
    final res = await ConsultantService().sendDateOffConsultant(
        MyApp.storage.getItem("token"), Body.dateOff, reasonTextController.text);
    print("Status: ${res.body}");
    var jsonResponse = json.decode(res.body);
    if (jsonResponse['code'] == 200){
      final snackBar = SnackBar(
        content: Text('Đăng ký ngày nghỉ thành công'),
        action: SnackBarAction(
          label: 'Bỏ qua',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else if(jsonResponse['code'] == 204){
      final snackBar = SnackBar(
        content: Text('Ngày đã được đăng ký'),
        action: SnackBarAction(
          label: 'Thử lại',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else {
      final snackBar = SnackBar(
        content: Text('Đăng ký không thành công'),
        action: SnackBarAction(
          label: 'Thử lại',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DatePickerWidget(),
              SizedBox(height: 24),
              //DateRangePickerWidget(),
              //SizedBox(height: 24),
              Row(
                children: [
                  Text(
                    "Lý do",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              TextField(
                controller: reasonTextController,
                maxLines: 5,
                style: TextStyle(
                    color: Colors.black, decoration: TextDecoration.none),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: kPrimaryColor,
                  onPressed: () async {
                    if(reasonTextController.text.trim() == ""){
                      final snackBar = SnackBar(
                        content: Text('Vui lòng ghi rõ lý do'),
                        action: SnackBarAction(
                          label: 'Thử lại',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }else{
                      await addDateOff();
                      print("DateTime nè: " + Body.dateOff.toString());
                      Body.dateOff = "";
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterDayOffScreen()),
                      );
                    }
                  },
                  child: Text(
                    "Đăng ký",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
