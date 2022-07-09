import 'package:flutter/material.dart';
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              widget.image!,
              height: 40,
              width: 40,
            ),
            widget.isRound != null
                ? const SizedBox()
                : Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(widget.text!,
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
