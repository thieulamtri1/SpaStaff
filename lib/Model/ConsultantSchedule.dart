// To parse this JSON data, do
//
//     final scheduleConsultant = scheduleConsultantFromJson(jsonString);

import 'dart:convert';

ScheduleConsultant scheduleConsultantFromJson(String str) => ScheduleConsultant.fromJson(json.decode(str));

String scheduleConsultantToJson(ScheduleConsultant data) => json.encode(data.toJson());

class ScheduleConsultant {
  ScheduleConsultant({
    this.code,
    this.status,
    this.data,
    this.paging,
  });

  int code;
  String status;
  List<Datum> data;
  Paging paging;

  factory ScheduleConsultant.fromJson(Map<String, dynamic> json) => ScheduleConsultant(
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
    this.bookingDetail,
    this.id,
    this.dateBooking,
    this.startTime,
    this.endTime,
    this.bookingPrice,
    this.statusBooking,
    this.reason,
    this.isConsultation,
    this.treatmentService,
    this.staff,
    this.consultant,
  });

  BookingDetail bookingDetail;
  int id;
  DateTime dateBooking;
  String startTime;
  String endTime;
  dynamic bookingPrice;
  String statusBooking;
  dynamic reason;
  String isConsultation;
  dynamic treatmentService;
  dynamic staff;
  Consultant consultant;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    bookingDetail: BookingDetail.fromJson(json["bookingDetail"]),
    id: json["id"],
    dateBooking: DateTime.parse(json["date_booking"]),
    startTime: json["start_time"],
    endTime: json["end_time"],
    bookingPrice: json["booking_price"],
    statusBooking: json["status_booking"],
    reason: json["reason"],
    isConsultation: json["is_consultation"],
    treatmentService: json["treatment_service"],
    staff: json["staff"],
    consultant: Consultant.fromJson(json["consultant"]),
  );

  Map<String, dynamic> toJson() => {
    "bookingDetail": bookingDetail.toJson(),
    "id": id,
    "date_booking": "${dateBooking.year.toString().padLeft(4, '0')}-${dateBooking.month.toString().padLeft(2, '0')}-${dateBooking.day.toString().padLeft(2, '0')}",
    "start_time": startTime,
    "end_time": endTime,
    "booking_price": bookingPrice,
    "status_booking": statusBooking,
    "reason": reason,
    "is_consultation": isConsultation,
    "treatment_service": treatmentService,
    "staff": staff,
    "consultant": consultant.toJson(),
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
  });

  int id;
  String name;
  String icon;
  String description;
  DateTime createTime;
  int createBy;
  String status;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
    description: json["description"],
    createTime: DateTime.parse(json["createTime"]),
    createBy: json["createBy"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
    "description": description,
    "createTime": "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "createBy": createBy,
    "status": status,
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
  });

  int id;
  String name;
  String description;
  double totalPrice;
  int totalTime;
  DateTime createTime;
  int createBy;
  SpaPackage spaPackage;

  factory SpaTreatment.fromJson(Map<String, dynamic> json) => SpaTreatment(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    totalPrice: json["totalPrice"],
    totalTime: json["totalTime"],
    createTime: DateTime.parse(json["createTime"]),
    createBy: json["createBy"],
    spaPackage: SpaPackage.fromJson(json["spaPackage"]),
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
