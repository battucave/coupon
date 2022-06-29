import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/views/global_components/k_back_button.dart';
import 'package:logan/views/global_components/k_bottom_navigation_bar.dart';
import 'package:logan/views/global_components/k_coupon_claim_card.dart';
import 'package:logan/views/global_components/k_dialog.dart';
import 'package:logan/views/global_components/k_services_man_card.dart';
import 'package:logan/views/screens/services/components/service_description_component.dart';
import 'package:logan/views/styles/b_style.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final String? name;
  final String? image;
  final String? category;
  final int? percent;
  final Color? color;
  final String? date;

  const ServiceDetailsScreen(
      {Key? key,
      this.name,
      this.image,
      this.category,
      this.color,
      this.percent,
      this.date})
      : super(key: key);

  @override
  State<ServiceDetailsScreen> createState() => _ServicesDetailsScreenState();
}

class _ServicesDetailsScreenState extends State<ServiceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: KSize.getHeight(context, 54),
                      bottom: KSize.getHeight(context, 25),
                      left: KSize.getWidth(context, 25)),
                  child: Row(
                    children: const [
                      KBackButton(),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: KColor.primary,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: KColor.black.withOpacity(0.16),
                            blurRadius: 6,
                            spreadRadius: 5)
                      ]),
                ),
                Positioned(
                    bottom: -60,
                    child: Container(
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                            color: KColor.black.withOpacity(0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 4))
                      ]),
                      child:
                          Image.asset(widget.image!, height: 114, width: 114),
                    ))
              ],
            ),
            const SizedBox(height: 70),
            Center(
              child: Text(
                widget.name!,
                style: KTextStyle.headline2
                    .copyWith(fontSize: 20, color: KColor.black),
              ),
            ),
            Center(
              child: Text(
                widget.category ?? '',
                style: KTextStyle.headline2
                    .copyWith(fontSize: 13, color: KColor.primary),
              ),
            ),
            SizedBox(height: KSize.getHeight(context, 20)),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 25)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name of Company",
                    style: KTextStyle.headline4
                        .copyWith(fontSize: 18, color: KColor.black),
                  ),
                  const SizedBox(height: 7),
                  RichText(
                    text: TextSpan(
                      text:
                          '<Company description> Lorem ipsum dolor sit amet, rebum commune adversarium nam in. Eos ex exerci sensibus ',
                      style: KTextStyle.headline2.copyWith(
                          fontSize: 14, color: KColor.black.withOpacity(0.5)),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'See More....',
                            style: KTextStyle.headline4
                                .copyWith(fontSize: 14, color: KColor.orange),
                            recognizer: TapGestureRecognizer()..onTap = () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 25),
              width: double.infinity,
              height: 1,
              color: KColor.silver.withOpacity(0.3),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(children: const [
                ServiceDescriptionComponent(
                  title: "Hours :",
                  subtitle: "10:30 am - 10:30 pm ",
                  image: AssetPath.clock,
                ),
                ServiceDescriptionComponent(
                  title: "Address :",
                  subtitle: "123 somewhere pl, Logan, Ut 12345",
                  image: AssetPath.address,
                ),
                ServiceDescriptionComponent(
                  title: "Phone :",
                  subtitle: "1 (xxx) xxx-xxxx",
                  image: AssetPath.phone1,
                ),
                ServiceDescriptionComponent(
                  title: "Email :",
                  subtitle: "dummyemail@gmail.com",
                  image: AssetPath.mail,
                ),
                ServiceDescriptionComponent(
                  title: "Website :",
                  subtitle: "httpsdummy.com",
                  image: AssetPath.website,
                ),
              ]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 25),
              width: double.infinity,
              height: 1,
              color: KColor.silver.withOpacity(0.3),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Coupons",
                    style: KTextStyle.headline2.copyWith(
                        fontWeight: FontWeight.w600, color: KColor.black),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: KColor.primary.withOpacity(0.15),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "See All",
                          style: KTextStyle.headline2
                              .copyWith(fontSize: 14, color: KColor.orange),
                        ),
                        const Icon(Icons.arrow_forward_ios_outlined,
                            color: KColor.orange, size: 15)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            KServicesManCard(
                name: widget.name,
                image: widget.image,
                buttonText: "Claim This Coupon",
                date: widget.date,
                color: widget.color,
                percent: widget.percent,
                onPressed: () {
                  KDialog.kShowDialog(
                    context: context,
                    dialogContent: Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15.0)), //this right here
                      child: KCouponClaimCard(
                        name: widget.name,
                        percent: widget.percent,
                        color: widget.color,
                        buttonText: "Claim This Coupon",
                        date: widget.date,
                        image: widget.image,
                        onPressed: () {
                          KDialog.kShowDialog(
                            context: context,
                            dialogContent: Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      15.0)), //this right here
                              child: KCouponClaimCard(
                                couponDetails: true,
                                name: widget.name,
                                percent: widget.percent,
                                color: widget.color,
                                buttonText: "Coupon Claimed",
                                date: widget.date,
                                image: widget.image,
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const KBottomNavigationBar()),
                                      (Route<dynamic> route) => false);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
