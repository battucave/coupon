import 'package:flutter/material.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/utils/extensions.dart';
import 'package:logan/views/screens/coupon/coupon_history_screens.dart';
import 'package:logan/views/screens/home/home_screen.dart';
import 'package:logan/views/screens/notification/notification_screen.dart';
import 'package:logan/views/screens/profile/profile_screen.dart';
import 'package:logan/views/styles/k_colors.dart';

class KBottomNavigationBar extends StatefulWidget {
  const KBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _KBottomNavBarState createState() => _KBottomNavBarState();
}

class _KBottomNavBarState extends State<KBottomNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _bottomNavPages = [
    const HomeScreen(),
    const CouponHistoryScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: _bottomNavPages[_currentIndex],
        bottomNavigationBar: Container(
          height: 64,
          decoration: BoxDecoration(
            color: KColor.white,
            boxShadow: [
              BoxShadow(color: KColor.black.withOpacity(0.16), blurRadius: 6),
            ],
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(context, AssetPath.home, 0),
              _buildBottomNavItem(context, AssetPath.cupon, 1),
              _buildBottomNavItem(context, AssetPath.notification, 2),
              _buildBottomNavItem(context, AssetPath.profile, 3),
            ],
          ),
        ));
  }

  Widget _buildBottomNavItem(
      BuildContext context, String navIconImg, int navIndex) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = navIndex;
        });
      },
      child: Container(
        height: context.screenHeight,
        width: context.screenWidth * 0.2,
        padding: const EdgeInsets.all(20),
        color: Colors.transparent,
        child: Image.asset(
          navIconImg,
          color: _currentIndex == navIndex
              ? Colors.orange.shade900
              : KColor.primary,
          height: 23,
          width: 23,
        ),
      ),
    );
  }
}
