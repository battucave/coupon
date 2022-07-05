import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logan/models/coupon/coupon_available_model.dart';
import 'package:logan/views/global_components/k_services_man_card.dart';
import 'package:logan/views/screens/services/service_details_screen.dart';

import '../../../../controllers/coupon_controller.dart';

class AvailableCouponsTab extends StatefulWidget {
  const AvailableCouponsTab({Key? key}) : super(key: key);

  @override
  State<AvailableCouponsTab> createState() => _CouponAvailableScreenState();
}

class _CouponAvailableScreenState extends State<AvailableCouponsTab> {
  List<Color> couponColors=[
     Color(0xFFE8804B),  
     Color(0xFF30C3CD), 
     Color(0xFF1697B7),  
  ];
  var couponController=Get.put(CouponController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Obx(()=>

              couponController.allCoupon.isNotEmpty?
              Column(
            children:

          List.generate(couponController.allCoupon.length, (index) {
             return KServicesManCard(
               name: couponController.allCoupon.elementAt(index).couponCode,
               image: couponAvailable[0].image,
               color:  couponColors.elementAt(Random().nextInt(couponColors.length)),
               percent:   couponController.allCoupon.elementAt(index).percentageOff,
               date:  couponController.allCoupon.elementAt(index).endDate.toString(),
               buttonText: "Shop Now",
               onPressed: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context) => ServiceDetailsScreen(
                         name:  couponController.allCoupon.elementAt(index).couponCode,
                         image: couponAvailable[index].image,
                         color:  couponColors.elementAt(Random().nextInt(couponColors.length)),
                         percent: couponController.allCoupon.elementAt(index).percentageOff,
                         date: couponController.allCoupon.elementAt(index).endDate.toString(),
                         vendorId:  couponController.allCoupon.elementAt(index).vid,
                       )),
                 );
               },
             );
           }),):
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
          ),
          const SizedBox(height: 160),
        ],
      ),
    );
  }
}
