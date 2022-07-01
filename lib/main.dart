import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:logan/views/global_components/k_bottom_navigation_bar.dart';
import 'package:logan/views/screens/auth/login_screen.dart';
import 'package:logan/views/screens/home/home_screen.dart';
import 'package:logan/views/screens/startup/splash_screen.dart';
import 'package:logan/views/styles/k_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: KColor.primary,
        // ignore: deprecated_member_use
        accentColor: KColor.buttonBackground,
        textTheme: Typography.material2018().white,
        backgroundColor: KColor.white,
        scaffoldBackgroundColor: KColor.white,
        fontFamily: 'Poppins',
      ),
      home: const SplashScreen(),
    );


  }
}
