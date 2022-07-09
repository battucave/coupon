import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/state_manager.dart';
import '../constant/api_routes.dart';
import '../models/api/profile_model.dart';
import '../network_services/network_handler.dart';
import 'package:http/http.dart';


class ProfileController extends GetxController{
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController cardController = TextEditingController();
  RxString username=''.obs;
  RxString email=''.obs;
  RxString phone=''.obs;
  RxString card=''.obs;

  @override
  void onInit(){
    super.onInit();
    getProfile();
    getProfileImage();
  }


  Future<int?> getProfile()async{
    Response response=(await NetWorkHandler().get(ApiRoutes.profile)) ;
    if(response.statusCode==200 || response.statusCode==201){

      dynamic data =json.decode(response.body);
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
    Response response=await NetWorkHandler().patch(profileModelToJson(editProfileModel),  ApiRoutes.profile) ;
    if(response.statusCode==200 || response.statusCode==201){
      getProfile();
      return  response.statusCode;
    }else{
      return  response.statusCode;
    }


  }
  Future<int?> uploadImage(filename, url,) async {
    StreamedResponse response=await NetWorkHandler().patchMultipartRequest(filename, url, ApiRoutes.uploadImage) ;
   print(response.statusCode);
   print(response.reasonPhrase);
   return response.statusCode;

  }
  Future<int?> getProfileImage()async{
    Response response=await NetWorkHandler().get(ApiRoutes.getProfileImage);

    ///Api  return {"detail":"No such file or directory exists"}

    if(response.statusCode==200 || response.statusCode==201){
      return  response.statusCode;
    }else{
      return  response.statusCode;
    }


  }
  Future<int?> logout()async{
    Response response=await NetWorkHandler().get(ApiRoutes.logout);
    if(response.statusCode==200 || response.statusCode==201){
      return  response.statusCode;
    }else{
      return  response.statusCode;
    }

  }

  Future<int?> deleteAccount()async{
    Response response=await NetWorkHandler().delete(ApiRoutes.profile);
    if(response.statusCode==200 || response.statusCode==201){
      return  response.statusCode;
    }else{
      return  response.statusCode;
    }

  }




}