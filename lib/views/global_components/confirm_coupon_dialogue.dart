import 'package:flutter/material.dart';
import 'package:logan/utils/extensions.dart';
import 'package:logan/views/global_components/k_dialog.dart';
import 'package:logan/views/styles/k_colors.dart';
import 'package:logan/views/styles/k_text_style.dart';

void showConfirmClaimDialogue(BuildContext context,
    {required Function onpressed}) {
  KDialog.kShowDialog(
    context: context,
    dialogContent: Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)), //this right here
      child: Container(
        decoration: BoxDecoration(
            color: KColor.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: KColor.silver.withOpacity(0.2),
                  blurRadius: 4,
                  spreadRadius: 2)
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 0, top: 15, bottom: 15),
              decoration: const BoxDecoration(
                  color: KColor.orange,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Confirm Claim",
                    style: KTextStyle.headline6.copyWith(fontSize: 24),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Are you sure you want to claim this coupon ?",
                    textAlign: TextAlign.center,
                    style: KTextStyle.headline2.copyWith(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                    onpressed();
                  },
                  child: Container(
                    height: 44,
                    width: context.screenWidth * 0.3,
                    decoration: const BoxDecoration(
                      color: KColor.orange,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        "Confirm",
                        style: KTextStyle.headline2
                            .copyWith(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 44,
                    width: context.screenWidth * 0.3,
                    decoration: const BoxDecoration(
                      color: KColor.orange,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: KTextStyle.headline2
                            .copyWith(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    ),
  );
}
