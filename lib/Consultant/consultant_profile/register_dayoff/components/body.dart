
import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Model/DateOff.dart';
import 'package:spa_and_beauty_staff/Service/consultant_service.dart';
import 'package:spa_and_beauty_staff/Service/staff_schedule_service.dart';
import 'package:spa_and_beauty_staff/main.dart';
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
                    "Reason",
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
                  color: Colors.orangeAccent,
                  onPressed: () async {
                    await addDateOff();
                    print("DateTime nè: " + Body.dateOff.toString());
                    Body.dateOff = "";
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
