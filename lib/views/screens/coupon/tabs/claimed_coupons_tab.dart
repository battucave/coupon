import 'package:flutter/material.dart';
import 'package:logan/models/coupon/coupon_claimed_model.dart';

import 'package:logan/views/global_components/k_services_man_card.dart';

class ClaimedCouponsTab extends StatefulWidget {
  const ClaimedCouponsTab({Key? key}) : super(key: key);

  @override
  State<ClaimedCouponsTab> createState() => _ClaimedCouponsTabState();
}

class _ClaimedCouponsTabState extends State<ClaimedCouponsTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: List.generate(couponClaimed.length, (index) {
          return KServicesManCard(
            name: couponClaimed[index].name,
            image: couponClaimed[index].image,
            color: couponClaimed[index].color,
            percent: couponClaimed[index].percent,
            date: couponClaimed[index].date,
            buttonText: "Redeem Code: 752431",
          );
        }),
      ),
    );
  }
}
