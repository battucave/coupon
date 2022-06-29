import 'package:flutter/material.dart';
import 'package:logan/models/coupon/coupon_expire_model.dart';

import 'package:logan/views/global_components/k_services_man_card.dart';

class ExpiredCouponsTab extends StatefulWidget {
  const ExpiredCouponsTab({Key? key}) : super(key: key);

  @override
  State<ExpiredCouponsTab> createState() => _CouponExpiredScreenState();
}

class _CouponExpiredScreenState extends State<ExpiredCouponsTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: List.generate(couponExpired.length, (index) {
          return KServicesManCard(
            name: couponExpired[index].name,
            image: couponExpired[index].image,
            color: couponExpired[index].color,
            percent: couponExpired[index].percent,
            date: couponExpired[index].date,
            buttonText: "Shop Now",
            couponExpired: true,
          );
        }),
      ),
    );
  }
}
