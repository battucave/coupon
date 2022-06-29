import 'package:flutter/material.dart';
import 'package:logan/views/styles/b_style.dart';

class NotificationCard extends StatefulWidget {
  final String? image;
  final String? name;
  final String? time;
  final int? percent;
  final String? date;

  const NotificationCard({Key? key, this.percent, this.image, this.name, this.time, this.date}) : super(key: key);

  @override
  State<NotificationCard> createState() => _KNotificationCardState();
}

class _KNotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(widget.image!, height: 58, width: 58),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.name!,
                            style: KTextStyle.headline2.copyWith(fontSize: 16, color: KColor.black),
                          ),
                        ),
                        Text(
                          widget.time!,
                          style: KTextStyle.headline2.copyWith(
                            fontSize: 12,
                            color: KColor.black.withOpacity(0.6),
                          ),
                        )
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        text: '${widget.percent}% Off ',
                        style: KTextStyle.headline2.copyWith(fontSize: 14, color: KColor.primary.withOpacity(0.7)),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Coupon Available Untill ${widget.date}',
                            style: KTextStyle.headline2.copyWith(fontSize: 14, color: KColor.black.withOpacity(0.7), overflow: TextOverflow.ellipsis),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(right: 19),
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
              decoration: BoxDecoration(color: KColor.primary, borderRadius: BorderRadius.circular(14.5)),
              child: Text(
                "Shop Now",
                style: KTextStyle.headline2.copyWith(fontSize: 12, color: KColor.white),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.only(left: 25),
          height: 1,
          color: KColor.black.withOpacity(0.1),
          width: double.infinity,
        )
      ],
    );
  }
}
