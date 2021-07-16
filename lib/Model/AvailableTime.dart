// To parse this JSON data, do
//
//     final availableTime = availableTimeFromJson(jsonString);

import 'dart:convert';

AvailableTime availableTimeFromJson(String str) => AvailableTime.fromJson(json.decode(str));

String availableTimeToJson(AvailableTime data) => json.encode(data.toJson());

class AvailableTime {
  AvailableTime({
    this.code,
    this.status,
    this.data,
    this.paging,
  });

  int code;
  String status;
  List<String> data;
  Paging paging;

  factory AvailableTime.fromJson(Map<String, dynamic> json) => AvailableTime(
    code: json["code"] == null ? null : json["code"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<String>.from(json["data"].map((x) => x)),
    paging: json["paging"] == null ? null : Paging.fromJson(json["paging"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x)),
    "paging": paging == null ? null : paging.toJson(),
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
