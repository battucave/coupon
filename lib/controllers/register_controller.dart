import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/state_manager.dart';
import 'package:logan/models/api/register_model.dart';
import '../constant/api_routes.dart';
import '../models/api/otp_model.dart';
import '../models/api/verify_otp_model.dart';
import '../network_services/network_handler.dart';
import 'package:http/http.dart';

class RegisterController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passCodeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var code = "".obs;

  Map data = {"recipient_id": "", "session_id": "", "otp_code": ""};

  Future<int?> sendOtp() async {
    OtpModel otpModel = OtpModel(recipientId: emailController.text);
    Response response = await NetWorkHandler.post(
        otpModelToJson(otpModel), ApiRoutes.sendMailOtp);
    print(jsonEncode(response.body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      ///we need recipient_id and session_id to veriry otp next
      data["recipient_id"] = emailController.text;
      data["session_id"] = jsonDecode(response.body)["session_id"];
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<int?> verifyOtp() async {
    log('IN VERIFY OTP');
    VerifyOtpModel otpModel = VerifyOtpModel(
        recipientId: emailController.text,
        sessionId: data["session_id"],
        otpCode: passCodeController.text);
    Response response = await NetWorkHandler.post(
        verifyOtpModelToJson(otpModel), ApiRoutes.verifyOtp);
    log('OTP RESPONE::: ${response.body} ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<int?> Register() async {
    RegisterModel registerModel = RegisterModel(
        email: emailController.text,
        password: passwordController.text,
        phone: phoneController.text);
    Response response = await NetWorkHandler.post(
        registerModelToJson(registerModel), ApiRoutes.register);
    if (response.statusCode == 200 || response.statusCode == 201) {
      log('REGISTER RESPONSE::: ${response.body}');
      return response.statusCode;
    } else {
      log('RESPONSE::: ${response.statusCode}');
      log('RESPONSE::: ${response.body}');
      return response.statusCode;
    }
  }
}
