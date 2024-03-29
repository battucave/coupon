import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/controllers/reset_password_controller.dart';
import 'package:logan/utils/extensions.dart';
import 'package:logan/views/global_components/k_arrow_go_button.dart';
import 'package:logan/views/global_components/k_back_button.dart';
import 'package:logan/views/global_components/k_text_field.dart';
import 'package:logan/views/screens/auth/confirm_password_screen.dart';
import 'package:logan/views/styles/b_style.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool isSignupScreen = true;
  final fromKey = GlobalKey<FormState>();
  // bool usePhone = false;
  //TextEditingController emailPhoneController = TextEditingController();
  ResetPasswordController resetPasswordController =
      Get.put(ResetPasswordController());
  bool isLoading = false;
  void stopLoading() {
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
  }

  void snackMessage(String msg) {
    final snackBar =
        SnackBar(content: Text(msg), duration: Duration(milliseconds: 3000));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return (regex.hasMatch(value)) ? true : false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.screenHeight,
        width: double.infinity,
        decoration: const BoxDecoration(
            // image: DecorationImage(
            // image: AssetImage(AssetPath.authBackground), fit: BoxFit.fill)),
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0E5E71),
            Color(0xFF1697B7),
            Color(0xFF1697B7),
            Color(0xFFF3F3F3),
            Color(0xFFF3F3F3),

            // KColor.blue,
            // KColor.blue,
            // KColor.blue,
            // Colors.white,
            // Colors.white,
          ],
        )),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: KSize.getHeight(context, 73),
                ),
                const KBackButton(),
                SizedBox(
                  height: KSize.getHeight(context, 35),
                ),
                Text(
                  "Forgot Password",
                  style: KTextStyle.headline4.copyWith(color: KColor.white),
                ),
                SizedBox(
                  height: KSize.getHeight(context, 8),
                ),
                Text(
                  "Please type in your Email address",
                  style: KTextStyle.headline2
                      .copyWith(fontSize: 18, color: KColor.white),
                ),
                SizedBox(
                  height: KSize.getHeight(context, 45),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: KColor.offWhite,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                                color: KColor.black.withOpacity(0.16),
                                blurRadius: 6)
                          ]),
                      child: Column(
                        children: [
                          SizedBox(height: KSize.getHeight(context, 30)),
                          Form(
                            key: fromKey,
                            child: Column(
                              children: [
                                KTextField(
                                  prefixIcon:
                                      // usePhone
                                      //     ? Image.asset(AssetPath.phone,
                                      //         height: 20, width: 20)
                                      //     :
                                      Image.asset(AssetPath.mailIcon,
                                          height: 16, width: 22),
                                  hintText:
                                      // usePhone ?
                                      // "Phone Number" :
                                      "Email Address",
                                  keyboardType:
                                      // usePhone
                                      //     ?
                                      //     TextInputType.phone
                                      //     :
                                      TextInputType.emailAddress,
                                  controller: resetPasswordController
                                      .emailPhoneController,
                                  validator: (value) {
                                    if (!validateEmail(value!)) {
                                      return 'invalid email';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: KSize.getHeight(context, 10)),
                                // Align(
                                //   alignment: Alignment.centerRight,
                                //   child: GestureDetector(
                                //       onTap: () {
                                //         setState(() {
                                //           // usePhone = !usePhone;
                                //         });
                                //       },
                                //       child: Text(
                                //         usePhone
                                //             ? "Use email address"
                                //             : "Use phone number ",
                                //         style: KTextStyle.headline2.copyWith(
                                //             fontSize: 14, color: KColor.primary),
                                //       )),
                                // ),
                                SizedBox(height: KSize.getHeight(context, 50)),
                              ],
                            ),
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
                          onpressed: () async {
                            if (!fromKey.currentState!.validate()) {
                              return;
                            }
                            if (resetPasswordController
                                .emailPhoneController.text.isNotEmpty) {
                              startLoading();
                              int? otpResult = await resetPasswordController
                                  .sendPasswordOtp();
                              if (otpResult == 200 || otpResult == 201) {
                                stopLoading();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ConfirmPasswordScreen(
                                              isSignUp: false,
                                            )));
                              } else {
                                stopLoading();
                                snackMessage("Error occurred when sending otp");
                              }
                            } else {
                              snackMessage("Field is required");
                            }
                          },
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
