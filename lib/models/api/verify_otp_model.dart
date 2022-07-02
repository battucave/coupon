
import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) => VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
  VerifyOtpModel({
    required this.recipientId,
    required this.sessionId,
    required this.otpCode,
  });

  String recipientId;
  String sessionId;
  String otpCode;

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
    recipientId: json["recipient_id"],
    sessionId: json["session_id"],
    otpCode: json["otp_code"],
  );

  Map<String, dynamic> toJson() => {
    "recipient_id": recipientId,
    "session_id": sessionId,
    "otp_code": otpCode,
  };
}
