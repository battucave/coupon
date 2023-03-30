import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart' hide Response;
import 'package:get/state_manager.dart';
import '../constant/api_routes.dart';
import '../models/api/otp_model.dart';
import '../models/api/reset_password_model.dart';
import '../models/api/verify_otp_model.dart';
import '../network_services/network_handler.dart';
import 'package:http/http.dart';

class ResetPasswordController extends GetxController {
  final TextEditingController emailPhoneController = TextEditingController();
  final TextEditingController passCodeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? resetPwdToken;
  Map data2 = {"recipient_id": "", "session_id": "", "otp_code": ""};

  Future<int?> sendPasswordOtp() async {
    OtpModel otpModel = OtpModel(recipientId: emailPhoneController.text);
    Response response = await NetWorkHandler.post(
        otpModelToJson(otpModel), ApiRoutes.forgotPasswordOtp);
    log(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      data2["recipient_id"] = emailPhoneController.text;
      data2["session_id"] = jsonDecode(response.body)["session_id"];
      print(jsonEncode(response.body));
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<int?> verifyPasswordOtp() async {
    log('IN VERIFY OTP PASSWORD');
    VerifyOtpModel otpModel = VerifyOtpModel(
        recipientId: emailPhoneController.text,
        sessionId: data2["session_id"],
        otpCode: passCodeController.text);
    Response response = await NetWorkHandler.post(
        verifyOtpModelToJson(otpModel), ApiRoutes.verifyPasswordOtp);
    log('VERTIFY PASSWORD OTP:: ${response.body} ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      resetPwdToken = jsonDecode(response.body)["reset_password_token"];
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<int?> resetPassword() async {
    ResetPasswordModel resetPasswordModel = ResetPasswordModel(
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text);
    Response response = await NetWorkHandler().postWithParameters(
        resetPasswordModelToJson(resetPasswordModel),
        ApiRoutes.resetPassword,
        resetPwdToken!);
    print("RESET");
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}
