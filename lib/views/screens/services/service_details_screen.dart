import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_network/image_network.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/controllers/coupon_controller.dart';
import 'package:logan/views/global_components/k_back_button.dart';
import 'package:logan/views/global_components/k_bottom_navigation_bar.dart';
import 'package:logan/views/global_components/k_coupon_claim_card.dart';
import 'package:logan/views/global_components/k_dialog.dart';
import 'package:logan/views/global_components/k_services_man_card.dart';
import 'package:logan/views/screens/services/components/service_description_component.dart';
import 'package:logan/views/styles/b_style.dart';

import '../../../controllers/vendor_controller.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final String? name;
  final String? image;
  final String? category;
  final int? percent;
  final Color? color;
  final String? date;
  final int vendorId;

  const ServiceDetailsScreen(
      {Key? key,
      this.name,
      this.image,
      this.category,
      this.color,
      this.percent,
      this.date,
      required this.vendorId})
      : super(key: key);

  @override
  State<ServiceDetailsScreen> createState() => _ServicesDetailsScreenState();
}

class _ServicesDetailsScreenState extends State<ServiceDetailsScreen> {


  VendorController vendorController=Get.put(VendorController());
  CouponController couponControlller=Get.put(CouponController());
  void snackMessage( String  msg){
    final snackBar = SnackBar(content: Text(msg),duration : Duration(milliseconds: 3000));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  @override
  void initState() {
    super.initState();

    vendorController.getVendorById(widget.vendorId);
    couponControlller.getCouponByVendorId(widget.vendorId);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

        GetX<VendorController>(
          init: VendorController(),
          builder: (controller)=> SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: KSize.getHeight(context, 54),
                          bottom: KSize.getHeight(context, 25),
                          left: KSize.getWidth(context, 25)),
                      child: Row(
                        children: const [
                          KBackButton(),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: KColor.primary,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: KColor.black.withOpacity(0.16),
                                blurRadius: 6,
                                spreadRadius: 5)
                          ]),
                    ),
                    Positioned(
                        bottom: -60,
                        child: Container(
                          decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                            BoxShadow(
                                color: KColor.black.withOpacity(0.25),
                                blurRadius: 4,
                                offset: const Offset(0, 4))
                          ]),
                          child: ImageNetwork(
                            image: controller.vendor.value.vendorLogPath,
                            imageCache: CachedNetworkImageProvider( widget.image!),
                            height: 144,
                            width: 144,
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
                            onTap: () {

                            },
                          ),

                          // Image.asset(widget.image!, height: 114, width: 114),
                        ))
                  ],
                ),
                const SizedBox(height: 70),
                Center(
                  child: Text(
                    controller.vendor.value.vendorName,
                    style: KTextStyle.headline2
                        .copyWith(fontSize: 20, color: KColor.black),
                  ),
                ),
                Center(
                  child: Text(
                     controller.vendor.value.requirements,
                    style: KTextStyle.headline2
                        .copyWith(fontSize: 13, color: KColor.primary),
                  ),
                ),
                SizedBox(height: KSize.getHeight(context, 20)),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 25)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name of Company",
                        style: KTextStyle.headline4
                            .copyWith(fontSize: 18, color: KColor.black),
                      ),
                      const SizedBox(height: 7),
                      RichText(
                        text: TextSpan(
                          text:
                           controller.vendor.value.description,
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 14, color: KColor.black.withOpacity(0.5)),
                          children: <TextSpan>[
                            TextSpan(
                                text: '  See More....',
                                style: KTextStyle.headline4
                                    .copyWith(fontSize: 14, color: KColor.orange),
                                recognizer: TapGestureRecognizer()..onTap = () {}),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 25),
                  width: double.infinity,
                  height: 1,
                  color: KColor.silver.withOpacity(0.3),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(children:  [
                    ServiceDescriptionComponent(
                      title: "Hours :",
                      subtitle:  vendorController.vendor.value.hours,
                      image: AssetPath.clock,
                    ),
                    //subtitle: "123 somewhere pl, Logan, Ut 12345",
                    ServiceDescriptionComponent(
                      title: "Address :",
                      subtitle: vendorController.vendor.value.street1+" "+vendorController.vendor.value.state+" "+vendorController.vendor.value.city+" "+vendorController.vendor.value.zipCode,
                      image: AssetPath.address,
                    ),
                    ServiceDescriptionComponent(
                      title: "Phone :",
                      subtitle:  vendorController.vendor.value.phone,
                      image: AssetPath.phone1,
                    ),
                    ServiceDescriptionComponent(
                      title: "Email :",
                      subtitle: vendorController.vendor.value.email,
                      image: AssetPath.mail,
                    ),
                    ServiceDescriptionComponent(
                      title: "Website :",
                      subtitle: vendorController.vendor.value.website,
                      image: AssetPath.website,
                    ),
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 25),
                  width: double.infinity,
                  height: 1,
                  color: KColor.silver.withOpacity(0.3),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Coupons",
                        style: KTextStyle.headline2.copyWith(
                            fontWeight: FontWeight.w600, color: KColor.black),
                      ),
                      couponControlller.vendorCouponList.isNotEmpty?Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: KColor.primary.withOpacity(0.15),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "See All",
                              style: KTextStyle.headline2
                                  .copyWith(fontSize: 14, color: KColor.orange),
                            ),
                            const Icon(Icons.arrow_forward_ios_outlined,
                                color: KColor.orange, size: 15)
                          ],
                        ),
                      ):SizedBox(),
                    ],
                  ),
                ),
               Container(
                 child:  Obx(()=>
                     couponControlller.vendorCouponList.isNotEmpty?
                 Column(
                   children:

                   List.generate(couponControlller.vendorCouponList.length, (index) {
                     return KServicesManCard(
                         name:vendorController.vendor.value.vendorName,
                         image:vendorController.vendor.value.vendorLogPath,
                         buttonText: "Claim This Coupon",
                         date:  couponControlller.vendorCouponList.elementAt(index).endDate.toString(),
                         color: widget.color,
                         percent:  couponControlller.vendorCouponList.elementAt(index).percentageOff,
                         onPressed: () {
                           KDialog.kShowDialog(
                             context: context,
                             dialogContent: Dialog(
                               shape: RoundedRectangleBorder(
                                   borderRadius:
                                   BorderRadius.circular(15.0)), //this right here
                               child: KCouponClaimCard(
                                 name:  vendorController.vendor.value.vendorName,
                                 percent:  couponControlller.vendorCouponList.elementAt(index).percentageOff,
                                 color: widget.color,
                                 buttonText: "Claim This Coupon",
                                 date: couponControlller.vendorCouponList.elementAt(index).endDate.toString(),
                                 image:  vendorController.vendor.value.vendorLogPath,
                                 onPressed: () async{
                                   int? result=await couponControlller.claimCoupon (couponControlller.vendorCouponList.elementAt(index).couponId);
                                   if(result==200 || result==201){
                                     KDialog.kShowDialog(
                                       context: context,
                                       dialogContent: Dialog(
                                         shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(
                                                 15.0)), //this right here
                                         child: KCouponClaimCard(
                                           couponDetails: true,
                                           name: vendorController.vendor.value.vendorName,
                                           percent:  couponControlller.vendorCouponList.elementAt(index).percentageOff,
                                           color: widget.color,
                                           buttonText: "Coupon Claimed",
                                           date:  couponControlller.vendorCouponList.elementAt(index).endDate.toString(),
                                           image:  vendorController.vendor.value.vendorLogPath,
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
                                     snackMessage("Coupon Already Claimed");
                                   }

                                 },
                               ),
                             ),
                           );
                         });
                   }),):
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     const SizedBox(height: 60),
                     Center(
                       child: Text("No coupon to display",
                         style: TextStyle(
                             color: Colors.grey
                         ),
                       ),
                     )
                   ],
                 ),
                 ),
               ),

                const SizedBox(height: 50)
              ],
            ),
          ),

        )
    );
  }
}
