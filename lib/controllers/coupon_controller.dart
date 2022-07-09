import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/state_manager.dart';
import 'package:logan/models/api/category_model.dart';
import '../constant/api_routes.dart';
import '../models/api/claim_model.dart';
import '../models/api/coupon_model.dart';
import '../network_services/network_handler.dart';
import 'package:http/http.dart';


class CouponController extends GetxController{


  RxList<CouponModel>  allCoupon = <CouponModel>[].obs;
  RxList<CouponModel>  vendorCouponList = <CouponModel>[].obs;

  @override
  void onInit(){
    super.onInit();
    getAllCoupon();
  }


  Future<int?> getAllCoupon()async{
    Response response=await NetWorkHandler().get(ApiRoutes.allCoupon)  ;

    if(response.statusCode==200 || response.statusCode==201){
      allCoupon.value=couponModelFromJson(response.body);
      return  response.statusCode;
    }else{
      return  response.statusCode;
    }


  }

  Future<int?> getCouponByVendorId(int vendorId)async{
    Response response=await NetWorkHandler().getWithParameters(ApiRoutes.couponByVendorId,vendorId,false)  ;
     print(response.statusCode);
     print(response.body);
    if(response.statusCode==200 || response.statusCode==201){
      vendorCouponList.value=couponModelFromJson(response.body);
      return  response.statusCode;
    }else{
      return  response.statusCode;
    }


  }

  Future<int?> claimCoupon(int coupon_id)async{

    ClaimModel claimModel= ClaimModel( couponId:coupon_id );

    Response response=await NetWorkHandler.post(claimModelToJson(claimModel),  ApiRoutes.claimCoupon) ;
    if(response.statusCode==200 || response.statusCode==201){

      return  response.statusCode;
    }else{
      return  response.statusCode;
    }


  }

}