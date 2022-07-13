import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_network/image_network.dart';
import 'package:logan/utils/extensions.dart';
import 'package:logan/views/styles/b_style.dart';

import '../../controllers/vendor_controller.dart';

class KFeaturedCarouselCard extends StatefulWidget {
  final double? percent;
  final String? image;
  const KFeaturedCarouselCard(
      {Key? key,
        this.image,
        this.percent,
      })
      : super(key: key);

  @override
  State<KFeaturedCarouselCard> createState() => _KFeaturedCarouselCardState();
}

class _KFeaturedCarouselCardState extends State<KFeaturedCarouselCard> {


  @override
  Widget build(BuildContext context) {

    return  Container(
        padding: EdgeInsets.only(left: 30, ),
        width: context.screenWidth,
        decoration: BoxDecoration(
            color: KColor.orange,
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment:MainAxisAlignment.start ,
                  children: [
                    Text(
                      "${widget.percent}"+"%",
                      style: KTextStyle.headline5.copyWith(fontSize: 36),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment:MainAxisAlignment.start ,
                  children: [
                    Text(
                      "Discount   ",
                      style: KTextStyle.headline5.copyWith(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment:MainAxisAlignment.start ,
                  children: [
                    Text(
                      "From Our Store",
                      style: KTextStyle.headline5.copyWith(fontSize:14 ),
                    ),
                  ],
                )

              ],
            ),
            Spacer(),
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
                borderRadius: BorderRadius.circular(400),
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
            ),
          ],
        )
    );
  }
}
