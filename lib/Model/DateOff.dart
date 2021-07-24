// To parse this JSON data, do
//
//     final dateOff = dateOffFromJson(jsonString);

import 'dart:convert';

List<DateOff> dateOffFromJson(String str) => List<DateOff>.from(json.decode(str).map((x) => DateOff.fromJson(x)));

String dateOffToJson(List<DateOff> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DateOff {
  DateOff({
    this.dateOff,
    this.employee,
    this.reasonDateOff,
    this.spa,
    this.statusDateOff,
  });

  DateTime dateOff;
  Employee employee;
  String reasonDateOff;
  Spa spa;
  String statusDateOff;

  factory DateOff.fromJson(Map<String, dynamic> json) => DateOff(
    dateOff: DateTime.parse(json["dateOff"]),
    employee: Employee.fromJson(json["employee"]),
    reasonDateOff: json["reasonDateOff"],
    spa: Spa.fromJson(json["spa"]),
    statusDateOff: json["statusDateOff"],
  );

  Map<String, dynamic> toJson() => {
    "dateOff": "${dateOff.year.toString().padLeft(4, '0')}-${dateOff.month.toString().padLeft(2, '0')}-${dateOff.day.toString().padLeft(2, '0')}",
    "employee": employee.toJson(),
    "reasonDateOff": reasonDateOff,
    "spa": spa.toJson(),
    "statusDateOff": statusDateOff,
  };
}

class Employee {
  Employee({
    this.active,
    this.address,
    this.birthdate,
    this.email,
    this.fullname,
    this.gender,
    this.id,
    this.image,
    this.password,
    this.phone,
  });

  bool active;
  String address;
  String birthdate;
  String email;
  String fullname;
  String gender;
  int id;
  String image;
  String password;
  String phone;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    active: json["active"],
    address: json["address"],
    birthdate: json["birthdate"],
    email: json["email"],
    fullname: json["fullname"],
    gender: json["gender"],
    id: json["id"],
    image: json["image"],
    password: json["password"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "active": active,
    "address": address,
    "birthdate": birthdate,
    "email": email,
    "fullname": fullname,
    "gender": gender,
    "id": id,
    "image": image,
    "password": password,
    "phone": phone,
  };
}

class Spa {
  Spa({
    this.city,
    this.createBy,
    this.createTime,
    this.district,
    this.id,
    this.image,
    this.latitude,
    this.longitude,
    this.name,
    this.status,
    this.street,
  });

  String city;
  String createBy;
  DateTime createTime;
  String district;
  int id;
  String image;
  String latitude;
  String longitude;
  String name;
  String status;
  String street;

  factory Spa.fromJson(Map<String, dynamic> json) => Spa(
    city: json["city"],
    createBy: json["createBy"],
    createTime: DateTime.parse(json["createTime"]),
    district: json["district"],
    id: json["id"],
    image: json["image"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    name: json["name"],
    status: json["status"],
    street: json["street"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "createBy": createBy,
    "createTime": "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "district": district,
    "id": id,
    "image": image,
    "latitude": latitude,
    "longitude": longitude,
    "name": name,
    "status": status,
    "street": street,
  };
}
