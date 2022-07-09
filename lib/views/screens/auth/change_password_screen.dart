import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/utils/extensions.dart';
import 'package:logan/views/global_components/k_arrow_go_button.dart';
import 'package:logan/views/global_components/k_back_button.dart';
import 'package:logan/views/global_components/k_text_field.dart';
import 'package:logan/views/screens/auth/login_screen.dart';
import 'package:logan/views/styles/b_style.dart';

import '../../../controllers/reset_password_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isSignupScreen = true;

  ResetPasswordController resetPasswordController=Get.put(ResetPasswordController());
  bool isLoading=false;
  void stopLoading( ){
    setState(() {
      isLoading=false;
    });
    Navigator.pop(context);
  }

  void startLoading(){
    setState(() {
      isLoading=true;
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
                  CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(KColor.primary)),

                ],
              ),
            ),
          );
        });
  }
  void snackMessage( String  msg){
    final snackBar = SnackBar(content: Text(msg),duration : Duration(milliseconds: 3000));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: context.screenHeight,
      width: double.infinity,
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(AssetPath.authBackground), fit: BoxFit.fill)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: KSize.getHeight(context, 73)),
              const KBackButton(),
              SizedBox(height: KSize.getHeight(context, 35)),
              Text(
                "Change password",
                style: KTextStyle.headline4.copyWith(color: KColor.white),
              ),
              SizedBox(height: KSize.getHeight(context, 8)),
              Text(
                "Please update your password.",
                style: KTextStyle.headline2.copyWith(fontSize: 18, color: KColor.white),
              ),
              SizedBox(height: KSize.getHeight(context, 45)),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: context.screenWidth - 40,
                    decoration: BoxDecoration(
                      color: KColor.offWhite,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: KSize.getHeight(context, 30)),
                        Column(
                          children: [
                            KTextField(
                              passWordField: true,
                              prefixIcon: Image.asset(AssetPath.lockIcon, height: 20, width: 16),
                              hintText: "Password",
                              controller: resetPasswordController.newPasswordController,
                            ),
                            SizedBox(height: KSize.getHeight(context, 30)),
                            KTextField(
                              passWordField: true,
                              prefixIcon: Image.asset(AssetPath.lockIcon, height: 20, width: 16),
                              hintText: "Confirm Password",
                              controller: resetPasswordController.confirmPasswordController,
                            ),
                            SizedBox(height: KSize.getHeight(context, 50)),
                          ],
                        )
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

                          if(resetPasswordController.newPasswordController.text.isNotEmpty &&
                              resetPasswordController.confirmPasswordController.text.isNotEmpty ){


                            startLoading();
                            int? resetResult= await resetPasswordController.resetPassword();
                            print(resetResult);
                            if(resetResult==200 || resetResult==201){
                              stopLoading();

                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                              snackMessage("Password reset successfully");
                            }else{
                              stopLoading();
                              snackMessage("Reset password token has expired, please request a new one.");
                            }
                          }else if(resetPasswordController.newPasswordController.text!=resetPasswordController.confirmPasswordController.text){
                            snackMessage("Passwords must be the same!");
                          }else{
                            snackMessage("Fields are required");
                          }

                        },
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
