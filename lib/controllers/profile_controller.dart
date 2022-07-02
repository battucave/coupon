import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import '../constant/api_routes.dart';
import '../models/api/profile_model.dart';
import '../network_services/network_handler.dart';


class ProfileController extends GetxController{
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController cardController = TextEditingController();
  var username=''.obs;
  var email=''.obs;
  var phone=''.obs;
  var card=''.obs;

  @override
  void onInit(){
    super.onInit();
    getProfile();
  }


  Future<int?> getProfile()async{
    var response=await NetWorkHandler().get(ApiRoutes.profile);
    if(response.statusCode==200 || response.statusCode==201){

      var data =json.decode(response.body);
      ///To display one profile screen
      if(data['fullname']!=null){///verify if fullname is not null
        username.value=data["fullname"];

        ///To display one Edit profile screen
        nameController.text=data["fullname"];
      }else{
        username.value='';
      }
      email.value=data["email"];
      phone.value=data["phone"];

      if(data["zip"]!=null){///verify if zip is not null
        card.value=data["zip"];

        ///To display one Edit profile screen
        cardController.text= data["zip"];
      }
      phoneController.text= data["phone"];
      mailController.text= data["email"];


      return  response.statusCode;
    }else{
      return  response.statusCode;
    }


  }

  Future<int?> EditProfile()async{
    ProfileModel  editProfileModel=  ProfileModel(fullname: nameController.text,phone: phoneController.text,zip: cardController.text);
    var response=await NetWorkHandler().patch(profileModelToJson(editProfileModel),  ApiRoutes.profile);
    if(response.statusCode==200 || response.statusCode==201){
      getProfile();
      return  response.statusCode;
    }else{
      return  response.statusCode;
    }


  }

  Future<int?> logout()async{
    var response=await NetWorkHandler().get(ApiRoutes.logout);
    if(response.statusCode==200 || response.statusCode==201){
      return  response.statusCode;
    }else{
      return  response.statusCode;
    }

  }

  Future<int?> deleteAccount()async{
    var response=await NetWorkHandler().delete(ApiRoutes.profile);
    if(response.statusCode==200 || response.statusCode==201){
      return  response.statusCode;
    }else{
      return  response.statusCode;
    }

  }




}