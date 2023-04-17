import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_network/image_network.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/controllers/coupon_controller.dart';
import 'package:logan/views/global_components/confirm_coupon_dialogue.dart';
import 'package:logan/views/global_components/k_back_button.dart';
import 'package:logan/views/global_components/k_bottom_navigation_bar.dart';
import 'package:logan/views/global_components/k_coupon_claim_card.dart';
import 'package:logan/views/global_components/k_dialog.dart';
import 'package:logan/views/global_components/k_services_man_card.dart';
import 'package:logan/views/screens/services/components/service_description_component.dart';
import 'package:logan/views/screens/services/vendor_service_screen.dart';
import 'package:logan/views/styles/b_style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../controllers/vendor_controller.dart';
import '../../animation/confetti_handler.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final String? name;
  final String? image;
  final String? category;
  final double? percent;
  final Color? color;
  final String? date;
  final int vendorId;

  const ServiceDetailsScreen(
      {Key? key,
      this.name,
      this.image,
      this.category,
      this.color,
      this.percent,
      this.date,
      required this.vendorId})
      : super(key: key);

  @override
  State<ServiceDetailsScreen> createState() => _ServicesDetailsScreenState();
}

class _ServicesDetailsScreenState extends State<ServiceDetailsScreen> {
  VendorController vendorController = Get.put(VendorController());
  CouponController couponController = Get.put(CouponController());

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
    vendorController.getVendorById(widget.vendorId);
    couponController.getCouponByVendorId(widget.vendorId);
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
    log('Service deatils screen ${couponController.vendorCouponList.length}');
    return Scaffold(
        body: GetX<VendorController>(
      init: VendorController(),
      builder: (controller) => controller.isLoading.value == true ||
              (controller.vendor.value.vendorName.isEmpty &&
                  controller.vendor.value.description.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: KSize.getHeight(context, 54),
                            bottom: KSize.getHeight(context, 25),
                            left: KSize.getWidth(context, 25)),
                        child: Row(
                          children: const [
                            KBackButton(),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: KColor.primary,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: KColor.black.withOpacity(0.16),
                                  blurRadius: 6,
                                  spreadRadius: 5)
                            ]),
                      ),
                      Positioned(
                          bottom: -60,
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white
                                //     boxShadow: [
                                //   BoxShadow(
                                //       color: KColor.black.withOpacity(0.25),
                                //       blurRadius: 4,
                                //       offset: const Offset(0, 4))
                                // ]
                                ),
                            child: controller
                                    .vendor.value.vendorLogPath.isNotEmpty
                                ? ImageNetwork(
                                    image:
                                        controller.vendor.value.vendorLogPath,
                                    imageCache: CachedNetworkImageProvider(
                                        vendorController
                                            .vendor.value.vendorLogPath),
                                    height: 124,
                                    width: 124,
                                    duration: 1500,
                                    curve: Curves.easeIn,
                                    onPointer: true,
                                    debugPrint: false,
                                    fullScreen: false,
                                    fitAndroidIos: BoxFit.scaleDown,
                                    fitWeb: BoxFitWeb.scaleDown,
                                    borderRadius: BorderRadius.circular(70),
                                    onLoading: const CircularProgressIndicator(
                                      color: Colors.indigoAccent,
                                    ),
                                    onError: const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  )
                                : const CircularProgressIndicator(),

                            // Image.asset(widget.image!, height: 114, width: 114),
                          ))
                    ],
                  ),
                  const SizedBox(height: 70),
                  Center(
                    child: Text(
                      controller.vendor.value.vendorName,
                      style: KTextStyle.headline2
                          .copyWith(fontSize: 20, color: KColor.black),
                    ),
                  ),
                  Center(
                    child: Text(
                      controller.vendor.value.requirements,
                      style: KTextStyle.headline2
                          .copyWith(fontSize: 13, color: KColor.primary),
                    ),
                  ),
                  SizedBox(height: KSize.getHeight(context, 20)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: KSize.getWidth(context, 25)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   "Name of Company",
                        //   style: KTextStyle.headline4
                        //       .copyWith(fontSize: 18, color: KColor.black),
                        // ),
                        // const SizedBox(height: 7),
                        RichText(
                          text: TextSpan(
                            text: controller.vendor.value.description,
                            style: KTextStyle.headline2.copyWith(
                                fontSize: 14,
                                color: KColor.black.withOpacity(0.5)),
                            children: <TextSpan>[
                              // TextSpan(
                              //     text: '  See More....',
                              //     style: KTextStyle.headline4
                              //         .copyWith(fontSize: 14, color: KColor.orange),
                              //     recognizer: TapGestureRecognizer()..onTap = () {}),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   margin: const EdgeInsets.symmetric(vertical: 25),
                  //   width: double.infinity,
                  //   height: 1,
                  //   color: KColor.silver.withOpacity(0.3),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: KSize.getWidth(context, 25)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Best of Logan Picks",
                          style: KTextStyle.headline4.copyWith(
                              fontSize: 18, color: const Color(0xff0E5E71)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          vendorController.vendor.value.best_of_logan_picks ??
                              "",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 14,
                              color: KColor.black.withOpacity(0.5)),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 25),
                    width: double.infinity,
                    height: 1,
                    color: KColor.silver.withOpacity(0.3),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(children: [
                      ServiceDescriptionComponent(
                        title: "",
                        subtitle: vendorController.vendor.value.hours,
                        image: AssetPath.clock,
                        tapState: TapState.other,
                      ),

                      //subtitle: "123 somewhere pl, Logan, Ut 12345",
                      vendorController.vendor.value.state.isNotEmpty ||
                              vendorController.vendor.value.city.isNotEmpty
                          ? ServiceDescriptionComponent(
                              title: "",
                              subtitle: vendorController.vendor.value.street1 +
                                  "\n" +
                                  vendorController.vendor.value.state +
                                  " " +
                                  vendorController.vendor.value.city +
                                  " " +
                                  vendorController.vendor.value.zipCode,
                              image: AssetPath.address,
                              tapState: TapState.address,
                            )
                          : const SizedBox(),
                      vendorController.vendor.value.phone.isNotEmpty
                          ? ServiceDescriptionComponent(
                              title: "",
                              subtitle: vendorController.vendor.value.phone,
                              image: AssetPath.phone1,
                              tapState: TapState.phone,
                            )
                          : const SizedBox(),
                      vendorController.vendor.value.email.isNotEmpty
                          ? ServiceDescriptionComponent(
                              title: "",
                              subtitle: vendorController.vendor.value.email,
                              image: AssetPath.mail,
                              tapState: TapState.email,
                            )
                          : const SizedBox(),
                      vendorController.vendor.value.website.isNotEmpty
                          ? ServiceDescriptionComponent(
                              title: "",
                              subtitle:
                                  '${vendorController.vendor.value.website}/',
                              image: AssetPath.website,
                              tapState: TapState.website,
                            )
                          : const SizedBox(),
                    ]),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Row(
                      // spacing: 20,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // alignment: WrapAlignment.center,
                      children: [
                        vendorController.vendor.value.instagram != null &&
                                vendorController
                                    .vendor.value.instagram!.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (vendorController
                                            .vendor.value.instagram !=
                                        null) {
                                      await launchUrlString(checkHttpsProtocol(
                                          vendorController
                                              .vendor.value.instagram!));
                                    }
                                  },
                                  child: const FaIcon(
                                    FontAwesomeIcons.instagram,
                                    color: Colors.redAccent,
                                    size: 34,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        vendorController.vendor.value.facebook != null &&
                                vendorController
                                    .vendor.value.facebook!.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (vendorController
                                            .vendor.value.facebook !=
                                        null) {
                                      await launchUrlString(checkHttpsProtocol(
                                          vendorController
                                              .vendor.value.facebook!));
                                    }
                                  },
                                  child: const FaIcon(
                                    FontAwesomeIcons.facebook,
                                    color: Colors.blue,
                                    size: 34,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        vendorController.vendor.value.youtube != null &&
                                vendorController
                                    .vendor.value.youtube!.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (vendorController.vendor.value.youtube !=
                                        null) {
                                      await launchUrlString(checkHttpsProtocol(
                                          vendorController
                                              .vendor.value.youtube!));
                                    }
                                  },
                                  child: const FaIcon(
                                    FontAwesomeIcons.youtube,
                                    color: Colors.red,
                                    size: 34,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        vendorController.vendor.value.twitter != null &&
                                vendorController
                                    .vendor.value.twitter!.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (vendorController.vendor.value.twitter !=
                                        null) {
                                      await launchUrlString(checkHttpsProtocol(
                                          vendorController
                                              .vendor.value.twitter!));
                                    }
                                  },
                                  child: const FaIcon(
                                    FontAwesomeIcons.twitter,
                                    color: Colors.blue,
                                    size: 34,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 25),
                    width: double.infinity,
                    height: 1,
                    color: KColor.silver.withOpacity(0.3),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Coupons",
                          style: KTextStyle.headline2.copyWith(
                              fontWeight: FontWeight.w600, color: KColor.black),
                        ),
                        couponController.vendorCouponList.length > 1
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VendorServiceSreen(
                                                name: vendorController
                                                    .vendor.value.vendorName,
                                                image: vendorController
                                                    .vendor.value.vendorLogPath,
                                                vid: widget.vendorId,
                                              )));
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: KColor.primary.withOpacity(0.15),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "See All",
                                        style: KTextStyle.headline2.copyWith(
                                            fontSize: 14, color: KColor.orange),
                                      ),
                                      const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: KColor.orange,
                                          size: 15)
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                  Container(
                    child: Obx(
                      () => couponController.vendorCouponList.isNotEmpty
                          ? couponController.vendorCouponList
                                  .elementAt(0)
                                  .isActive
                              ? Column(
                                  children: List.generate(1, (index) {
                                    return KServicesManCard(
                                      name: vendorController
                                          .vendor.value.vendorName,
                                      image: vendorController
                                          .vendor.value.vendorLogPath,
                                      buttonText: "Claim This Coupon",
                                      date: couponController.vendorCouponList
                                          .elementAt(0)
                                          .endDate
                                          .toString(),
                                      color: widget.color,
                                      percent: couponController.vendorCouponList
                                          .elementAt(0)
                                          .percentageOff,
                                      vid: vendorController.vendor.value.vid,
                                      onPressed: () {
                                        log('CLAIM COUPON:::');
                                        showConfirmClaimDialogue(context,
                                            onpressed: () {
                                          KDialog.kShowDialog(
                                            context: context,
                                            dialogContent: Dialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0)), //this right here
                                              child: KCouponClaimCard(
                                                name: vendorController
                                                    .vendor.value.vendorName,
                                                percent: couponController
                                                    .vendorCouponList
                                                    .elementAt(0)
                                                    .percentageOff,
                                                color: widget.color,
                                                buttonText: "Claim This Coupon",
                                                date:
                                                    "${couponController.vendorCouponList.elementAt(0).endDate.day}-${couponController.vendorCouponList.elementAt(0).endDate.month}-${couponController.vendorCouponList.elementAt(0).endDate.year}",
                                                //  couponController.vendorCouponList
                                                //     .elementAt(0)
                                                //     .endDate
                                                //     .toString(),
                                                image: vendorController
                                                    .vendor.value.vendorLogPath,
                                                couponCode: couponController
                                                    .vendorCouponList
                                                    .elementAt(0)
                                                    .couponCode,
                                                onPressed: () async {
                                                  startLoading();
                                                  int? result =
                                                      await couponController
                                                          .claimCoupon(
                                                              couponController
                                                                  .vendorCouponList
                                                                  .elementAt(0)
                                                                  .couponId,
                                                              false);
                                                  if (result == 200 ||
                                                      result == 201) {
                                                    stopLoading();
                                                    Navigator.pop(context);
                                                    KDialog.kShowDialog(
                                                      context: context,
                                                      dialogContent: Dialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0)), //this right here
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: ConfettiWidget(
                                                            confettiController:
                                                                _controllerCenter,
                                                            blastDirectionality:
                                                                BlastDirectionality
                                                                    .explosive, // don't specify a direction, blast randomly
                                                            shouldLoop:
                                                                false, // start again as soon as the animation is finished
                                                            colors: ConfettiHandler
                                                                .starColors, // manually specify the colors to be used
                                                            createParticlePath:
                                                                ConfettiHandler
                                                                    .drawStar,
                                                            child:
                                                                KCouponClaimCard(
                                                              showGreyOut: true,
                                                              couponDetails:
                                                                  true,
                                                              name: vendorController
                                                                  .vendor
                                                                  .value
                                                                  .vendorName,
                                                              percent: couponController
                                                                  .vendorCouponList
                                                                  .elementAt(0)
                                                                  .percentageOff,
                                                              color:
                                                                  widget.color,
                                                              buttonText:
                                                                  "Coupon Claimed",
                                                              date: couponController
                                                                  .vendorCouponList
                                                                  .elementAt(0)
                                                                  .endDate
                                                                  .toString(),
                                                              image: vendorController
                                                                  .vendor
                                                                  .value
                                                                  .vendorLogPath,
                                                              couponCode:
                                                                  couponController
                                                                      .vendorCouponList
                                                                      .elementAt(
                                                                          0)
                                                                      .couponCode,
                                                              onPressed: () {
                                                                // Navigator.of(context).pushAndRemoveUntil(
                                                                //     MaterialPageRoute(
                                                                //         builder: (context) =>
                                                                //         const KBottomNavigationBar()),
                                                                //         (Route<dynamic> route) => false);
                                                              },
                                                            ), // define a custom shape/path.
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                    _controllerCenter.play();
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
                                      onProfilePressed: () {},
                                    );
                                  }),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    SizedBox(height: 60),
                                    Center(
                                      child: Text(
                                        "No coupon to display",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    )
                                  ],
                                )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                SizedBox(height: 60),
                                Center(
                                  child: Text(
                                    "No coupon to display",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 50)
                ],
              ),
            ),
    ));
  }

  String checkHttpsProtocol(String url) {
    if (url.startsWith("http")) {
      return url;
    } else {
      return "https://$url";
    }
  }
}
