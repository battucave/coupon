import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_network/image_network.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/network_services/network_handler.dart';
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
  final _formKey = GlobalKey<FormState>();

  /// Used to format numbers as mobile or land line
  PhoneNumberType globalPhoneType = PhoneNumberType.mobile;

  /// Use international or national phone format
  PhoneNumberFormat globalPhoneFormat = PhoneNumberFormat.international;

  /// Current selected country
  CountryWithPhoneCode currentSelectedCountry = const CountryWithPhoneCode.us();
  bool inputContainsCountryCode = true;
  ProfileController editProfileController = Get.put(ProfileController());
  bool isLoading = false;
  void stopLoading() {
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
  }

  void startLoading() {
    setState(() {
      isLoading = true;
    });
    showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(KColor.primary)),
                ],
              ),
            ),
          );
        });
  }

  void snackMessage(String msg) {
    final snackBar = SnackBar(
        content: Text(msg), duration: const Duration(milliseconds: 3000));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

    startLoading();
    if (pickedImage != null) {
      var result = await editProfileController.uploadProfileImage(
        pickedImage.path,
        pickedImage.path,
      );
      if (result == 200 || result == 201) {
        stopLoading();
      }
    }
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return (regex.hasMatch(value)) ? true : false;
  }

  @override
  void initState() {
    super.initState();
    editProfileController.getProfile();
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
                    padding: const EdgeInsets.only(
                        top: 75, bottom: 25, left: 25, right: 25),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: KColor.black.withOpacity(0.16),
                            blurRadius: 6,
                            spreadRadius: 5)
                      ],
                      color: KColor.primary,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: const Align(
                        alignment: Alignment.bottomLeft, child: KBackButton()),
                  ),
                  Positioned(
                    bottom: 55,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Obx(() => (image == null &&
                                    editProfileController
                                        .aws_Link.value.isEmpty)
                                ? const Image(
                                    image: AssetImage(AssetPath.profileImg))
                                : (image == null &&
                                        editProfileController
                                            .aws_Link.value.isNotEmpty)
                                    ? ImageNetwork(
                                        image: editProfileController
                                            .aws_Link.value,
                                        // imageCache: CachedNetworkImageProvider(
                                        //     profileController.aws_Link.value),
                                        height: 100,
                                        width: 100,
                                        duration: 1500,

                                        curve: Curves.easeIn,
                                        onPointer: true,
                                        debugPrint: false,
                                        fullScreen: false,
                                        // fitAndroidIos: BoxFit.fill,
                                        fitWeb: BoxFitWeb.scaleDown,
                                        borderRadius: BorderRadius.circular(70),
                                        onLoading:
                                            const CircularProgressIndicator(
                                          color: KColor.primary,
                                        ),
                                        onError: const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                        onTap: () {},
                                      )
                                    : Container(
                                        height: 100.0,
                                        width: 100.0,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(image!)),
                                            shape: BoxShape.circle),
                                      )
                            //  Container(
                            //   height: 100,
                            //   width: 100,
                            //   decoration: BoxDecoration(
                            //     shape: BoxShape.circle,
                            //     image: DecorationImage(
                            //       fit: BoxFit.cover,
                            //       image: (image == null &&
                            //               editProfileController
                            //                   .aws_Link.value.isEmpty)
                            //           ? const AssetImage(AssetPath.profileImg)
                            //           : (image == null &&
                            //                   editProfileController
                            //                       .aws_Link.value.isNotEmpty)
                            //               ? NetworkImage(
                            //                   editProfileController
                            //                       .aws_Link.value,
                            //                 )
                            //               : FileImage(image!) as ImageProvider,
                            //     ),
                            //   ),
                            // ),
                            ),
                        Positioned(
                          right: 5,
                          bottom: -10,
                          child: InkWell(
                            onTap: () {
                              getMyImage();
                            },
                            child: Image.asset(AssetPath.camera,
                                height: 40, width: 40),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: KSize.getWidth(context, 25)),
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
                      readOnly: true,
                      controller: editProfileController.phoneController,
                      keyboardType: TextInputType.phone,
                      format: [
                        LibPhonenumberTextFormatter(
                          phoneNumberType: globalPhoneType,
                          phoneNumberFormat: globalPhoneFormat,
                          country: currentSelectedCountry,
                          inputContainsCountryCode: inputContainsCountryCode,
                          additionalDigits: 3,
                          shouldKeepCursorAtEndOfInput: false,
                        ),
                      ],
                      prefixIcon: Image.asset(
                        AssetPath.phone,
                        height: 20,
                        width: 20,
                        color: KColor.orange,
                      ),
                    ),
                    SizedBox(height: KSize.getHeight(context, 25)),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          KTextField(
                            readOnly: true,
                            controller: editProfileController.mailController,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Image.asset(
                              AssetPath.mail,
                              height: 20,
                              width: 20,
                              color: KColor.orange,
                            ),
                            onChanged: (value) {
                              _formKey.currentState!.validate();
                              setState(() {});
                            },
                            validator: (v) {
                              if (!validateEmail(
                                  editProfileController.mailController.text)) {
                                return 'invalid email';
                              }
                            },
                          ),
                        ],
                      ),
                    ),

                    // SizedBox(height: KSize.getHeight(context, 25)),
                    // KTextField(
                    //   controller: editProfileController.cardController,
                    //   prefixIcon: Image.asset(
                    //     AssetPath.card,
                    //     height: 20,
                    //     width: 20,
                    //     color: KColor.orange,
                    //   ),
                    // ),
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
                            onPressed: () async {
                              startLoading();
                              var editResult =
                                  await editProfileController.EditProfile(
                                      image != null);
                              if (editResult == 200 || editResult == 201) {
                                snackMessage("User updated successfully");
                                stopLoading();
                                Navigator.pop(context);
                              } else {
                                stopLoading();
                                snackMessage(
                                    "Update failed. Please try again.");
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
