import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_network/image_network.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/views/animation/confetti_handler.dart';
import 'package:logan/views/global_components/confirm_coupon_dialogue.dart';
import 'package:logan/views/screens/services/service_details_screen.dart';

import '../../../../controllers/coupon_controller.dart';
import '../../../controllers/category_controller.dart';
import '../../../controllers/vendor_controller.dart';
import '../../global_components/k_back_button.dart';
import '../../global_components/k_coupon_claim_card.dart';
import '../../global_components/k_dialog.dart';
import '../../global_components/k_services_man_card.dart';
import '../../global_components/k_text_field.dart';
import '../../styles/k_colors.dart';
import '../../styles/k_size.dart';
import '../../styles/k_text_style.dart';

class ServicesScreen extends StatefulWidget {
  final int catId;
  final bool isFeatured;
  final String title;
  const ServicesScreen(
      {Key? key,
      required this.catId,
      this.isFeatured = false,
      required this.title})
      : super(key: key);

  @override
  _ServicesScreen createState() => _ServicesScreen();
}

class _ServicesScreen extends State<ServicesScreen> {
  TextEditingController searchController = TextEditingController();
  List<Color> couponColors = [
    const Color(0xFFE8804B),
    const Color(0xFF30C3CD),
    const Color(0xFF1697B7),
  ];
  int _currentIndex = 0;
  int _currentSubCatId = 1;

  bool visible = true;

  CategoryController categoryController = Get.put(CategoryController());
  VendorController vendorController = Get.put(VendorController());
  CouponController couponController = Get.put(CouponController());

  ScrollController scrollController = ScrollController();

  void _scrollListener() {
    setState(() {
      scrollOffset = scrollController.offset;
      discoverOpacity = ((scrollController.offset - 216) / -58).clamp(0.0, 1.0);
    });
  }

  late ConfettiController _controllerCenter;
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;
  late ConfettiController _controllerTopCenter;
  late ConfettiController _controllerBottomCenter;

  double scrollOffset = 0.0;
  double discoverOpacity = 1.0;
  double cPadding = 16.0;
  double cBottomNavigationBarCurve = 24.0;
  double cBottomNavigationBarOptionSize = 78.0;
  Color cBottomNavigationBarOptionColor = const Color(0xFFD3D3E8);
  double? cFloatingActionButtonHeight;

  void snackMessage(String msg) {
    final snackBar = SnackBar(
        content: Text(msg), duration: const Duration(milliseconds: 3000));
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

  @override
  void initState() {
    if (!widget.isFeatured) {
      categoryController.getSubCategory(widget.catId).then((value) => {
            if (categoryController.subCategory.isNotEmpty)
              {
                couponController.getCouponBySubCategory(widget.catId,
                    categoryController.subCategory.elementAt(0).scid),
              }
          });
    } else {
      couponController.getFeaturedCoupon();
    }
    couponController.getFeaturedCoupon();
    scrollController.addListener(_scrollListener);
    cFloatingActionButtonHeight =
        (cBottomNavigationBarOptionSize - (cBottomNavigationBarCurve / 2)) +
            (cBottomNavigationBarOptionSize / 2);
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
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    _controllerCenter.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("here");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KColor.white,
        elevation: 0,
        leading: Padding(
            padding: const EdgeInsets.all(10),
            child: KBackButton(
                bgColor: KColor.black.withOpacity(0.1),
                iconColor: KColor.black)),
        centerTitle: true,
        title: Text(
          widget.title,
          style: KTextStyle.headline2
              .copyWith(fontSize: 22, color: KColor.blueSapphire),
        ),
      ),
      body: CustomScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      KTextField(
                        prefixIcon:
                            const Icon(Icons.search, color: KColor.black),
                        hintText: "Search",
                        controller: searchController,
                        onChanged: (value) {
                          if (widget.isFeatured) {
                            couponController.seachFeaturedCoupon(value);
                            setState(() {});
                          } else {
                            couponController.seachCoupon(value);
                            setState(() {});
                          }
                        },
                      ),
                      const SizedBox(height: 25),
                      if (!widget.isFeatured)
                        Obx(
                          () => SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Row(
                              children: List.generate(
                                  categoryController.subCategory.length,
                                  (index) {
                                if (categoryController
                                    .subCategory[index].subCategoryName
                                    .startsWith("Default-")) {
                                  return const SizedBox.shrink();
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _currentIndex = index;
                                        _currentSubCatId = categoryController
                                            .subCategory
                                            .elementAt(index)
                                            .scid;
                                        print("HERE");
                                        print(_currentSubCatId);
                                        couponController.getCouponBySubCategory(
                                            widget.catId, _currentSubCatId);
                                        //couponController.getFilteredCoupons(_currentSubCatId);
                                        // couponController.getCouponBySubCategory(_currentSubCatId);
                                        setState(() {});
                                        // couponController.getCouponBySubCategory(_currentSubCatId);
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: KColor.white,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: KColor.orange
                                                    .withOpacity(0.1)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: KColor.black
                                                      .withOpacity(0.16),
                                                  blurRadius: 6)
                                            ],
                                          ),
                                          child: ImageNetwork(
                                            image: categoryController
                                                .subCategory
                                                .elementAt(index)
                                                .subCategoryLogoPath,
                                            imageCache:
                                                CachedNetworkImageProvider(
                                                    categoryController
                                                        .subCategory
                                                        .elementAt(index)
                                                        .subCategoryLogoPath),
                                            height: 23,
                                            width: 23,
                                            duration: 1500,
                                            curve: Curves.easeIn,
                                            onPointer: true,
                                            debugPrint: false,
                                            fullScreen: false,
                                            fitAndroidIos: BoxFit.cover,
                                            fitWeb: BoxFitWeb.cover,
                                            borderRadius:
                                                BorderRadius.circular(70),
                                            onLoading:
                                                const CircularProgressIndicator(
                                              color: Colors.indigoAccent,
                                            ),
                                            onError: const Icon(
                                              Icons.error,
                                              color: Colors.red,
                                            ),
                                            onTap: () {
                                              _currentIndex = index;
                                              _currentSubCatId =
                                                  categoryController.subCategory
                                                      .elementAt(index)
                                                      .scid;
                                              couponController
                                                  .getCouponBySubCategory(
                                                      widget.catId,
                                                      _currentSubCatId);
                                              // couponController.getFilteredCoupons(_currentSubCatId);
                                              // couponController.getCouponBySubCategory(_currentSubCatId);
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          categoryController.subCategory
                                              .elementAt(index)
                                              .subCategoryName,
                                          style: KTextStyle.headline2.copyWith(
                                              fontSize: 13,
                                              color: _currentIndex == index
                                                  ? KColor.orange
                                                  : KColor.primary),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: KSize.getHeight(context, 15),
                ),
                Opacity(
                  opacity: discoverOpacity,
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                  ),
                ),
              ],
            ),
          ),
          (!widget.isFeatured)
              ? Obx(
                  () =>
                      categoryController.subCategory.isNotEmpty &&
                              couponController.foundBySubCategory.isNotEmpty &&
                              couponController.vendorAndCouponList.isNotEmpty
                          ? SliverPadding(
                              padding: const EdgeInsets.all(0).add(
                                  EdgeInsets.only(
                                      bottom: cPadding +
                                          cFloatingActionButtonHeight!)),
                              sliver: SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                (BuildContext buildContext, int index) {
                                  const itemHeight = 220.0;
                                  const heightFactor = 0.8;
                                  final itemPositionOffset =
                                      index * itemHeight * heightFactor;
                                  final difference =
                                      (scrollOffset - 20) - itemPositionOffset;
                                  final percent = 1.0 -
                                      (difference /
                                          (itemHeight * heightFactor));
                                  final result = percent.clamp(0.0, 1.0);
                                  return Align(
                                    heightFactor: heightFactor,
                                    child: SizedBox(
                                      height: itemHeight,
                                      child: Transform.scale(
                                        scale: result,
                                        alignment: const Alignment(0.0, 0.56),
                                        child: Opacity(
                                          opacity: result,
                                          child: Obx(
                                            () => SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.7,
                                              child: KServicesManCard(
                                                onProfilePressed: () {
                                                  print("OK");
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ServiceDetailsScreen(
                                                                color: couponColors
                                                                    .elementAt(
                                                                        0),
                                                                vendorId: couponController
                                                                    .vendorAndCouponList
                                                                    .elementAt(
                                                                        index)
                                                                    .vendorId)),
                                                  );
                                                },
                                                name: couponController
                                                    .vendorAndCouponList
                                                    .elementAt(index)
                                                    .vendorName,
                                                // name: couponController
                                                //     .vendorAndCouponList
                                                //     .elementAt(index)
                                                //     .vendorName,
                                                image: couponController
                                                    .vendorAndCouponList
                                                    .elementAt(index)
                                                    .vendorLogPath,

                                                color: index % 2 == 0
                                                    ? couponColors.elementAt(0)
                                                    : couponColors.elementAt(1),
                                                percent: couponController
                                                        .vendorAndCouponList
                                                        .isNotEmpty
                                                    ? couponController
                                                        .vendorAndCouponList
                                                        .elementAt(index)
                                                        .percentageOff
                                                    :
                                                    // couponController.vendorAndCouponList.elementAt(index).vendorCouponsList.isNotEmpty?
                                                    // couponController.vendorAndCouponList.elementAt(index).vendorCouponsList.elementAt(0).percentageOff:
                                                    "0",
                                                date: couponController
                                                        .vendorAndCouponList
                                                        .isNotEmpty
                                                    ? couponController
                                                        .vendorAndCouponList
                                                        .elementAt(index)
                                                        .endDate
                                                        .toString()
                                                    :
                                                    // couponController.vendorAndCouponList.elementAt(index).vendorCouponsList.isNotEmpty?
                                                    // couponController.vendorAndCouponList.elementAt(0).vendorCouponsList.elementAt(0).endDate.toString():
                                                    "------------",
                                                vid: couponController
                                                    .vendorAndCouponList
                                                    .elementAt(index)
                                                    .vendorId,
                                                buttonText: "Claim Deal",
                                                onPressed: () {
                                                  showConfirmClaimDialogue(
                                                      context, onpressed: () {
                                                    log('CLAIM COUPON $index ${couponController.vendorAndCouponList.length}');
                                                    KDialog.kShowDialog(
                                                      context: context,
                                                      dialogContent: Dialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0)), //this right here
                                                        child: KCouponClaimCard(
                                                          name: couponController
                                                              .vendorAndCouponList
                                                              .elementAt(index)
                                                              .vendorName,
                                                          image: couponController
                                                              .vendorAndCouponList
                                                              .elementAt(index)
                                                              .vendorLogPath,
                                                          color: couponColors
                                                              .elementAt(0),
                                                          percent: couponController
                                                                  .vendorAndCouponList
                                                                  .isNotEmpty
                                                              ? couponController
                                                                  .vendorAndCouponList
                                                                  .elementAt(
                                                                      index)
                                                                  .percentageOff
                                                              :
                                                              // couponController.vendorAndCouponList.elementAt(index).vendorCouponsList.isNotEmpty?
                                                              // couponController.vendorAndCouponList.elementAt(index).vendorCouponsList.elementAt(0).percentageOff:
                                                              "0",
                                                          // date:
                                                          //TODO: uncomment

                                                          date: couponController
                                                                  .vendorAndCouponList
                                                                  .isNotEmpty
                                                              ? "${couponController.vendorCouponList.elementAt(index).endDate.day}-${couponController.vendorCouponList.elementAt(index).endDate.month}-${couponController.vendorCouponList.elementAt(index).endDate.year}"
                                                              //  couponController
                                                              //     .vendorAndCouponList
                                                              //     .elementAt(index)
                                                              //     .endDate
                                                              //     .toString()
                                                              :
                                                              // couponController.vendorAndCouponList.elementAt(index).vendorCouponsList.isNotEmpty?
                                                              // couponController.vendorAndCouponList.elementAt(0).vendorCouponsList.elementAt(0).endDate.toString():
                                                              "------------",
                                                          buttonText:
                                                              "Claim This Coupon",
                                                          onPressed: () async {
                                                            startLoading();

                                                            int? result = await couponController.claimCoupon(
                                                                couponController
                                                                    .vendorAndCouponList
                                                                    .elementAt(
                                                                        0)
                                                                    .couponId);
                                                            if (result == 200 ||
                                                                result == 201) {
                                                              stopLoading();
                                                              Navigator.pop(
                                                                  context);
                                                              KDialog
                                                                  .kShowDialog(
                                                                context:
                                                                    context,
                                                                dialogContent:
                                                                    StatefulBuilder(builder:
                                                                        (context,
                                                                            setState) {
                                                                  return Dialog(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15.0)), //this right here
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          ConfettiWidget(
                                                                        confettiController:
                                                                            _controllerCenter,
                                                                        blastDirectionality:
                                                                            BlastDirectionality.explosive, // don't specify a direction, blast randomly
                                                                        shouldLoop:
                                                                            false, // start again as soon as the animation is finished
                                                                        colors:
                                                                            ConfettiHandler.starColors, // manually specify the colors to be used
                                                                        createParticlePath:
                                                                            ConfettiHandler.drawStar,
                                                                        child:
                                                                            KCouponClaimCard(
                                                                          showGreyOut:
                                                                              true,
                                                                          couponDetails:
                                                                              true,
                                                                          coupon_id: couponController.vendorAndCouponList.isNotEmpty
                                                                              ? couponController.vendorAndCouponList.elementAt(0).couponId
                                                                              : 0,
                                                                          name: couponController
                                                                              .vendorAndCouponList
                                                                              .elementAt(index)
                                                                              .vendorName,
                                                                          image: couponController
                                                                              .vendorAndCouponList
                                                                              .elementAt(index)
                                                                              .vendorLogPath,
                                                                          color:
                                                                              couponColors.elementAt(0),
                                                                          percent: couponController.vendorAndCouponList.isNotEmpty
                                                                              ? couponController.vendorAndCouponList.elementAt(0).percentageOff
                                                                              : "0",
                                                                          date: couponController.vendorAndCouponList.isNotEmpty
                                                                              ? couponController.vendorAndCouponList.elementAt(0).endDate.toString()
                                                                              : "------------",
                                                                          buttonText:
                                                                              "Coupon Claimed",
                                                                          onPressed:
                                                                              () {},
                                                                        ), // define a custom shape/path.
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                              );
                                                              _controllerCenter
                                                                  .play();
                                                            } else {
                                                              stopLoading();
                                                              snackMessage(
                                                                  "Fail to claim coupon");
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                childCount:
                                    couponController.vendorAndCouponList.length,
                                addAutomaticKeepAlives: true,
                                addRepaintBoundaries: false,
                              )),
                            )
                          : SliverToBoxAdapter(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(height: 200),
                                  Center(
                                    child: Text(
                                      "No data to display",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                )
              : Obx(
                  () => couponController.foundFeaturedCouponList.isNotEmpty
                      ? SliverPadding(
                          padding: const EdgeInsets.all(0).add(EdgeInsets.only(
                              bottom: cPadding + cFloatingActionButtonHeight!)),
                          sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                            (BuildContext buildContext, int index) {
                              const itemHeight = 220.0;
                              const heightFactor = 0.8;
                              final itemPositionOffset =
                                  index * itemHeight * heightFactor;
                              final difference =
                                  (scrollOffset - 20) - itemPositionOffset;
                              final percent = 1.0 -
                                  (difference / (itemHeight * heightFactor));
                              final result = percent.clamp(0.0, 1.0);
                              return Align(
                                heightFactor: heightFactor,
                                child: SizedBox(
                                  height: itemHeight,
                                  child: Transform.scale(
                                    scale: result,
                                    alignment: const Alignment(0.0, 0.56),
                                    child: Opacity(
                                      opacity: result,
                                      child: Obx(
                                        () => SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.7,
                                          child: KServicesManCard(
                                            onProfilePressed: () {},
                                            name: couponController
                                                .foundFeaturedCouponList
                                                .elementAt(index)
                                                .vendorName,
                                            image: couponController
                                                .foundFeaturedCouponList
                                                .elementAt(index)
                                                .vendorLogPath,
                                            color: couponColors.elementAt(0),
                                            percent: couponController
                                                .foundFeaturedCouponList
                                                .elementAt(index)
                                                .percentageOff,
                                            date: couponController
                                                .foundFeaturedCouponList
                                                .elementAt(index)
                                                .endDate
                                                .toString(),
                                            buttonText: "Claim Deal",
                                            onPressed: () {
                                              KDialog.kShowDialog(
                                                context: context,
                                                dialogContent: Dialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0)), //this right here
                                                  child: KCouponClaimCard(
                                                    name: couponController
                                                        .foundFeaturedCouponList
                                                        .elementAt(index)
                                                        .vendorName,
                                                    image: couponController
                                                        .foundFeaturedCouponList
                                                        .elementAt(index)
                                                        .vendorLogPath,
                                                    color: couponColors
                                                        .elementAt(0),
                                                    percent: couponController
                                                        .foundFeaturedCouponList
                                                        .elementAt(index)
                                                        .percentageOff,
                                                    date:
                                                        "${couponController.foundFeaturedCouponList.elementAt(index).endDate.month}-${couponController.foundFeaturedCouponList.elementAt(index).endDate.day}-${couponController.foundFeaturedCouponList.elementAt(index).endDate.year}",
                                                    //  couponController
                                                    //     .foundFeaturedCouponList
                                                    //     .elementAt(index)
                                                    //     .endDate
                                                    //     .toString(),
                                                    coupon_id: couponController
                                                        .foundFeaturedCouponList
                                                        .elementAt(index)
                                                        .couponId,
                                                    buttonText:
                                                        "Claim This Coupon",
                                                    onPressed: () async {
                                                      showConfirmClaimDialogue(
                                                          context,
                                                          onpressed: () async {
                                                        startLoading();
                                                        int? result = await couponController
                                                            .claimCoupon(
                                                                couponController
                                                                    .foundFeaturedCouponList
                                                                    .elementAt(
                                                                        index)
                                                                    .couponId);
                                                        if (result == 200 ||
                                                            result == 201) {
                                                          stopLoading();
                                                          Navigator.pop(
                                                              context);
                                                          KDialog.kShowDialog(
                                                            context: context,
                                                            dialogContent:
                                                                Dialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.0)), //this right here
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    ConfettiWidget(
                                                                  confettiController:
                                                                      _controllerCenter,
                                                                  blastDirectionality:
                                                                      BlastDirectionality
                                                                          .explosive, // don't specify a direction, blast randomly
                                                                  shouldLoop:
                                                                      true, // start again as soon as the animation is finished
                                                                  colors: ConfettiHandler
                                                                      .starColors, // manually specify the colors to be used
                                                                  createParticlePath:
                                                                      ConfettiHandler
                                                                          .drawStar,
                                                                  child:
                                                                      KCouponClaimCard(
                                                                    showGreyOut:
                                                                        true,
                                                                    couponDetails:
                                                                        true,
                                                                    name: couponController
                                                                        .foundFeaturedCouponList
                                                                        .elementAt(
                                                                            index)
                                                                        .vendorName,
                                                                    image: couponController
                                                                        .foundFeaturedCouponList
                                                                        .elementAt(
                                                                            index)
                                                                        .vendorLogPath,
                                                                    color: couponColors
                                                                        .elementAt(
                                                                            0),
                                                                    percent: couponController
                                                                        .foundFeaturedCouponList
                                                                        .elementAt(
                                                                            index)
                                                                        .percentageOff,
                                                                    date: couponController
                                                                        .foundFeaturedCouponList
                                                                        .elementAt(
                                                                            index)
                                                                        .endDate
                                                                        .toString(),
                                                                    coupon_id: couponController
                                                                        .foundFeaturedCouponList
                                                                        .elementAt(
                                                                            index)
                                                                        .couponId,
                                                                    buttonText:
                                                                        "Coupon Claimed",
                                                                    onPressed:
                                                                        () {},
                                                                  ), // define a custom shape/path.
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                          _controllerCenter
                                                              .play();
                                                        } else {
                                                          stopLoading();
                                                          KDialog.kShowDialog(
                                                            context: context,
                                                            dialogContent:
                                                                Dialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.0)), //this right here
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: KColor
                                                                        .white,
                                                                    borderRadius: BorderRadius.circular(15),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          color: KColor.silver.withOpacity(
                                                                              0.2),
                                                                          blurRadius:
                                                                              4,
                                                                          spreadRadius:
                                                                              2)
                                                                    ]),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              100,
                                                                          top:
                                                                              15,
                                                                          bottom:
                                                                              15),
                                                                      decoration: const BoxDecoration(
                                                                          color: KColor
                                                                              .orange,
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(15),
                                                                              topRight: Radius.circular(15))),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          30,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          "Coupon Already Claimed",
                                                                          style: KTextStyle.headline2.copyWith(
                                                                              fontSize: 18,
                                                                              color: Colors.black),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          30,
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            44,
                                                                        width:
                                                                            150,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          color:
                                                                              KColor.orange,
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(10)),
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "OK",
                                                                            style:
                                                                                KTextStyle.headline2.copyWith(fontSize: 16, color: Colors.white),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          30,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                          //snackMessage("Fail to claim coupon");
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount:
                                couponController.foundFeaturedCouponList.length,
                            addAutomaticKeepAlives: true,
                            addRepaintBoundaries: false,
                          )),
                        )
                      : SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(height: 200),
                              Center(
                                child: Text(
                                  "No data to display",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                        ),
                ),
        ],
      ),
    );
  }
}
