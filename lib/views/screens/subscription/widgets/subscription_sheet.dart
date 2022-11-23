import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:logan/views/screens/auth/login_screen.dart';
import 'package:logan/views/styles/b_style.dart';
import 'package:logan/views/styles/k_text_style.dart';

import '../../../../controllers/subscription_controller.dart';

class ShowSubscriptionSheet extends StatelessWidget {
  ShowSubscriptionSheet({Key? key, required this.productDetails})
      : super(key: key);

  final controller = Get.find<SubscriptionController>();

  List<ProductDetails> productDetails;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionController>(
      builder: (controller) => Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10.0),
              height: 5.0,
              width: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                // color: AppColors.kBlack.withOpacity(0.5)
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.5,
            width: Get.width,
            child:
                // FutureBuilder(
                //   future: controller.loadPurchases(),
                //   builder:
                //       (context, AsyncSnapshot<List<ProductDetails>?> snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return const Center(
                //         child: CircularProgressIndicator(),
                //       );
                //     } else if (snapshot.connectionState == ConnectionState.done) {
                //       if (snapshot.hasError) {
                //         return Center(
                //           child: Text(
                //             '${snapshot.error} occurred',
                //             style: const TextStyle(fontSize: 18),
                //           ),
                //         );
                //       } else if (snapshot.hasData) {
                //         return
                ListView.builder(
                    itemCount: productDetails.length,
                    itemBuilder: (context, index) {
                      print(index);
                      return PurchaseWidget(
                        product: productDetails[index],
                        onPressed: () async {
                          // Get.offAll(LoginScreen());
                          await controller.buy(productDetails[index]);
                        },
                      );
                    }),
            //       }
            //     }
            //     return const SizedBox();
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}

class PurchaseWidget extends StatelessWidget {
  const PurchaseWidget(
      {Key? key, required this.product, required this.onPressed})
      : super(key: key);

  final ProductDetails product;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        product.title,
        style: KTextStyle.headline5.copyWith(color: KColor.black),
      ),
      trailing: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 40.0,
          width: 150.0,
          decoration: BoxDecoration(
              color: KColor.primary, borderRadius: BorderRadius.circular(15.0)),
          child: Center(
            child: Text(
              'Buy ${product.price}',
              style: KTextStyle.headline5.copyWith(color: KColor.white),
            ),
          ),
        ),
      ),
    );
  }
}
