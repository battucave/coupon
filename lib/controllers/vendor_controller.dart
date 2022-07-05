import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:logan/models/api/category_model.dart';
import '../constant/api_routes.dart';
import '../models/api/profile_model.dart';
import '../models/api/single_vendor_model.dart';
import '../models/api/sub_category.dart';
import '../models/api/vendor_model.dart';
import '../network_services/network_handler.dart';


class VendorController extends GetxController{


  var vendorList = <VendorModel>[].obs;
  var subCategory = <SubCategoryModel>[].obs;

  var vendor=SingleVendorModel(
      vid: 0,
      scid: 0,
      vendorName: "",
      vendorLogPath: "",
      featureVendor:false,
      description: "",
      hours:"",
      street1: "",
      street2: "",
      city: "",
      state: "",
      zipCode: "",
      email: "",
      phone: "",
      website: "",
      requirements: "",

      isActive:true).obs;



  @override
  void onInit(){
    super.onInit();

  }




  Future<int?> getVendorBySubCategory(int subCategoryId)async{
    var response=await NetWorkHandler().getWithParameters(ApiRoutes.vendor,subCategoryId,false);

    if(response.statusCode==200 || response.statusCode==201){
      vendorList.value= vendorModelFromJson(response.body);
      return  response.statusCode;
    }else{
      return  response.statusCode;
    }


  }

  Future<int?> getVendorById(int vendorId)async{
    var response=await NetWorkHandler().getWithParameters(ApiRoutes.vendorById,vendorId,true);

    if(response.statusCode==200 || response.statusCode==201){
      vendor.value=singleVendorModelFromJson(response.body);
      return  response.statusCode;
    }else{
      return  response.statusCode;
    }


  }





}