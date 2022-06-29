import 'package:flutter/material.dart';
import 'package:logan/views/styles/k_colors.dart';

class KBackButton extends StatefulWidget {
  final Color? bgColor, iconColor;
  const KBackButton({Key? key, this.bgColor, this.iconColor}) : super(key: key);

  @override
  State<KBackButton> createState() => _KBackButtonState();
}

class _KBackButtonState extends State<KBackButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: widget.bgColor ?? KColor.white.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_back_ios_rounded,
          color: widget.iconColor ?? KColor.white,
          size: 18,
        ),
      ),
    );
  }
}
