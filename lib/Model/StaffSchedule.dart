// To parse this JSON data, do
//
//     final schedule = scheduleFromJson(jsonString);

import 'dart:convert';

Schedule scheduleFromJson(String str) => Schedule.fromJson(json.decode(str));

String scheduleToJson(Schedule data) => json.encode(data.toJson());

class Schedule {
  Schedule({
    this.code,
    this.status,
    this.data,
    this.paging,
  });

  int code;
  String status;
  List<Datum> data;
  Paging paging;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
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
  int bookingPrice;
  String statusBooking;
  dynamic reasonCancel;
  String isConsultation;
  TreatmentService treatmentService;
  Staff staff;
  dynamic consultant;
  BookingDetail bookingDetail;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    dateBooking: DateTime.parse(json["date_booking"]),
    startTime: json["start_time"],
    endTime: json["end_time"],
    bookingPrice: json["booking_price"],
    statusBooking: json["status_booking"],
    reasonCancel: json["reason_cancel"],
    isConsultation: json["is_consultation"],
    treatmentService: TreatmentService.fromJson(json["treatment_service"]),
    staff: Staff.fromJson(json["staff"]),
    consultant: json["consultant"],
    bookingDetail: BookingDetail.fromJson(json["booking_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date_booking": "${dateBooking.year.toString().padLeft(4, '0')}-${dateBooking.month.toString().padLeft(2, '0')}-${dateBooking.day.toString().padLeft(2, '0')}",
    "start_time": startTime,
    "end_time": endTime,
    "booking_price": bookingPrice,
    "status_booking": statusBooking,
    "reason_cancel": reasonCancel,
    "is_consultation": isConsultation,
    "treatment_service": treatmentService.toJson(),
    "staff": staff.toJson(),
    "consultant": consultant,
    "booking_detail": bookingDetail.toJson(),
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
  Type type;
  int totalPrice;
  String statusBooking;
  Booking booking;
  SpaTreatment spaTreatment;
  SpaPackage spaPackage;

  factory BookingDetail.fromJson(Map<String, dynamic> json) => BookingDetail(
    id: json["id"],
    totalTime: json["totalTime"],
    type: typeValues.map[json["type"]],
    totalPrice: json["totalPrice"],
    statusBooking: json["statusBooking"],
    booking: Booking.fromJson(json["booking"]),
    spaTreatment: SpaTreatment.fromJson(json["spaTreatment"]),
    spaPackage: SpaPackage.fromJson(json["spaPackage"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "totalTime": totalTime,
    "type": typeValues.reverse[type],
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
  int totalPrice;
  int totalTime;
  String statusBooking;
  DateTime createTime;
  Customer customer;
  Spa spa;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"],
    totalPrice: json["totalPrice"],
    totalTime: json["totalTime"],
    statusBooking: json["statusBooking"],
    createTime: DateTime.parse(json["createTime"]),
    customer: Customer.fromJson(json["customer"]),
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

class Customer {
  Customer({
    this.id,
    this.customType,
    this.user,
  });

  int id;
  String customType;
  User user;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    customType: json["customType"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customType": customType,
    "user": user.toJson(),
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
  String image;
  String address;
  bool active;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullname: json["fullname"],
    phone: json["phone"],
    password: json["password"],
    gender: json["gender"] == null ? null : json["gender"],
    birthdate: json["birthdate"] == null ? null : DateTime.parse(json["birthdate"]),
    email: json["email"] == null ? null : json["email"],
    image: json["image"] == null ? null : json["image"],
    address: json["address"] == null ? null : json["address"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "phone": phone,
    "password": password,
    "gender": gender == null ? null : gender,
    "birthdate": birthdate == null ? null : "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
    "email": email == null ? null : email,
    "image": image == null ? null : image,
    "address": address == null ? null : address,
    "active": active,
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
  SpaName name;
  dynamic image;
  Street street;
  String district;
  City city;
  String latitude;
  String longtitude;
  String createBy;
  DateTime createTime;
  Status status;

  factory Spa.fromJson(Map<String, dynamic> json) => Spa(
    id: json["id"],
    name: spaNameValues.map[json["name"]],
    image: json["image"],
    street: streetValues.map[json["street"]],
    district: json["district"],
    city: cityValues.map[json["city"]],
    latitude: json["latitude"],
    longtitude: json["longtitude"],
    createBy: json["createBy"],
    createTime: DateTime.parse(json["createTime"]),
    status: statusValues.map[json["status"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": spaNameValues.reverse[name],
    "image": image,
    "street": streetValues.reverse[street],
    "district": district,
    "city": cityValues.reverse[city],
    "latitude": latitude,
    "longtitude": longtitude,
    "createBy": createBy,
    "createTime": "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "status": statusValues.reverse[status],
  };
}

enum City { H_CH_MINH }

final cityValues = EnumValues({
  "Hồ Chí Minh": City.H_CH_MINH
});

enum SpaName { SPA_A }

final spaNameValues = EnumValues({
  "Spa A": SpaName.SPA_A
});

enum Status { AVAILABLE }

final statusValues = EnumValues({
  "AVAILABLE": Status.AVAILABLE
});

enum Street { THE_64_A_TRNG_NH }

final streetValues = EnumValues({
  "64A Trương Định": Street.THE_64_A_TRNG_NH
});

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
  SpaPackageName name;
  String description;
  String image;
  Type type;
  Status status;
  DateTime createTime;
  int createBy;
  Category category;
  Spa spa;

  factory SpaPackage.fromJson(Map<String, dynamic> json) => SpaPackage(
    id: json["id"],
    name: spaPackageNameValues.map[json["name"]],
    description: json["description"],
    image: json["image"],
    type: typeValues.map[json["type"]],
    status: statusValues.map[json["status"]],
    createTime: DateTime.parse(json["createTime"]),
    createBy: json["create_by"],
    category: Category.fromJson(json["category"]),
    spa: Spa.fromJson(json["spa"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": spaPackageNameValues.reverse[name],
    "description": description,
    "image": image,
    "type": typeValues.reverse[type],
    "status": statusValues.reverse[status],
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
  CategoryName name;
  String icon;
  Description description;
  DateTime createTime;
  int createBy;
  Status status;
  Spa spa;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: categoryNameValues.map[json["name"]],
    icon: json["icon"],
    description: descriptionValues.map[json["description"]],
    createTime: DateTime.parse(json["createTime"]),
    createBy: json["createBy"],
    status: statusValues.map[json["status"]],
    spa: Spa.fromJson(json["spa"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": categoryNameValues.reverse[name],
    "icon": icon,
    "description": descriptionValues.reverse[description],
    "createTime": "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "createBy": createBy,
    "status": statusValues.reverse[status],
    "spa": spa.toJson(),
  };
}

enum Description { SKIN, FACE }

final descriptionValues = EnumValues({
  "Face": Description.FACE,
  "Skin": Description.SKIN
});

enum CategoryName { IU_TR_DA, FACE }

final categoryNameValues = EnumValues({
  "Face": CategoryName.FACE,
  "Điều trị da": CategoryName.IU_TR_DA
});

enum SpaPackageName { TR_MN, PACKAGE_B1, TR_NM, PACKAGE_C1 }

final spaPackageNameValues = EnumValues({
  "Package B1": SpaPackageName.PACKAGE_B1,
  "Package C1": SpaPackageName.PACKAGE_C1,
  "Trị mụn": SpaPackageName.TR_MN,
  "Trị nám": SpaPackageName.TR_NM
});

enum Type { ONESTEP }

final typeValues = EnumValues({
  "ONESTEP": Type.ONESTEP
});

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
  int totalPrice;
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

class Staff {
  Staff({
    this.id,
    this.user,
    this.spa,
  });

  int id;
  User user;
  Spa spa;

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
    id: json["id"],
    user: User.fromJson(json["user"]),
    spa: Spa.fromJson(json["spa"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user.toJson(),
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
  int price;
  Status status;
  Type type;
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
    status: statusValues.map[json["status"]],
    type: typeValues.map[json["type"]],
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
    "status": statusValues.reverse[status],
    "type": typeValues.reverse[type],
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

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
