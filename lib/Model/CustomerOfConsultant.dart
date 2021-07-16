// To parse this JSON data, do
//
//     final customerOfConsultant = customerOfConsultantFromJson(jsonString);

import 'dart:convert';

CustomerOfConsultant customerOfConsultantFromJson(String str) => CustomerOfConsultant.fromJson(json.decode(str));

String customerOfConsultantToJson(CustomerOfConsultant data) => json.encode(data.toJson());

class CustomerOfConsultant {
  CustomerOfConsultant({
    this.code,
    this.status,
    this.data,
    this.paging,
  });

  int code;
  String status;
  List<Datum> data;
  Paging paging;

  factory CustomerOfConsultant.fromJson(Map<String, dynamic> json) => CustomerOfConsultant(
    code: json["code"] == null ? null : json["code"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    paging: json["paging"] == null ? null : Paging.fromJson(json["paging"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "paging": paging == null ? null : paging.toJson(),
  };
}

class Datum {
  Datum({
    this.id,
    this.fullname,
    this.phone,
    this.password,
    this.gender,
    this.birthdate,
    this.email,
    this.image,
    this.address,
    this.active,
  });

  int id;
  String fullname;
  String phone;
  String password;
  String gender;
  DateTime birthdate;
  String email;
  dynamic image;
  String address;
  bool active;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    fullname: json["fullname"] == null ? null : json["fullname"],
    phone: json["phone"] == null ? null : json["phone"],
    password: json["password"] == null ? null : json["password"],
    gender: json["gender"] == null ? null : json["gender"],
    birthdate: json["birthdate"] == null ? null : DateTime.parse(json["birthdate"]),
    email: json["email"] == null ? null : json["email"],
    image: json["image"],
    address: json["address"] == null ? null : json["address"],
    active: json["active"] == null ? null : json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "fullname": fullname == null ? null : fullname,
    "phone": phone == null ? null : phone,
    "password": password == null ? null : password,
    "gender": gender == null ? null : gender,
    "birthdate": birthdate == null ? null : "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
    "email": email == null ? null : email,
    "image": image,
    "address": address == null ? null : address,
    "active": active == null ? null : active,
  };
}

class Paging {
  Paging({
    this.page,
    this.totalPage,
    this.itemPerPage,
    this.totalItem,
  });

  int page;
  int totalPage;
  int itemPerPage;
  int totalItem;

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
    page: json["page"] == null ? null : json["page"],
    totalPage: json["totalPage"] == null ? null : json["totalPage"],
    itemPerPage: json["itemPerPage"] == null ? null : json["itemPerPage"],
    totalItem: json["totalItem"] == null ? null : json["totalItem"],
  );

  Map<String, dynamic> toJson() => {
    "page": page == null ? null : page,
    "totalPage": totalPage == null ? null : totalPage,
    "itemPerPage": itemPerPage == null ? null : itemPerPage,
    "totalItem": totalItem == null ? null : totalItem,
  };
}
