import 'package:flutter/material.dart';
import 'package:logan/views/styles/k_colors.dart';

class KSocialMediaButton extends StatefulWidget {
  final String image;
  final double height, width;
  final Function()? onPressed;

  const KSocialMediaButton({Key? key, required this.image, required this.height, required this.width, this.onPressed}) : super(key: key);

  @override
  State<KSocialMediaButton> createState() => _KSocialMediaButtonState();
}

class _KSocialMediaButtonState extends State<KSocialMediaButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: KColor.white,
          boxShadow: [BoxShadow(color: KColor.black.withOpacity(0.16), blurRadius: 6)],
        ),
        child: Image.asset(
          widget.image,
          height: widget.height,
          width: widget.width,
        ),
      ),
    );
  }
}
