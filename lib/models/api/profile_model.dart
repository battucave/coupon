
import 'dart:convert';

ProfileModel editProfileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    required this.fullname,
    required this.phone,
    required this.zip,
  });

  String fullname;
  String phone;
  String zip;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    fullname: json["fullname"],
    phone: json["phone"],
    zip: json["zip"],
  );

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "phone": phone,
    "zip": zip,
  };
}
