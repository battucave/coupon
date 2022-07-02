
import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  OtpModel({
    required this.recipientId,
  });

  String recipientId;

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
    recipientId: json["recipient_id"],
  );

  Map<String, dynamic> toJson() => {
    "recipient_id": recipientId,
  };
}
