import 'package:flutter/material.dart';
import 'package:logan/views/styles/b_style.dart';

class ServiceDescriptionComponent extends StatelessWidget {
  final String? image;
  final String? title;
  final String? subtitle;

  const ServiceDescriptionComponent({Key? key, this.image, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Image.asset(image!, height: 25, width: 18),
          SizedBox(width: KSize.getWidth(context, 15)),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: title,
                style: KTextStyle.headline4.copyWith(fontSize: 15, color: KColor.black),
                children: <TextSpan>[
                  TextSpan(
                    text: subtitle,
                    style: KTextStyle.headline4.copyWith(fontSize: 15, color: KColor.black.withOpacity(0.5)),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
