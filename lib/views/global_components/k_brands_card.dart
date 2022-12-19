import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:image_network/image_network.dart';
import 'package:logan/views/styles/b_style.dart';

import '../screens/services/service_details_screen.dart';

class KBrandsCard extends StatefulWidget {
  final String? text;
  final String? image;
  final Function()? onPressed;
  final bool? isRound;
  final int vid;
  final Function? onTap;
  const KBrandsCard(
      {Key? key,
      this.image,
      this.onPressed,
      this.text,
      this.isRound,
      required this.vid,
      required this.onTap})
      : super(key: key);

  @override
  State<KBrandsCard> createState() => _KBrandsCardState();
}

class _KBrandsCardState extends State<KBrandsCard> {
  List<Color> colors = [
    const Color(0xFFE8804B),
    const Color(0xFF30C3CD),
    const Color(0xFF1697B7),
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: 100,
        height: 105,
        margin: const EdgeInsets.only(right: 9),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: KColor.white,
          // color: Colors.red,
          shape: widget.isRound != null ? BoxShape.circle : BoxShape.rectangle,
          borderRadius:
              widget.isRound != null ? null : BorderRadius.circular(23),
          boxShadow: const [
            BoxShadow(
              color: Colors.black87,
              blurRadius: 10,
            ),
            // BoxShadow(color: KColor.primary.withOpacity(0.62), blurRadius: 25),
          ],
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return ImageNetwork(
            width: constraints.maxWidth * 0.9,
            height: constraints.maxHeight * 0.9,
            image: widget.image!,
            imageCache: CachedNetworkImageProvider(widget.image!),
            duration: 1500,
            curve: Curves.easeIn,
            onPointer: true,
            debugPrint: false,
            fullScreen: false,
            fitAndroidIos: BoxFit.contain,
            fitWeb: BoxFitWeb.cover,
            // borderRadius: BorderRadius.circular(70),
            onLoading: const CircularProgressIndicator(
              color: Colors.indigoAccent,
            ),
            onError: const Icon(
              Icons.error,
              color: Colors.red,
            ),
            onTap: widget.onTap,
          );
        }),
      ),
    );
  }
}
