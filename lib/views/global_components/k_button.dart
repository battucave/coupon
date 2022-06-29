import 'package:flutter/material.dart';
import 'package:logan/views/styles/b_style.dart';

class KButton extends StatefulWidget {
  final String? text;
  final bool outlineButton;
  final Color? color;
  final bool isCoupon;
  final Color? textColor;

  final Function()? onPressed;

  const KButton({Key? key, this.text, this.outlineButton = false, this.onPressed, this.isCoupon = false, this.textColor, this.color})
      : super(key: key);

  @override
  State<KButton> createState() => _KButtonState();
}

class _KButtonState extends State<KButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: widget.outlineButton
            ? BoxDecoration(
                color: KColor.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: widget.isCoupon ? KColor.orange : KColor.primary),
              )
            : BoxDecoration(borderRadius: BorderRadius.circular(10), color: widget.isCoupon ? KColor.orange : KColor.primary),
        child: Center(child: Text(widget.text!, style: KTextStyle.headline2.copyWith(fontSize: 16, color: widget.textColor))),
      ),
    );
  }
}
