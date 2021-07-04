
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:spa_and_beauty_staff/Model/DateOff.dart';
import 'package:spa_and_beauty_staff/Model/Staff.dart';
import 'package:spa_and_beauty_staff/Model/StaffSchedule.dart';
import '../main.dart';


class StaffScheduleService{
  static final String urlStaffSchedule =
      "https://swp490spa.herokuapp.com/api/staff/workingofstaff/findbydatechosen/";
  static final String dateChosen =
      "?dateChosen=";
  static final String urlDateOff =
      "https://swp490spa.herokuapp.com/api/staff/dateoff/create";

  static Future<Schedule> getStaffSchedule(id, date, token) async {
      try {
        final response = await http.get(Uri.parse(urlStaffSchedule + id.toString() + dateChosen + date), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
        print("Status code lấy lịch: "+response.statusCode.toString());
        print("URL: " + urlStaffSchedule + id.toString() + dateChosen + date);
        print(response.body);
        if (response.statusCode == 200) {
          print("Vô dc đây rồi");
          return scheduleFromJson(utf8.decode(response.bodyBytes));
        } else {
          throw Exception('Failed to load staffSchedule');
        }
      } catch (e) {
        throw Exception('Failed to load staffSchedule');
      }
    }

  Future<http.Response> sendDateOff(token, dateOff) {
    return http.post(
      Uri.parse(urlDateOff),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: dateOffToJson(dateOff),
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