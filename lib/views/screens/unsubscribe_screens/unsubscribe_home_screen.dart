import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/models/categories_models.dart';
import 'package:logan/utils/extensions.dart';
import 'package:logan/views/styles/b_style.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../controllers/category_controller.dart';
import '../../../controllers/coupon_controller.dart';
import '../../../controllers/profile_controller.dart';
import '../../../controllers/vendor_controller.dart';
import '../../global_components/k_brands_card.dart';
import '../../global_components/k_featured_carousel_card.dart';
import '../subscription/subscription_screen.dart';

class UnsubscribeHomeScreen extends StatefulWidget {
  const UnsubscribeHomeScreen({Key? key}) : super(key: key);

  @override
  State<UnsubscribeHomeScreen> createState() => _UnsubscribeHomeScreenState();
}

class _UnsubscribeHomeScreenState extends State<UnsubscribeHomeScreen> {
  CarouselController buttonCarouselController = CarouselController();
  bool viewScreens = false;
  List<Color> colors = [
    const Color(0xFFE8804B),
    const Color(0xFF30C3CD),
    const Color(0xFF1697B7),
  ];
  CategoryController categoryController = Get.put(CategoryController());
  CouponController couponController = Get.put(CouponController());
  VendorController vendorController = Get.put(VendorController());
  ProfileController profileController = Get.put(ProfileController());
  List<Widget>? featuredCarousel = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.09,
        ), // here the desired height
        child: Container(
          color: KColor.offWhite,
          padding: Platform.isAndroid
              ? const EdgeInsets.all(0.0)
              : const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Welcome ",
                    style: KTextStyle.headline4
                        .copyWith(color: KColor.blueSapphire),
                  ),
                  Obx(
                    () => profileController.username.value.isNotEmpty
                        ? Text(
                            profileController.username.value
                                .split(' ')[0]
                                .capitalizeFirst!,
                            style: KTextStyle.headline4.copyWith(
                              color: KColor.blueSapphire,
                            ),

                            ///Get only user firstname
                            // style: KTextStyle.headline4
                            //     .copyWith(color: KColor.black),
                          )
                        : Text(
                            "",
                            style: KTextStyle.headline4.copyWith(
                              color: KColor.blueSapphire,
                            ),
                          ),
                  )
                ],
              ),
              // const SizedBox(height: 0),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Image.asset(AssetPath.location, height: 22, width: 18),
                  const SizedBox(width: 18),
                  Text(
                    "Logan, UT, USA",
                    style: KTextStyle.headline2
                        .copyWith(color: KColor.orange, fontSize: 16),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: KColor.offWhite,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: KSize.getWidth(context, 23),
                  right: KSize.getWidth(context, 18)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 10),
                  Obx(
                    () => couponController.featured2CouponList.isNotEmpty
                        ? SizedBox(
                            width: context.screenWidth,
                            height: context.screenHeight * 0.13,
                            child: CarouselSlider(
                                carouselController: buttonCarouselController,
                                items: List.generate(
                                    couponController.featured2CouponList.length,
                                    (index) {
                                  return KFeaturedCarouselCard(
                                    onTap: () {
                                      //TODO: Subscribe dialog
                                      print('Please subscribe first');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SubscriptionScreen()));
                                    },
                                    percent: couponController
                                        .featured2CouponList
                                        .elementAt(index)
                                        .percentageOff,
                                    image: couponController.featured2CouponList
                                        .elementAt(index)
                                        .vendorLogPath,
                                    vid: vendorController.featuredVendorList
                                        .firstWhere((element) =>
                                            element.vendorName ==
                                            couponController.featured2CouponList
                                                .elementAt(index)
                                                .vendorName)
                                        .vid,
                                    vendorName: couponController
                                        .featured2CouponList
                                        .elementAt(index)
                                        .vendorName,
                                    // vid: featured2CouponList,
                                    // .elementAt(index)
                                    // .v,

                                    onImageTap: () {},
                                  );
                                }),
                                options: CarouselOptions(
                                  height: 157,
                                  viewportFraction: 1,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 7),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 1000),
                                  enlargeCenterPage: true,
                                  scrollDirection: Axis.horizontal,
                                )),
                          )
                        : Container(),
                  ),

                  const SizedBox(height: 10),
                  Text(
                    "Categories",
                    style: KTextStyle.headline4
                        .copyWith(fontSize: 20, color: KColor.blueSapphire),
                  ),
                  const SizedBox(height: 5),
                  Obx(() => SizedBox(
                        // color: Colors.red,
                        // height: context.screenHeight * 0.35,
                        child: GridView.builder(
                            // clipBehavior: Clip.none,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                                top: 5, left: 0, right: 0),
                            itemCount: viewScreens
                                ? categoriesViewsItem.length
                                : categoryController.allCategory.length,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: context.screenHeight * 0.140,
                              // mainAxisSpacing: context.screenWidth * 0.004,
                              // crossAxisSpacing: context.screenWidth * 0.09,
                              crossAxisCount: 3,
                            ),
                            itemBuilder: (context, index) {
                              // log(categoriesViewsItem[index].image.toString());
                              // log(categoryController
                              //     .allCategory[index].categoryLogoPath
                              //     .toString());
                              return GestureDetector(
                                onTap: () {
                                  //TODO: Subscribe dialog
                                  print('Please subscribe first');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SubscriptionScreen()));

                                  //TODO: OLD LOGIC
                                  // if (categoryController.allCategory
                                  //         .elementAt(index)
                                  //         .categoryName ==
                                  //     "Featured") {
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               ServicesScreen(
                                  //                 catId: categoryController
                                  //                     .allCategory
                                  //                     .elementAt(index)
                                  //                     .cid,
                                  //                 isFeatured: true,
                                  //                 title: categoryController
                                  //                     .allCategory
                                  //                     .elementAt(index)
                                  //                     .categoryName,
                                  //               )));
                                  // } else {
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               ServicesScreen(
                                  //                 catId: categoryController
                                  //                     .allCategory
                                  //                     .elementAt(index)
                                  //                     .cid,
                                  //                 title: categoryController
                                  //                     .allCategory
                                  //                     .elementAt(index)
                                  //                     .categoryName,
                                  //                 isFeatured: false,
                                  //               )));
                                  // }
                                },
                                child: viewScreens
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              color: KColor.white,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: KColor.cornflowerBlue
                                                    .withOpacity(0.1),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: KColor.black
                                                        .withOpacity(0.16),
                                                    blurRadius: 4),
                                              ],
                                            ),
                                            child: Image.asset(
                                              categoriesViewsItem[index].image!,
                                              height: 20,
                                              width: 20,
                                            ),
                                          ),
                                          // const SizedBox(height: 10),
                                          Text(
                                            categoriesViewsItem[index].text!,
                                            // overflow: TextOverflow.clip,
                                            style: KTextStyle.headline2
                                                .copyWith(
                                                    fontSize: 13,
                                                    color: KColor.black),
                                          )
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              //TODO: Subscribe dialog
                                              print('Please subscribe first');
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const SubscriptionScreen()));

                                              //TODO: OLD LOGIC REMOVE THEN
                                              // if (categoryController.allCategory
                                              //         .elementAt(index)
                                              //         .categoryName ==
                                              //     "Featured") {
                                              //   Navigator.push(
                                              //       context,
                                              //       MaterialPageRoute(
                                              //           builder: (context) => ServicesScreen(
                                              //               catId:
                                              //                   categoryController
                                              //                       .allCategory
                                              //                       .elementAt(
                                              //                           index)
                                              //                       .cid,
                                              //               isFeatured: true,
                                              //               title: categoryController
                                              //                   .allCategory
                                              //                   .elementAt(
                                              //                       index)
                                              //                   .categoryName)));
                                              // } else {
                                              //   Navigator.push(
                                              //       context,
                                              //       MaterialPageRoute(
                                              //           builder: (context) => ServicesScreen(
                                              //               catId:
                                              //                   categoryController
                                              //                       .allCategory
                                              //                       .elementAt(
                                              //                           index)
                                              //                       .cid,
                                              //               title: categoryController
                                              //                   .allCategory
                                              //                   .elementAt(
                                              //                       index)
                                              //                   .categoryName)));
                                              // }
                                            },
                                            child: Container(
                                              width: 90,
                                              height: 90,
                                              // padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  scale: 2.2,
                                                  // fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    categoryController
                                                        .allCategory
                                                        .elementAt(index)
                                                        .categoryLogoPath,
                                                    // scale: 2.0,
                                                  ),
                                                ),
                                                border: Border.all(
                                                    width: 0.5,
                                                    color: Colors.red),
                                                color: KColor.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: KColor.black
                                                          .withOpacity(0.6),
                                                      offset: Offset(0, 1.5),
                                                      blurRadius: 5)
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 7),
                                          Container(
                                            // color: Colors.red,
                                            child: Text(
                                              categoryController
                                                  .allCategory[index]
                                                  .categoryName,
                                              textAlign: TextAlign.center,
                                              style:
                                                  KTextStyle.headline2.copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: KColor.black,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                              );
                            }),
                      )),

                  // const SizedBox(height: 25),
                  // SizedBox(height: KSize.getHeight(context, 20)),
                ],
              ),
            ),
          ),
          Align(
            alignment: const Alignment(1, 0.545),
            child: Container(
              width: context.screenWidth,
              height: context.screenHeight * 0.05,
              color: const Color(0xff1697B7),
            ),
          ),
          Align(
            alignment: const Alignment(1, 0.75),
            child: Obx(
              () => vendorController.featuredVendorList.isNotEmpty
                  ? SingleChildScrollView(
                      clipBehavior: Clip.none,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            vendorController.featuredVendorList.length,
                            (index) {
                          return GestureDetector(
                            onTap: () {
                              print('Please subscribe first');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SubscriptionScreen()));
                            },
                            child: KBrandsCard(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SubscriptionScreen()));
                              },
                              onPressed: () {
                                print('Please subscribe first');
                              },
                              image: vendorController.featuredVendorList
                                  .elementAt(index)
                                  .vendorLogPath,
                              text: vendorController.featuredVendorList
                                  .elementAt(index)
                                  .vendorName,
                              vid: vendorController.featuredVendorList
                                  .elementAt(index)
                                  .vid,
                            ),
                          );
                        }),
                      ),
                    )
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }
}
