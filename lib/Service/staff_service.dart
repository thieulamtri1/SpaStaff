import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:spa_and_beauty_staff/Model/Staff.dart';
import 'package:spa_and_beauty_staff/main.dart';

class StaffService {
  static const String urlGetProfileStaff =
      "https://swp490spa.herokuapp.com/api/staff/findbyId?userId=";
  static const String urlGetProfileConsultant =
      "https://swp490spa.herokuapp.com/api/consultant/findById/";
  static const String urlUpdateProfileStaff =
      "https://swp490spa.herokuapp.com/api/staff/editprofile";
  static const String urlUpdateProfileConsultant =
      "https://swp490spa.herokuapp.com/api/consultant/editprofile";
  static const String urlEditPasswordStaff =
      "https://swp490spa.herokuapp.com/api/staff/editpassword";
  static const String urlEditPasswordConsultant =
      "https://swp490spa.herokuapp.com/api/consultant/editpassword";

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

  static Future<Staff> getConsultantProfileById(id, token) async {
    try {
      final response = await http.get(Uri.parse(urlGetProfileConsultant + id.toString()), headers: {
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

  Future<http.Response> updateConsultantProfile({
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
      Uri.parse(urlUpdateProfileConsultant),
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

  Future<http.Response> editStaffPasswordStaff(token, password) {
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

  Future<http.Response> editStaffPasswordConsultant(token, password) {
    return http.put(
      Uri.parse(urlEditPasswordConsultant),
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
}
