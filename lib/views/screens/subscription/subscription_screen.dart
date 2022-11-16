import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/controllers/builder_ids/builder_ids.dart';
import 'package:logan/controllers/subscription_controller.dart';
import 'package:logan/views/screens/subscription/widgets/subscription_sheet.dart';
import 'package:logan/views/styles/b_style.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final subscriptionController = Get.put(SubscriptionController());

  @override
  void initState() {
    super.initState();
    subscriptionController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    subscriptionController.subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: () {
              showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) => SubscriptionAlertDialog());
            },
            child: Container(
              height: 40.0,
              width: 120.0,
              decoration: BoxDecoration(
                color: KColor.primary,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: const Center(
                  child: Text(
                'Subscribe',
              )),
            ),
          ),
        ),
      ),
    );
  }
}

class SubscriptionAlertDialog extends StatefulWidget {
  const SubscriptionAlertDialog({Key? key}) : super(key: key);

  @override
  State<SubscriptionAlertDialog> createState() =>
      _SubscriptionAlertDialogState();
}

class _SubscriptionAlertDialogState extends State<SubscriptionAlertDialog> {
  final subscriptionController = Get.find<SubscriptionController>();

  bool isYearlySubscription = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      child: Container(
        height: Get.height * 0.55,
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: KColor.primary,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Subscribe Now',
              style: KTextStyle.headline3.copyWith(fontSize: 24.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Bill Monthly',
                  style: isYearlySubscription == true
                      ? KTextStyle.headline3.copyWith(fontSize: 16.0)
                      : KTextStyle.headline1.copyWith(fontSize: 16.0),
                ),
                CustomSwitch(
                    width: 60.0,
                    height: 26.0,
                    value: isYearlySubscription,
                    enableColor: KColor.black,
                    disableColor: KColor.white,
                    onChanged: (value) {
                      print('value');
                      setState(() {
                        isYearlySubscription = value;
                        print(isYearlySubscription);
                      });
                    }),
                Text(
                  'Bill Annually',
                  style: isYearlySubscription == true
                      ? KTextStyle.headline1.copyWith(fontSize: 16.0)
                      : KTextStyle.headline3.copyWith(fontSize: 16.0),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.done,
                    size: 18.0,
                    color: KColor.white,
                  ),
                  const SizedBox(width: 15.0),
                  Text(
                    'Exclusive Deals',
                    style: KTextStyle.headline2,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: isYearlySubscription == true
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.width * 0.5,
                  width: Get.width * 0.6,
                  child: Image.asset(AssetPath.logo),
                ),
                isYearlySubscription == true
                    ? Container(
                        height: 30.0,
                        decoration: BoxDecoration(
                            color: KColor.white,
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        margin:
                            const EdgeInsets.only(bottom: 140.0, right: 20.0),
                        child: Center(
                          child: Text(
                            'Save \$10',
                            style: KTextStyle.headline1.copyWith(
                                fontSize: 10.0, color: Colors.purple[800]),
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Text(
                    '\$',
                    style: KTextStyle.headline3.copyWith(fontSize: 25.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      isYearlySubscription == false ? '5' : '50',
                      style: KTextStyle.headline1.copyWith(fontSize: 25.0),
                    ),
                  ),
                  Text(
                    isYearlySubscription == false ? ' /month' : ' /annually',
                    style: KTextStyle.headline3.copyWith(
                        fontSize: 16.0, color: Colors.white.withOpacity(0.7)),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                //TODO: Show subscription sheet
                final productDetails =
                    await subscriptionController.loadPurchases();
                if (productDetails != null || productDetails!.isNotEmpty) {
                  showModalBottomSheet(
                      context: context,
                      builder: (_) => ShowSubscriptionSheet(
                            productDetails: productDetails,
                          ));
                } else {
                  print('No products found');
                }
              },
              child: Container(
                height: Get.height * 0.08,
                width: Get.width * 0.8,
                decoration: BoxDecoration(
                  color: KColor.orange,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Center(
                  child: GetBuilder<SubscriptionController>(
                    id: kProductDetailBuilder,
                    builder: (controller) => controller.isLoading == true
                        ? const CircularProgressIndicator(
                            color: KColor.white,
                          )
                        : Text(
                            '7-Day Trial',
                            style: KTextStyle.headline1,
                          ),
                  ),
                ),
              ),
            ),
            Text(
              'No Thanks',
              style: KTextStyle.headline6
                  .copyWith(color: Colors.white.withOpacity(0.7)),
            )
          ],
        ),
      ),
    );
  }
}

class CustomSwitch extends StatefulWidget {
  final bool value;
  final Color enableColor;
  final Color disableColor;
  final double? width;
  final double? height;
  final double? switchHeight;
  final double? switchWidth;
  final ValueChanged<bool> onChanged;

  CustomSwitch(
      {Key? key,
      required this.value,
      required this.enableColor,
      required this.disableColor,
      this.width,
      this.height,
      this.switchHeight,
      this.switchWidth,
      required this.onChanged})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: widget.width ?? 48.0,
            height: widget.height ?? 24.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: _circleAnimation.value == Alignment.centerLeft
                  ? widget.disableColor
                  : widget.enableColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
              child: Container(
                alignment:
                    widget.value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: widget.switchWidth ?? 20.0,
                  height: widget.switchHeight ?? 20.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: KColor.orange,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
