import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';



import 'package:logan/constant/asset_path.dart';
import 'package:logan/controllers/login_controller.dart';
import 'package:logan/controllers/register_controller.dart';
import 'package:logan/utils/extensions.dart';
import 'package:logan/views/global_components/k_arrow_go_button.dart';
import 'package:logan/views/global_components/k_bottom_navigation_bar.dart';
import 'package:logan/views/global_components/k_social_media_button.dart';
import 'package:logan/views/global_components/k_text_field.dart';
import 'package:logan/views/screens/auth/forgot_password_screen.dart';
import 'package:logan/views/styles/b_style.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import 'confirm_password_screen.dart';

class LoginScreen extends StatefulWidget {
  final bool isSignupScreen;
  const LoginScreen({Key? key, this.isSignupScreen = false}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSignupScreen = true;
  RegisterController registerController=Get.put(RegisterController());
  LoginController loginController=Get.put(LoginController());
  bool isLoading=false;
  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return (regex.hasMatch(value)) ? true : false;
  }
  @override
  void initState() {
    super.initState();
    isSignupScreen = widget.isSignupScreen;
  }
  @override
  void dispose() {
    super.dispose();
     isLoading=false;
  }

  ///Show message to user according to api response statuscode
  void snackMessage( String  msg){
    final snackBar = SnackBar(content: Text(msg),duration : Duration(milliseconds: 3000));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  final _formKey = GlobalKey<FormState>();
  /// Used to format numbers as mobile or land line
  PhoneNumberType globalPhoneType = PhoneNumberType.mobile;
  /// Use international or national phone format
  PhoneNumberFormat globalPhoneFormat = PhoneNumberFormat.international;
  /// Current selected country
  CountryWithPhoneCode currentSelectedCountry = const CountryWithPhoneCode.us();
  bool inputContainsCountryCode = true;

  void stopLoading( ){
    setState(() {
      isLoading=false;
    });
    Navigator.pop(context);
  }
  void startLoading(){
    setState(() {
      isLoading=true;
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
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.screenHeight,
        width: double.infinity,
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(AssetPath.authBackground), fit: BoxFit.fill)),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: KSize.getHeight(context, 33)),
                  Text(
                    isSignupScreen ? "Welcome" : "Welcome back!",
                    style: KTextStyle.headline4.copyWith(color: KColor.white),
                  ),
                  SizedBox(height: KSize.getHeight(context, 8)),
                  Text(
                    isSignupScreen ? "Create your account" : "Login to your account",
                    style: KTextStyle.headline2.copyWith(fontSize: 18, color: KColor.white),
                  ),
                  SizedBox(height: KSize.getHeight(context, 40)),
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(color: KColor.offWhite, borderRadius: BorderRadius.circular(24)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSignupScreen = true;
                                      isLoading=false;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        "Sign Up",
                                        style: KTextStyle.headline2.copyWith(fontSize: 20, color: isSignupScreen ? KColor.primary : KColor.black),
                                      ),
                                      if (isSignupScreen)
                                        Container(
                                          margin: const EdgeInsets.only(top: 3),
                                          height: 2.5,
                                          width: KSize.getWidth(context, 77),
                                          color: KColor.primary,
                                        )
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 39),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSignupScreen = false;
                                      isLoading=false;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        "Login",
                                        style: KTextStyle.headline2.copyWith(fontSize: 20, color: !isSignupScreen ? KColor.primary : KColor.black),
                                      ),
                                      if (!isSignupScreen)
                                        Container(
                                          margin: const EdgeInsets.only(top: 3),
                                          height: 2.5,
                                          width: KSize.getWidth(context, 55),
                                          color: KColor.primary,
                                        )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: KSize.getHeight(context, 56)),
                            isSignupScreen
                                ? Column(
                                    children: [
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          children: <Widget>[
                                            KTextField(
                                              hintText: "Email Address",
                                              prefixIcon: Image.asset(AssetPath.mailIcon, height: 16, width: 22),
                                              keyboardType: TextInputType.emailAddress,
                                              controller: registerController.emailController,
                                              onChanged: (value){
                                                _formKey.currentState!.validate();
                                                setState(() {   });

                                              },
                                              validator: (v){
                                                if( !validateEmail( registerController.emailController.text)){
                                                  return 'invalid email';
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: KSize.getHeight(context, 30)),
                                      KTextField(
                                        hintText: "Phone Number",
                                        prefixIcon: Image.asset(AssetPath.phone, height: 20, width: 20),
                                        keyboardType: TextInputType.phone,
                                        controller: registerController.phoneController,
                                        format: [
                                          LibPhonenumberTextFormatter(
                                            phoneNumberType: globalPhoneType,
                                            phoneNumberFormat: globalPhoneFormat,
                                            country: currentSelectedCountry,
                                            inputContainsCountryCode:
                                            inputContainsCountryCode,
                                            additionalDigits: 3,
                                            shouldKeepCursorAtEndOfInput: false,
                                          ),
                                        ],


                                      ),
                                      SizedBox(height: KSize.getHeight(context, 30)),
                                      KTextField(
                                        passWordField: true,
                                        hintText: "Password",
                                        prefixIcon: Image.asset(AssetPath.lockIcon, height: 20, width: 16),
                                        controller: registerController.passwordController,
                                      ),
                                      SizedBox(height: KSize.getHeight(context, 85)),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      KTextField(
                                        hintText: "Email Address",
                                        prefixIcon: Image.asset(AssetPath.mailIcon, height: 16, width: 22),
                                        keyboardType: TextInputType.emailAddress,
                                        controller: loginController.emailController,
                                      ),
                                      SizedBox(height: KSize.getHeight(context, 30)),
                                      KTextField(
                                        passWordField: true,
                                        hintText: "Password",
                                        prefixIcon: Image.asset(AssetPath.lockIcon, height: KSize.getHeight(context, 20), width: 16),
                                        controller: loginController.passwordController,
                                      ),
                                      SizedBox(height: KSize.getHeight(context, 10)),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
                                          },
                                          child: Text(
                                            "Forgot Password?",
                                            style: KTextStyle.headline2.copyWith(fontSize: 14, color: KColor.primary),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: KSize.getHeight(context, 80)),
                                    ],
                                  )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: -25,
                        child: KArrowGoButton(
                          isLoading:isLoading ,
                          onpressed: () async{





                         if(isSignupScreen){
                           if(registerController.emailController.text.isNotEmpty &&
                               registerController.phoneController.text.isNotEmpty &&
                               registerController.passwordController.text.isNotEmpty){
                             startLoading();

                             int?  otpResult= await registerController.sendOtp();
                             if(otpResult==200 || otpResult==201){

                               stopLoading();

                               Navigator.push(context, MaterialPageRoute(builder: (context) =>   ConfirmPasswordScreen(isSignUp: true,)));

                             }else{
                               stopLoading();
                               snackMessage("Error occurred when sending otp");
                             }
                           }else{
                             snackMessage("All fields are required");
                           }

                         }else{
                           if(loginController.emailController.text.isNotEmpty &&
                               loginController.passwordController.text.isNotEmpty ){

                             startLoading();
                             int? result=await loginController.Login();
                             if(result==200 || result==201){//To know if login is success from api
                               ///Remove credential
                               loginController.emailController.text="";
                               loginController.passwordController.text="";

                               stopLoading();
                               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const KBottomNavigationBar()));
                             }else{
                               stopLoading();
                               snackMessage("Incorrect username or password");

                             }
                           }else{
                             snackMessage("All fields are required");
                           }

                         }


                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 44),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/line.png"),
                      const SizedBox(width: 12),
                      Text(
                        "Or log in with",
                        style: KTextStyle.headline2.copyWith(fontSize: 14, color: KColor.black.withOpacity(0.4)),
                      ),
                      const SizedBox(width: 12),
                      Image.asset("assets/images/line.png"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      KSocialMediaButton(
                        image: AssetPath.facebook,
                        width: 13,
                        height: 27,
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const KBottomNavigationBar()));
                        },
                      ),
                      const SizedBox(width: 40),
                      KSocialMediaButton(
                        image: AssetPath.google,
                        width: 25,
                        height: 24,
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const KBottomNavigationBar()));
                        },
                      ),
                      const SizedBox(width: 40),
                      KSocialMediaButton(
                        image: AssetPath.apple,
                        width: 22,
                        height: 27,
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const KBottomNavigationBar()));
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 27),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isSignupScreen ? "Already have acount?" : "Don’t have acount?",
                        style: KTextStyle.headline2.copyWith(color: KColor.black.withOpacity(0.7), fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSignupScreen) {
                              isSignupScreen = false;
                            } else {
                              isSignupScreen = true;
                            }
                          });
                        },
                        child: Text(
                          isSignupScreen ? " Login" : " Sign Up",
                          style: KTextStyle.headline2.copyWith(color: KColor.primary, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isSignupScreen ? 74 : 140),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
