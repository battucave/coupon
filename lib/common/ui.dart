import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Ui {
  static GetSnackBar SuccessSnackBar(
      {String title = 'Success', required String message}) {
    Get.log("[$title] $message");
    return GetSnackBar(
      titleText: Text(
        title.tr,
        style: Get.textTheme.headline6!.merge(
          const TextStyle(color: Colors.white),
        ),
      ),
      messageText: Text(
        message,
        style: Get.textTheme.caption!.merge(
          const TextStyle(color: Colors.white),
        ),
      ),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.green,
      icon:
          const Icon(Icons.check_circle_outline, size: 32, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 3),
    );
  }

  static GetSnackBar ErrorSnackBar(
      {String title = 'Error', required String message}) {
    Get.log("[$title] $message", isError: true);
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.headline6!.merge(
            const TextStyle(color: Colors.white),
          )),
      messageText: Text(
        message,
        style: Get.textTheme.caption!.merge(
          const TextStyle(color: Colors.white),
        ),
      ),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.red,
      icon: const Icon(Icons.remove_circle_outline,
          size: 32, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  static GetSnackBar defaultSnackBar(
      {String title = 'Alert', required String message}) {
    Get.log("[$title] $message", isError: false);
    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.headline6!.merge(
            const TextStyle(color: Colors.white),
          )),
      messageText: Text(message,
          style: Get.textTheme.caption!.merge(
            const TextStyle(color: Colors.white),
          )),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.black87,
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon: const Icon(Icons.warning_amber_rounded,
          size: 32, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 2),
    );
  }

  static Color parseColor(String hexCode, {double? opacity}) {
    try {
      return Color(int.parse(hexCode.replaceAll("#", "0xFF")))
          .withOpacity(opacity ?? 1);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity ?? 1);
    }
  }
}
