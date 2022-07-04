
import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) => List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  CategoryModel({
    required this.cid,
    required this.categoryName,
    required this.categoryLogoPath,
    required this.createdDate,
    required this.updatedDate,
    required this.isActive,
  });

  int cid;
  String categoryName;
  String categoryLogoPath;
  DateTime createdDate;
  DateTime updatedDate;
  bool isActive;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    cid: json["cid"],
    categoryName: json["category_name"],
    categoryLogoPath: json["category_logo_path"],
    createdDate: DateTime.parse(json["created_date"]),
    updatedDate: DateTime.parse(json["updated_date"]),
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "cid": cid,
    "category_name": categoryName,
    "category_logo_path": categoryLogoPath,
    "created_date": createdDate.toIso8601String(),
    "updated_date": updatedDate.toIso8601String(),
    "is_active": isActive,
  };
}
