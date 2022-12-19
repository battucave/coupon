import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:logan/common/ui.dart';
import 'package:logan/constant/api_routes.dart';
import 'package:logan/controllers/builder_ids/builder_ids.dart';
import 'package:logan/network_services/network_handler.dart';
import 'package:logan/views/global_components/k_bottom_navigation_bar.dart';

import '../models/subscription/purchasable_product.dart';

class SubscriptionController extends GetxController {
  InAppPurchase iaPurchase = InAppPurchase.instance;

  late StreamSubscription<List<PurchaseDetails>> subscription;
  StoreState storeState = StoreState.loading;
  ProductStatus productStatus = ProductStatus.pending;
  List<ProductDetails> products = List.empty(growable: true);

  final network = NetWorkHandler();

  bool isLoading = false;

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
    iaPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach(_handlePurchase);
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    log(purchaseDetails.status.toString());
    if (purchaseDetails.status == PurchaseStatus.purchased) {
      String serverKey = purchaseDetails.verificationData.serverVerificationData
          .replaceAll(RegExp(' +'), ' ');
      log('SERVER VERIFICATION:: $serverKey');
      // log('LOCAL VERIFICATION::: ${purchaseDetails.verificationData.localVerificationData}');
      // log('SERVER VERIFICATION:::: ${purchaseDetails.verificationData.serverVerificationData}');
      // log('TRANSACTION DATE:::; ${purchaseDetails.transactionDate.toString()}');
      // log('PRODUCT ID::::;; ${purchaseDetails.productID}');
      // log('PRODUCT ID::::;; ${purchaseDetails.purchaseID}');
      int response = await createSubscripton(receipt: serverKey);
      if (response == 200 || response == 201) {
        //TODO: Subscription routing logic
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: 'Purchase done successfully'));
        Get.offAll(() => KBottomNavigationBar());
      } else {
        //TODO: Error logic
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: 'An error occured please try again'));
      }
    }
    if (purchaseDetails.pendingCompletePurchase) {
      await iaPurchase.completePurchase(purchaseDetails);
    }
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
    products = List.empty(growable: true);
    Set<String> ids;
    log('IN LOAD PURCHASES ${products.length}');
    final available = await iaPurchase.isAvailable();
    if (!available) {
      storeState = StoreState.notAvailable;
      return null;
    }
    ids = <String>{'monthly_subscription', 'yearly_subscription'};
    final response = await iaPurchase.queryProductDetails(ids);
    for (var element in response.notFoundIDs) {
      debugPrint('Purchase $element not found');
    }
    products.addAll(response.productDetails);
    storeState = StoreState.available;
    isLoading = false;
    update([kProductDetailBuilder]);
    return products;
  }

  Future<int> getSubscription() async {
    //TODO: save Subscription details
    final response = await network.getSubscription(ApiRoutes.getSubscription);
    return response.statusCode;
  }

  Future<int> createSubscripton({required String receipt}) async {
    //TODO: Save subscription details
    final response = await network.createSubscription(
        endpoint: ApiRoutes.createSubscription,
        platform: Platform.isAndroid ? 'Android' : 'IOS',
        receipt: receipt);
    log(response.statusCode.toString());
    log(response.body);
    return response.statusCode;
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
