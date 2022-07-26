import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/state_manager.dart';
import 'package:logan/models/api/category_model.dart';
import '../constant/api_routes.dart';
import '../models/api/profile_model.dart';
import '../models/api/sub_category.dart';
import '../network_services/network_handler.dart';
import 'package:http/http.dart'  ;


class CategoryController extends GetxController{


  RxList<CategoryModel>  allCategory = <CategoryModel>[].obs;
  RxList<SubCategoryModel>  subCategory = <SubCategoryModel>[].obs;

  @override
  void onInit(){
    super.onInit();
    getAllCategory();
  }


  Future<int?> getAllCategory()async{
    CategoryModel? featuredCat;
    CategoryModel? _first;
    Response response=await NetWorkHandler().get(ApiRoutes.allCategory) ;
    print(response.body);
    print(response.statusCode);
    if(response.statusCode==200 || response.statusCode==201){
      allCategory.value=categoryModelFromJson(response.body);
      ///Set featured as first element
      if(allCategory.value.isNotEmpty){
        _first=allCategory.value.elementAt(0);
        for(int i=0;i<allCategory.value.length;i++){
          if(allCategory.value.elementAt(i).categoryName=="Featured"){

            featuredCat=allCategory.value.elementAt(i);
            allCategory.value.removeAt(i);
          }
        }
        if(featuredCat!=null){
          allCategory.value.first=featuredCat;
          allCategory.value.add(_first);

        }

      }

      return  response.statusCode;
    }else{
      return  response.statusCode;
    }


  }

 Future<int?> getSubCategory(int categoryId)async{
   Response response=await NetWorkHandler().getWithParameters(ApiRoutes.subCategory,categoryId,false) ;

   if(response.statusCode==200 || response.statusCode==201){
     subCategory.value=subCategoryModelFromJson(response.body);

     return  response.statusCode;
   }else{
     return  response.statusCode;
   }


 }



}