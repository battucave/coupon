import 'package:cached_network_image/cached_network_image.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_network/image_network.dart';
import 'package:logan/utils/extensions.dart';
import 'package:logan/views/styles/b_style.dart';

import '../../constant/asset_path.dart';
import '../../controllers/vendor_controller.dart';
import '../../models/api/single_vendor_model.dart';

class KFeaturedCarouselCard extends StatefulWidget {
  final String? percent;
  final String? image;
  final int? vid;
  const KFeaturedCarouselCard({Key? key, this.image, this.percent, this.vid})
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
    return Container(
        padding: const EdgeInsets.only(
          left: 30,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.percent.toString(),
                      style: KTextStyle.headline5.copyWith(fontSize: 14),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Discount   ",
                      style: KTextStyle.headline5.copyWith(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "From Our Store",
                      style: KTextStyle.headline5.copyWith(fontSize: 14),
                    ),
                  ],
                )
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
              child: ImageNetwork(
                image: widget.image!,
                imageCache: CachedNetworkImageProvider(widget.image!),
                height: 80,
                width: 80,
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
                onTap: () {},
              ),
            ),
          ],
        ));
  }
}
