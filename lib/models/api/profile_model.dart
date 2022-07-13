

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    required this.fullname,
    required this.phone,
    required this.zip,
     required this.profileLogoPath,
  });

  String fullname;
  String phone;
  String zip;
  String profileLogoPath;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    fullname: json["fullname"],
    phone: json["phone"],
    zip: json["zip"],
    profileLogoPath: json["profile_logo_path"],
  );

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "phone": phone,
    "zip": zip,
    "profile_logo_path": profileLogoPath,
  };
}
