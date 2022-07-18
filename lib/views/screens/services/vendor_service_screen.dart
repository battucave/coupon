import 'dart:math';

import 'package:confetti/confetti.dart';
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
  late ConfettiController _controllerCenter;
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;
  late ConfettiController _controllerTopCenter;
  late ConfettiController _controllerBottomCenter;

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }


  @override
  void initState() {
    super.initState();
    couponController.getCouponByVendorId(widget.vid);
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

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
      ConfettiWidget(
        confettiController: _controllerCenter,
        blastDirectionality: BlastDirectionality
            .explosive, // don't specify a direction, blast randomly
        shouldLoop:
        true, // start again as soon as the animation is finished
        colors: const [
          Colors.green,
          Colors.blue,
          Colors.pink,
          Colors.orange,
          Colors.purple
        ], // manually specify the colors to be used
        createParticlePath: drawStar, // define a custom shape/path.
        child:   SingleChildScrollView(
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
                          vid: widget.vid,
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
                                    startLoading();
                                    int? result=await couponController.claimCoupon(couponController.vendorCouponList.elementAt(index).couponId);
                                    if(result==200 || result==201){
                                      stopLoading();
                                      Navigator.pop(context);
                                      KDialog.kShowDialog(
                                        context: context,
                                        dialogContent: Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  15.0)), //this right here
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: ConfettiWidget(
                                              confettiController: _controllerCenter,
                                              blastDirectionality: BlastDirectionality
                                                  .explosive, // don't specify a direction, blast randomly
                                              shouldLoop:
                                              true, // start again as soon as the animation is finished
                                              colors: const [
                                                Colors.green,
                                                Colors.blue,
                                                Colors.pink,
                                                Colors.orange,
                                                Colors.purple
                                              ], // manually specify the colors to be used
                                              createParticlePath: drawStar,
                                              child:     KCouponClaimCard(
                                                couponDetails: true,
                                                name: widget.name,
                                                percent:  couponController.vendorCouponList.elementAt(index).percentageOff,
                                                color: couponColors.elementAt(Random().nextInt(couponColors.length)),
                                                buttonText: "Coupon Claimed",
                                                date:  couponController.vendorCouponList.elementAt(index).endDate.toString(),
                                                image:   widget.image,
                                                couponCode: couponController.vendorCouponList.elementAt(index).couponCode,
                                                onPressed: () {
                                                  // Navigator.of(context).pushAndRemoveUntil(
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //         const KBottomNavigationBar()),
                                                  //         (Route<dynamic> route) => false);
                                                },
                                              ),// define a custom shape/path.
                                            ),

                                          ),

                                        ),
                                      );
                                      _controllerCenter.play();
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
      ),

    );
  }
}
