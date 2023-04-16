import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_network/image_network.dart';
import 'package:logan/utils/extensions.dart';
import 'package:logan/views/screens/services/service_details_screen.dart';
import 'package:logan/views/styles/b_style.dart';

import '../../constant/asset_path.dart';
import '../../controllers/coupon_controller.dart';
import '../../controllers/vendor_controller.dart';
import '../../models/api/featured_coupon_model.dart';
import '../../models/api/single_vendor_model.dart';
import '../animation/confetti_handler.dart';
import 'confirm_coupon_dialogue.dart';
import 'k_coupon_claim_card.dart';
import 'k_dialog.dart';

class KFeaturedCarouselCard extends StatefulWidget {
  final String? percent;
  final String? image;
  final int? vid;
  final String? vendorName;
  final VoidCallback onTap;
  final FeaturedCouponModel? featuredCoupon;
  final VoidCallback? onImageTap;

  const KFeaturedCarouselCard(
      {Key? key,
      this.image,
      this.percent,
      this.vid,
      this.vendorName,
      this.featuredCoupon,
      this.onImageTap,
      required this.onTap})
      : super(key: key);

  @override
  State<KFeaturedCarouselCard> createState() => _KFeaturedCarouselCardState();
}

class _KFeaturedCarouselCardState extends State<KFeaturedCarouselCard> {
  VendorController vendorController = Get.put(VendorController());
  CouponController couponController = Get.find<CouponController>();
  Future<SingleVendorModel> getVendor() async {
    return await vendorController.getVendorProfileById(widget.vid!);
  }

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
    // TODO: implement initState
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
    return GestureDetector(
      //TODO: Old logic
      //  onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => ServiceDetailsScreen(
      //         color: KColor.blueGreen,
      //         vendorId: widget.vid!,
      //       ),
      //     ),
      //   );
      // },
      onTap: widget.onTap,
      child: Container(
          padding: const EdgeInsets.only(
            left: 5.0,
          ),
          width: context.screenWidth,
          decoration: const BoxDecoration(
              color: KColor.blueGreen,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.vendorName ?? "Discount",
                        style: KTextStyle.headline5.copyWith(fontSize: 30),
                      ),
                    ],
                  ),

                  SizedBox(
                    width: Get.width * 0.6,
                    child: Text(
                      '${widget.percent} % off',
                      style: KTextStyle.headline5.copyWith(fontSize: 24.0),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       "Click for details",
                  //       style: KTextStyle.headline5.copyWith(fontSize: 16.0),
                  //     ),
                  //   ],
                  // )
                ],
              ),
              const Spacer(),
              // Container(
              //   margin: const EdgeInsets.only(right: 20),
              //   child: widget.image!.isNotEmpty?
              //   ImageNetwork(
              //     image: widget.image!,
              //     imageCache: CachedNetworkImageProvider(widget.image!),
              //     height: 80,
              //     width: 80,
              //     duration: 1500,
              //     curve: Curves.easeIn,
              //     onPointer: true,
              //     debugPrint: false,
              //     fullScreen: false,
              //     fitAndroidIos: BoxFit.cover,
              //     fitWeb: BoxFitWeb.cover,
              //     borderRadius: BorderRadius.circular(400),
              //     onLoading: const CircularProgressIndicator(
              //       color: Colors.indigoAccent,
              //     ),
              //     onError: const Icon(
              //       Icons.error,
              //       color: Colors.red,
              //     ),
              //     onTap: () {
              //
              //     },
              //   ):   Image.asset(AssetPath.defaultImage, height: 100, width: 100,fit: BoxFit.contain,),
              // ),
              ///Need data in featured coupon to test this part
              // widget.vid!=null?StreamBuilder<SingleVendorModel>(
              //   stream: getVendor().asStream(),
              //   builder: (context, AsyncSnapshot<SingleVendorModel> snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const CircularProgressIndicator();
              //     }else{
              //       if(snapshot.hasData){
              //         return  Container(
              //           margin: const EdgeInsets.only(right: 20),
              //           child:ImageNetwork(
              //             image: snapshot.data!.vendorLogPath,
              //             height: 80,
              //             width: 80,
              //             duration: 1500,
              //             curve: Curves.easeIn,
              //             onPointer: true,
              //             debugPrint: false,
              //             fullScreen: false,
              //             fitAndroidIos: BoxFit.cover,
              //             fitWeb: BoxFitWeb.cover,
              //             borderRadius: BorderRadius.circular(70),
              //             onLoading: const CircularProgressIndicator(
              //               color: Colors.indigoAccent,
              //             ),
              //             onError: const Icon(
              //               Icons.error,
              //               color: Colors.red,
              //             ),
              //             onTap: () {
              //
              //             },
              //           ) ,
              //         );
              //
              //
              //       }else{
              //         return Container();
              //       }
              //     }
              //
              //   },
              // ):

              Container(
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ImageNetwork(
                  image: widget.image!,
                  imageCache: CachedNetworkImageProvider(widget.image!),
                  height: 90,
                  width: 90,
                  duration: 1500,
                  curve: Curves.easeIn,
                  onPointer: true,
                  debugPrint: false,
                  fullScreen: false,
                  fitAndroidIos: BoxFit.cover,
                  fitWeb: BoxFitWeb.cover,
                  borderRadius: BorderRadius.circular(70),
                  onLoading: const CircularProgressIndicator(
                    color: Colors.indigoAccent,
                  ),
                  onError: const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                  onTap: widget.onImageTap ??
                      () {
                        //CLAIM FEATURE COUPON DIRECTLY

                        // showConfirmClaimDialogue(context, onpressed: () {
                        //   KDialog.kShowDialog(
                        //     context: context,
                        //     dialogContent: Dialog(
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(
                        //               15.0)), //this right here
                        //       child: KCouponClaimCard(
                        //         name: widget.vendorName,
                        //         percent: widget.percent,
                        //         color: KColor.blueGreen,
                        //         buttonText: "Claim This Coupon",
                        //         date:
                        //             "${widget.featuredCoupon!.endDate.day}-${widget.featuredCoupon!.endDate.month}-${widget.featuredCoupon!.endDate.year}",
                        //         // date:
                        //         // "${couponController.vendorCouponList.elementAt(0).endDate.day}-${couponController.vendorCouponList.elementAt(0).endDate.month}-${couponController.vendorCouponList.elementAt(0).endDate.year}",
                        //         //  couponController.vendorCouponList
                        //         //     .elementAt(0)
                        //         //     .endDate
                        //         //     .toString(),
                        //         image: widget.image,
                        //         couponCode: null,
                        //         onPressed: () async {
                        //           startLoading();
                        //           int? result =
                        //               await couponController.claimCoupon(
                        //                   widget.featuredCoupon!.couponId,
                        //                   false);
                        //           if (result == 200 || result == 201) {
                        //             stopLoading();
                        //             Navigator.pop(context);
                        //             KDialog.kShowDialog(
                        //               context: context,
                        //               dialogContent: Dialog(
                        //                 shape: RoundedRectangleBorder(
                        //                     borderRadius: BorderRadius.circular(
                        //                         15.0)), //this right here
                        //                 child: Align(
                        //                   alignment: Alignment.center,
                        //                   child: ConfettiWidget(
                        //                     confettiController:
                        //                         _controllerCenter,
                        //                     blastDirectionality: BlastDirectionality
                        //                         .explosive, // don't specify a direction, blast randomly
                        //                     shouldLoop:
                        //                         false, // start again as soon as the animation is finished
                        //                     colors: ConfettiHandler
                        //                         .starColors, // manually specify the colors to be used
                        //                     createParticlePath:
                        //                         ConfettiHandler.drawStar,
                        //                     child: KCouponClaimCard(
                        //                       showGreyOut: true,
                        //                       couponDetails: true,
                        //                       name: widget.vendorName,
                        //                       percent: widget.percent,
                        //                       color: KColor.blueGreen,
                        //                       buttonText: "Coupon Claimed",
                        //                       date: widget
                        //                           .featuredCoupon!.endDate
                        //                           .toString(),
                        //                       image: widget.image,
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
                        //             snackMessage("Fail to claim coupon");
                        //           }
                        //         },
                        //       ),
                        //     ),
                        //   );
                        // });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ServiceDetailsScreen(
                              color: KColor.blueGreen,
                              vendorId: widget.vid!,
                            ),
                          ),
                        );
                      },
                ),
              ),
            ],
          )),
    );
  }
}
