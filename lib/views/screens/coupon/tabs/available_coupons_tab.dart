import 'package:flutter/material.dart';
import 'package:logan/models/coupon/coupon_available_model.dart';
import 'package:logan/views/global_components/k_services_man_card.dart';
import 'package:logan/views/screens/services/service_details_screen.dart';

class AvailableCouponsTab extends StatefulWidget {
  const AvailableCouponsTab({Key? key}) : super(key: key);

  @override
  State<AvailableCouponsTab> createState() => _CouponAvailableScreenState();
}

class _CouponAvailableScreenState extends State<AvailableCouponsTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Column(
            children: List.generate(couponAvailable.length, (index) {
              return KServicesManCard(
                name: couponAvailable[index].name,
                image: couponAvailable[index].image,
                color: couponAvailable[index].color,
                percent: couponAvailable[index].percent,
                date: couponAvailable[index].date,
                buttonText: "Shop Now",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ServiceDetailsScreen(
                              name: couponAvailable[index].name,
                              image: couponAvailable[index].image,
                              color: couponAvailable[index].color,
                              percent: couponAvailable[index].percent,
                              date: couponAvailable[index].date,
                            )),
                  );
                },
              );
            }),
          ),
          const SizedBox(height: 160),
        ],
      ),
    );
  }
}
