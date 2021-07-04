import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:spa_and_beauty_staff/Model/Staff.dart';

class StaffService {
  static const String urlGetProfile =
      "https://swp490spa.herokuapp.com/api/staff/findbyId?userId=";
  static const String urlUpdateProfile =
      "https://swp490spa.herokuapp.com/api/staff/staff/editprofile";
  static const String urlEditPassword =
      "https://swp490spa.herokuapp.com/api/staff/editpassword";

  static Future<Staff> getStaffProfileById(id, token) async {
    print("ID lúc gọi API: $id");
    try {
      final response = await http.get(Uri.parse(urlGetProfile + id.toString()), headers: {
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
      Uri.parse(urlUpdateProfile),
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

  Future<http.Response> editStaffPassword(token, password) {
    return http.put(
      Uri.parse(urlEditPassword),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "id": 6,
        "password": password,
      }),
    );
  }
}
