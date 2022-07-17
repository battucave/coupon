import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logan/constant/asset_path.dart';
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
  void showClaimedImg(){
    setState(() {
      showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
          barrierDismissible: true,
          context: context,
          builder: (_) {
            return Dialog(
              // The background color
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:  [
                    // The loading indicator
                    Image.asset(AssetPath.claimedSample),
                  ],
                ),
              ),
            );
          });
    });

  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children:[
          Obx(()=>
          couponController.claimedCouponList.isNotEmpty?
          Column(
              children:   List.generate(couponController.claimedCouponList.length, (index) {
                return KServicesManCard(
                  name:  couponController.claimedCouponList.elementAt(index).vendorName,
                  image: couponController.claimedCouponList.elementAt(index).vendorLogPath,
                  color:  couponColors.elementAt(Random().nextInt(couponColors.length)),
                  percent:  double.parse(couponController.claimedCouponList.elementAt(index).percentageOff.toString()),
                  date:  couponController.claimedCouponList.elementAt(index).claimedDate.toString(),
                  endDate: couponController.claimedCouponList.elementAt(index).claimedDate.toString(),
                  buttonText: "Details",
                  couponExpired: false,
                  onPressed:(){
                    showClaimedImg();
                  },


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
