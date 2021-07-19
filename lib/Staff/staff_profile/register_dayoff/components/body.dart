import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spa_and_beauty_staff/Model/DateOff.dart';
import 'package:spa_and_beauty_staff/Service/staff_schedule_service.dart';
import 'package:spa_and_beauty_staff/Service/staff_service.dart';
import 'package:spa_and_beauty_staff/main.dart';
import 'date_picker.dart';
import 'date_range_picker.dart';

class Body extends StatefulWidget {
  static String dateOff;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController reasonTextController = TextEditingController();

  addDateOff() async {
    List<DateOff> dateOffToAdd = [];
    Employee employee = new Employee();
    Spa spa = new Spa();
    DateOff dateOff = new DateOff();

    // await StaffService.getStaffProfileById(
    //         MyApp.storage.getItem("staffId"), MyApp.storage.getItem("token"))
    //     .then((staff) => {
    //           setState(() {
    //             employee.active = true;
    //             employee.address = staff.data.user.address;
    //             employee.birthdate = staff.data.user.birthdate;
    //             employee.email = staff.data.user.email;
    //             employee.fullname = staff.data.user.fullname;
    //             employee.gender = staff.data.user.gender;
    //             employee.id = staff.data.user.id;
    //             employee.image = staff.data.user.image;
    //             employee.password = staff.data.user.password;
    //             employee.phone = staff.data.user.phone;
    //
    //             spa.city = staff.data.spa.city;
    //             spa.createBy = staff.data.spa.createBy;
    //             spa.createTime = staff.data.spa.createTime;
    //             spa.district = staff.data.spa.district;
    //             spa.id = staff.data.spa.id;
    //             spa.image = staff.data.spa.image;
    //             spa.latitude = staff.data.spa.latitude;
    //             spa.longtitude = staff.data.spa.longtitude;
    //             spa.name = staff.data.spa.name;
    //             spa.status = staff.data.spa.status;
    //             spa.street = staff.data.spa.street;
    //           }),
    //         });

    // for (int i = 0; i < Body.dateOffList.length; i++) {
    //   DateTime dateTime = DateTime.parse(Body.dateOffList[i]);
    //   dateOff.dateOff = dateTime;
    //   dateOff.employee = employee;
    //   dateOff.spa = spa;
    //   dateOff.reasonDateOff = reasonTextController.text;
    //   dateOff.statusDateOff = "WAITING";
    //   dateOffToAdd.add(dateOff);
    // }

    if (MyApp.storage.getItem("role") == "STAFF") {
      final res = await StaffScheduleService().sendDateOffStaff(
          MyApp.storage.getItem("token"), dateOff, reasonTextController.text);
      print("Status: ${res.body}");
    } else {
      final res = await StaffScheduleService().sendDateOffConsultant(
          MyApp.storage.getItem("token"), dateOff, reasonTextController.text);
      print("Status: ${res.body}");
    }

    //print(json.encode(dateOffToJson(dateOffToAdd)));
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
