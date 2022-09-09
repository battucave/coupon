
import 'dart:convert';

List<SubCatCouponModel> subCatCouponModelFromJson(String str) => List<SubCatCouponModel>.from(json.decode(str).map((x) => SubCatCouponModel.fromJson(x)));

String subCatCouponModelToJson(List<SubCatCouponModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCatCouponModel {
  SubCatCouponModel({
    required this.subCategoryId,
    required this.subCategoryName,
    required this.subCategoryLogoPath,
    required this.vendorsAndCouponsList,
  });

  int subCategoryId;
  String subCategoryName;
  String subCategoryLogoPath;
  List<VendorsAndCouponsList> vendorsAndCouponsList;

  factory SubCatCouponModel.fromJson(Map<String, dynamic> json) => SubCatCouponModel(
    subCategoryId: json["sub_category_id"],
    subCategoryName: json["sub_category_name"],
    subCategoryLogoPath: json["sub_category_logo_path"]??"",
    vendorsAndCouponsList: List<VendorsAndCouponsList>.from(json["vendors_and_coupons_list"].map((x) => VendorsAndCouponsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sub_category_id": subCategoryId,
    "sub_category_name": subCategoryName,
    "sub_category_logo_path": subCategoryLogoPath,
    "vendors_and_coupons_list": List<dynamic>.from(vendorsAndCouponsList.map((x) => x.toJson())),
  };
}

class VendorsAndCouponsList {
  VendorsAndCouponsList({
    required this.couponId,
    required this.percentageOff,
    required this.endDate,
    required this.couponDescription,
    required this.vendorId,
    required this.vendorName,
    required this.vendorLogPath,
  });

  int couponId;
  double percentageOff;
  DateTime endDate;
  String couponDescription;
  int vendorId;
  String vendorName;
  String vendorLogPath;

  factory VendorsAndCouponsList.fromJson(Map<String, dynamic> json) => VendorsAndCouponsList(
    couponId: json["coupon_id"],
    percentageOff: json["percentage_off"],
    endDate: DateTime.parse(json["end_date"]),
    couponDescription: json["coupon_description"],
    vendorId: json["vendor_id"],
    vendorName: json["vendor_name"],
    vendorLogPath: json["vendor_log_path"],
  );

  Map<String, dynamic> toJson() => {
    "coupon_id": couponId,
    "percentage_off": percentageOff,
    "end_date": endDate.toIso8601String(),
    "coupon_description": couponDescription,
    "vendor_id": vendorId,
    "vendor_name": vendorName,
    "vendor_log_path": vendorLogPath,
  };
}






///PREVIEW MODEL
//
// import 'dart:convert';
//
// List<SubCatCouponModel> subCatCouponModelFromJson(String str) => List<SubCatCouponModel>.from(json.decode(str).map((x) => SubCatCouponModel.fromJson(x)));
//
// String subCatCouponModelToJson(List<SubCatCouponModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class SubCatCouponModel {
//   SubCatCouponModel({
//      this.subCategoryId,
//      this.subCategoryName,
//       this.subCategoryLogoPath,
//       this.vendorsAndCouponsList,
//   });
//
//   int? subCategoryId;
//   String? subCategoryName;
//   String? subCategoryLogoPath;
//   List<VendorsAndCouponsList>? vendorsAndCouponsList;
//
//   factory SubCatCouponModel.fromJson(Map<String, dynamic> json) => SubCatCouponModel(
//     subCategoryId: json["sub_category_id"],
//     subCategoryName: json["sub_category_name"],
//     subCategoryLogoPath: json["sub_category_logo_path"],
//     vendorsAndCouponsList: List<VendorsAndCouponsList>.from(json["vendors_and_coupons_list"].map((x) => VendorsAndCouponsList.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "sub_category_id": subCategoryId,
//     "sub_category_name": subCategoryName,
//     "sub_category_logo_path": subCategoryLogoPath,
//     "vendors_and_coupons_list": List<dynamic>.from(vendorsAndCouponsList!.map((x) => x.toJson())),
//   };
// }
//
// class VendorsAndCouponsList {
//   VendorsAndCouponsList({
//     required this.vendorId,
//     required this.vendorName,
//     required this.vendorLogPath,
//     required this.vendorCouponsList,
//   });
//
//   int vendorId;
//   String vendorName;
//   String vendorLogPath;
//   List<VendorCouponsList> vendorCouponsList;
//
//   factory VendorsAndCouponsList.fromJson(Map<String, dynamic> json) => VendorsAndCouponsList(
//     vendorId: json["vendor_id"],
//     vendorName: json["vendor_name"],
//     vendorLogPath: json["vendor_log_path"],
//     vendorCouponsList: List<VendorCouponsList>.from(json["vendor_coupons_list"].map((x) => VendorCouponsList.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "vendor_id": vendorId,
//     "vendor_name": vendorName,
//     "vendor_log_path": vendorLogPath,
//     "vendor_coupons_list": List<dynamic>.from(vendorCouponsList.map((x) => x.toJson())),
//   };
// }
//
// class VendorCouponsList {
//   VendorCouponsList({
//     required this.couponId,
//     required this.percentageOff,
//     required this.endDate,
//   });
//
//   int couponId;
//   dynamic percentageOff;
//   DateTime endDate;
//
//   factory VendorCouponsList.fromJson(Map<String, dynamic> json) => VendorCouponsList(
//     couponId: json["coupon_id"],
//     percentageOff: json["percentage_off"],
//     endDate: DateTime.parse(json["end_date"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "coupon_id": couponId,
//     "percentage_off": percentageOff,
//     "end_date": endDate.toIso8601String(),
//   };
// }
