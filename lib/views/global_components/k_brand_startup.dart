import 'package:flutter/material.dart';
import 'package:logan/views/styles/b_style.dart';

class KBrandsCardStartup extends StatefulWidget {
  final String? text;
  final String? image;
  final Function()? onPressed;
  final bool? isRound;
  const KBrandsCardStartup(
      {Key? key, this.image, this.onPressed, this.text, this.isRound})
      : super(key: key);

  @override
  State<KBrandsCardStartup> createState() => _KBrandsCardStartupState();
}

class _KBrandsCardStartupState extends State<KBrandsCardStartup> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: 115,
        height: 120,
        margin: const EdgeInsets.only(right: 3),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: KColor.white,
          shape: widget.isRound != null ? BoxShape.circle : BoxShape.rectangle,
          borderRadius:
              widget.isRound != null ? null : BorderRadius.circular(25),
          // boxShadow: const [
          //   BoxShadow(color: Colors.black45, blurRadius: 7),
          //   // BoxShadow(color: KColor.primary.withOpacity(0.62), blurRadius: 25),
          // ],
        ),
        child: Image.asset(
          widget.image!,
          // height: 40,
          // width: 40,
        ),
      ),
    );
  }
}
