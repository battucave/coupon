import 'package:cached_network_image/cached_network_image.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_network/image_network.dart';
import 'package:logan/utils/extensions.dart';
import 'package:logan/views/screens/services/service_details_screen.dart';
import 'package:logan/views/styles/b_style.dart';

import '../../constant/asset_path.dart';
import '../../controllers/vendor_controller.dart';
import '../../models/api/single_vendor_model.dart';

class KFeaturedCarouselCard extends StatefulWidget {
  final String? percent;
  final String? image;
  final int? vid;
  final String? vendorName;
  final VoidCallback onTap;
  const KFeaturedCarouselCard(
      {Key? key,
      this.image,
      this.percent,
      this.vid,
      this.vendorName,
      required this.onTap})
      : super(key: key);

  @override
  State<KFeaturedCarouselCard> createState() => _KFeaturedCarouselCardState();
}

class _KFeaturedCarouselCardState extends State<KFeaturedCarouselCard> {
  VendorController vendorController = Get.put(VendorController());
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
    return GestureDetector(
      //TODO: Old logic
      //  onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => ServiceDetailsScreen(
      //         color: KColor.blueGreen,
      //         vendorId: widget.vid!,
      //       ),
      //     ),
      //   );
      // },
      onTap: widget.onTap,
      child: Container(
          padding: const EdgeInsets.only(
            left: 20,
          ),
          width: context.screenWidth,
          decoration: const BoxDecoration(
              color: KColor.blueGreen,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.vendorName ?? "Discount",
                        style: KTextStyle.headline5.copyWith(fontSize: 36),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.percent} % off',
                        style: KTextStyle.headline5.copyWith(fontSize: 26.0),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       "Click for details",
                  //       style: KTextStyle.headline5.copyWith(fontSize: 16.0),
                  //     ),
                  //   ],
                  // )
                ],
              ),
              const Spacer(),
              // Container(
              //   margin: const EdgeInsets.only(right: 20),
              //   child: widget.image!.isNotEmpty?
              //   ImageNetwork(
              //     image: widget.image!,
              //     imageCache: CachedNetworkImageProvider(widget.image!),
              //     height: 80,
              //     width: 80,
              //     duration: 1500,
              //     curve: Curves.easeIn,
              //     onPointer: true,
              //     debugPrint: false,
              //     fullScreen: false,
              //     fitAndroidIos: BoxFit.cover,
              //     fitWeb: BoxFitWeb.cover,
              //     borderRadius: BorderRadius.circular(400),
              //     onLoading: const CircularProgressIndicator(
              //       color: Colors.indigoAccent,
              //     ),
              //     onError: const Icon(
              //       Icons.error,
              //       color: Colors.red,
              //     ),
              //     onTap: () {
              //
              //     },
              //   ):   Image.asset(AssetPath.defaultImage, height: 100, width: 100,fit: BoxFit.contain,),
              // ),
              ///Need data in featured coupon to test this part
              // widget.vid!=null?StreamBuilder<SingleVendorModel>(
              //   stream: getVendor().asStream(),
              //   builder: (context, AsyncSnapshot<SingleVendorModel> snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const CircularProgressIndicator();
              //     }else{
              //       if(snapshot.hasData){
              //         return  Container(
              //           margin: const EdgeInsets.only(right: 20),
              //           child:ImageNetwork(
              //             image: snapshot.data!.vendorLogPath,
              //             height: 80,
              //             width: 80,
              //             duration: 1500,
              //             curve: Curves.easeIn,
              //             onPointer: true,
              //             debugPrint: false,
              //             fullScreen: false,
              //             fitAndroidIos: BoxFit.cover,
              //             fitWeb: BoxFitWeb.cover,
              //             borderRadius: BorderRadius.circular(70),
              //             onLoading: const CircularProgressIndicator(
              //               color: Colors.indigoAccent,
              //             ),
              //             onError: const Icon(
              //               Icons.error,
              //               color: Colors.red,
              //             ),
              //             onTap: () {
              //
              //             },
              //           ) ,
              //         );
              //
              //
              //       }else{
              //         return Container();
              //       }
              //     }
              //
              //   },
              // ):

              Container(
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ImageNetwork(
                  image: widget.image!,
                  imageCache: CachedNetworkImageProvider(widget.image!),
                  height: 90,
                  width: 90,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServiceDetailsScreen(
                          color: KColor.blueGreen,
                          vendorId: widget.vid!,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
