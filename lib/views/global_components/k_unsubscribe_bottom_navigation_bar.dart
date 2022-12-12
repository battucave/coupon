import 'package:flutter/material.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/utils/extensions.dart';
import 'package:logan/views/screens/coupon/coupon_history_screens.dart';
import 'package:logan/views/screens/home/home_screen.dart';
import 'package:logan/views/screens/notification/notification_screen.dart';
import 'package:logan/views/screens/profile/profile_screen.dart';
import 'package:logan/views/screens/unsubscribe_screens/unsubscribe_home_screen.dart';
import 'package:logan/views/styles/k_colors.dart';

import '../screens/subscription/subscription_screen.dart';

class KUnsubscribeBottomNavigationBar extends StatefulWidget {
  const KUnsubscribeBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<KUnsubscribeBottomNavigationBar> createState() =>
      _KUnsubscribeBottomNavigationBarState();
}

class _KUnsubscribeBottomNavigationBarState
    extends State<KUnsubscribeBottomNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _bottomNavPages = [
    const UnsubscribeHomeScreen(),
    // const CouponHistoryScreen(),
    // const NotificationScreen(),
    // const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: _bottomNavPages[_currentIndex],
        bottomNavigationBar: Container(
          height: 60,
          margin: const EdgeInsets.only(bottom: 10.0),
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
              // _buildBottomNavItem(context, AssetPath.notification, 2),
              //TODO: For now profile naviagtion index 2.. Change to 3 when get notification back
              _buildBottomNavItem(context, AssetPath.profile, 2),
            ],
          ),
        ));
  }

  Widget _buildBottomNavItem(
      BuildContext context, String navIconImg, int navIndex) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (navIndex == 0) {
            _currentIndex = navIndex;
          } else {
            //TODO: Subscribe dialog
            print('Please subscribe first');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SubscriptionScreen()));
          }
          // _currentIndex = navIndex;
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
