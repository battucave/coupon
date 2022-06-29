import 'package:flutter/material.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/views/styles/k_colors.dart';

class KArrowGoButton extends StatefulWidget {
  final Function()? onpressed;
  const KArrowGoButton({Key? key, this.onpressed}) : super(key: key);

  @override
  State<KArrowGoButton> createState() => _KArrowGoButtonState();
}

class _KArrowGoButtonState extends State<KArrowGoButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onpressed,
      child: Container(
        decoration: const BoxDecoration(color: KColor.primary, shape: BoxShape.circle),
        padding: const EdgeInsets.all(23),
        child: Image.asset(AssetPath.arrowGo, height: 17, width: 30),
      ),
    );
  }
}
