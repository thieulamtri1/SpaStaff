import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:spa_and_beauty_staff/Model/BookingDetail.dart';
import 'package:spa_and_beauty_staff/Model/BookingDetailSteps.dart';
import 'package:spa_and_beauty_staff/Model/CustomerOfConsultant.dart';
import 'package:spa_and_beauty_staff/Model/Staff.dart';
import 'package:spa_and_beauty_staff/main.dart';

class ConsultantService {
  static final String urlListCustomerOfConsultant =
      "https://swp490spa.herokuapp.com/api/consultant/getListCustomerOfConsultant/";
  static final String urlfindByCustomerAndConsultant =
      "https://swp490spa.herokuapp.com/api/consultant/bookingDetail/findByCustomerAndConsultant/";
  static final String GET_BOOKING_DETAIL_STEP_BY_BOOKING_DETAIL_ID = "https://swp490spa.herokuapp.com/api/consultant/bookingDetailStep/findByBookingDetail/";


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

  static Future<BookingDetailByConsultant> findBookingDetailByCustomerAndConsultant(
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
        throw Exception('Failed to load booking detail steps');
      }
    } catch (e) {
      throw Exception('Failed to load booking detail steps');
    }
  }
}
