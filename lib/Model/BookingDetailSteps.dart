// To parse this JSON data, do
//
//     final bookingDetailSteps = bookingDetailStepsFromJson(jsonString);

import 'dart:convert';

BookingDetailSteps bookingDetailStepsFromJson(String str) => BookingDetailSteps.fromJson(json.decode(str));

String bookingDetailStepsToJson(BookingDetailSteps data) => json.encode(data.toJson());

class BookingDetailSteps {
  BookingDetailSteps({
    this.code,
    this.status,
    this.data,
    this.paging,
  });

  int code;
  String status;
  List<Datum> data;
  Paging paging;

  factory BookingDetailSteps.fromJson(Map<String, dynamic> json) => BookingDetailSteps(
    code: json["code"],
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    paging: Paging.fromJson(json["paging"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "paging": paging.toJson(),
  };
}

class Datum {
  Datum({
    this.id,
    this.dateBooking,
    this.startTime,
    this.endTime,
    this.bookingPrice,
    this.statusBooking,
    this.reasonCancel,
    this.isConsultation,
    this.treatmentService,
    this.staff,
    this.consultant,
    this.bookingDetail,
  });

  int id;
  DateTime dateBooking;
  String startTime;
  String endTime;
  double bookingPrice;
  String statusBooking;
  dynamic reasonCancel;
  String isConsultation;
  TreatmentService treatmentService;
  dynamic staff;
  Consultant consultant;
  BookingDetail bookingDetail;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    dateBooking: json["dateBooking"] == null ? null : DateTime.parse(json["dateBooking"]),
    startTime: json["startTime"] == null ? null : json["startTime"],
    endTime: json["endTime"] == null ? null : json["endTime"],
    bookingPrice: json["bookingPrice"] == null ? null : json["bookingPrice"],
    statusBooking: json["statusBooking"],
    reasonCancel: json["reasonCancel"],
    isConsultation: json["isConsultation"],
    treatmentService: json["treatmentService"] == null ? null : TreatmentService.fromJson(json["treatmentService"]),
    staff: json["staff"],
    consultant: Consultant.fromJson(json["consultant"]),
    bookingDetail: BookingDetail.fromJson(json["bookingDetail"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dateBooking": dateBooking == null ? null : "${dateBooking.year.toString().padLeft(4, '0')}-${dateBooking.month.toString().padLeft(2, '0')}-${dateBooking.day.toString().padLeft(2, '0')}",
    "startTime": startTime == null ? null : startTime,
    "endTime": endTime == null ? null : endTime,
    "bookingPrice": bookingPrice == null ? null : bookingPrice,
    "statusBooking": statusBooking,
    "reasonCancel": reasonCancel,
    "isConsultation": isConsultation,
    "treatmentService": treatmentService == null ? null : treatmentService.toJson(),
    "staff": staff,
    "consultant": consultant.toJson(),
    "bookingDetail": bookingDetail.toJson(),
  };
}

class BookingDetail {
  BookingDetail({
    this.id,
    this.totalTime,
    this.type,
    this.totalPrice,
    this.statusBooking,
    this.booking,
    this.spaTreatment,
    this.spaPackage,
  });

  int id;
  int totalTime;
  String type;
  double totalPrice;
  String statusBooking;
  Booking booking;
  SpaTreatment spaTreatment;
  SpaPackage spaPackage;

  factory BookingDetail.fromJson(Map<String, dynamic> json) => BookingDetail(
    id: json["id"],
    totalTime: json["totalTime"],
    type: json["type"],
    totalPrice: json["totalPrice"],
    statusBooking: json["statusBooking"],
    booking: Booking.fromJson(json["booking"]),
    spaTreatment: SpaTreatment.fromJson(json["spaTreatment"]),
    spaPackage: SpaPackage.fromJson(json["spaPackage"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "totalTime": totalTime,
    "type": type,
    "totalPrice": totalPrice,
    "statusBooking": statusBooking,
    "booking": booking.toJson(),
    "spaTreatment": spaTreatment.toJson(),
    "spaPackage": spaPackage.toJson(),
  };
}

class Booking {
  Booking({
    this.id,
    this.totalPrice,
    this.totalTime,
    this.statusBooking,
    this.createTime,
    this.customer,
    this.spa,
  });

  int id;
  double totalPrice;
  int totalTime;
  String statusBooking;
  DateTime createTime;
  Consultant customer;
  Spa spa;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"],
    totalPrice: json["totalPrice"],
    totalTime: json["totalTime"],
    statusBooking: json["statusBooking"],
    createTime: DateTime.parse(json["createTime"]),
    customer: Consultant.fromJson(json["customer"]),
    spa: Spa.fromJson(json["spa"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "totalPrice": totalPrice,
    "totalTime": totalTime,
    "statusBooking": statusBooking,
    "createTime": "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "customer": customer.toJson(),
    "spa": spa.toJson(),
  };
}

class Consultant {
  Consultant({
    this.id,
    this.customType,
    this.user,
    this.tokenFcm,
    this.spa,
  });

  int id;
  String customType;
  User user;
  String tokenFcm;
  Spa spa;

  factory Consultant.fromJson(Map<String, dynamic> json) => Consultant(
    id: json["id"],
    customType: json["customType"] == null ? null : json["customType"],
    user: User.fromJson(json["user"]),
    tokenFcm: json["tokenFCM"],
    spa: json["spa"] == null ? null : Spa.fromJson(json["spa"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customType": customType == null ? null : customType,
    "user": user.toJson(),
    "tokenFCM": tokenFcm,
    "spa": spa == null ? null : spa.toJson(),
  };
}

class Spa {
  Spa({
    this.id,
    this.name,
    this.image,
    this.street,
    this.district,
    this.city,
    this.latitude,
    this.longtitude,
    this.createBy,
    this.createTime,
    this.status,
  });

  int id;
  String name;
  dynamic image;
  String street;
  String district;
  String city;
  String latitude;
  String longtitude;
  String createBy;
  DateTime createTime;
  String status;

  factory Spa.fromJson(Map<String, dynamic> json) => Spa(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    street: json["street"],
    district: json["district"],
    city: json["city"],
    latitude: json["latitude"],
    longtitude: json["longtitude"],
    createBy: json["createBy"],
    createTime: DateTime.parse(json["createTime"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "street": street,
    "district": district,
    "city": city,
    "latitude": latitude,
    "longtitude": longtitude,
    "createBy": createBy,
    "createTime": "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "status": status,
  };
}

class User {
  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullname: json["fullname"],
    phone: json["phone"],
    password: json["password"],
    gender: json["gender"],
    birthdate: DateTime.parse(json["birthdate"]),
    email: json["email"],
    image: json["image"],
    address: json["address"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "phone": phone,
    "password": password,
    "gender": gender,
    "birthdate": "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
    "email": email,
    "image": image,
    "address": address,
    "active": active,
  };
}

class SpaPackage {
  SpaPackage({
    this.id,
    this.name,
    this.description,
    this.image,
    this.type,
    this.status,
    this.createTime,
    this.createBy,
    this.category,
    this.spa,
  });

  int id;
  String name;
  String description;
  String image;
  String type;
  String status;
  DateTime createTime;
  int createBy;
  Category category;
  Spa spa;

  factory SpaPackage.fromJson(Map<String, dynamic> json) => SpaPackage(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    type: json["type"],
    status: json["status"],
    createTime: DateTime.parse(json["createTime"]),
    createBy: json["create_by"],
    category: Category.fromJson(json["category"]),
    spa: Spa.fromJson(json["spa"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "type": type,
    "status": status,
    "createTime": "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "create_by": createBy,
    "category": category.toJson(),
    "spa": spa.toJson(),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.icon,
    this.description,
    this.createTime,
    this.createBy,
    this.status,
    this.spa,
  });

  int id;
  String name;
  String icon;
  String description;
  DateTime createTime;
  int createBy;
  String status;
  Spa spa;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
    description: json["description"],
    createTime: DateTime.parse(json["createTime"]),
    createBy: json["createBy"],
    status: json["status"],
    spa: Spa.fromJson(json["spa"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
    "description": description,
    "createTime": "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "createBy": createBy,
    "status": status,
    "spa": spa.toJson(),
  };
}

class SpaTreatment {
  SpaTreatment({
    this.id,
    this.name,
    this.description,
    this.totalPrice,
    this.totalTime,
    this.createTime,
    this.createBy,
    this.spaPackage,
    this.spa,
  });

  int id;
  String name;
  String description;
  double totalPrice;
  int totalTime;
  DateTime createTime;
  int createBy;
  SpaPackage spaPackage;
  Spa spa;

  factory SpaTreatment.fromJson(Map<String, dynamic> json) => SpaTreatment(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    totalPrice: json["totalPrice"],
    totalTime: json["totalTime"],
    createTime: DateTime.parse(json["createTime"]),
    createBy: json["createBy"],
    spaPackage: SpaPackage.fromJson(json["spaPackage"]),
    spa: Spa.fromJson(json["spa"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "totalPrice": totalPrice,
    "totalTime": totalTime,
    "createTime": "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "createBy": createBy,
    "spaPackage": spaPackage.toJson(),
    "spa": spa.toJson(),
  };
}

class TreatmentService {
  TreatmentService({
    this.id,
    this.ordinal,
    this.spaService,
  });

  int id;
  int ordinal;
  SpaService spaService;

  factory TreatmentService.fromJson(Map<String, dynamic> json) => TreatmentService(
    id: json["id"],
    ordinal: json["ordinal"],
    spaService: SpaService.fromJson(json["spaService"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ordinal": ordinal,
    "spaService": spaService.toJson(),
  };
}

class SpaService {
  SpaService({
    this.id,
    this.name,
    this.image,
    this.description,
    this.price,
    this.status,
    this.type,
    this.durationMin,
    this.createTime,
    this.createBy,
    this.spa,
    this.spaPackages,
  });

  int id;
  String name;
  String image;
  String description;
  double price;
  String status;
  String type;
  int durationMin;
  DateTime createTime;
  String createBy;
  Spa spa;
  List<SpaPackage> spaPackages;

  factory SpaService.fromJson(Map<String, dynamic> json) => SpaService(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    description: json["description"],
    price: json["price"],
    status: json["status"],
    type: json["type"],
    durationMin: json["durationMin"],
    createTime: DateTime.parse(json["createTime"]),
    createBy: json["createBy"],
    spa: Spa.fromJson(json["spa"]),
    spaPackages: List<SpaPackage>.from(json["spaPackages"].map((x) => SpaPackage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "description": description,
    "price": price,
    "status": status,
    "type": type,
    "durationMin": durationMin,
    "createTime": "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "createBy": createBy,
    "spa": spa.toJson(),
    "spaPackages": List<dynamic>.from(spaPackages.map((x) => x.toJson())),
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
    page: json["page"],
    totalPage: json["totalPage"],
    itemPerPage: json["itemPerPage"],
    totalItem: json["totalItem"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "totalPage": totalPage,
    "itemPerPage": itemPerPage,
    "totalItem": totalItem,
  };
}
