import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/controllers/subscription_controller.dart';
import 'package:logan/network_services/network_handler.dart';
import 'package:logan/views/global_components/k_bottom_navigation_bar.dart';
import 'package:logan/views/screens/subscription/subscription_screen.dart';
import 'package:logan/views/styles/b_style.dart';
import '../../global_components/k_unsubscribe_bottom_navigation_bar.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final subscriptionController = Get.put(SubscriptionController());

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    String? session = await NetWorkHandler.getToken();

    if (session != null) {
      log('SESSION IS NULL');
      //If user already have session, and subscription go to Home
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        int subscriptonResponse =
            await subscriptionController.getSubscription();
        if (subscriptonResponse == 200 || subscriptonResponse == 201) {
          log('SUBSCRIPTION SCREEN');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const KBottomNavigationBar()));
        } else {
          log('UNSUBSCRIPTION SCREEN');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const KUnsubscribeBottomNavigationBar()));
        }
      });
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.offWhite,
      body: Center(
        child: Image.asset(
          AssetPath.logo,
          height: KSize.getHeight(context, 220),
          width: KSize.getWidth(context, 184),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
