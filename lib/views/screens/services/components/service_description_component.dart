import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logan/views/styles/b_style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

enum TapState {
  address,
  phone,
  email,
  website,
  other,
}

class ServiceDescriptionComponent extends StatelessWidget {
  final String? image;
  final String? title;
  final String? subtitle;
  final TapState tapState;

  const ServiceDescriptionComponent(
      {Key? key, this.image, this.title, this.subtitle, required this.tapState})
      : super(key: key);

  void launchMap(String address) async {
    String query = Uri.encodeComponent(address);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    await launchUrlString(googleUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Image.asset(image!, height: 25, width: 18),
          SizedBox(width: KSize.getWidth(context, 15)),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                if (subtitle != null) {
                  switch (tapState) {
                    case TapState.address:
                      launchMap(subtitle!);
                      break;
                    case TapState.phone:
                      launchUrlString("tel:${subtitle!}");
                      break;
                    case TapState.email:
                      launchUrlString("mailto:${subtitle!}");
                      break;
                    case TapState.website:
                      if (subtitle!.startsWith("http")) {
                        await launchUrl(Uri.parse(subtitle!));
                      } else {
                        await launchUrl(
                          Uri.parse(
                            "https://${subtitle!}",
                          ),
                          mode: LaunchMode.externalApplication,
                          // webViewConfiguration: WebViewConfiguration
                        );
                      }

                      break;
                    case TapState.other:
                      return;
                  }
                }
              },
              child: RichText(
                text: TextSpan(
                  text: title,
                  style: KTextStyle.headline4
                      .copyWith(fontSize: 15, color: KColor.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' $subtitle',
                      style: KTextStyle.headline4.copyWith(
                          fontSize: 15, color: KColor.black.withOpacity(0.5)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
