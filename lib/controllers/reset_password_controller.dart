
import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart' hide Response;
import 'package:get/state_manager.dart';
import '../constant/api_routes.dart';
import '../models/api/otp_model.dart';
import '../models/api/reset_password_model.dart';
import '../models/api/verify_otp_model.dart';
import '../network_services/network_handler.dart';
import 'package:http/http.dart';


class ResetPasswordController extends GetxController{
  final TextEditingController emailPhoneController =TextEditingController();
  final TextEditingController passCodeController =TextEditingController();
  final TextEditingController newPasswordController =TextEditingController();
  final TextEditingController confirmPasswordController =TextEditingController();

  Map data = {
    "recipient_id": "",
    "session_id": "",
    "otp_code": ""
  };


  Future<int?> sendOtp()async{
    OtpModel otpModel= OtpModel(recipientId: emailPhoneController.text);
    Response response=await NetWorkHandler.post(otpModelToJson(otpModel),  ApiRoutes.forgotPasswordOtp) ;

    if(response.statusCode==200 || response.statusCode==201){
      ///we need recipient_id and session_id to veriry otp next

      data["recipient_id"]=emailPhoneController.text;
      data["session_id"]=jsonDecode(response.body)["session_id"];
      print(jsonEncode(response.body));
     return  response.statusCode;
    }else{
      return  response.statusCode;
    }

  }

  Future<int?> verifyOtp()async{
    VerifyOtpModel otpModel= VerifyOtpModel(recipientId: emailPhoneController.text,sessionId: data["session_id"],otpCode: passCodeController.text);
    Response response=await NetWorkHandler.post(verifyOtpModelToJson(otpModel),  ApiRoutes.verifyOtp) ;
    if(response.statusCode==200 || response.statusCode==201){
      return  response.statusCode;
    }else{
      return  response.statusCode;
    }

  }

  Future<int?> resetPassword()async{
    ResetPasswordModel resetPasswordModel= ResetPasswordModel(newPassword:newPasswordController.text,confirmPassword: confirmPasswordController.text );
    Response response=await NetWorkHandler.post(resetPasswordModelToJson(resetPasswordModel),  ApiRoutes.resetPassword+data["session_id"]);
    if(response.statusCode==200 || response.statusCode==201){
      return  response.statusCode;
    }else{
      return  response.statusCode;
    }

  }
}