import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/utils/extensions.dart';
import 'package:logan/views/global_components/k_arrow_go_button.dart';
import 'package:logan/views/global_components/k_back_button.dart';
import 'package:logan/views/global_components/k_text_field.dart';
import 'package:logan/views/screens/auth/change_password_screen.dart';
import 'package:logan/views/styles/b_style.dart';

import '../../../controllers/reset_password_controller.dart';
// import 'package:pin_code_text_field/pin_code_text_field.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  const ConfirmPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmPasswordScreen> createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  //TextEditingController pinCodeController = TextEditingController();
  var resetPasswordController=Get.put(ResetPasswordController());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.screenHeight,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(AssetPath.authBackground), fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: KSize.getHeight(context, 73)),
                const KBackButton(),
                SizedBox(height: KSize.getHeight(context, 35)),
                Text(
                  "Confirm Your passcode",
                  style: KTextStyle.headline4.copyWith(color: KColor.white),
                ),
                SizedBox(height: KSize.getHeight(context, 8)),
                Text(
                  "Please enter 4 digit code you received",
                  style: KTextStyle.headline2.copyWith(fontSize: 18, color: KColor.white),
                ),
                SizedBox(height: KSize.getHeight(context, 45)),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: BoxDecoration(color: KColor.offWhite, borderRadius: BorderRadius.circular(24), boxShadow: [
                        BoxShadow(
                          color: KColor.black.withOpacity(0.16),
                          blurRadius: 6,
                        )
                      ]),
                      child: Column(
                        children: [
                          SizedBox(height: KSize.getHeight(context, 30)),
                            KTextField(
                            controller: resetPasswordController.passCodeController,
                            hintText: "Enter Passcode",
                            keyboardType: TextInputType.numberWithOptions(),
                          ),

                          ///
                          /// Pin Code Fields UI Code Snippet
                          ///
                          // PinCodeTextField(
                          //   hasTextBorderColor: KColor.primary,
                          //   autofocus: true,
                          //   controller: pinCodeController,
                          //   hideCharacter: false,
                          //   highlight: true,
                          //   highlightColor: KColor.orange,
                          //   defaultBorderColor: KColor.orange,
                          //   pinBoxRadius: 10,
                          //   maxLength: 4,
                          //   onTextChanged: (text) {
                          //     setState(() {
                          //       //hasError = false;
                          //     });
                          //   },
                          //   onDone: (text) {
                          //     // print("DONE $text");
                          //     Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
                          //   },
                          //   pinBoxWidth: 52,
                          //   pinBoxHeight: 52,
                          //   hasUnderline: false,
                          //   wrapAlignment: WrapAlignment.spaceAround,
                          //   pinTextStyle: const TextStyle(fontSize: 15.0, color: KColor.black),
                          //   pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
                          //   pinTextAnimatedSwitcherDuration: const Duration(milliseconds: 300),
                          //   keyboardType: TextInputType.number,
                          // ),

                          SizedBox(height: KSize.getHeight(context, 80)),
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: -25,
                        right: KSize.getWidth(context, 150),
                        left: KSize.getWidth(context, 150),
                        child: KArrowGoButton(
                          isLoading: isLoading,
                          onpressed: () async{

                            if(resetPasswordController.emailPhoneController.text.isNotEmpty ){
                              ///get code tap by user
                              resetPasswordController.data["otp_code"]=resetPasswordController.passCodeController.text;
                              startLoading();

                              var verifyResult= await resetPasswordController.verifyOtp();
                              if(verifyResult==200 || verifyResult==201){
                                stopLoading();
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));

                              }else{
                                stopLoading();
                                snackMessage("Invalid code");
                              }
                            }else{
                              snackMessage("Code is required");
                            }


                          },
                        ))
                  ],
                ),
                SizedBox(height: KSize.getHeight(context, 70)),
                Center(
                  child: Text(
                    "Didn’t receive a verification code?",
                    style: KTextStyle.headline2.copyWith(fontSize: 14, color: KColor.black),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text("Resend code ", style: KTextStyle.headline2.copyWith(fontSize: 14, color: KColor.primary)),
                    ),
                    Container(
                      height: 12,
                      width: 1.5,
                      color: KColor.primary,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(" Change email", style: KTextStyle.headline2.copyWith(fontSize: 14, color: KColor.primary)),
                    )
                  ],
                ),
                const SizedBox(height: 150),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
