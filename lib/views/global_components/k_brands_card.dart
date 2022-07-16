import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:logan/views/styles/b_style.dart';

class KBrandsCard extends StatefulWidget {
  final String? text;
  final String? image;
  final Function()? onPressed;
  final bool? isRound;
  const KBrandsCard(
      {Key? key, this.image, this.onPressed, this.text, this.isRound})
      : super(key: key);

  @override
  State<KBrandsCard> createState() => _KBrandsCardState();
}

class _KBrandsCardState extends State<KBrandsCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: 100,
        height: 115,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: KColor.white,
          shape: widget.isRound != null ? BoxShape.circle : BoxShape.rectangle,
          borderRadius:
              widget.isRound != null ? null : BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.black45, blurRadius: 7),
            // BoxShadow(color: KColor.primary.withOpacity(0.62), blurRadius: 25),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ImageNetwork(
              image: widget.image!,
              imageCache: CachedNetworkImageProvider(widget.image!),
              height: 40,
              width: 40,
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
            widget.isRound != null
                ? const SizedBox()
                : Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(widget.text!,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,

                          style: KTextStyle.headline2
                              .copyWith(fontSize: 13, color: KColor.black)),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
