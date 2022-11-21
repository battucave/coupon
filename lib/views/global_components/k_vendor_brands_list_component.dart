import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logan/models/brands_model.dart';
import 'package:logan/views/global_components/k_brand_startup.dart';
import 'package:logan/views/global_components/k_brands_card.dart';

import '../../models/api/vendor_model.dart';

class KVendorBrandsListComponent extends StatelessWidget {
  KVendorBrandsListComponent({
    this.isRound,
    this.fromOnboard = false,
    required this.listOfBrands,
    Key? key,
  }) : super(key: key);
  final bool? isRound;
  final bool fromOnboard;
  List<VendorModel> listOfBrands;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 10),
        child: Row(
          children: listOfBrands.map((e) {
            return KBrandsCardStartup(
              image: e.vendorLogPath,
              text: '',
              onPressed: () {},
              isRound: isRound,
            );
          }).toList(),
          // List.generate(listOfBrands.length, (index) {
          //   log(listOfBrands.length.toString());
          //   return KBrandsCardStartup(
          //     image: brandsItem[index].image,
          //     text: brandsItem[index].text,
          //     onPressed: () {},
          //     isRound: isRound,
          //   );
          // }),
        ),
      ),
    );
  }
}
