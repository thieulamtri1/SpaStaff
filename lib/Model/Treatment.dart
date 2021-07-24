// To parse this JSON data, do
//
//     final treatment = treatmentFromJson(jsonString);

import 'dart:convert';

Treatment treatmentFromJson(String str) => Treatment.fromJson(json.decode(str));

String treatmentToJson(Treatment data) => json.encode(data.toJson());

class Treatment {
  Treatment({
    this.code,
    this.status,
    this.data,
    this.paging,
  });

  int code;
  String status;
  List<TreatmentInstance> data;
  Paging paging;

  factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
    code: json["code"] == null ? null : json["code"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<TreatmentInstance>.from(json["data"].map((x) => TreatmentInstance.fromJson(x))),
    paging: json["paging"] == null ? null : Paging.fromJson(json["paging"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "paging": paging == null ? null : paging.toJson(),
  };
}

class TreatmentInstance {
  TreatmentInstance({
    this.id,
    this.name,
    this.description,
    this.totalPrice,
    this.totalTime,
    this.createTime,
    this.createBy,
    this.spaPackage,
    this.spa,
    this.treatmentservices,
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
  List<Treatmentservice> treatmentservices;

  factory TreatmentInstance.fromJson(Map<String, dynamic> json) => TreatmentInstance(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    totalPrice: json["total_price"] == null ? null : json["total_price"],
    totalTime: json["total_time"] == null ? null : json["total_time"],
    createTime: json["create_time"] == null ? null : DateTime.parse(json["create_time"]),
    createBy: json["create_by"] == null ? null : json["create_by"],
    spaPackage: json["spa_package"] == null ? null : SpaPackage.fromJson(json["spa_package"]),
    spa: json["spa"] == null ? null : Spa.fromJson(json["spa"]),
    treatmentservices: json["treatmentservices"] == null ? null : List<Treatmentservice>.from(json["treatmentservices"].map((x) => Treatmentservice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "total_price": totalPrice == null ? null : totalPrice,
    "total_time": totalTime == null ? null : totalTime,
    "create_time": createTime == null ? null : "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "create_by": createBy == null ? null : createBy,
    "spa_package": spaPackage == null ? null : spaPackage.toJson(),
    "spa": spa == null ? null : spa.toJson(),
    "treatmentservices": treatmentservices == null ? null : List<dynamic>.from(treatmentservices.map((x) => x.toJson())),
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
    this.longitude,
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
  String longitude;
  String createBy;
  DateTime createTime;
  String status;

  factory Spa.fromJson(Map<String, dynamic> json) => Spa(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"],
    street: json["street"] == null ? null : json["street"],
    district: json["district"] == null ? null : json["district"],
    city: json["city"] == null ? null : json["city"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    createBy: json["createBy"] == null ? null : json["createBy"],
    createTime: json["createTime"] == null ? null : DateTime.parse(json["createTime"]),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "image": image,
    "street": street == null ? null : street,
    "district": district == null ? null : district,
    "city": city == null ? null : city,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "createBy": createBy == null ? null : createBy,
    "createTime": createTime == null ? null : "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "status": status == null ? null : status,
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
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    image: json["image"] == null ? null : json["image"],
    type: json["type"] == null ? null : json["type"],
    status: json["status"] == null ? null : json["status"],
    createTime: json["createTime"] == null ? null : DateTime.parse(json["createTime"]),
    createBy: json["create_by"] == null ? null : json["create_by"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    spa: json["spa"] == null ? null : Spa.fromJson(json["spa"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "image": image == null ? null : image,
    "type": type == null ? null : type,
    "status": status == null ? null : status,
    "createTime": createTime == null ? null : "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "create_by": createBy == null ? null : createBy,
    "category": category == null ? null : category.toJson(),
    "spa": spa == null ? null : spa.toJson(),
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
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    icon: json["icon"] == null ? null : json["icon"],
    description: json["description"] == null ? null : json["description"],
    createTime: json["createTime"] == null ? null : DateTime.parse(json["createTime"]),
    createBy: json["createBy"] == null ? null : json["createBy"],
    status: json["status"] == null ? null : json["status"],
    spa: json["spa"] == null ? null : Spa.fromJson(json["spa"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "icon": icon == null ? null : icon,
    "description": description == null ? null : description,
    "createTime": createTime == null ? null : "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "createBy": createBy == null ? null : createBy,
    "status": status == null ? null : status,
    "spa": spa == null ? null : spa.toJson(),
  };
}

class Treatmentservice {
  Treatmentservice({
    this.id,
    this.ordinal,
    this.spaService,
  });

  int id;
  int ordinal;
  SpaService spaService;

  factory Treatmentservice.fromJson(Map<String, dynamic> json) => Treatmentservice(
    id: json["id"] == null ? null : json["id"],
    ordinal: json["ordinal"] == null ? null : json["ordinal"],
    spaService: json["spaService"] == null ? null : SpaService.fromJson(json["spaService"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "ordinal": ordinal == null ? null : ordinal,
    "spaService": spaService == null ? null : spaService.toJson(),
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
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    description: json["description"] == null ? null : json["description"],
    price: json["price"] == null ? null : json["price"],
    status: json["status"] == null ? null : json["status"],
    type: json["type"] == null ? null : json["type"],
    durationMin: json["durationMin"] == null ? null : json["durationMin"],
    createTime: json["createTime"] == null ? null : DateTime.parse(json["createTime"]),
    createBy: json["createBy"] == null ? null : json["createBy"],
    spa: json["spa"] == null ? null : Spa.fromJson(json["spa"]),
    spaPackages: json["spaPackages"] == null ? null : List<SpaPackage>.from(json["spaPackages"].map((x) => SpaPackage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
    "description": description == null ? null : description,
    "price": price == null ? null : price,
    "status": status == null ? null : status,
    "type": type == null ? null : type,
    "durationMin": durationMin == null ? null : durationMin,
    "createTime": createTime == null ? null : "${createTime.year.toString().padLeft(4, '0')}-${createTime.month.toString().padLeft(2, '0')}-${createTime.day.toString().padLeft(2, '0')}",
    "createBy": createBy == null ? null : createBy,
    "spa": spa == null ? null : spa.toJson(),
    "spaPackages": spaPackages == null ? null : List<dynamic>.from(spaPackages.map((x) => x.toJson())),
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
