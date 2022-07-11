import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logan/models/coupon/coupon_claimed_model.dart';

import 'package:logan/views/global_components/k_services_man_card.dart';

import '../../../../controllers/coupon_controller.dart';
import '../../../../models/coupon/coupon_available_model.dart';

class ClaimedCouponsTab extends StatefulWidget {
  const ClaimedCouponsTab({Key? key}) : super(key: key);

  @override
  State<ClaimedCouponsTab> createState() => _ClaimedCouponsTabState();
}

class _ClaimedCouponsTabState extends State<ClaimedCouponsTab> {
  List<Color> couponColors=[
    Color(0xFFE8804B),
    Color(0xFF30C3CD),
    Color(0xFF1697B7),
  ];
  CouponController couponController=Get.put(CouponController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children:[
          //Obx(()=>
          // couponController.allCoupon.isNotEmpty?
          // Column(
          //   children:  List.generate(couponController.allCoupon.length, (index) {
          //     return KServicesManCard(
          //       name: couponController.allCoupon.elementAt(index).couponCode,
          //       image: couponClaimed[0].image,
          //       color:  couponColors.elementAt(Random().nextInt(couponColors.length)),
          //       percent: couponController.allCoupon.elementAt(index).percentageOff,
          //       date: couponController.allCoupon.elementAt(index).endDate.toString(),
          //       buttonText: "Redeem Code: "+couponController.allCoupon.elementAt(index).couponCode,
          //     );
          //   }),):
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
