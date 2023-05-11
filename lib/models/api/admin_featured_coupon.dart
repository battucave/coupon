import 'dart:convert';

List<AdminFeaturedCoupon> adminFeaturedCouponModelFromJson(String str) =>
    List<AdminFeaturedCoupon>.from(
        json.decode(str).map((x) => AdminFeaturedCoupon.fromJson(x)));

class AdminFeaturedCoupon {
  int couponId;
  int vid;
  int scid;
  String couponCode;
  String percentageOff;
  bool singleUse;
  bool featureCoupon;
  DateTime startDate;
  DateTime endDate;
  DateTime createdDate;
  DateTime updatedDate;
  bool isActive;
  String couponDescription;
  String scheduler;

  AdminFeaturedCoupon({
    required this.couponId,
    required this.vid,
    required this.scid,
    required this.couponCode,
    required this.percentageOff,
    required this.singleUse,
    required this.featureCoupon,
    required this.startDate,
    required this.endDate,
    required this.createdDate,
    required this.updatedDate,
    required this.isActive,
    required this.couponDescription,
    required this.scheduler,
  });

  factory AdminFeaturedCoupon.fromJson(Map<String, dynamic> json) =>
      AdminFeaturedCoupon(
        couponId: json["coupon_id"],
        vid: json["vid"],
        scid: json["scid"],
        couponCode: json["coupon_code"],
        percentageOff: json["percentage_off"],
        singleUse: json["single_use"],
        featureCoupon: json["feature_coupon"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        createdDate: DateTime.parse(json["created_date"]),
        updatedDate: DateTime.parse(json["updated_date"]),
        isActive: json["is_active"],
        couponDescription: json["coupon_description"],
        scheduler: json["scheduler"],
      );

  Map<String, dynamic> toJson() => {
        "coupon_id": couponId,
        "vid": vid,
        "scid": scid,
        "coupon_code": couponCode,
        "percentage_off": percentageOff,
        "single_use": singleUse,
        "feature_coupon": featureCoupon,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "created_date": createdDate.toIso8601String(),
        "updated_date": updatedDate.toIso8601String(),
        "is_active": isActive,
        "coupon_description": couponDescription,
        "scheduler": scheduler,
      };
}
