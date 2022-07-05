import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:logan/models/api/category_model.dart';
import '../constant/api_routes.dart';
import '../models/api/profile_model.dart';
import '../models/api/sub_category.dart';
import '../network_services/network_handler.dart';


class CategoryController extends GetxController{


 var allCategory = <CategoryModel>[].obs;
 var subCategory = <SubCategoryModel>[].obs;

  @override
  void onInit(){
    super.onInit();
    getAllCategory();
  }


  Future<int?> getAllCategory()async{
    var response=await NetWorkHandler().get(ApiRoutes.allCategory);
    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200 || response.statusCode==201){

      allCategory.value=categoryModelFromJson(response.body);

      return  response.statusCode;
    }else{
      return  response.statusCode;
    }


  }

 Future<int?> getSubCategory(int categoryId)async{
   var response=await NetWorkHandler().getWithParameters(ApiRoutes.subCategory,categoryId,false);

   if(response.statusCode==200 || response.statusCode==201){
     subCategory.value=subCategoryModelFromJson(response.body);
     return  response.statusCode;
   }else{
     return  response.statusCode;
   }


 }





}