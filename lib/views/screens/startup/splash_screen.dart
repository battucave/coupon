import 'package:flutter/material.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/network_services/network_handler.dart';
import 'package:logan/views/global_components/k_bottom_navigation_bar.dart';
import 'package:logan/views/styles/b_style.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    initData();
  }

  initData() async{
    var session= await NetWorkHandler.getToken();
    Future.delayed(
      const Duration(seconds: 3),
      (){
        if(session!=null){//If user already have session, go to homeScreen
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const KBottomNavigationBar()));
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OnboardingScreen()));
        }

      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.white,
      body: Center(
        child: Image.asset(
          AssetPath.logo,
          height: KSize.getHeight(context, 198),
          width: KSize.getWidth(context, 164),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
