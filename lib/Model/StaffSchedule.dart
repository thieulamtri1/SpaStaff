// To parse this JSON data, do
//
//     final staffSchedule = staffScheduleFromJson(jsonString);

import 'dart:convert';

List<StaffSchedule> staffScheduleFromJson(String str) => List<StaffSchedule>.from(json.decode(str).map((x) => StaffSchedule.fromJson(x)));

String staffScheduleToJson(List<StaffSchedule> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StaffSchedule {
  StaffSchedule({
    this.day,
    this.listStaffScheduleForSlots,
  });

  DateTime day;
  List<ListStaffScheduleForSlot> listStaffScheduleForSlots;

  factory StaffSchedule.fromJson(Map<String, dynamic> json) => StaffSchedule(
    day: DateTime.parse(json["day"]),
    listStaffScheduleForSlots: List<ListStaffScheduleForSlot>.from(json["listStaffScheduleForSlots"].map((x) => ListStaffScheduleForSlot.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "day": "${day.year.toString().padLeft(4, '0')}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}",
    "listStaffScheduleForSlots": List<dynamic>.from(listStaffScheduleForSlots.map((x) => x.toJson())),
  };
}

class ListStaffScheduleForSlot {
  ListStaffScheduleForSlot({
    this.slotTime,
    this.slot,
    this.bookingId,
    this.service,
    this.process,
    this.processStep,
    this.customerInfo,
    this.customerPhone,
  });

  String slotTime;
  Slot slot;
  int bookingId;
  Service service;
  Process process;
  dynamic processStep;
  CustomerInfo customerInfo;
  String customerPhone;

  factory ListStaffScheduleForSlot.fromJson(Map<String, dynamic> json) => ListStaffScheduleForSlot(
    slotTime: json["slotTime"],
    slot: Slot.fromJson(json["slot"]),
    bookingId: json["bookingId"] == null ? null : json["bookingId"],
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
    process: json["process"] == null ? null : Process.fromJson(json["process"]),
    processStep: json["processStep"],
    customerInfo: json["customerInfo"] == null ? null : CustomerInfo.fromJson(json["customerInfo"]),
    customerPhone: json["customerPhone"] == null ? null : json["customerPhone"],
  );

  Map<String, dynamic> toJson() => {
    "slotTime": slotTime,
    "slot": slot.toJson(),
    "bookingId": bookingId == null ? null : bookingId,
    "service": service == null ? null : service.toJson(),
    "process": process == null ? null : process.toJson(),
    "processStep": processStep,
    "customerInfo": customerInfo == null ? null : customerInfo.toJson(),
    "customerPhone": customerPhone == null ? null : customerPhone,
  };
}

class CustomerInfo {
  CustomerInfo({
    this.id,
    this.fullname,
    this.gender,
    this.dateOfBirth,
    this.street,
    this.district,
    this.province,
    this.lastLocation,
    this.image,
  });

  int id;
  String fullname;
  Gender gender;
  DateTime dateOfBirth;
  String street;
  String district;
  String province;
  String lastLocation;
  String image;

  factory CustomerInfo.fromJson(Map<String, dynamic> json) => CustomerInfo(
    id: json["id"],
    fullname: json["fullname"],
    gender: Gender.fromJson(json["gender"]),
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    street: json["street"],
    district: json["district"],
    province: json["province"],
    lastLocation: json["lastLocation"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "gender": gender.toJson(),
    "dateOfBirth": dateOfBirth.toIso8601String(),
    "street": street,
    "district": district,
    "province": province,
    "lastLocation": lastLocation,
    "image": image,
  };
}

class Gender {
  Gender({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Process {
  Process({
    this.id,
    this.description,
  });

  int id;
  String description;

  factory Process.fromJson(Map<String, dynamic> json) => Process(
    id: json["id"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
  };
}

class Service {
  Service({
    this.id,
    this.name,
    this.description,
    this.image,
    this.company,
    this.type,
    this.removed,
    this.customized,
  });

  int id;
  String name;
  String description;
  String image;
  Company company;
  Gender type;
  bool removed;
  bool customized;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    company: Company.fromJson(json["company"]),
    type: Gender.fromJson(json["type"]),
    removed: json["removed"],
    customized: json["customized"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "company": company.toJson(),
    "type": type.toJson(),
    "removed": removed,
    "customized": customized,
  };
}

class Company {
  Company({
    this.id,
    this.name,
    this.image,
    this.email,
    this.location,
    this.street,
    this.district,
    this.province,
    this.createAt,
    this.workStart,
    this.workEnd,
    this.breakStart,
    this.breakEnd,
  });

  int id;
  String name;
  String image;
  String email;
  String location;
  String street;
  String district;
  String province;
  DateTime createAt;
  String workStart;
  String workEnd;
  String breakStart;
  String breakEnd;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    email: json["email"],
    location: json["location"],
    street: json["street"],
    district: json["district"],
    province: json["province"],
    createAt: DateTime.parse(json["createAt"]),
    workStart: json["workStart"],
    workEnd: json["workEnd"],
    breakStart: json["breakStart"],
    breakEnd: json["breakEnd"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "email": email,
    "location": location,
    "street": street,
    "district": district,
    "province": province,
    "createAt": createAt.toIso8601String(),
    "workStart": workStart,
    "workEnd": workEnd,
    "breakStart": breakStart,
    "breakEnd": breakEnd,
  };
}

class Slot {
  Slot({
    this.id,
    this.time,
  });

  int id;
  String time;

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
    id: json["id"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "time": time,
  };
}
