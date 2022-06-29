import 'package:flutter/material.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/utils/extensions.dart';
import 'package:logan/views/global_components/k_arrow_go_button.dart';
import 'package:logan/views/global_components/k_back_button.dart';
import 'package:logan/views/global_components/k_text_field.dart';
import 'package:logan/views/screens/auth/login_screen.dart';
import 'package:logan/views/styles/b_style.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isSignupScreen = true;
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();

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
                              controller: passwordController,
                            ),
                            SizedBox(height: KSize.getHeight(context, 30)),
                            KTextField(
                              passWordField: true,
                              prefixIcon: Image.asset(AssetPath.lockIcon, height: 20, width: 16),
                              hintText: "Confirm Password",
                              controller: passwordConfirmationController,
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
                        onpressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
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
