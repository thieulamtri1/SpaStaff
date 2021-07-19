import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:spa_and_beauty_staff/Model/AvailableTime.dart';
import 'package:spa_and_beauty_staff/Model/BookingDetail.dart';
import 'package:spa_and_beauty_staff/Model/BookingDetailSteps.dart';
import 'package:spa_and_beauty_staff/Model/CustomerOfConsultant.dart';
import 'package:spa_and_beauty_staff/Model/Staff.dart';
import 'package:spa_and_beauty_staff/Model/Treatment.dart';
import 'package:spa_and_beauty_staff/main.dart';

class ConsultantService {
  static final String urlListCustomerOfConsultant =
      "https://swp490spa.herokuapp.com/api/consultant/getListCustomerOfConsultant/";
  static final String urlfindByCustomerAndConsultant =
      "https://swp490spa.herokuapp.com/api/consultant/bookingDetail/findByCustomerAndConsultant/";
  static final String GET_BOOKING_DETAIL_STEP_BY_BOOKING_DETAIL_ID = "https://swp490spa.herokuapp.com/api/consultant/bookingDetailStep/findByBookingDetail/";
  static final String GET_TREATMENTS_BY_PACKAGE_ID = "https://swp490spa.herokuapp.com/api/consultant/spatreatment/findbyspapackage?spaPackageId=";
  static final String GET_AVAILABLE_TIME_FOR_FIRST_STEP = "https://swp490spa.herokuapp.com/api/consultant/getListTimeBookingForAddTreatment?";
  static final String GET_AVAILABLE_TIME_FOR_NEXT_STEP = "https://swp490spa.herokuapp.com/api/consultant/getListTimeBookingForAStep?";
  static final String ADD_TREATMENT_FOR_BOOKING_DETAIL = "https://swp490spa.herokuapp.com/api/consultant/bookingdetailstep/addtreatment";
  static final String BOOKING_FOR_NEXT_STEP = "https://swp490spa.herokuapp.com/api/consultant/bookingDetailStep/addTimeNextStep";
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
        return bookingDetailByConsultantFromJson(utf8.decode(response.bodyBytes));
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
        return BookingDetailSteps();
      }
    } catch (e) {
      return BookingDetailSteps();
    }
  }

  static Future<Treatment> getTreatmentByPackageId(int packageId) async {
    try {
      final response = await http.get(
          Uri.parse(GET_TREATMENTS_BY_PACKAGE_ID + packageId.toString()),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${MyApp.storage.getItem("token")}',
          });
      print(response.body);
      if (response.statusCode == 200) {
        Treatment treatment = treatmentFromJson(utf8.decode(response.bodyBytes));
        return treatment;
      } else {
        throw Exception('Failed to load treatment');
      }
    } catch (e) {
      throw Exception('Failed to load treatment');
    }
  }

  static Future<AvailableTime> getAvailableTimeForFirstStep(int consultantId,int customerId, String dateBooking, int spaId,int spaTreatmentId) async {
    try {
      final response = await http.get(
          Uri.parse(GET_AVAILABLE_TIME_FOR_FIRST_STEP + "consultantId=$consultantId&customerId=$customerId&dateBooking=$dateBooking&spaId=$spaId&spaTreatmentId=$spaTreatmentId"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${MyApp.storage.getItem("token")}',
          });
      print(response.body);
      if (response.statusCode == 200) {
        AvailableTime availableTime = availableTimeFromJson(utf8.decode(response.bodyBytes));
        return availableTime;
      } else {
        return AvailableTime();
      }
    } catch (e) {
      return AvailableTime();
    }
  }
  static Future<String> bookingForFirstStep(int bookingDetailId, int consultantId, String dateBooking, int spaTreatmentId, String timeBooking) async {
    var jsonResponse;
    final res = await http.put(ADD_TREATMENT_FOR_BOOKING_DETAIL,
        headers: {
          "accept" : "application/json",
          "content-type" : "application/json",
          "authorization" : "Bearer " + MyApp.storage.getItem("token"),
        },
        body: jsonEncode(
            {
              "bookingDetailId": bookingDetailId,
              "consultantId": consultantId,
              "dateBooking": dateBooking,
              "spaTreatmentId": spaTreatmentId,
              "timeBooking": timeBooking
            }));
    if (res.statusCode == 200){
      jsonResponse = utf8.decode(res.bodyBytes);
      print(jsonResponse.toString());
    }
    print("LOI ROI" + "Status code = " + res.statusCode.toString());
    return res.statusCode.toString();
  }
  static Future<String> bookingForNextStep(int bookingDetailStepId, String dateBooking, String timeBooking) async {
    var jsonResponse;
    final res = await http.put(BOOKING_FOR_NEXT_STEP,
        headers: {
          "accept" : "application/json",
          "content-type" : "application/json",
          "authorization" : "Bearer " + MyApp.storage.getItem("token"),
        },
        body: jsonEncode(
            {
              "bookingDetailStepId": bookingDetailStepId,
              "dateBooking": dateBooking,
              "timeBooking": timeBooking,
            }));
    if (res.statusCode == 200){
      jsonResponse = utf8.decode(res.bodyBytes);
      print(jsonResponse.toString());
    }
    print("LOI ROI" + "Status code = " + res.statusCode.toString());
    return res.statusCode.toString();
  }

  static Future<AvailableTime> getAvailableTimeForNextStep(int bookingDetailStepId, int customerId, String dateBooking, spaId, spaServiceId) async {
    try {
      final response = await http.get(
          Uri.parse(GET_AVAILABLE_TIME_FOR_NEXT_STEP + "bookingDetailStepId=$bookingDetailStepId&customerId=$customerId&dateBooking=$dateBooking&spaId=$spaId&spaServiceId=$spaServiceId"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${MyApp.storage.getItem("token")}',
          });
      print(response.body);
      if (response.statusCode == 200) {
        AvailableTime availableTime = availableTimeFromJson(utf8.decode(response.bodyBytes));
        return availableTime;
      } else {
        return AvailableTime();
      }
    } catch (e) {
      return AvailableTime();
    }
  }
}
