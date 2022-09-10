import 'package:flutter/material.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/utils/extensions.dart';
import 'package:logan/views/global_components/k_button.dart';
import 'package:logan/views/global_components/k_vendor_brands_list_component.dart';
import 'package:logan/views/screens/auth/login_screen.dart';
import 'package:logan/views/styles/b_style.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.offWhite,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: KSize.getHeight(context, 40)),
                    SizedBox(
                      height: context.screenHeight * 0.3,
                      child: SizedBox(
                        width: context.screenWidth * 0.4,
                        // height: context.screenWidth * 0.5,
                        child: Image.asset(
                          AssetPath.logo,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: KSize.getHeight(context, 80)),
                    Text(
                      "Locals Supporting Locals",
                      style:
                          KTextStyle.headline2.copyWith(color: KColor.primary),
                    ),
                    SizedBox(height: KSize.getHeight(context, 9)),
                    Center(
                        child: Text(
                      " Save money while supporting your favorite local businesses!",
                      textAlign: TextAlign.center,
                      style: KTextStyle.headline3
                          .copyWith(color: KColor.black, height: 1.7),
                    )),
                    SizedBox(height: context.screenHeight * 0.07),
                    KButton(
                      text: "Login",
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                    ),
                    SizedBox(height: KSize.getHeight(context, 25)),
                    KButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LoginScreen(isSignupScreen: true)));
                      },
                      outlineButton: true,
                      text: "Sign Up",
                      textColor: KColor.primary,
                    ),
                    SizedBox(height: KSize.getHeight(context, 35)),
                  ],
                ),
              ),
              const KVendorBrandsListComponent(
                fromOnboard: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
