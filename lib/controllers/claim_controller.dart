

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:logan/models/api/register_model.dart';
import '../constant/api_routes.dart';
import '../models/api/claim_model.dart';
import '../network_services/network_handler.dart';


class ClaimController extends GetxController{
  final TextEditingController emailController =TextEditingController();
  final TextEditingController phoneController =TextEditingController();
  final TextEditingController passwordController =TextEditingController();

  Future<int?> claimCoupon(int coupon_id)async{

   ClaimModel claimModel= ClaimModel( couponId:coupon_id );
   Response response=(await NetWorkHandler.post(claimModelToJson(claimModel),  ApiRoutes.claimCoupon)) as Response;
    if(response.statusCode==200 || response.statusCode==201){

      return  response.statusCode;
    }else{
      return  response.statusCode;
    }


  }
}