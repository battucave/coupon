
import 'dart:convert';

List<ClaimedCouponModel> claimedCouponModelFromJson(String str) => List<ClaimedCouponModel>.from(json.decode(str).map((x) => ClaimedCouponModel.fromJson(x)));

String claimedCouponModelToJson(List<ClaimedCouponModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClaimedCouponModel {
  ClaimedCouponModel({
    required this.claimedDate,
    required this.percentageOff,
    required this.vendorName,
    required this.vendorLogPath,
  });

  DateTime claimedDate;
  dynamic percentageOff;
  String vendorName;
  String vendorLogPath;

  factory ClaimedCouponModel.fromJson(Map<String, dynamic> json) => ClaimedCouponModel(
    claimedDate: DateTime.parse(json["claimed_date"]),
    percentageOff: json["percentage_off"],
    vendorName: json["vendor_name"],
    vendorLogPath: json["vendor_log_path"],
  );

  Map<String, dynamic> toJson() => {
    "claimed_date": claimedDate.toIso8601String(),
    "percentage_off": percentageOff,
    "vendor_name": vendorName,
    "vendor_log_path": vendorLogPath,
  };
}
