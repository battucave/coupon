
import 'dart:convert';

SingleVendorModel singleVendorModelFromJson(String str) => SingleVendorModel.fromJson(json.decode(str));

String singleVendorModelToJson(SingleVendorModel data) => json.encode(data.toJson());

class SingleVendorModel {
  SingleVendorModel({
    required this.vid,
    required this.scid,
    required this.vendorName,
    required this.vendorLogPath,
    required this.featureVendor,
    required this.description,
    required this.hours,
    required this.street1,
    required this.street2,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.email,
    required this.phone,
    required this.website,
    required this.requirements,
     this.createdDate,
   this.updatedDate,
    required this.isActive,
  });

  int vid;
  int scid;
  String vendorName;
  String vendorLogPath;
  bool featureVendor;
  String description;
  String hours;
  String street1;
  String street2;
  String city;
  String state;
  String zipCode;
  String email;
  String phone;
  String website;
  String requirements;
  DateTime? createdDate;
  DateTime? updatedDate;
  bool isActive;

  factory SingleVendorModel.fromJson(Map<String, dynamic> json) => SingleVendorModel(
    vid: json["vid"],
    scid: json["scid"]??0,
    vendorName: json["vendor_name"],
    vendorLogPath: json["vendor_log_path"],
    featureVendor: json["feature_vendor"],
    description: json["description"],
    hours: json["hours"],
    street1: json["street1"],
    street2: json["street2"],
    city: json["city"],
    state: json["state"],
    zipCode: json["zip_code"],
    email: json["email"],
    phone: json["phone"],
    website: json["website"],
    requirements: json["requirements"],
    createdDate: DateTime.parse(json["created_date"]),
    updatedDate: DateTime.parse(json["updated_date"]),
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "vid": vid,
    "scid": scid,
    "vendor_name": vendorName,
    "vendor_log_path": vendorLogPath,
    "feature_vendor": featureVendor,
    "description": description,
    "hours": hours,
    "street1": street1,
    "street2": street2,
    "city": city,
    "state": state,
    "zip_code": zipCode,
    "email": email,
    "phone": phone,
    "website": website,
    "requirements": requirements,
    "created_date": createdDate?.toIso8601String(),
    "updated_date": updatedDate?.toIso8601String(),
    "is_active": isActive,
  };
}
