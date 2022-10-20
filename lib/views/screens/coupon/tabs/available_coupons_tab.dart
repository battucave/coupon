import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/views/animation/confetti_handler.dart';
import '../../../../controllers/coupon_controller.dart';
import '../../../global_components/k_coupon_claim_card.dart';
import '../../../global_components/k_dialog.dart';
import '../../../global_components/k_services_man_card.dart';
import '../../../styles/k_colors.dart';
import '../../../styles/k_text_style.dart';
import '../../services/service_details_screen.dart';

class AvailableCouponsTab extends StatefulWidget {
  const AvailableCouponsTab({Key? key}) : super(key: key);

  @override
  _AvailableCouponsTabState createState() => _AvailableCouponsTabState();
}

class _AvailableCouponsTabState extends State<AvailableCouponsTab> {
  ScrollController scrollController = ScrollController();
  double scrollOffset = 0.0;
  double discoverOpacity = 1.0;
  double cPadding = 16.0;
  double cBottomNavigationBarCurve = 24.0;
  double cBottomNavigationBarOptionSize = 78.0;
  Color cBottomNavigationBarOptionColor = const Color(0xFFD3D3E8);
  double? cFloatingActionButtonHeight;
  void _scrollListener() {
    setState(() {
      scrollOffset = scrollController.offset;
      discoverOpacity = ((scrollController.offset - 216) / -58).clamp(0.0, 1.0);
    });
  }

  List<Color> couponColors = [
    const Color(0xFFE8804B),
    const Color(0xFF30C3CD),
    const Color(0xFF1697B7),
  ];
  CouponController couponController = Get.put(CouponController());
  late ConfettiController _controllerCenter;
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;
  late ConfettiController _controllerTopCenter;
  late ConfettiController _controllerBottomCenter;

  /// A custom Path to paint stars.
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
    scrollController.addListener(_scrollListener);
    cFloatingActionButtonHeight =
        (cBottomNavigationBarOptionSize - (cBottomNavigationBarCurve / 2)) +
            (cBottomNavigationBarOptionSize / 2);
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Opacity(
                opacity: discoverOpacity,
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: SizedBox(
                    height: 30.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => couponController.allCoupon.isNotEmpty
              ? SliverPadding(
                  padding: const EdgeInsets.all(0).add(EdgeInsets.only(
                      bottom: cPadding + cFloatingActionButtonHeight!)),
                  sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext buildContext, int index) {
                    const itemHeight = 210.0;
                    const heightFactor = 0.86;
                    final itemPositionOffset =
                        index * itemHeight * heightFactor;
                    final difference = (scrollOffset - 20) - itemPositionOffset;
                    final percent =
                        1.0 - (difference / (itemHeight * heightFactor));
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
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: KServicesManCard(
                                  //name: couponController.allCoupon.elementAt(index).couponCode,
                                  onProfilePressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ServiceDetailsScreen(
                                                //name:  couponController.allCoupon.elementAt(index).couponCode,
                                                //image: couponAvailable[0].image,
                                                color: couponColors.elementAt(
                                                    Random().nextInt(
                                                        couponColors.length)),
                                                percent: couponController
                                                    .allCoupon
                                                    .elementAt(index)
                                                    .percentageOff,
                                                date: couponController.allCoupon
                                                    .elementAt(index)
                                                    .endDate
                                                    .toString(),
                                                vendorId: couponController
                                                    .allCoupon
                                                    .elementAt(index)
                                                    .vid,
                                              )),
                                    );
                                  },
                                  color: index % 2 == 0
                                      ? couponColors.elementAt(0)
                                      : couponColors.elementAt(1),
                                  percent: couponController.allCoupon
                                      .elementAt(index)
                                      .percentageOff,
                                  date: couponController.allCoupon
                                      .elementAt(index)
                                      .endDate
                                      .toString(),
                                  vid: couponController.allCoupon
                                      .elementAt(index)
                                      .vid,
                                  buttonText: "Claim Deal",
                                  onPressed: () {
                                    KDialog.kShowDialog(
                                      context: context,
                                      dialogContent: Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                15.0)), //this right here
                                        child: KCouponClaimCard(
                                          percent: couponController.allCoupon
                                              .elementAt(index)
                                              .percentageOff,
                                          color: couponColors.elementAt(Random()
                                              .nextInt(couponColors.length)),
                                          buttonText: "Claim Deal",
                                          date:
                                              "${couponController.allCoupon.elementAt(index).endDate.month}-${couponController.allCoupon.elementAt(index).endDate.day}-${couponController.allCoupon.elementAt(index).endDate.year}",
                                          // couponController.allCoupon
                                          //     .elementAt(index)
                                          //     .endDate
                                          //     .toString(),
                                          vid: couponController.allCoupon
                                              .elementAt(index)
                                              .vid,
                                          onPressed: () async {
                                            //startLoading();
                                            //Navigator.pop(context);
                                            startLoading();
                                            int? result = await couponController
                                                .claimCoupon(couponController
                                                    .allCoupon
                                                    .elementAt(index)
                                                    .couponId);
                                            if (result == 200 ||
                                                result == 201) {
                                              stopLoading();
                                              Navigator.pop(context);
                                              KDialog.kShowDialog(
                                                context: context,
                                                dialogContent: Dialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0)), //this right here
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: ConfettiWidget(
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
                                                      child: KCouponClaimCard(
                                                        couponDetails: true,
                                                        percent:
                                                            couponController
                                                                .allCoupon
                                                                .elementAt(
                                                                    index)
                                                                .percentageOff,
                                                        color: couponColors
                                                            .elementAt(Random()
                                                                .nextInt(
                                                                    couponColors
                                                                        .length)),
                                                        buttonText:
                                                            "Coupon Claimed",
                                                        date: couponController
                                                            .allCoupon
                                                            .elementAt(index)
                                                            .endDate
                                                            .toString(),
                                                        couponCode:
                                                            couponController
                                                                .allCoupon
                                                                .elementAt(
                                                                    index)
                                                                .couponCode,
                                                        vid: couponController
                                                            .allCoupon
                                                            .elementAt(index)
                                                            .vid,
                                                        onPressed: () {},
                                                      ), // define a custom shape/path.
                                                    ),
                                                  ),
                                                ),
                                              );
                                              _controllerCenter.play();
                                            } else {
                                              stopLoading();
                                              KDialog.kShowDialog(
                                                context: context,
                                                dialogContent: Dialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0)), //this right here
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: KColor.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: KColor
                                                                  .silver
                                                                  .withOpacity(
                                                                      0.2),
                                                              blurRadius: 4,
                                                              spreadRadius: 2)
                                                        ]),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 100,
                                                                  top: 15,
                                                                  bottom: 15),
                                                          decoration: const BoxDecoration(
                                                              color:
                                                                  KColor.orange,
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          15),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          15))),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 30,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Coupon Already Claimed",
                                                              style: KTextStyle
                                                                  .headline2
                                                                  .copyWith(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .black),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 30,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () async {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                            height: 44,
                                                            width: 150,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  KColor.orange,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "OK",
                                                                style: KTextStyle
                                                                    .headline2
                                                                    .copyWith(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 30,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );

                                              ///snackMessage("Fail to claim coupon");

                                            }
                                          },
                                        ),
                                      ),
                                    );

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => ServiceDetailsScreen(
                                    //         //name:  couponController.allCoupon.elementAt(index).couponCode,
                                    //         //image: couponAvailable[0].image,
                                    //         color:  couponColors.elementAt(Random().nextInt(couponColors.length)),
                                    //         percent: couponController.allCoupon.elementAt(index).percentageOff,
                                    //         date: couponController.allCoupon.elementAt(index).endDate.toString(),
                                    //         vendorId:  couponController.allCoupon.elementAt(index).vid,
                                    //       )),
                                    // );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                          childCount: couponController.allCoupon.length,
                          addAutomaticKeepAlives: true,
                          addRepaintBoundaries: false)),
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
    );
  }
}
