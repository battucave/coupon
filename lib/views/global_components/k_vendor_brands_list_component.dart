import 'package:flutter/material.dart';
import 'package:logan/models/brands_model.dart';
import 'package:logan/views/global_components/k_brands_card.dart';

class KVendorBrandsListComponent extends StatelessWidget {
  const KVendorBrandsListComponent({
    this.isRound,
    Key? key,
  }) : super(key: key);
  final bool? isRound;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(brandsItem.length, (index) {
          return KBrandsCard(
            image: brandsItem[index].image,
            text: brandsItem[index].text,
            onPressed: () {},
            isRound: isRound,
          );
        }),
      ),
    );
  }
}
