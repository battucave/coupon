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
import '../../services/service_details_screen.dart';

class ClaimedCouponsTab extends StatefulWidget {
  const ClaimedCouponsTab({Key? key}) : super(key: key);

  @override
  _ClaimedCouponsTabState createState() => _ClaimedCouponsTabState();
}

class _ClaimedCouponsTabState extends State<ClaimedCouponsTab> {
  ScrollController scrollController = ScrollController();

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

  void showClaimedImg() {
    setState(() {
      showDialog(
          // The user CANNOT close this dialog  by pressing outsite it
          barrierDismissible: true,
          context: context,
          builder: (_) {
            return Dialog(
              // The background color
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // The loading indicator
                    Image.asset(AssetPath.claimedSample),
                  ],
                ),
              ),
            );
          });
    });
  }

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
    scrollController.addListener(_scrollListener);
    cFloatingActionButtonHeight =
        (cBottomNavigationBarOptionSize - (cBottomNavigationBarCurve / 2)) +
            (cBottomNavigationBarOptionSize / 2);
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 5));
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 5));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 5));
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 5));
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 5));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await couponController.getClaimCoupon();
    });
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
        Obx(() => couponController.claimedCouponList.isNotEmpty
            ? SliverPadding(
                padding: const EdgeInsets.all(0).add(EdgeInsets.only(
                    bottom: cPadding + cFloatingActionButtonHeight!)),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext buildContext, int index) {
                  const itemHeight = 210.0;
                  const heightFactor = 0.86;
                  final itemPositionOffset = index * itemHeight * heightFactor;
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
                          child: Obx(() => SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: KServicesManCard(
                                  name: couponController.claimedCouponList
                                      .elementAt(index)
                                      .vendorName,
                                  image: couponController.claimedCouponList
                                      .elementAt(index)
                                      .vendorLogPath,
                                  color: index % 2 == 0
                                      ? couponColors.elementAt(0)
                                      : couponColors.elementAt(1),
                                  percent: couponController.claimedCouponList
                                      .elementAt(index)
                                      .percentageOff
                                      .toString(),
                                  date: couponController.claimedCouponList
                                      .elementAt(index)
                                      .claimedDate
                                      .toString(),
                                  endDate: couponController.claimedCouponList
                                      .elementAt(index)
                                      .claimedDate
                                      .toString(),
                                  buttonText: "Details",
                                  couponExpired: false,
                                  onPressed: () {
                                    showClaimedImg();
                                  },
                                  onProfilePressed: () {},
                                ),
                              )),
                        ),
                      ),
                    ),
                  );
                },
                        childCount: couponController.claimedCouponList.length,
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
              )),
      ],
    );
  }
}
