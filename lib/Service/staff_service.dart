import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:spa_and_beauty_staff/Model/Staff.dart';


class StaffService {
  static const String urlGetProfile =
      "https://swp490spa.herokuapp.com/api/staff/search/";
  static const String urlUpdateProfile = "chua co";

  static Future<Staff> getStaffProfileById(id, token) async {
    print("ID nè: $id");
    try {
      final response = await http.get(urlGetProfile + id.toString()
      //     , headers: {
      //   'Content-Type': 'application/json',
      //   'Accept': 'application/json',
      //   'Authorization': 'Bearer $token',
      // }
      );
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
    fullname,
    image,
    id,
    token,
  }) {
    return http.put(
      urlUpdateProfile + id.toString(),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        "fullname": fullname,
        "image": image,
      }),
    );
  }
}
