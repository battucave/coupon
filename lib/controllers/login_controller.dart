import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/state_manager.dart';
import 'package:logan/models/api/register_model.dart';
import '../constant/api_routes.dart';
import '../models/api/login_model.dart';
import '../network_services/network_handler.dart';
import 'package:http/http.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<int?> Login() async {
    LoginModel loginModel = LoginModel(
        username: emailController.text, password: passwordController.text);
    Response response =
        await NetWorkHandler.postFormData(loginModel.toJson(), ApiRoutes.login);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);

      ///Store user token
      NetWorkHandler.storeToken(data['access_token']);
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}
