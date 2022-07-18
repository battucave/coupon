import 'dart:convert';

SingleCouponModel singleCouponModelFromJson(String str) => SingleCouponModel.fromJson(json.decode(str));

String singleCouponModelToJson(SingleCouponModel data) => json.encode(data.toJson());

class SingleCouponModel {
  SingleCouponModel({
    required this.couponId,
    required this.vid,
    required this.couponCode,
    required this.percentageOff,
    required this.singleUse,
    required this.featureCoupon,
  this.startDate,
    this.endDate,
      this.createdDate,
      this.updatedDate,
    required this.isActive,
  });

  int couponId;
  int vid;
  String couponCode;
  dynamic percentageOff;
  bool singleUse;
  bool featureCoupon;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? createdDate;
  DateTime? updatedDate;
  bool isActive;

  factory SingleCouponModel.fromJson(Map<String, dynamic> json) => SingleCouponModel(
    couponId: json["coupon_id"],
    vid: json["vid"],
    couponCode: json["coupon_code"],
    percentageOff: json["percentage_off"],
    singleUse: json["single_use"],
    featureCoupon: json["feature_coupon"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    createdDate: DateTime.parse(json["created_date"]),
    updatedDate: DateTime.parse(json["updated_date"]),
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "coupon_id": couponId,
    "vid": vid,
    "coupon_code": couponCode,
    "percentage_off": percentageOff,
    "single_use": singleUse,
    "feature_coupon": featureCoupon,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "created_date": createdDate!.toIso8601String(),
    "updated_date": updatedDate!.toIso8601String(),
    "is_active": isActive,
  };
}
