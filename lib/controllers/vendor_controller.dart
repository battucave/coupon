import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/state_manager.dart';
import 'package:logan/models/api/category_model.dart';
import '../constant/api_routes.dart';
import '../models/api/profile_model.dart';
import '../models/api/single_vendor_model.dart';
import '../models/api/sub_category.dart';
import '../models/api/vendor_model.dart';
import '../network_services/network_handler.dart';
import 'package:http/http.dart';

class VendorController extends GetxController {
  RxList<VendorModel> featuredVendorList = <VendorModel>[].obs;
  RxList<SubCategoryModel> subCategory = <SubCategoryModel>[].obs;
  RxList<VendorModel> foundVendorList = <VendorModel>[].obs;
  Rx<SingleVendorModel> vendor = SingleVendorModel(
          vid: 0,
          scid: 0,
          vendorName: "",
          vendorLogPath: "",
          featureVendor: false,
          description: "",
          hours: "",
          street1: "",
          street2: "",
          city: "",
          state: "",
          zipCode: "",
          email: "",
          phone: "",
          website: "",
          requirements: "",
          isActive: true)
      .obs;
  Rx<SingleVendorModel> vendorProfile = SingleVendorModel(
          vid: 0,
          scid: 0,
          vendorName: "",
          vendorLogPath: "",
          featureVendor: false,
          description: "",
          hours: "",
          street1: "",
          street2: "",
          city: "",
          state: "",
          zipCode: "",
          email: "",
          phone: "",
          website: "",
          requirements: "",
          isActive: true)
      .obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getFeaturedVendor();
  }

  // Future<int?> getVendorBySubCategory(int subCategoryId) async {
  //   Response response = (await NetWorkHandler().getWithParameters(
  //       ApiRoutes.vendor, subCategoryId, false));
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     vendorList.value = vendorModelFromJson(response.body);
  //     return response.statusCode;
  //   } else {
  //     return response.statusCode;
  //   }
  // }

  Future<int?> getVendorById(int vendorId) async {
    isLoading.value = true;
    Response response = await NetWorkHandler()
        .getWithParameters(ApiRoutes.vendorById, vendorId, true);
    if (response.statusCode == 200 || response.statusCode == 201) {
      vendor.value = singleVendorModelFromJson(response.body);
      isLoading.value = false;
      return response.statusCode;
    } else {
      isLoading.value = false;
      return response.statusCode;
    }
  }

  Future<SingleVendorModel> getVendorProfileById(int vendorId) async {
    Response response = await NetWorkHandler()
        .getWithParameters(ApiRoutes.vendorById, vendorId, true);
    //if (response.statusCode == 200 || response.statusCode == 201) {
    vendorProfile.value = singleVendorModelFromJson(response.body);
    return vendorProfile.value;
    //}
  }

  Future<int?> getFeaturedVendor() async {
    Response response = await NetWorkHandler().get(ApiRoutes.featuredVendor);
    if (response.statusCode == 200 || response.statusCode == 201) {
      featuredVendorList.value = vendorModelFromJson(response.body);
      log('VENDOR LIST::: ${featuredVendorList.length}');
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}
