import 'dart:convert';
import 'dart:developer';

List<FeaturedCouponModel> featuredCouponModelFromJson(String str) =>
    List<FeaturedCouponModel>.from(
        json.decode(str).map((x) => FeaturedCouponModel.fromJson(x)));

String featuredCouponModelToJson(List<FeaturedCouponModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeaturedCouponModel {
  FeaturedCouponModel({
    required this.couponId,
    required this.percentageOff,
    required this.endDate,
    required this.vendorName,
    required this.vendorLogPath,
  });

  int couponId;
  dynamic percentageOff;
  DateTime endDate;
  String vendorName;
  String vendorLogPath;

  factory FeaturedCouponModel.fromJson(Map<String, dynamic> json) {
    print("HERE is the type: ${json["percentage_off"].runtimeType}");
    // print("HERE is the type: ${json["percentage_off"].runtimeType}");
    // print("HERE is the type: ${json["percentage_off"].runtimeType}");
    // print("HERE is the type: ${json["percentage_off"].runtimeType}");
    return FeaturedCouponModel(
      couponId: json["coupon_id"],
      percentageOff: (json["percentage_off"]).toString(),
      endDate: DateTime.parse(json["end_date"]),
      vendorName: json["vendor_name"],
      vendorLogPath: json["vendor_log_path"],
    );
  }

  Map<String, dynamic> toJson() => {
        "coupon_id": couponId,
        "percentage_off": percentageOff,
        "end_date": endDate.toIso8601String(),
        "vendor_name": vendorName,
        "vendor_log_path": vendorLogPath,
      };
}
