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
    const Color(0xFFE8804B),
    const Color(0xFF30C3CD),
    const Color(0xFF1697B7),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
         Obx(()=>
          couponController.expriredCouponList.isNotEmpty?
          Column(
            children:   List.generate(couponController.expriredCouponList.length, (index) {
              return KServicesManCard(
                //name:  couponController.expriredCouponList.elementAt(index).couponCode,
                //image: couponExpired[0].image,
                color:  couponColors.elementAt(Random().nextInt(couponColors.length)),
                percent:  couponController.expriredCouponList.elementAt(index).percentageOff,
                date:  couponController.expriredCouponList.elementAt(index).endDate.toString(),
                endDate: couponController.expriredCouponList.elementAt(index).endDate.toString(),
                vid:  couponController.expriredCouponList.elementAt(index).vid,
                buttonText: "Details",
                couponExpired: true, onPressed: () {  }, onProfilePressed: () {  },


              );
            }))
              :
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(height: 200),
              Center(
                child: Text("No data to display",
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
              )
            ],
          ),
        ),
          const SizedBox(height: 160),
        ]



      ),
    );
  }
}
