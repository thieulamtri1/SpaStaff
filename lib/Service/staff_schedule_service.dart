import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:spa_and_beauty_staff/Model/ConsultantSchedule.dart';
import 'package:spa_and_beauty_staff/Model/DateOff.dart';
import 'package:spa_and_beauty_staff/Model/Staff.dart';
import 'package:spa_and_beauty_staff/Model/StaffSchedule.dart';
import '../main.dart';


class StaffScheduleService{
  static final String urlStaffSchedule =
      "https://swp490spa.herokuapp.com/api/staff/workingofstaff/findbydatechosen/";
  static final String urlConsultantSchedule =
      "https://swp490spa.herokuapp.com/api/consultant/workingofconsultant/findbydatechosen/";
  static final String dateChosen =
      "?dateChosen=";
  static final String urlDateOffStaff =
      "https://swp490spa.herokuapp.com/api/staff/dateoff/create/";
  static final String urlDateOffConsultant =
      "https://swp490spa.herokuapp.com/api/consultant/dateoff/create/";

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

  static Future<ScheduleConsultant> getConsultantSchedule(id, date, token) async {
    try {
      final response = await http.get(Uri.parse(urlConsultantSchedule + id.toString() + dateChosen + date), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        print("lấy lịch Thành công");
        ScheduleConsultant consultantSchedule = scheduleConsultantFromJson(utf8.decode(response.bodyBytes));
        return consultantSchedule;
      } else {
        throw Exception('Failed to load staffSchedule');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load staffSchedule');
    }
  }

  Future<http.Response> sendDateOffStaff(token, dateOff, reasonDateOff) {
    return http.post(
      Uri.parse(urlDateOffStaff + MyApp.storage.getItem('staffId').toString()),
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


  Future<http.Response> sendDateOffConsultant(token, dateOff, reasonDateOff) {
    return http.post(
      Uri.parse(urlDateOffConsultant + MyApp.storage.getItem('staffId').toString()),
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

  Future<http.Response> getLich(token) {
    return http.get(
      Uri.parse("https://swp490spa.herokuapp.com/api/staff/workingofstaff/findbydatechosen/6?dateChosen=2021-07-01"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }
  

  // static Future<List<StaffSchedule>> getStaffSchedule(id) async {
  //   try {
  //     final response = await http.get(urlStaffSchedule + id.toString());
  //     print(response.body);
  //     print("status code la : "+response.statusCode.toString());
  //     if (response.statusCode == 200) {
  //       final  List<StaffSchedule> list = staffScheduleFromJson(utf8.decode(response.bodyBytes));
  //       return list;
  //     } else {
  //       throw Exception('Failed to load staffSchedule');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load staffSchedule');
  //   }
  // }



}