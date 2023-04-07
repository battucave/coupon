import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_network/image_network.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/controllers/builder_ids/builder_ids.dart';
import 'package:logan/models/api/coupon_model.dart';
import 'package:logan/models/api/single_coupon_model.dart';
import 'package:logan/views/styles/b_style.dart';
import 'package:quiver/async.dart';

import '../../controllers/coupon_controller.dart';
import '../../controllers/vendor_controller.dart';
import '../../models/api/single_vendor_model.dart';
import 'k_button.dart';

class KCouponClaimCard extends StatefulWidget {
  const KCouponClaimCard(
      {Key? key,
      this.percent,
      this.color,
      this.date,
      this.image,
      this.name,
      this.buttonText,
      this.couponDetails = false,
      this.showGreyOut = false,
      this.onPressed,
      this.couponCode,
      this.coupon_id,
      this.vid})
      : super(key: key);

  final String? name;
  final String? image;
  final Color? color;
  final dynamic percent;
  final String? couponCode;
  final int? coupon_id;
  final int? vid;
  final String? date;
  final String? buttonText;
  final Function()? onPressed;
  final bool couponDetails;
  final bool? showGreyOut;

  @override
  State<KCouponClaimCard> createState() => _KCouponClaimCardState();
}

class _KCouponClaimCardState extends State<KCouponClaimCard> {
  CouponController couponController = Get.put(CouponController());
  VendorController vendorController = Get.put(VendorController());
  Future<SingleCouponModel> getCoupon() async {
    return await couponController.getCouponById(widget.coupon_id!);
  }

  Future<SingleVendorModel> getVendor() async {
    return await vendorController.getVendorProfileById(widget.vid!);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: widget.showGreyOut! ? Colors.grey : Colors.white,
          // color: KColor.blueGreen,
          // color: Colors.grey,
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: KColor.silver.withOpacity(0.2),
                blurRadius: 4,
                spreadRadius: 2)
          ]),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                  color: widget.color,
                  // color: Colors.grey,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Row(
                children: [
                  (widget.image == null)
                      ? StreamBuilder<SingleVendorModel>(
                          stream: getVendor().asStream(),
                          builder: (context,
                              AsyncSnapshot<SingleVendorModel> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else {
                              if (snapshot.hasData) {
                                return GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: 55.0,
                                      width: 55.0,

                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              snapshot.data!.vendorLogPath,
                                            ),
                                            fit: BoxFit.fill),
                                        shape: BoxShape.circle,
                                      ),
                                      // ImageNetwork(
                                      //   image: snapshot.data!.vendorLogPath,
                                      //   imageCache: CachedNetworkImageProvider(
                                      //     snapshot.data!.vendorLogPath,
                                      //   ),
                                      //   height: 55,
                                      //   width: 55,
                                      //   // duration: 1500,
                                      //   // curve: Curves.easeIn,
                                      //   onPointer: true,
                                      //   debugPrint: false,
                                      //   fullScreen: false,
                                      //   fitAndroidIos: BoxFit.cover,
                                      //   fitWeb: BoxFitWeb.cover,
                                      //   borderRadius: BorderRadius.circular(70),
                                      //   // onLoading: const CircularProgressIndicator(
                                      //   //   color: Colors.indigoAccent,
                                      //   // ),
                                      //   onError: const Icon(
                                      //     Icons.error,
                                      //     color: Colors.red,
                                      //   ),
                                      //   onTap: () {},
                                      // ),
                                      // );
                                    ));
                              } else {
                                return Container();
                              }
                            }
                          },
                        )
                      : Container(
                          height: 55.0,
                          width: 55.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  widget.image!,
                                ),
                                fit: BoxFit.fill),
                            shape: BoxShape.circle,
                          ),
                        ),

                  // ImageNetwork(
                  //     image: widget.image!,
                  //     imageCache: CachedNetworkImageProvider(widget.image!),
                  //     height: 55,
                  //     width: 55,
                  //     // duration: 1500,
                  //     // curve: Curves.easeIn,
                  //     onPointer: true,
                  //     debugPrint: false,
                  //     fullScreen: false,
                  //     fitAndroidIos: BoxFit.cover,
                  //     fitWeb: BoxFitWeb.scaleDown,
                  //     borderRadius: BorderRadius.circular(70),
                  //     // onLoading: const CircularProgressIndicator(
                  //     //   color: Colors.indigoAccent,
                  //     // ),
                  //     onError: const Icon(
                  //       Icons.error,
                  //       color: Colors.red,
                  //     ),
                  //     onTap: () {},
                  //   ),
                  SizedBox(width: KSize.getWidth(context, 10)),
                  (widget.name == null)
                      ? StreamBuilder<SingleVendorModel>(
                          stream: getVendor().asStream(),
                          builder: (context,
                              AsyncSnapshot<SingleVendorModel> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("");
                            } else {
                              if (snapshot.hasData) {
                                return Expanded(
                                  flex: 3,
                                  child: Text(
                                    snapshot.data!.vendorName,
                                    style: KTextStyle.headline4
                                        .copyWith(fontSize: 18),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }
                          },
                        )
                      : Expanded(
                          flex: 3,
                          child: Text(
                            widget.name!,
                            style: KTextStyle.headline4.copyWith(fontSize: 18),
                          ),
                        ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    //  Container(
                    //   height: 50,
                    //   width: 50,
                    //   decoration: const BoxDecoration(
                    //       color: Colors.red,
                    //       borderRadius: BorderRadius.all(Radius.circular(200))),
                    //   child: const Icon(
                    //     Icons.close,
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ),
                  SizedBox(width: KSize.getWidth(context, 5)),
                ],
              ),
            ),
            GetBuilder<CouponController>(
              id: kCouponClaimCardBuilder,
              builder: (controller) =>
                  // AnimatedOpacity(
                  // opacity:
                  //     widget.showGreyOut! && couponController.timeRemaining == 1
                  //         ? 0.4
                  //         : 1.0,
                  // duration: const Duration(milliseconds: 500),
                  // child:
                  Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.couponDetails
                          ? Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: widget.percent.toString(),
                                          style: KTextStyle.headline4.copyWith(
                                              fontSize: 25,
                                              color: KColor.orange),
                                          children: <TextSpan>[
                                            // TextSpan(
                                            //     text: 'OFF',
                                            //     style: KTextStyle.headline4
                                            //         .copyWith(
                                            //             fontSize: 18,
                                            //             color: KColor.orange)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: KSize.getHeight(context, 20),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Valid Thru: ',
                                          style: KTextStyle.headline2.copyWith(
                                              fontSize: 16,
                                              color: KColor.black),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: widget.date,
                                                style: KTextStyle.headline2
                                                    .copyWith(
                                                        fontSize: 14,
                                                        color: KColor.black
                                                            .withOpacity(0.3))),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset(AssetPath.couponSuccess,
                                    height: 75, width: 135)
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: widget.percent.toString(),
                                    style: KTextStyle.headline4.copyWith(
                                        fontSize: 25, color: KColor.orange),
                                    children: <TextSpan>[
                                      // TextSpan(
                                      //     text: 'OFF',
                                      //     style: KTextStyle.headline4.copyWith(
                                      //         fontSize: 18, color: KColor.orange)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: KSize.getHeight(context, 20),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Valid Thru: ',
                                    style: KTextStyle.headline2.copyWith(
                                        fontSize: 16, color: KColor.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: widget.date,
                                          style: KTextStyle.headline2.copyWith(
                                              fontSize: 14,
                                              color: KColor.black
                                                  .withOpacity(0.3))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: KSize.getHeight(context, 20),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Requirements: ',
                          style: KTextStyle.headline2
                              .copyWith(fontSize: 16, color: KColor.black),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    'Must be 18 years or older, must buy \$15 or more in merchandise, must have a moustache, must be able to touch your nose to your toes, must pay in red-headed children',
                                style: KTextStyle.headline2.copyWith(
                                    height: 25 / 14,
                                    fontSize: 14,
                                    color: KColor.black.withOpacity(0.3))),
                          ],
                        ),
                      ),
                    ],
                    // ),
                  ),
                ),
              ),
            ),
            widget.couponDetails
                ? GetBuilder<CouponController>(
                    id: kCouponClaimCardBuilder,
                    builder: (controller) => Container(
                        color: Colors.white,
                        child: TimerWidget(
                          couponId: widget.coupon_id,
                        )),
                  )
                : const SizedBox(),
            !widget.couponDetails
                ? GetBuilder<CouponController>(
                    id: kCouponClaimCardBuilder,
                    builder: (controller) => Container(
                      color: Colors.white,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "* Redeem code ONLY when asked at checkout",
                            style: TextStyle(
                              fontSize: 12,
                              color: KColor.orange,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            widget.couponDetails
                ? GetBuilder<CouponController>(
                    id: kCouponClaimCardBuilder,
                    builder: (controller) => Container(
                      width: Get.width,
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Redeem Code",
                            style: KTextStyle.headline2.copyWith(
                                fontSize: 18,
                                height: 25 / 18,
                                color: KColor.orange),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          (widget.couponCode != null)
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: KSize.getWidth(context, 33),
                                      vertical: KSize.getHeight(context, 8)),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: KColor.blue),
                                  child: Text(
                                    "${widget.couponCode}",
                                    style: KTextStyle.headline2.copyWith(
                                        fontSize: 18, height: 25 / 18),
                                  ),
                                )
                              :

                              ///To get coupon code using coupon Id, working on it
                              StreamBuilder<SingleCouponModel>(
                                  stream: getCoupon().asStream(),
                                  builder: (context,
                                      AsyncSnapshot<SingleCouponModel>
                                          snapshot) {
                                    if (snapshot.hasData) {
                                      print(snapshot.data!.couponCode);
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                KSize.getWidth(context, 33),
                                            vertical:
                                                KSize.getHeight(context, 8)),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: KColor.blue),
                                        child: Text(
                                          snapshot.data!.couponCode.toString(),
                                          style: KTextStyle.headline2.copyWith(
                                              fontSize: 18, height: 25 / 18),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        child: Text("jjjjj"),
                                      );
                                    }
                                  },
                                )
                        ],
                      ),
                    ),
                  )
                : Container(),
            GetBuilder<CouponController>(
              id: kCouponClaimCardBuilder,
              builder: (controller) => Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 22),
                  child: KButton(
                    isCoupon: true,
                    text: widget.buttonText,
                    onPressed: widget.onPressed,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({
    required this.couponId,
    Key? key,
  }) : super(key: key);

  final int? couponId;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  final int _start = 30;
  int _current = 30;

  final couponController = Get.find<CouponController>();

  late StreamSubscription<CountdownTimer> sub;

  @override
  void initState() {
    CountdownTimer countDownTimer = CountdownTimer(
      Duration(seconds: _start),
      const Duration(seconds: 1),
    );
    sub = countDownTimer.listen(null);
    startTimer();
    super.initState();
  }

  void startTimer() {
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
      });
    });

    sub.onDone(() async {
      Navigator.pop(context);
      if (widget.couponId != null) {
        final isSingleUse =
            await couponController.checkIfCouponSingleUse(widget.couponId!);
        if (isSingleUse) {
          log('SINGLE USE');
          await couponController.removeClaimedCoupon(
              couponId: widget.couponId!);
        }
      }
      sub.cancel();
    });
  }

  @override
  void dispose() {
    super.dispose();
    sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Row(
            children: [
              const Icon(
                Icons.timer_outlined,
                color: KColor.orange,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "00:00:${(_current).toString()}",
                style: const TextStyle(color: Colors.black),
              ),
            ],
          )
        ],
      ),
    );
  }
}
