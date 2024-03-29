import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_network/image_network.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/extensions/string_extension.dart';
import 'package:logan/models/categories_models.dart';
import 'package:logan/utils/extensions.dart';
import 'package:logan/views/global_components/k_vendor_brands_list_component.dart';
import 'package:logan/views/screens/services/services_screen.dart';
import 'package:logan/views/styles/b_style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controllers/category_controller.dart';
import '../../../controllers/coupon_controller.dart';
import '../../../controllers/profile_controller.dart';
import '../../../controllers/vendor_controller.dart';
import '../../animation/confetti_handler.dart';
import '../../global_components/confirm_coupon_dialogue.dart';
import '../../global_components/k_brands_card.dart';
import '../../global_components/k_coupon_claim_card.dart';
import '../../global_components/k_dialog.dart';
import '../../global_components/k_featured_carousel_card.dart';
import '../services/service_details_screen.dart';
import '../services/vendor_service_screen.dart';
import '../subscription/subscription_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  void snackMessage(String msg) {
    final snackBar =
        SnackBar(content: Text(msg), duration: Duration(milliseconds: 3000));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void stopLoading() {
    Navigator.pop(context);
  }

  void startLoading() {
    setState(() {
      showDialog(
          // The user CANNOT close this dialog  by pressing outsite it
          barrierDismissible: false,
          context: context,
          builder: (_) {
            return Dialog(
              // The background color
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    // The loading indicator
                    CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(KColor.primary)),
                  ],
                ),
              ),
            );
          });
    });
  }

  late ConfettiController _controllerCenter;
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;
  late ConfettiController _controllerTopCenter;
  late ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 1));
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 1));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 1));
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 1));
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.1,
        ), // here the desired height
        child: SafeArea(
          child: Container(
            color: KColor.offWhite,
            child: Column(
              children: [
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
                                    onTap: () async {
                                      // log(couponController
                                      //     .featured2CouponList[index]
                                      //     .toJson()
                                      //     .toString());
                                      // log(vendorController.featuredVendorList
                                      //     .map((element) => element.toJson())
                                      //     .toList()
                                      //     .toString());

                                      //Claim featured coupon directly

                                      // showConfirmClaimDialogue(context,
                                      //     onpressed: () {
                                      //   KDialog.kShowDialog(
                                      //     context: context,
                                      //     dialogContent: Dialog(
                                      //       shape: RoundedRectangleBorder(
                                      //           borderRadius:
                                      //               BorderRadius.circular(
                                      //                   15.0)), //this right here
                                      //       child: KCouponClaimCard(
                                      //         name: vendorController
                                      //             .featuredVendorList
                                      //             .firstWhere((element) =>
                                      //                 element.vendorName ==
                                      //                 couponController
                                      //                     .featured2CouponList
                                      //                     .elementAt(index)
                                      //                     .vendorName)
                                      //             .vendorName,
                                      //         percent: couponController
                                      //             .featured2CouponList
                                      //             .elementAt(index)
                                      //             .percentageOff,
                                      //         color: KColor.blueGreen,
                                      //         buttonText: "Claim This Coupon",
                                      //         date:
                                      //             "${couponController.featured2CouponList.elementAt(index).endDate.day}-${couponController.featured2CouponList.elementAt(index).endDate.month}-${couponController.featured2CouponList.elementAt(index).endDate.year}",
                                      //         // date:
                                      //         // "${couponController.vendorCouponList.elementAt(0).endDate.day}-${couponController.vendorCouponList.elementAt(0).endDate.month}-${couponController.vendorCouponList.elementAt(0).endDate.year}",
                                      //         //  couponController.vendorCouponList
                                      //         //     .elementAt(0)
                                      //         //     .endDate
                                      //         //     .toString(),
                                      //         image: couponController
                                      //             .featured2CouponList
                                      //             .elementAt(index)
                                      //             .vendorLogPath,
                                      //         couponCode: null,
                                      //         onPressed: () async {
                                      //           startLoading();
                                      //           int? result = await couponController
                                      //               .claimCoupon(
                                      //                   couponController
                                      //                       .featured2CouponList
                                      //                       .elementAt(index)
                                      //                       .couponId,
                                      //                   false);
                                      //           if (result == 200 ||
                                      //               result == 201) {
                                      //             stopLoading();
                                      //             Navigator.pop(context);
                                      //             KDialog.kShowDialog(
                                      //               context: context,
                                      //               dialogContent: Dialog(
                                      //                 shape: RoundedRectangleBorder(
                                      //                     borderRadius:
                                      //                         BorderRadius.circular(
                                      //                             15.0)), //this right here
                                      //                 child: Align(
                                      //                   alignment:
                                      //                       Alignment.center,
                                      //                   child: ConfettiWidget(
                                      //                     confettiController:
                                      //                         _controllerCenter,
                                      //                     blastDirectionality:
                                      //                         BlastDirectionality
                                      //                             .explosive, // don't specify a direction, blast randomly
                                      //                     shouldLoop:
                                      //                         false, // start again as soon as the animation is finished
                                      //                     colors: ConfettiHandler
                                      //                         .starColors, // manually specify the colors to be used
                                      //                     createParticlePath:
                                      //                         ConfettiHandler
                                      //                             .drawStar,
                                      //                     child:
                                      //                         KCouponClaimCard(
                                      //                       showGreyOut: true,
                                      //                       couponDetails: true,
                                      //                       name: couponController
                                      //                           .featured2CouponList
                                      //                           .elementAt(
                                      //                               index)
                                      //                           .vendorName,
                                      //                       percent: couponController
                                      //                           .featured2CouponList
                                      //                           .elementAt(
                                      //                               index)
                                      //                           .percentageOff,
                                      //                       color: KColor
                                      //                           .blueGreen,
                                      //                       buttonText:
                                      //                           "Coupon Claimed",
                                      //                       date: couponController
                                      //                           .featured2CouponList
                                      //                           .elementAt(
                                      //                               index)
                                      //                           .endDate
                                      //                           .toString(),
                                      //                       image: couponController
                                      //                           .featured2CouponList
                                      //                           .elementAt(
                                      //                               index)
                                      //                           .vendorLogPath,
                                      //                       //TODO:
                                      //                       couponCode: null,
                                      //                       onPressed: () {
                                      //                         // Navigator.of(context).pushAndRemoveUntil(
                                      //                         //     MaterialPageRoute(
                                      //                         //         builder: (context) =>
                                      //                         //         const KBottomNavigationBar()),
                                      //                         //         (Route<dynamic> route) => false);
                                      //                       },
                                      //                     ), // define a custom shape/path.
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //             );
                                      //             _controllerCenter.play();
                                      //           } else {
                                      //             stopLoading();
                                      //             snackMessage(
                                      //                 "Fail to claim coupon");
                                      //           }
                                      //         },
                                      //       ),
                                      //     ),
                                      //   );
                                      // });

                                      if (couponController
                                          .adminFeatureCouponsList.isEmpty) {
                                        await couponController
                                            .getAdminFeaturedCoupons();
                                      }

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ServiceDetailsScreen(
                                            color: KColor.blueGreen,
                                            vendorId: couponController
                                                .adminFeatureCouponsList
                                                .firstWhere((element) =>
                                                    element.couponId ==
                                                    couponController
                                                        .featured2CouponList
                                                        .elementAt(index)
                                                        .couponId)
                                                .vid,
                                          ),
                                        ),
                                      );
                                    },
                                    featuredCoupon: couponController
                                        .featured2CouponList
                                        .elementAt(index),
                                    percent: couponController
                                        .featured2CouponList
                                        .elementAt(index)
                                        .percentageOff,
                                    image: couponController.featured2CouponList
                                        .elementAt(index)
                                        .vendorLogPath,
                                    vid: couponController
                                        .adminFeatureCouponsList
                                        .firstWhere((element) =>
                                            element.couponId ==
                                            couponController.featured2CouponList
                                                .elementAt(index)
                                                .couponId)
                                        .vid,
                                    vendorName: couponController
                                        .featured2CouponList
                                        .elementAt(index)
                                        .vendorName,
                                    // vid: featured2CouponList,
                                    // .elementAt(index)
                                    // .v,
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
                                  if (categoryController.allCategory
                                          .elementAt(index)
                                          .categoryName ==
                                      "Featured") {
                                    log('Featured');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ServicesScreen(
                                          catId: categoryController.allCategory
                                              .elementAt(index)
                                              .cid,
                                          isFeatured: true,
                                          title: categoryController.allCategory
                                              .elementAt(index)
                                              .categoryName,
                                        ),
                                      ),
                                    );
                                  } else if (categoryController.allCategory
                                          .elementAt(index)
                                          .categoryName ==
                                      'Best of Logan') {
                                    launchUrl(Uri.parse(
                                        'https://thebestoflogan.com/'));
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ServicesScreen(
                                          catId: categoryController.allCategory
                                              .elementAt(index)
                                              .cid,
                                          title: categoryController.allCategory
                                              .elementAt(index)
                                              .categoryName,
                                          isFeatured: false,
                                        ),
                                      ),
                                    );
                                  }
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
                                              log('CATEGORY NAME;: ${categoryController.allCategory.elementAt(index).categoryName}');

                                              if (categoryController.allCategory
                                                      .elementAt(index)
                                                      .categoryName ==
                                                  "Featured") {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => ServicesScreen(
                                                            catId:
                                                                categoryController
                                                                    .allCategory
                                                                    .elementAt(
                                                                        index)
                                                                    .cid,
                                                            isFeatured: true,
                                                            title: categoryController
                                                                .allCategory
                                                                .elementAt(
                                                                    index)
                                                                .categoryName)));
                                              } else if (categoryController
                                                      .allCategory
                                                      .elementAt(index)
                                                      .categoryName ==
                                                  'Best of Logan') {
                                                launchUrl(Uri.parse(
                                                    'https://thebestoflogan.com/'));
                                              } else {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => ServicesScreen(
                                                            catId:
                                                                categoryController
                                                                    .allCategory
                                                                    .elementAt(
                                                                        index)
                                                                    .cid,
                                                            title: categoryController
                                                                .allCategory
                                                                .elementAt(
                                                                    index)
                                                                .categoryName)));
                                              }
                                            },
                                            child: Container(
                                              // width: 90,
                                              // height: 90,
                                              height:
                                                  context.screenHeight * 0.09,
                                              width: context.screenWidth * 0.18,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ServiceDetailsScreen(
                                        color: colors[0],
                                        vendorId: vendorController
                                            .featuredVendorList
                                            .elementAt(index)
                                            .vid)),
                              );
                            },
                            child: KBrandsCard(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ServiceDetailsScreen(
                                              color: colors[0],
                                              vendorId: vendorController
                                                  .featuredVendorList
                                                  .elementAt(index)
                                                  .vid)),
                                );
                              },
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ServiceDetailsScreen(
                                              color: colors[0],
                                              vendorId: vendorController
                                                  .featuredVendorList
                                                  .elementAt(index)
                                                  .vid)),
                                );
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
