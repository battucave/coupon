
import 'dart:convert';

ClaimModel claimModelFromJson(String str) => ClaimModel.fromJson(json.decode(str));

String claimModelToJson(ClaimModel data) => json.encode(data.toJson());

class ClaimModel {
  ClaimModel({
    required this.couponId,
  });

  int couponId;

  factory ClaimModel.fromJson(Map<String, dynamic> json) => ClaimModel(
    couponId: json["coupon_id"],
  );

  Map<String, dynamic> toJson() => {
    "coupon_id": couponId,
  };
}


