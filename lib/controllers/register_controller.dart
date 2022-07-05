

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:logan/models/api/register_model.dart';
import '../constant/api_routes.dart';
import '../models/api/otp_model.dart';
import '../models/api/verify_otp_model.dart';
import '../network_services/network_handler.dart';


class RegisterController extends GetxController{
final TextEditingController emailController =TextEditingController();
final TextEditingController phoneController =TextEditingController();
final TextEditingController passCodeController =TextEditingController();
final TextEditingController passwordController =TextEditingController();


Map data = {
  "recipient_id": "",
  "session_id": "",
  "otp_code": ""
};


Future<int?> sendOtp()async{

  OtpModel otpModel= OtpModel(recipientId:  emailController.text);
  var response=await NetWorkHandler.post(otpModelToJson(otpModel),  ApiRoutes.sendMailOtp);

  if(response.statusCode==200 || response.statusCode==201){
    ///we need recipient_id and session_id to veriry otp next

    data["recipient_id"]=emailController.text;
    data["session_id"]=jsonDecode(response.body)["session_id"];

    print(jsonEncode(response.body));


    return  response.statusCode;
  }else{
    return  response.statusCode;
  }

}

Future<int?> verifyOtp()async{
  VerifyOtpModel otpModel= VerifyOtpModel(recipientId: emailController.text,sessionId: data["session_id"],otpCode: passCodeController.text);
  var response=await NetWorkHandler.post(verifyOtpModelToJson(otpModel),  ApiRoutes.verifyOtp);

  if(response.statusCode==200 || response.statusCode==201){


    return  response.statusCode;
  }else{
    return  response.statusCode;
  }

}

 Future<int?> Register()async{

  RegisterModel registerModel= RegisterModel(email:emailController.text, password:passwordController.text, phone: phoneController.text);

  var response=await NetWorkHandler.post(registerModelToJson(registerModel),  ApiRoutes.register);
  if(response.statusCode==200 || response.statusCode==201){

    return  response.statusCode;
  }else{
    return  response.statusCode;
  }


}
}