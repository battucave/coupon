import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_network/image_network.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/models/api/coupon_model.dart';
import 'package:logan/models/api/single_coupon_model.dart';
import 'package:logan/views/styles/b_style.dart';

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
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: KColor.white,
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
                                  child: ImageNetwork(
                                    image: snapshot.data!.vendorLogPath,
                                    imageCache: CachedNetworkImageProvider(
                                      snapshot.data!.vendorLogPath,
                                    ),
                                    height: 55,
                                    width: 55,
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
                                    onTap: () {},
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }
                          },
                        )
                      : ImageNetwork(
                          image: widget.image!,
                          imageCache: CachedNetworkImageProvider(widget.image!),
                          height: 55,
                          width: 55,
                          duration: 1500,
                          curve: Curves.easeIn,
                          onPointer: true,
                          debugPrint: false,
                          fullScreen: false,
                          fitAndroidIos: BoxFit.cover,
                          fitWeb: BoxFitWeb.scaleDown,
                          borderRadius: BorderRadius.circular(70),
                          onLoading: const CircularProgressIndicator(
                            color: Colors.indigoAccent,
                          ),
                          onError: const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                          onTap: () {},
                        ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.couponDetails
                      ? Row(
                          children: [
                            Expanded(
                              child: Column(
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
                                          fontSize: 16, color: KColor.black),
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
                                          color:
                                              KColor.black.withOpacity(0.3))),
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
              ),
            ),
            widget.couponDetails
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: KSize.getWidth(context, 22)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(
                          "Redeem Code",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 18,
                              height: 25 / 18,
                              color: KColor.orange),
                        )),
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
                                  style: KTextStyle.headline2
                                      .copyWith(fontSize: 18, height: 25 / 18),
                                ),
                              )
                            :

                            ///To get coupon code using coupon Id, working on it
                            StreamBuilder<SingleCouponModel>(
                                stream: getCoupon().asStream(),
                                builder: (context,
                                    AsyncSnapshot<SingleCouponModel> snapshot) {
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
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 22),
              child: KButton(
                isCoupon: true,
                text: widget.buttonText,
                onPressed: widget.onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
