// To parse this JSON data, do
//
//     final staff = staffFromJson(jsonString);

import 'dart:convert';

Staff staffFromJson(String str) => Staff.fromJson(json.decode(str));

String staffToJson(Staff data) => json.encode(data.toJson());

class Staff {
  Staff({
    this.staffId,
    this.district,
    this.fullname,
    this.image,
    this.province,
    this.street,
    this.gender,
    this.type,
    this.phoneNumber,
  });

  int staffId;
  String district;
  String fullname;
  String image;
  String province;
  String street;
  Gender gender;
  Gender type;
  String phoneNumber;

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
    staffId: json["staffId"],
    district: json["district"],
    fullname: json["fullname"],
    image: json["image"],
    province: json["province"],
    street: json["street"],
    gender: Gender.fromJson(json["gender"]),
    type: Gender.fromJson(json["type"]),
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "staffId": staffId,
    "district": district,
    "fullname": fullname,
    "image": image,
    "province": province,
    "street": street,
    "gender": gender.toJson(),
    "type": type.toJson(),
    "phoneNumber": phoneNumber,
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
