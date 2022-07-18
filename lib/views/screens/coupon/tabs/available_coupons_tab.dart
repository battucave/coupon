import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logan/models/coupon/coupon_available_model.dart';
import 'package:logan/views/global_components/k_services_man_card.dart';
import 'package:logan/views/screens/services/service_details_screen.dart';

import '../../../../controllers/coupon_controller.dart';
import '../../../../controllers/vendor_controller.dart';
import '../../../global_components/k_coupon_claim_card.dart';
import '../../../global_components/k_dialog.dart';
import '../../../styles/k_colors.dart';

class AvailableCouponsTab extends StatefulWidget {

    AvailableCouponsTab({Key? key,}) : super(key: key);

  @override
  State<AvailableCouponsTab> createState() => _CouponAvailableScreenState();
}

class _CouponAvailableScreenState extends State<AvailableCouponsTab> {
  List<Color> couponColors=[
     const Color(0xFFE8804B),
     const Color(0xFF30C3CD),
     const Color(0xFF1697B7),
  ];
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Obx(()=>

              couponController.allCoupon.isNotEmpty?
              Column(
            children: List.generate(couponController.allCoupon.length, (index) {
             return KServicesManCard(
               //name: couponController.allCoupon.elementAt(index).couponCode,
               onProfilePressed: (){
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context) => ServiceDetailsScreen(
                         //name:  couponController.allCoupon.elementAt(index).couponCode,
                         //image: couponAvailable[0].image,
                         color:  couponColors.elementAt(Random().nextInt(couponColors.length)),
                         percent: couponController.allCoupon.elementAt(index).percentageOff,
                         date: couponController.allCoupon.elementAt(index).endDate.toString(),
                         vendorId:  couponController.allCoupon.elementAt(index).vid,
                       )),
                 );
               },
               color:  couponColors.elementAt(Random().nextInt(couponColors.length)),
               percent:   couponController.allCoupon.elementAt(index).percentageOff,
               date:  couponController.allCoupon.elementAt(index).endDate.toString(),
               vid:couponController.allCoupon.elementAt(index).vid,
               buttonText: "Claim deal",
               onPressed: () {
                 KDialog.kShowDialog(
                   context: context,
                   dialogContent: Dialog(
                     shape: RoundedRectangleBorder(
                         borderRadius:
                         BorderRadius.circular(15.0)), //this right here
                     child: KCouponClaimCard(
                       percent:  couponController.allCoupon.elementAt(index).percentageOff,
                       color: couponColors.elementAt(Random().nextInt(couponColors.length)),
                       buttonText: "Claim This Coupon",
                       date: couponController.allCoupon.elementAt(index).endDate.toString(),
                       vid: couponController.allCoupon.elementAt(index).vid,
                       onPressed: () async{
                         //startLoading();
                         //Navigator.pop(context);
                         startLoading();
                         int? result=await couponController.claimCoupon(couponController.allCoupon.elementAt(index).couponId);
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
                                     percent:  couponController.allCoupon.elementAt(index).percentageOff,
                                     color: couponColors.elementAt(Random().nextInt(couponColors.length)),
                                     buttonText: "Coupon Claimed",
                                     date:  couponController.allCoupon.elementAt(index).endDate.toString(),
                                     couponCode: couponController.allCoupon.elementAt(index).couponCode,
                                     vid: couponController.allCoupon.elementAt(index).vid,
                                     onPressed: () {

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
             );
           }),):
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(height: 200),
                  Center(
                    child: Text("No data to display",
                      style: TextStyle(
                          color: Colors.grey
                      ),
                    ),
                  )
                ],
              ),
          ),
          const SizedBox(height: 160),
        ],
      ),
    );
  }
}
