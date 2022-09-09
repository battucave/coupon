import 'dart:convert';

List<SubCategoryModel> subCategoryModelFromJson(String str) => List<SubCategoryModel>.from(json.decode(str).map((x) => SubCategoryModel.fromJson(x)));

String subCategoryModelToJson(List<SubCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategoryModel {
  SubCategoryModel({
    required this.scid,
    required this.cid,
    required this.subCategoryName,
    required this.subCategoryLogoPath,
    required this.createdDate,
    required this.updatedDate,
    required this.isActive,
  });

  int scid;
  int cid;
  String subCategoryName;
  String subCategoryLogoPath;
  DateTime createdDate;
  DateTime updatedDate;
  bool isActive;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
    scid: json["scid"],
    cid: json["cid"],
    subCategoryName: json["sub_category_name"],
    subCategoryLogoPath:  json["sub_category_logo_path"] ?? "",
    createdDate: DateTime.parse(json["created_date"]),
    updatedDate: DateTime.parse(json["updated_date"]),
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "scid": scid,
    "cid": cid,
    "sub_category_name": subCategoryName,
    "sub_category_logo_path": subCategoryLogoPath,
    "created_date": createdDate.toIso8601String(),
    "updated_date": updatedDate.toIso8601String(),
    "is_active": isActive,
  };
}
