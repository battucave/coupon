import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:logan/views/screens/startup/splash_screen.dart';
import 'package:logan/views/styles/k_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ///Change statusBarColor
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor:  KColor.blueGreen, // status bar color
  // ));
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  ).then((_) {
    runApp(const MyApp());
  });
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
