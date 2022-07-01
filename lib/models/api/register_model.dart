
import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    required this.email,
    required this.password,
    required this.phone,
  });

  String email;
  String password;
  String phone;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "phone": phone,
  };
}
