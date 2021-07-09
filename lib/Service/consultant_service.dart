import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:spa_and_beauty_staff/Model/BookingDetail.dart';
import 'package:spa_and_beauty_staff/Model/CustomerOfConsultant.dart';
import 'package:spa_and_beauty_staff/Model/Staff.dart';

class ConsultantService {
  static const String urlListCustomerOfConsultant =
      "https://swp490spa.herokuapp.com/api/consultant/getListCustomerOfConsultant/";
  static const String urlfindByCustomerAndConsultant =
      "https://swp490spa.herokuapp.com/api/consultant/bookingDetail/findByCustomerAndConsultant/";

  static Future<CustomerOfConsultant> getListCustomerOfConsultant(id, token) async {
    try {
      final response = await http.get(
          Uri.parse(urlListCustomerOfConsultant + id.toString()),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      print(response.body);
      if (response.statusCode == 200) {
        return customerOfConsultantFromJson(utf8.decode(response.bodyBytes));
      } else {
        throw Exception('Failed to load CustomerOfConsultant');
      }
    } catch (e) {
      throw Exception('Failed to load CustomerOfConsultant');
    }
  }

  static Future<BookingDetailByCustomerAndConsultant> findByCustomerAndConsultant(
      idCustomer, idConsultant, token) async {
    try {
      final response = await http.get(
          Uri.parse(urlfindByCustomerAndConsultant + idCustomer.toString() + "/" + idConsultant.toString()),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      print(response.body);
      if (response.statusCode == 200) {
        return bookingDetailByCustomerAndConsultantFromJson(utf8.decode(response.bodyBytes));
      } else {
        throw Exception('Failed to load findByCustomerAndConsultant');
      }
    } catch (e) {
      throw Exception('Failed to load findByCustomerAndConsultant');
    }
  }
}
