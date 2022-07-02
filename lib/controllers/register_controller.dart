

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:logan/models/api/register_model.dart';
import '../constant/api_routes.dart';
import '../network_services/network_handler.dart';


class RegisterController extends GetxController{
final TextEditingController emailController =TextEditingController();
final TextEditingController phoneController =TextEditingController();
final TextEditingController passwordController =TextEditingController();

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