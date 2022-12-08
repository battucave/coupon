import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:logan/controllers/builder_ids/builder_ids.dart';
import 'package:logan/views/screens/auth/login_screen.dart';

import '../models/subscription/purchasable_product.dart';

class SubscriptionController extends GetxController {
  InAppPurchase iaPurchase = InAppPurchase.instance;

  late StreamSubscription<List<PurchaseDetails>> subscription;
  StoreState storeState = StoreState.loading;
  ProductStatus productStatus = ProductStatus.pending;
  List<ProductDetails> products = List.empty(growable: true);

  String email = '';
  String password = '';

  bool isLoading = false;

  // static const String storeKeyConsumable = 'storeKeyConsumable';
  // static const String storeKeySubscription = 'storeKeySubscription';
  // static const String storeKeyUpgrade = 'storeKeyUpgrade';

  void initialize() async {
    final purchaseUpdate = iaPurchase.purchaseStream;
    subscription = purchaseUpdate.listen(
      _onPurchaseUpdate,
      onDone: _updateStreamOnDone,
      onError: _updateStreamOnError,
    );
    loadPurchases();
  }

  Future<void> buy(ProductDetails product) async {
    final purchaseParam = PurchaseParam(productDetails: product);
    // switch (product.id) {
    //   case storeKeyConsumable:
    //     await iaPurchase.buyConsumable(purchaseParam: purchaseParam);
    //     break;
    //   case storeKeySubscription:
    //   case storeKeyUpgrade:
    iaPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    //     break;
    //   default:
    //     throw ArgumentError.value(
    //         product, '${product.id} is not a known product');
    // }
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach(_handlePurchase);
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    log(purchaseDetails.status.toString());
    if (purchaseDetails.status == PurchaseStatus.purchased) {
      //TODO: Verify purchase from server

      // var validPurchase = await _verifyPurchase(purchaseDetails);
      // validPurchase = true;

      //Valid purchase condition when purchase verified from backend
      // if (validPurchase) {
      // Apply changes locally
      // switch (purchaseDetails.productID) {
      //   case storeKeySubscription:
      String serverKey =
          purchaseDetails.verificationData.serverVerificationData;
      // String email = Get.arguments['email'];
      // String password = Get.arguments['password'];
      log('EMAIL IN CONTROLLER ::::::; $email');
      log('PASSWORD IN CONTROLLER ::::::; $password');
      log('LOCAL VERIFICATION::: ${purchaseDetails.verificationData.localVerificationData}');
      log('SERVER VERIFICATION:::: ${purchaseDetails.verificationData.serverVerificationData}');
      log('TRANSACTION DATE:::; ${purchaseDetails.transactionDate.toString()}');
      log('PRODUCT ID::::;; ${purchaseDetails.productID}');
      log('PRODUCT ID::::;; ${purchaseDetails.purchaseID}');
      Get.offAll(LoginScreen());

      //     break;
      //   case storeKeyConsumable:
      //     print('Consumable done');
      //     // counter.addBoughtDashes(1000);
      //     break;
      // }
      // }
    }
    if (purchaseDetails.pendingCompletePurchase) {
      await iaPurchase.completePurchase(purchaseDetails);
    }
  }

  //TODO: Verify purchase

  Future<void> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    // var functions = await firebaseNotifier.functions;
    // final callable = functions.httpsCallable('verifyPurchase');
    // final results = await callable({
    //   'source': purchaseDetails.verificationData.source,
    //   'verificationData':
    //       purchaseDetails.verificationData.serverVerificationData,
    //   'productId': purchaseDetails.productID,
    // });
    // return results.data as bool;
  }

  void _updateStreamOnDone() {
    subscription.cancel();
  }

  void _updateStreamOnError(dynamic error) {
    log('Error occured $error');
  }

  Future<List<ProductDetails>?> loadPurchases() async {
    isLoading = true;
    update([kProductDetailBuilder]);
    log('IN LOAD PURCHASES');
    products = List.empty(growable: true);
    Set<String> ids;
    log('IN LOAD PURCHASES ${products.length}');
    final available = await iaPurchase.isAvailable();
    if (!available) {
      print('Not availalbe');
      storeState = StoreState.notAvailable;
      return null;
    }
    // if (Platform.isIOS) {
    ids = <String>{'monthly_subscription', 'yearly_subscription'};
    // } else {
    //TODO: Set IDs for Android
    ids = <String>{'monthly_subscription', 'yearly_subscription'};
    // }
    final response = await iaPurchase.queryProductDetails(ids);
    for (var element in response.notFoundIDs) {
      debugPrint('Purchase $element not found');
    }
    products.addAll(response.productDetails);
    storeState = StoreState.available;
    log('IN LOAD PURCHASES ${products.length}');
    isLoading = false;
    update([kProductDetailBuilder]);
    return products;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
