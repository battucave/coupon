import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logan/models/coupon/coupon_expire_model.dart';

import 'package:logan/views/global_components/k_services_man_card.dart';

import '../../../../controllers/coupon_controller.dart';

class ExpiredCouponsTab extends StatefulWidget {
  const ExpiredCouponsTab({Key? key}) : super(key: key);

  @override
  State<ExpiredCouponsTab> createState() => _CouponExpiredScreenState();
}

class _CouponExpiredScreenState extends State<ExpiredCouponsTab> {
  CouponController couponController=Get.put(CouponController());
  List<Color> couponColors=[
    Color(0xFFE8804B),
    Color(0xFF30C3CD),
    Color(0xFF1697B7),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
         // Obx(()=>
          // couponController.allCoupon.isNotEmpty?
          // Column(
          //   children:   List.generate(couponController.allCoupon.length, (index) {
          //     return KServicesManCard(
          //       name:  couponController.allCoupon.elementAt(index).couponCode,
          //       image: couponExpired[0].image,
          //       color:  couponColors.elementAt(Random().nextInt(couponColors.length)),
          //       percent:  couponController.allCoupon.elementAt(index).percentageOff,
          //       date:  couponController.allCoupon.elementAt(index).couponCode,
          //       buttonText: "Shop Now",
          //       couponExpired: true,
          //     );
          //   }))
          //     :
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 200),
              Center(
                child: Text("No data to display",
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
              )
            ],
          ),
         // ),
        ]



      ),
    );
  }
}
