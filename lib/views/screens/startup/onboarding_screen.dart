import 'package:flutter/material.dart';
import 'package:logan/constant/asset_path.dart';
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: KSize.getHeight(context, 0)),
                    Image.asset(AssetPath.onboard, fit: BoxFit.scaleDown, ),
                    SizedBox(height: KSize.getHeight(context, 9)),
                    Text(
                      "Lorem Ipsum",
                      style:
                          KTextStyle.headline2.copyWith(color: KColor.primary),
                    ),
                    SizedBox(height: KSize.getHeight(context, 9)),
                    Center(
                        child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                      textAlign: TextAlign.center,
                      style: KTextStyle.headline3
                          .copyWith(color: KColor.black, height: 1.7),
                    )),
                    SizedBox(height: KSize.getHeight(context, 15)),
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
                    SizedBox(height: KSize.getHeight(context, 30)),
                  ],
                ),
              ),

           const KVendorBrandsListComponent(
              isRound: true,
            ) ,


              SizedBox(height: KSize.getHeight(context, 16)),
            ],
          ),
        ),
      ),
    );
  }
}
