import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/utils/extensions.dart';
import 'package:logan/views/global_components/k_back_button.dart';
import 'package:logan/views/global_components/k_button.dart';
import 'package:logan/views/global_components/k_text_field.dart';
import 'package:logan/views/styles/b_style.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controllers/profile_controller.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  var editProfileController=Get.put(ProfileController());
  bool isLoading=false;
  void stopLoading( ){
    setState(() {
      isLoading=false;
    });
  }
  void snackMessage( String  msg){
    final snackBar = SnackBar(content: Text(msg),duration : Duration(milliseconds: 3000));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void startLoading(){
    setState(() {
      isLoading=true;
    });
  }

  File? image;
  final picker = ImagePicker();

  Future getMyImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    });
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.offWhite,
      body: SizedBox(
        height: context.screenHeight,
        width: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 100),
                    padding: const EdgeInsets.only(top: 75, bottom: 25, left: 25, right: 25),
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: KColor.black.withOpacity(0.16), blurRadius: 6, spreadRadius: 5)],
                      color: KColor.primary,
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                    ),
                    child: const Align(alignment: Alignment.bottomLeft, child: KBackButton()),
                  ),
                  Positioned(
                    bottom: 55,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: image == null ? const AssetImage(AssetPath.profileImg) : FileImage(image!) as ImageProvider,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 5,
                          bottom: -10,
                          child: InkWell(
                            onTap: () {
                              getMyImage();
                            },
                            child: Image.asset(AssetPath.camera, height: 40, width: 40),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 25)),
                child: Column(
                  children: [
                    KTextField(
                      controller: editProfileController.nameController,
                      prefixIcon: Image.asset(
                        AssetPath.person,
                        height: 20,
                        width: 20,
                        color: KColor.orange,
                      ),
                    ),
                    SizedBox(height: KSize.getHeight(context, 25)),
                    KTextField(
                      controller: editProfileController.phoneController,
                      keyboardType: TextInputType.phone,
                      prefixIcon: Image.asset(
                        AssetPath.phone,
                        height: 20,
                        width: 20,
                        color: KColor.orange,
                      ),
                    ),
                    SizedBox(height: KSize.getHeight(context, 25)),
                    KTextField(
                      controller: editProfileController.mailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Image.asset(
                        AssetPath.mail,
                        height: 20,
                        width: 20,
                        color: KColor.orange,
                      ),
                    ),
                    SizedBox(height: KSize.getHeight(context, 25)),
                    KTextField(
                      controller: editProfileController.cardController,
                      prefixIcon: Image.asset(
                        AssetPath.card,
                        height: 20,
                        width: 20,
                        color: KColor.orange,
                      ),
                    ),
                    SizedBox(height: KSize.getHeight(context, 90)),
                    Row(
                      children: [
                        SizedBox(
                          width: KSize.getWidth(context, 153),
                          child: KButton(
                            isCoupon: true,
                            textColor: KColor.orange,
                            outlineButton: true,
                            text: "Cancel",
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(width: KSize.getWidth(context, 20)),
                        Expanded(
                          child: KButton(
                            isCoupon: true,
                            onPressed: () async{
                              var editResult=await editProfileController.EditProfile();
                              if(editResult==200 || editResult==201){
                                snackMessage("User updated successfully");
                                Navigator.pop(context);
                              }else{
                                snackMessage("Updated failed, try again please");
                              }

                            },
                            text: "Confirm",
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
