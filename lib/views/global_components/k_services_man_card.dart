import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_network/image_network.dart';
import 'package:logan/models/api/single_vendor_model.dart';
import 'package:logan/views/styles/b_style.dart';

import '../../controllers/vendor_controller.dart';

class KServicesManCard extends StatefulWidget {
  final String? name;
  final String? image;
  final dynamic? percent;
  final String? date;
  final String? endDate;
  final Color? color;
  final Function()? onPressed;
  final String? buttonText;
  final bool couponExpired;
  final int? vid;

  const KServicesManCard(
      {Key? key,
      this.date,
        this.endDate,
      this.name,
      this.image,
      this.percent,
      this.color,
      this.onPressed,
      this.buttonText,
      this.couponExpired = false,
       this.vid


      })
      : super(key: key);

  @override
  State<KServicesManCard> createState() => _KServicesManCardState();
}

class _KServicesManCardState extends State<KServicesManCard> {

  VendorController vendorController=Get.put(VendorController());

  Future<SingleVendorModel>getVendor()async{
    return await vendorController.getVendorProfileById(widget.vid!);

  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: KSize.getHeight(context, 16)),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: KColor.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: KColor.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: Row(
                    children: [

                      (widget.image==null)?StreamBuilder<SingleVendorModel>(
                        stream: getVendor().asStream(),
                        builder: (context, AsyncSnapshot<SingleVendorModel> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }else{
                            if(snapshot.hasData){
                              return ImageNetwork(
                                image: snapshot.data!.vendorLogPath,
                                imageCache: CachedNetworkImageProvider(snapshot.data!.vendorLogPath,),
                                height: 55,
                                width: 55,
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
                              );
                            }else{
                              return Container();
                            }
                          }

                        },
                      ):ImageNetwork(
                    image: widget.image!,
                    imageCache: CachedNetworkImageProvider(widget.image!),
                    height: 55,
                    width: 55,
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

                      SizedBox(width: KSize.getWidth(context, 10)),
                      (widget.name==null)?StreamBuilder<SingleVendorModel>(
                        stream: getVendor().asStream(),
                        builder: (context, AsyncSnapshot<SingleVendorModel> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Text("");
                          }else{
                            if(snapshot.hasData){
                              return  Expanded(
                                child: Text(
                                   snapshot.data!.vendorName,
                                  style: KTextStyle.headline4.copyWith(fontSize: 18),
                                ),
                              );
                            }else{
                              return Container();
                            }
                          }

                        },
                      ):
                      Expanded(
                        child: Text(
                          widget.name!,
                          style: KTextStyle.headline4.copyWith(fontSize: 18),
                        ),
                      )
                      ,
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: '${widget.percent}% ',
                                style: KTextStyle.headline4.copyWith(
                                    fontSize: 30,
                                    color: widget.couponExpired
                                        ? KColor.orange.withOpacity(0.5)
                                        : KColor.orange),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'OFF',
                                      style: KTextStyle.headline4.copyWith(
                                          fontSize: 18,
                                          color: widget.couponExpired
                                              ? KColor.orange.withOpacity(0.5)
                                              : KColor.orange)),
                                ],
                              ),
                            ),
                            Text(
                             ! widget.couponExpired?"valid until: ${widget.date!.length>11?widget.date!.substring(0,11):widget.date}":
                              "Expired on: ${widget.endDate!.length>11?widget.endDate!.substring(0,11):widget.endDate}",
                              // widget.date!.length>11?"valid until: ${widget.date!.substring(0,11)}":
                              // "valid until:",


                              style: KTextStyle.headline2.copyWith(
                                  fontSize: 14,
                                  color: KColor.black.withOpacity(0.3)),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onPressed,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 6),
                          decoration: BoxDecoration(
                              color: widget.couponExpired
                                  ? KColor.silver.withOpacity(0.1)
                                  : KColor.orange,
                              borderRadius: BorderRadius.circular(14.5)),
                          child: Text(
                            widget.buttonText!,
                            style: KTextStyle.headline2.copyWith(
                                fontSize: 12,
                                color: widget.couponExpired
                                    ? KColor.silver
                                    : KColor.white),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: KSize.getHeight(context, 15)),
        ],
      ),
    );
  }
}
