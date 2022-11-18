import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/state_manager.dart';
import 'package:logan/models/api/category_model.dart';
import 'package:logan/models/api/featured_coupon_model.dart';
import '../constant/api_routes.dart';
import '../models/api/claim_model.dart';
import '../models/api/claimed_coupon_model.dart';
import '../models/api/coupon_by_subcat_model.dart';
import '../models/api/coupon_model.dart';
import '../models/api/single_coupon_model.dart';
import '../network_services/network_handler.dart';
import 'package:http/http.dart';

class CouponController extends GetxController {
  RxList<CouponModel> allCoupon = <CouponModel>[].obs;
  RxList<CouponModel> expriredCouponList = <CouponModel>[].obs;
  RxList<CouponModel> vendorCouponList = <CouponModel>[].obs;
  // RxList<CouponModel> featuredCouponList = <CouponModel>[].obs;

  RxList<ClaimedCouponModel> claimedCouponList = <ClaimedCouponModel>[].obs;
  RxList<FeaturedCouponModel> foundFeaturedCouponList =
      <FeaturedCouponModel>[].obs;
  RxList<FeaturedCouponModel> featured2CouponList = <FeaturedCouponModel>[].obs;

  RxList<SubCatCouponModel> couponBySubCategory = <SubCatCouponModel>[].obs;
  RxList<SubCatCouponModel> foundBySubCategory = <SubCatCouponModel>[].obs;
  RxList<SubCatCouponModel> foundSearchBySubCategory =
      <SubCatCouponModel>[].obs;
  RxList<SubCatCouponModel> filterSubCategoryCoupon = <SubCatCouponModel>[].obs;
  RxList<SubCatCouponModel> realfoundBySubCategory = <SubCatCouponModel>[].obs;
  Rx<SingleCouponModel> singleCouponModel = SingleCouponModel(
          couponId: 0,
          vid: 0,
          couponCode: "",
          percentageOff: 0,
          singleUse: true,
          featureCoupon: false,
          isActive: true)
      .obs;

  RxList<VendorsAndCouponsList> vendorAndCouponList =
      <VendorsAndCouponsList>[].obs;
  @override
  void onInit() {
    super.onInit();
    getFeaturedCoupon();
    // getAllFeaturedCoupon();
    getAllCoupon();
    getAllExpiredCoupon();
    getClaimCoupon();

    foundFeaturedCouponList = featured2CouponList;
    if (foundBySubCategory.isNotEmpty) {
      if (foundBySubCategory.first.vendorsAndCouponsList.isNotEmpty) {
        vendorAndCouponList.value =
            foundBySubCategory.first.vendorsAndCouponsList;
      }
    }
    foundSearchBySubCategory = foundBySubCategory;
  }

  void seachCoupon(String couponName) {
    RxList<SubCatCouponModel> result2 = <SubCatCouponModel>[].obs;
    RxList<VendorsAndCouponsList> result = <VendorsAndCouponsList>[].obs;
    if (couponName.isEmpty) {
      result.value = foundBySubCategory.first.vendorsAndCouponsList;
    } else {
      result.value = foundBySubCategory.first.vendorsAndCouponsList
          .where((element) => element.vendorName
              .toUpperCase()
              .contains(couponName.toUpperCase()))
          .toList();
    }

    vendorAndCouponList.value = result;
    //foundSearchBySubCategory.value= result.value;
  }

  void seachFeaturedCoupon(String couponName) {
    RxList<FeaturedCouponModel> result = <FeaturedCouponModel>[].obs;
    if (couponName.isEmpty) {
      result = featured2CouponList;
    } else {
      result.value = featured2CouponList.value
          .where((element) => element.vendorName
              .toUpperCase()
              .contains(couponName.toUpperCase()))
          .toList();
    }
    foundFeaturedCouponList = result;
  }

  Future<int?> getCouponBySubCategory(int categoryId, int subcatId) async {
    Response response = (await NetWorkHandler()
        .getWithParameters(ApiRoutes.subCatCouponList, categoryId, true));

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("CouponBySubCat");
      print(response.body);

      foundBySubCategory.value = subCatCouponModelFromJson(response.body);
      foundBySubCategory.value = foundBySubCategory.value
          .where((element) => element.subCategoryId == subcatId)
          .toList();

      vendorAndCouponList.value =
          foundBySubCategory.value.first.vendorsAndCouponsList;
      print(foundBySubCategory.first.vendorsAndCouponsList.length);

      //filterSubCategoryCoupon.value=subCatCouponModelFromJson(response.body);
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<int?> getAllCoupon() async {
    Response response = await NetWorkHandler().get(ApiRoutes.allCoupon);
    if (response.statusCode == 200 || response.statusCode == 201) {
      allCoupon.value = couponModelFromJson(response.body);
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<int?> getAllExpiredCoupon() async {
    Response response = await NetWorkHandler().get(ApiRoutes.expiredCoupon);
    if (response.statusCode == 200 || response.statusCode == 201) {
      expriredCouponList.value = couponModelFromJson(response.body);
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  // Future<int?> getAllFeaturedCoupon() async {
  //   Response response = await NetWorkHandler().get(ApiRoutes.featuredCoupon);

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     featuredCouponList.value = couponModelFromJson(response.body);
  //     return response.statusCode;
  //   } else {
  //     return response.statusCode;
  //   }
  // }

  Future<int?> getCouponByVendorId(int vendorId) async {
    Response response = await NetWorkHandler()
        .getWithParameters(ApiRoutes.couponByVendorId, vendorId, false);
    if (response.statusCode == 200 || response.statusCode == 201) {
      vendorCouponList.value = couponModelFromJson(response.body);
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<int?> claimCoupon(int coupon_id) async {
    ClaimModel claimModel = ClaimModel(couponId: coupon_id);
    Response response = await NetWorkHandler().postWithAuthorization(
        claimModelToJson(claimModel), ApiRoutes.claimCoupon);
    print("CLAIM COUPON POST REQUEST ::: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<int?> getClaimCoupon() async {
    Response response = await NetWorkHandler().get(ApiRoutes.claimCouponList);
    log('CLAIMED COUPON GET REQUEST:::: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      claimedCouponList.value = claimedCouponModelFromJson(response.body);
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<int?> getFeaturedCoupon() async {
    Response response =
        await NetWorkHandler().get(ApiRoutes.featuredCouponApps);
    print("FEATUREDDD");
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      featured2CouponList.value = featuredCouponModelFromJson(response.body);
      print(featured2CouponList.length);
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<SingleCouponModel> getCouponById(int couponId) async {
    Response response = await NetWorkHandler()
        .getWithParameters(ApiRoutes.couponById, couponId, true);
    print(response.body);
    singleCouponModel.value = singleCouponModelFromJson(response.body);
    return singleCouponModel.value;
  }
}
