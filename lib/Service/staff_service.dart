import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:spa_and_beauty_staff/Model/BookingDetailSteps.dart';
import 'package:spa_and_beauty_staff/Model/ConsultantSchedule.dart';
import 'package:spa_and_beauty_staff/Model/Staff.dart';
import 'package:spa_and_beauty_staff/Model/StaffSchedule.dart';
import 'package:spa_and_beauty_staff/main.dart';

class StaffService {
  static const String urlGetProfileStaff = "https://swp490spa.herokuapp.com/api/staff/findbyId?userId=";
  static const String urlUpdateProfileStaff = "https://swp490spa.herokuapp.com/api/staff/editprofile";
  static const String urlEditPasswordStaff = "https://swp490spa.herokuapp.com/api/staff/editpassword";
  static final String urlStaffSchedule = "https://swp490spa.herokuapp.com/api/staff/workingofstaff/findbydatechosen/";
  static final String dateChosen = "?dateChosen=";
  static final String urlDateOff = "https://swp490spa.herokuapp.com/api/staff/dateoff/create/";
  static final String GET_BOOKING_DETAIL_STEP_BY_BOOKING_DETAIL_ID = "https://swp490spa.herokuapp.com/api/staff/bookingDetailStep/findByBookingDetail/";

  static Future<Staff> getStaffProfileById(id, token) async {
    try {
      final response = await http.get(Uri.parse(urlGetProfileStaff + id.toString()), headers: {
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
      Uri.parse(urlUpdateProfileStaff),
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
      Uri.parse(urlEditPasswordStaff),
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
      final response = await http.get(Uri.parse(urlStaffSchedule + id.toString() + dateChosen + date), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      print("URL: " + urlStaffSchedule + id.toString() + dateChosen + date);
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
      Uri.parse(urlDateOff + MyApp.storage.getItem('staffId').toString()),
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

}
