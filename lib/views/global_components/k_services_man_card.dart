import 'package:flutter/material.dart';
import 'package:logan/views/styles/b_style.dart';

class KServicesManCard extends StatefulWidget {
  final String? name;
  final String? image;
  final int? percent;
  final String? date;
  final Color? color;
  final Function()? onPressed;
  final String? buttonText;
  final bool couponExpired;
  const KServicesManCard(
      {Key? key,
      this.date,
      this.name,
      this.image,
      this.percent,
      this.color,
      this.onPressed,
      this.buttonText,
      this.couponExpired = false})
      : super(key: key);

  @override
  State<KServicesManCard> createState() => _KServicesManCardState();
}

class _KServicesManCardState extends State<KServicesManCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: KSize.getHeight(context, 16)),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: KColor.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: KColor.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: Row(
                    children: [
                      Image.asset(
                        widget.image!,
                        height: 55,
                        width: 55,
                      ),
                      SizedBox(width: KSize.getWidth(context, 10)),
                      Expanded(
                        child: Text(
                          widget.name!,
                          style: KTextStyle.headline4.copyWith(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: '${widget.percent}% ',
                                style: KTextStyle.headline4.copyWith(
                                    fontSize: 30,
                                    color: widget.couponExpired
                                        ? KColor.orange.withOpacity(0.5)
                                        : KColor.orange),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'OFF',
                                      style: KTextStyle.headline4.copyWith(
                                          fontSize: 18,
                                          color: widget.couponExpired
                                              ? KColor.orange.withOpacity(0.5)
                                              : KColor.orange)),
                                ],
                              ),
                            ),
                            Text(
                              "valid until: ${widget.date}",
                              style: KTextStyle.headline2.copyWith(
                                  fontSize: 14,
                                  color: KColor.black.withOpacity(0.3)),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onPressed,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 6),
                          decoration: BoxDecoration(
                              color: widget.couponExpired
                                  ? KColor.silver.withOpacity(0.1)
                                  : KColor.orange,
                              borderRadius: BorderRadius.circular(14.5)),
                          child: Text(
                            widget.buttonText!,
                            style: KTextStyle.headline2.copyWith(
                                fontSize: 12,
                                color: widget.couponExpired
                                    ? KColor.silver
                                    : KColor.white),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: KSize.getHeight(context, 15)),
        ],
      ),
    );
  }
}
