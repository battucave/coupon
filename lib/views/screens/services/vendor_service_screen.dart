import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logan/models/coupon/coupon_available_model.dart';
import 'package:logan/utils/extensions.dart';
import 'package:logan/views/global_components/k_services_man_card.dart';
import 'package:logan/views/screens/services/service_details_screen.dart';

import '../../../../controllers/coupon_controller.dart';
import '../../../constant/asset_path.dart';
import '../../global_components/k_back_button.dart';
import '../../global_components/k_bottom_navigation_bar.dart';
import '../../global_components/k_coupon_claim_card.dart';
import '../../global_components/k_dialog.dart';
import '../../styles/k_colors.dart';
import '../../styles/k_size.dart';

class VendorServiceSreen extends StatefulWidget {
  final String? name;
  final String? image;
  final int vid;
  const VendorServiceSreen({Key? key,this.name,this.image,required this.vid}) : super(key: key);

  @override
  State<VendorServiceSreen> createState() => _VendorServiceSreenState();
}

class _VendorServiceSreenState extends State<VendorServiceSreen> {
  List<Color> couponColors=[
    Color(0xFFE8804B),
    Color(0xFF30C3CD),
    Color(0xFF1697B7),
  ];

  void snackMessage( String  msg){
    final snackBar = SnackBar(content: Text(msg),duration : Duration(milliseconds: 3000));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void stopLoading( ){

    Navigator.pop(context);
  }
  void startLoading(){
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
                    CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(KColor.primary)),

                  ],
                ),
              ),
            );
          });
    });

  }
  CouponController couponController=Get.put(CouponController());

  @override
  void initState() {
    super.initState();

    couponController.getCouponByVendorId(widget.vid);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child:  Column(children: [
          SizedBox(
            height: KSize.getHeight(context, 73),
          ),

          Row(

            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: KSize.getHeight(context, 20),
              ),
              const KBackButton(bgColor: KColor.blueGreen,),
            ],
          ),
          SizedBox(
            height: KSize.getHeight(context, 15),
          ),
          Obx(()=>

              Column(
                children: List.generate(couponController.vendorCouponList.length, (index) {
                  return KServicesManCard(
                      name:widget.name,
                      image:widget.image,
                      buttonText: "Claim This Coupon",
                      date:  couponController.vendorCouponList.elementAt(index).endDate.toString(),
                      color: couponColors.elementAt(Random().nextInt(couponColors.length)),
                      percent:  couponController.vendorCouponList.elementAt(index).percentageOff,
                      onPressed: () {
                        KDialog.kShowDialog(
                          context: context,
                          dialogContent: Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(15.0)), //this right here
                            child: KCouponClaimCard(
                              name:  widget.name,
                              percent:  couponController.vendorCouponList.elementAt(index).percentageOff,
                              color: couponColors.elementAt(Random().nextInt(couponColors.length)),
                              buttonText: "Claim This Coupon",
                              date: couponController.vendorCouponList.elementAt(index).endDate.toString(),
                              image:   widget.image,
                              onPressed: () async{
                                //print(couponControlller.vendorCouponList.elementAt(index).couponId);
                                startLoading();
                                int? result=await couponController.claimCoupon(couponController.vendorCouponList.elementAt(index).couponId);
                                if(result==200 || result==201){
                                  stopLoading();
                                  KDialog.kShowDialog(
                                    context: context,
                                    dialogContent: Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15.0)), //this right here
                                      child: KCouponClaimCard(
                                        couponDetails: true,
                                        name: widget.name,
                                        percent:  couponController.vendorCouponList.elementAt(index).percentageOff,
                                        color: couponColors.elementAt(Random().nextInt(couponColors.length)),
                                        buttonText: "Coupon Claimed",
                                        date:  couponController.vendorCouponList.elementAt(index).endDate.toString(),
                                        image:   widget.image,
                                        onPressed: () {
                                          Navigator.of(context).pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                  const KBottomNavigationBar()),
                                                  (Route<dynamic> route) => false);
                                        },
                                      ),
                                    ),
                                  );
                                }else{
                                  stopLoading();
                                  snackMessage("Fail to claim coupon");
                                }

                              },
                            ),
                          ),
                        );
                      });
                }),

              )

          ),

        ],)
      ),
    );
  }
}
