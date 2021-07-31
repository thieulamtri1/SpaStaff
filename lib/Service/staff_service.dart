import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:spa_and_beauty_staff/Model/BookingDetailSteps.dart';
import 'package:spa_and_beauty_staff/Model/ConsultantSchedule.dart';
import 'package:spa_and_beauty_staff/Model/NotificationConsultant.dart';
import 'package:spa_and_beauty_staff/Model/Staff.dart';
import 'package:spa_and_beauty_staff/Model/StaffSchedule.dart';
import 'package:spa_and_beauty_staff/main.dart';

class StaffService {
  static const String GET_PROFILE_STAFF = "https://swp490spa.herokuapp.com/api/staff/findbyId?userId=";
  static const String UPDATE_PROFILE_STAFF = "https://swp490spa.herokuapp.com/api/staff/editprofile";
  static const String EDIT_PASSWORD_STAFF = "https://swp490spa.herokuapp.com/api/staff/editpassword";
  static final String GET_STAFF_SCHEDULE = "https://swp490spa.herokuapp.com/api/staff/workingofstaff/findbydatechosen/";
  static final String dateChosen = "?dateChosen=";
  static final String CREATE_DATEOFF = "https://swp490spa.herokuapp.com/api/staff/dateoff/create/";
  static final String GET_BOOKING_DETAIL_STEP_BY_BOOKING_DETAIL_ID = "https://swp490spa.herokuapp.com/api/staff/bookingDetailStep/findByBookingDetail/";
  static final String UPDATE_PROCESS_STEP = "https://swp490spa.herokuapp.com/api/staff/bookingDetailStep/confirmFinishAStep";
  static final String GET_NOTIFICATION_STAFF = "https://swp490spa.herokuapp.com/api/staff/getAllNotification/";


  static Future<String> editProcessStep(int bookingDetailStepId, String result) async {
    var jsonResponse;
    final res = await http.put(UPDATE_PROCESS_STEP,
        headers: {
          "accept" : "application/json",
          "content-type" : "application/json",
          "authorization" : "Bearer " + MyApp.storage.getItem("token"),
        },
        body: jsonEncode(
            {
              "bookingDetailStepId": bookingDetailStepId,
              "result": result,
            }));
    if (res.statusCode == 200){
      jsonResponse = utf8.decode(res.bodyBytes);
      print(jsonResponse.toString());
    }
    else {
      print("LOI ROI" + "Status code = " + res.statusCode.toString());
    }
    return res.statusCode.toString();
  }

  static Future<Staff> getStaffProfileById(id, token) async {
    try {
      final response = await http.get(Uri.parse(GET_PROFILE_STAFF + id.toString()), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      print(response.body);
      if (response.statusCode == 200) {
        return staffFromJson(utf8.decode(response.bodyBytes));
      } else {
        throw Exception('Failed to load staffProfile');
      }
    } catch (e) {
      throw Exception('Failed to load staffProfile');
    }
  }

  Future<http.Response> updateStaffProfile({
    token,
    active,
    address,
    birthdate,
    email,
    fullname,
    gender,
    id,
    image,
    password,
    phone,
  }) {
    return http.put(
      Uri.parse(UPDATE_PROFILE_STAFF),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "active": true,
        "address": address,
        "birthdate": birthdate,
        "email": email,
        "fullname": fullname,
        "gender": gender,
        "id": id,
        "image": image,
        "password": password,
        "phone": phone,
      }),
    );
  }

  Future<http.Response> editPasswordStaff(token, password) {
    return http.put(
      Uri.parse(EDIT_PASSWORD_STAFF),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "id": MyApp.storage.getItem("staffId"),
        "password": password,
      }),
    );
  }

  static Future<ScheduleStaff> getStaffSchedule(id, date, token) async {
    try {
      final response = await http.get(Uri.parse(GET_STAFF_SCHEDULE + id.toString() + dateChosen + date), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      print("URL: " + GET_STAFF_SCHEDULE + id.toString() + dateChosen + date);
      print("status code: " + response.statusCode.toString());
      if (response.statusCode == 200) {
        ScheduleStaff staffSchedule = scheduleStaffFromJson(utf8.decode(response.bodyBytes));
        return staffSchedule;
      } else {
        throw Exception('Failed to load staffSchedule');
      }
    } catch (e) {
      throw Exception('Failed to load staffSchedule');
    }
  }

  Future<http.Response> sendDateOffStaff(token, dateOff, reasonDateOff) {
    return http.post(
      Uri.parse(CREATE_DATEOFF + MyApp.storage.getItem('staffId').toString()),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "id": MyApp.storage.getItem("staffId"),
        "dateOff": dateOff,
        "reasonDateOff": reasonDateOff,
      }),
    );
  }

  static Future<BookingDetailSteps> getBookingDetailStepsByBookingDetailId(int bookingId) async {
    try {
      final response = await http.get(
          Uri.parse(GET_BOOKING_DETAIL_STEP_BY_BOOKING_DETAIL_ID + bookingId.toString()),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${MyApp.storage.getItem("token")}',
          });
      print(response.body);
      if (response.statusCode == 200) {
        BookingDetailSteps bookingDetailSteps = bookingDetailStepsFromJson(utf8.decode(response.bodyBytes));
        return bookingDetailSteps;
      } else {
        print("error code: "+ response.statusCode.toString());
      }
    } catch (e) {
      print("error code: loi khac");
    }
  }

  static Future<NotificationEmployee> getNotificationStaff() async {
    try{
      final response = await http.get(GET_NOTIFICATION_STAFF + MyApp.storage.getItem("staffId").toString(),
          headers: {
            "authorization": "Bearer " + MyApp.storage.getItem("token"),
          });
      print(response.body);
      if(200 == response.statusCode){
        final NotificationEmployee notification = notificationEmployeeFromJson(utf8.decode(response.bodyBytes));
        return notification;
      }else{
        return NotificationEmployee();
      }
    }catch(e){
      print(e);
      return NotificationEmployee();
    }
  }

}
