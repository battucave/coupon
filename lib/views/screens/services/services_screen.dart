import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_network/image_network.dart';
import 'package:logan/models/services_man_model.dart';
import 'package:logan/models/services_model.dart';
import 'package:logan/views/global_components/k_back_button.dart';
import 'package:logan/views/global_components/k_services_man_card.dart';
import 'package:logan/views/global_components/k_text_field.dart';
import 'package:logan/views/screens/services/service_details_screen.dart';
import 'package:logan/views/styles/b_style.dart';

import '../../../controllers/category_controller.dart';
import '../../../controllers/coupon_controller.dart';
import '../../../controllers/vendor_controller.dart';
import '../../global_components/k_coupon_claim_card.dart';
import '../../global_components/k_dialog.dart';

class ServicesScreen extends StatefulWidget {
  final int catId;
  final bool isFeatured;
  final String title;
  const ServicesScreen({Key? key,required this.catId,this.isFeatured=false,required this.title}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  TextEditingController searchController = TextEditingController();
  List<Color> couponColors=[
    const Color(0xFFE8804B),
    const Color(0xFF30C3CD),
    const Color(0xFF1697B7),
  ];
  int _currentIndex = 0;
  int _currentSubCatId = 1;
  CategoryController categoryController=Get.put(CategoryController());
  VendorController vendorController=Get.put(VendorController());
  CouponController couponController=Get.put(CouponController());
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
    if(!widget.isFeatured){
      categoryController.getSubCategory(widget.catId).then((value) => {
        if(categoryController.subCategory.isNotEmpty){
          couponController.getCouponBySubCategory(widget.catId,categoryController.subCategory.elementAt(0).scid),
        }
      }
      );
    }else{
      couponController.getFeaturedCoupon();
    }
    couponController.getFeaturedCoupon();


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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerCenter.stop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.offWhite,
      appBar: AppBar(
        backgroundColor: KColor.offWhite,
        elevation: 0,
        leading: Padding(padding: const EdgeInsets.all(10), child: KBackButton(bgColor: KColor.black.withOpacity(0.1), iconColor: KColor.black)),
        centerTitle: true,
        title: Text(
          widget.title,
          style: KTextStyle.headline2.copyWith(fontSize: 22, color: KColor.blueSapphire),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  KTextField(
                    prefixIcon: const Icon(Icons.search, color: KColor.black),
                    hintText: "Search",
                    controller: searchController,
                    onChanged: (value){
                   if(widget.isFeatured){
                     couponController.seachFeaturedCoupon(value);
                     setState(() {
                     });
                   }else{
                     couponController.seachCoupon(value);
                     setState(() {
                     });
                   }

                    },
                  ),
                  const SizedBox(height: 25),
                  if(!widget.isFeatured)Obx(()=>  SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: List.generate(categoryController.subCategory.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentIndex = index;
                              _currentSubCatId=categoryController.subCategory.elementAt(index).scid;
                              print("HERE");
                              print(_currentSubCatId);
                              couponController.getCouponBySubCategory(widget.catId,_currentSubCatId);
                              //couponController.getFilteredCoupons(_currentSubCatId);
                             // couponController.getCouponBySubCategory(_currentSubCatId);
                              setState(() {  });
                             // couponController.getCouponBySubCategory(_currentSubCatId);

                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: KColor.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: KColor.orange.withOpacity(0.1)),
                                  boxShadow: [BoxShadow(color: KColor.black.withOpacity(0.16), blurRadius: 6)],
                                ),
                                child: ImageNetwork(
                                  image: categoryController.subCategory.elementAt(index).subCategoryLogoPath,
                                  imageCache: CachedNetworkImageProvider(categoryController.subCategory.elementAt(index).subCategoryLogoPath),
                                  height: 23,
                                  width: 23,
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
                                    _currentIndex = index;
                                    _currentSubCatId=categoryController.subCategory.elementAt(index).scid;
                                    couponController.getCouponBySubCategory(widget.catId,_currentSubCatId);
                                    // couponController.getFilteredCoupons(_currentSubCatId);
                                   // couponController.getCouponBySubCategory(_currentSubCatId);
                                    setState(() {  });

                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                categoryController.subCategory.elementAt(index).subCategoryName,
                                style: KTextStyle.headline2.copyWith(fontSize: 13, color: _currentIndex == index ? KColor.orange : KColor.primary),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),),

                ],
              ),
            ),
            const SizedBox(height: 10),
            (!widget.isFeatured)?

            // Obx(
            //       ()=> categoryController.subCategory.isNotEmpty && couponController.foundBySubCategory.isNotEmpty?
            //       ListView.builder(
            //     shrinkWrap: true,
            //     padding: EdgeInsets.zero,
            //     itemCount: couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.length,
            //     physics: const BouncingScrollPhysics(),
            //     itemBuilder: (context, index) {
            //
            //       return KServicesManCard(
            //         onProfilePressed: (){
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => ServiceDetailsScreen(
            //                     color: servicesMan[0].color,
            //                     vendorId:couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorId
            //                 )),
            //           );
            //         },
            //          name: couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorName,
            //          image:  couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorLogPath,
            //          color: servicesMan[0].color,
            //          percent:    couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorCouponsList.isNotEmpty?
            //          couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorCouponsList.elementAt(0).percentageOff:"0",
            //          date:  couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorCouponsList.isNotEmpty?
            //          couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(0).vendorCouponsList.elementAt(0).endDate.toString():"------------",
            //         buttonText: "Claim Deal",
            //         vid:couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorId,
            //         onPressed: () {
            //           KDialog.kShowDialog(
            //             context: context,
            //             dialogContent: Dialog(
            //               shape: RoundedRectangleBorder(
            //                   borderRadius:
            //                   BorderRadius.circular(15.0)), //this right here
            //               child: KCouponClaimCard(
            //                 name: couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorName,
            //                 percent:    couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorCouponsList.isNotEmpty?
            //                 couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorCouponsList.elementAt(0).percentageOff:"0",
            //                 date:  couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorCouponsList.isNotEmpty?
            //                 couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(0).vendorCouponsList.elementAt(0).endDate.toString():"------------",
            //                 color: couponColors.elementAt(0),
            //                coupon_id: couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorCouponsList.isNotEmpty?
            //                couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorCouponsList.elementAt(0).couponId:0,
            //                 buttonText: "Claim This Coupon",
            //                 image:  couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorLogPath,
            //                 onPressed: () async{
            //                   startLoading();
            //                   int? result=await couponController.claimCoupon(couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorCouponsList.elementAt(0).couponId);
            //                   if(result==200 || result==201){
            //                     stopLoading();
            //                     Navigator.pop(context);
            //                     KDialog.kShowDialog(
            //                       context: context,
            //                       dialogContent: Dialog(
            //                         shape: RoundedRectangleBorder(
            //                             borderRadius: BorderRadius.circular(
            //                                 15.0)), //this right here
            //                         child:
            //                         Align(
            //                           alignment: Alignment.center,
            //                           child: ConfettiWidget(
            //                             confettiController: _controllerCenter,
            //                             blastDirectionality: BlastDirectionality
            //                                 .explosive, // don't specify a direction, blast randomly
            //                             shouldLoop:
            //                             true, // start again as soon as the animation is finished
            //                             colors: const [
            //                               Colors.green,
            //                               Colors.blue,
            //                               Colors.pink,
            //                               Colors.orange,
            //                               Colors.purple
            //                             ], // manually specify the colors to be used
            //                             createParticlePath: drawStar,
            //                             child:       KCouponClaimCard(
            //                               couponDetails: true,
            //                               name: couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorName,
            //                               percent:    couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorCouponsList.isNotEmpty?
            //                               couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorCouponsList.elementAt(0).percentageOff:"0",
            //                               date:  couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorCouponsList.isNotEmpty?
            //                               couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(0).vendorCouponsList.elementAt(0).endDate.toString():"------------",
            //                               color: couponColors.elementAt(0),
            //                               coupon_id: couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorCouponsList.isNotEmpty?
            //                               couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorCouponsList.elementAt(0).couponId:0,
            //                               buttonText: "Coupon Claimed",
            //                               image:  couponController.foundBySubCategory.elementAt(0).vendorsAndCouponsList!.elementAt(index).vendorLogPath,
            //                               onPressed: () {
            //
            //                               },
            //                             ),// define a custom shape/path.
            //                           ),
            //
            //                         ),
            //
            //                       ),
            //                     );
            //                     _controllerCenter.play();
            //                   }else{
            //                     stopLoading();
            //                     snackMessage("Fail to claim coupon");
            //                   }
            //
            //                 },
            //               ),
            //             ),
            //           );
            //         },
            //       );
            //     }) :
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: const [
            //           SizedBox(height: 200),
            //           Center(
            //             child: Text("No data to display",
            //               style: TextStyle(
            //                   color: Colors.grey
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //
            // )
            Obx(
                  ()=> categoryController.subCategory.isNotEmpty && couponController.foundBySubCategory.isNotEmpty && couponController.vendorAndCouponList.isNotEmpty?
              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: couponController.vendorAndCouponList.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {

                    return
                      KServicesManCard(
                      onProfilePressed: (){
                        print("OK");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ServiceDetailsScreen(
                                  color: servicesMan[0].color,
                                  vendorId:couponController.vendorAndCouponList.elementAt(index).vendorId
                              )),
                        );
                      },
                      name: couponController.vendorAndCouponList.elementAt(index).vendorName,
                      image: couponController.vendorAndCouponList.elementAt(index).vendorLogPath,
                      color: servicesMan[0].color,
                      percent:    couponController.vendorAndCouponList.elementAt(index).vendorCouponsList.isNotEmpty?
                      couponController.vendorAndCouponList.elementAt(index).vendorCouponsList.elementAt(0).percentageOff:"0",
                      date:  couponController.vendorAndCouponList.elementAt(index).vendorCouponsList.isNotEmpty?
                      couponController.vendorAndCouponList.elementAt(0).vendorCouponsList.elementAt(0).endDate.toString():"------------",
                      vid:couponController.vendorAndCouponList.elementAt(index).vendorId,
                      buttonText: "Claim Deal",

                      onPressed: () {
                        KDialog.kShowDialog(
                          context: context,
                          dialogContent: Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(15.0)), //this right here
                            child: KCouponClaimCard(
                              name: couponController.vendorAndCouponList.elementAt(index).vendorName,
                              image: couponController.vendorAndCouponList.elementAt(index).vendorLogPath,
                              color: servicesMan[0].color,
                              percent:    couponController.vendorAndCouponList.elementAt(index).vendorCouponsList.isNotEmpty?
                              couponController.vendorAndCouponList.elementAt(index).vendorCouponsList.elementAt(0).percentageOff:"0",
                              date:  couponController.vendorAndCouponList.elementAt(index).vendorCouponsList.isNotEmpty?
                              couponController.vendorAndCouponList.elementAt(0).vendorCouponsList.elementAt(0).endDate.toString():"------------",

                              buttonText: "Claim This Coupon",

                              onPressed: () async{
                                startLoading();
                                int? result=await couponController.claimCoupon(couponController.vendorAndCouponList.elementAt(index).vendorCouponsList.elementAt(0).couponId);
                                if(result==200 || result==201){
                                  stopLoading();
                                  Navigator.pop(context);
                                  KDialog.kShowDialog(
                                    context: context,
                                    dialogContent: Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15.0)), //this right here
                                      child:
                                      Align(
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
                                          child:       KCouponClaimCard(
                                            couponDetails: true,
                                            coupon_id: couponController.vendorAndCouponList.elementAt(index).vendorCouponsList.isNotEmpty?
                                            couponController.vendorAndCouponList.elementAt(index).vendorCouponsList.elementAt(0).couponId:0,
                                            name: couponController.vendorAndCouponList.elementAt(index).vendorName,
                                            image: couponController.vendorAndCouponList.elementAt(index).vendorLogPath,
                                            color: servicesMan[0].color,
                                            percent:    couponController.vendorAndCouponList.elementAt(index).vendorCouponsList.isNotEmpty?
                                            couponController.vendorAndCouponList.elementAt(index).vendorCouponsList.elementAt(0).percentageOff:"0",
                                            date:  couponController.vendorAndCouponList.elementAt(index).vendorCouponsList.isNotEmpty?
                                            couponController.vendorAndCouponList.elementAt(0).vendorCouponsList.elementAt(0).endDate.toString():"------------",
                                            buttonText: "Coupon Claimed",

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
                      },
                    );
                  }) :
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

            )

                :
            Obx(
                  ()=>  couponController.foundFeaturedCouponList.isNotEmpty?
              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount:  couponController.foundFeaturedCouponList.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {

                    return KServicesManCard(
                      onProfilePressed: (){

                      },
                      name: couponController.foundFeaturedCouponList.elementAt(index).vendorName,
                      image: couponController.foundFeaturedCouponList.elementAt(index).vendorLogPath,
                      color: servicesMan[0].color,
                      percent: couponController.foundFeaturedCouponList.elementAt(index).percentageOff,
                      date: couponController.foundFeaturedCouponList.elementAt(index).endDate.toString(),
                      buttonText: "Claim Deal",
                      onPressed: () {
                        KDialog.kShowDialog(
                          context: context,
                          dialogContent: Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(15.0)), //this right here
                            child: KCouponClaimCard(
                              name: couponController.foundFeaturedCouponList.elementAt(index).vendorName,
                              image: couponController.foundFeaturedCouponList.elementAt(index).vendorLogPath,
                              color: couponColors.elementAt(0),
                              percent: couponController.foundFeaturedCouponList.elementAt(index).percentageOff,
                              date: couponController.foundFeaturedCouponList.elementAt(index).endDate.toString(),
                              coupon_id: couponController.foundFeaturedCouponList.elementAt(index).couponId,
                              buttonText: "Claim This Coupon",
                               onPressed: () async{
                                startLoading();
                                int? result=await couponController.claimCoupon(couponController.foundFeaturedCouponList.elementAt(index).couponId);
                                if(result==200 || result==201){
                                  stopLoading();
                                  Navigator.pop(context);
                                  KDialog.kShowDialog(
                                    context: context,
                                    dialogContent: Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15.0)), //this right here
                                      child:
                                      Align(
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
                                          child:       KCouponClaimCard(
                                            couponDetails: true,
                                            name: couponController.foundFeaturedCouponList.elementAt(index).vendorName,
                                            image: couponController.foundFeaturedCouponList.elementAt(index).vendorLogPath,
                                            color: couponColors.elementAt(0),
                                            percent: couponController.foundFeaturedCouponList.elementAt(index).percentageOff,
                                            date: couponController.foundFeaturedCouponList.elementAt(index).endDate.toString(),
                                            coupon_id: couponController.foundFeaturedCouponList.elementAt(index).couponId,
                                            buttonText: "Coupon Claimed",
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
                      },
                    );
                  }) :
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

            const SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}
