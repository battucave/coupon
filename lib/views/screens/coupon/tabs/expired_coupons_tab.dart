import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/coupon_controller.dart';
import '../../../global_components/k_services_man_card.dart';

class ExpiredCouponsTab extends StatefulWidget {
  const ExpiredCouponsTab({Key? key}) : super(key: key);

  @override
  _ExpiredCouponsTabState createState() => _ExpiredCouponsTabState();
}

class _ExpiredCouponsTabState extends State<ExpiredCouponsTab> {
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

  double scrollOffset = 0.0;
  double discoverOpacity = 1.0;
  double cPadding = 16.0;
  double cBottomNavigationBarCurve = 24.0;
  double cBottomNavigationBarOptionSize = 78.0;
  Color cBottomNavigationBarOptionColor = const Color(0xFFD3D3E8);
  double? cFloatingActionButtonHeight;

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    cFloatingActionButtonHeight =
        (cBottomNavigationBarOptionSize - (cBottomNavigationBarCurve / 2)) +
            (cBottomNavigationBarOptionSize / 2);

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
        Obx(() => couponController.expriredCouponList.isNotEmpty
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
                                  //name:  couponController.expriredCouponList.elementAt(index).couponCode,
                                  //image: couponExpired[0].image,
                                  color: index % 2 == 0
                                      ? couponColors.elementAt(0)
                                      : couponColors.elementAt(1),
                                  percent: couponController.expriredCouponList
                                      .elementAt(index)
                                      .percentageOff
                                      .toString(),
                                  date: couponController.expriredCouponList
                                      .elementAt(index)
                                      .endDate
                                      .toString(),
                                  endDate: couponController.expriredCouponList
                                      .elementAt(index)
                                      .endDate
                                      .toString(),
                                  vid: couponController.expriredCouponList
                                      .elementAt(index)
                                      .vid,
                                  buttonText: "Details",
                                  couponExpired: true, onPressed: () {},
                                  onProfilePressed: () {},
                                ),
                              )),
                        ),
                      ),
                    ),
                  );
                },
                        childCount: couponController.expriredCouponList.length,
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
