import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logan/views/global_components/k_bottom_navigation_bar.dart';
import 'package:logan/views/global_components/k_vendor_brands_list_component.dart';
import 'package:logan/views/screens/coupon/tabs/available_coupons_tab.dart';
import 'package:logan/views/screens/coupon/tabs/claimed_coupons_tab.dart';
import 'package:logan/views/screens/coupon/tabs/expired_coupons_tab.dart';
import 'package:logan/views/styles/b_style.dart';
import '../../../controllers/coupon_controller.dart';

class CouponHistoryScreen extends StatefulWidget {
  const CouponHistoryScreen({Key? key}) : super(key: key);

  @override
  State<CouponHistoryScreen> createState() => _CouponHistoryScreenState();
}

class _CouponHistoryScreenState extends State<CouponHistoryScreen>
    with TickerProviderStateMixin {
  List<String> tabs = ['  Available  ', '    Used    ', '  Expired  '];
  int _tabIndex = 0;
  TabController? _tabController;
  CouponController couponController=Get.put(CouponController());
  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: tabs.length);
    _tabController?.addListener(() {
      setState(() {
        _tabIndex = _tabController!.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        FocusScope.of(context).unfocus();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const KBottomNavigationBar()));

        return Future<bool>.value(true);
      },
      child: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
            backgroundColor: KColor.offWhite,
            appBar: AppBar(
              backgroundColor: KColor.offWhite,
              centerTitle: true,
              title: Text(
                'My Deals',
                style: KTextStyle.headline2
                    .copyWith(fontSize: 22, color: KColor.blueSapphire),
              ),
              bottom: TabBar(
                onTap: (val){
                  _tabController?.index=val;
                },
                //controller: _tabController,
                indicatorColor: KColor.orange,
                unselectedLabelStyle: KTextStyle.headline2
                    .copyWith(fontSize: 16, color: KColor.white),
                labelStyle: KTextStyle.headline2
                    .copyWith(fontSize: 16, color: KColor.white),
                tabs: List.generate(
                  tabs.length,
                  (index) {
                    return Tab(
                      child: Container(
                        //padding: const EdgeInsets.only(left: 7,right: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            color: _tabIndex == index
                                ? KColor.primary
                                : KColor.blueGreen),
                        child: Text(tabs[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children:     [
                      TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: const [
                          AvailableCouponsTab(),
                          ClaimedCouponsTab(),
                          ExpiredCouponsTab(),
                        ],
                      ),
                      // Positioned(
                      //   left: 0,
                      //   bottom: 64,
                      //   child: KVendorBrandsListComponent(),
                      // )
                    ],
                  ),
                ),
                const SizedBox(height: 5),
              ],
            )),
      ),
    );
  }
}
