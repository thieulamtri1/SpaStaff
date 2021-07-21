import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:spa_and_beauty_staff/Model/AvailableTime.dart';
import 'package:spa_and_beauty_staff/Model/BookingDetail.dart';
import 'package:spa_and_beauty_staff/Model/BookingDetailSteps.dart';
import 'package:spa_and_beauty_staff/Model/ConsultantSchedule.dart';
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
  static final String EDIT_CONSULTATION_CONTENT = "https://swp490spa.herokuapp.com/api/consultant/consultationcontent/edit";

  static const String urlGetProfileConsultant =
      "https://swp490spa.herokuapp.com/api/consultant/findById/";
  static const String urlUpdateProfileConsultant =
      "https://swp490spa.herokuapp.com/api/consultant/editprofile";
  static const String urlEditPasswordConsultant =
      "https://swp490spa.herokuapp.com/api/consultant/editpassword";
  static final String urlConsultantSchedule =
      "https://swp490spa.herokuapp.com/api/consultant/workingofconsultant/findbydatechosen/";
  static final String dateChosen =
      "?dateChosen=";
  static final String urlDateOff =
      "https://swp490spa.herokuapp.com/api/staff/dateoff/create/";


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
              "timeBooking": timeBooking,
              "dateBooking": dateBooking,
            }));
    if (res.statusCode == 200){
      jsonResponse = utf8.decode(res.bodyBytes);
      print(jsonResponse.toString());
    }
    print("LOI ROI" + "Status code = " + res.statusCode.toString());
    return res.statusCode.toString();
  }

  static Future<String> editConsultationContent(int id, String description, String expectation, String note) async {
    var jsonResponse;
    final res = await http.put(EDIT_CONSULTATION_CONTENT,
        headers: {
          "accept" : "application/json",
          "content-type" : "application/json",
          "authorization" : "Bearer " + MyApp.storage.getItem("token"),
        },
        body: jsonEncode(
            {
              "id": id,
              "description": description,
              "expectation": expectation,
              "note": note,
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
      print("link: "+GET_AVAILABLE_TIME_FOR_NEXT_STEP + "bookingDetailStepId=$bookingDetailStepId&customerId=$customerId&dateBooking=$dateBooking&spaId=$spaId&spaServiceId=$spaServiceId");
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

  Future<http.Response> sendDateOffConsultant(token, dateOff, reasonDateOff) {
    return http.post(
      Uri.parse(urlDateOff + MyApp.storage.getItem('consultantId').toString()),
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

  Future<http.Response> editPasswordConsultant(token, password) {
    return http.put(
      Uri.parse(urlEditPasswordConsultant),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "id": MyApp.storage.getItem("consultantId"),
        "password": password,
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
}
