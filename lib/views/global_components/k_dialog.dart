import 'package:flutter/material.dart';
import 'package:logan/views/styles/b_style.dart';

class KDialog {
  static kShowDialog({required BuildContext context, required Widget dialogContent, bool barrierDismissible = true}) async {
    await showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: KColor.blueSapphire.withOpacity(0.25),
      builder: (context) => dialogContent,
    );
  }
}
