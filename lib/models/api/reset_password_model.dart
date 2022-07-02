
import 'dart:convert';

ResetPasswordModel resetPasswordModelFromJson(String str) => ResetPasswordModel.fromJson(json.decode(str));

String resetPasswordModelToJson(ResetPasswordModel data) => json.encode(data.toJson());

class ResetPasswordModel {
  ResetPasswordModel({
    required this.newPassword,
    required this.confirmPassword,
  });

  String newPassword;
  String confirmPassword;

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) => ResetPasswordModel(
    newPassword: json["new_password"],
    confirmPassword: json["confirm_password"],
  );

  Map<String, dynamic> toJson() => {
    "new_password": newPassword,
    "confirm_password": confirmPassword,
  };
}
