import 'package:flutter/material.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/models/k_contact_model.dart';
import 'package:logan/utils/extensions.dart';
import 'package:logan/views/global_components/k_back_button.dart';
import 'package:logan/views/global_components/k_social_media_button.dart';
import 'package:logan/views/styles/b_style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.screenHeight,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0E5E71),
              Color(0xFF1697B7),
              Color(0xFF1697B7),
              Color(0xFFF3F3F3),
              Color(0xFFF3F3F3),

              // KColor.blue,
              // KColor.blue,
              // KColor.blue,
              // Colors.white,
              // Colors.white,
            ],
          ),
          // image: DecorationImage(image: AssetImage(AssetPath.authBackground), fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: KSize.getWidth(context, 25),
                vertical: KSize.getHeight(context, 72)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const KBackButton(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 46),
                  child: Text(
                    "Contact Us ",
                    style: KTextStyle.headline4.copyWith(fontSize: 26),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(25),
                    width: context.screenWidth - 40,
                    decoration: BoxDecoration(
                        color: KColor.offWhite,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: KColor.black.withOpacity(0.16),
                            blurRadius: 8,
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          spacing: 20,
                          runSpacing: 25,
                          children:
                              List.generate(contactMethod.length, (index) {
                            return KContactMethod(
                              onPressed: () {
                                if (index == 0) {
                                  launchUrlString(
                                      "mailto:marketing@thebestoflogan.com");
                                } else if (index == 1) {
                                  launchUrl(
                                      Uri.parse('https://thebestoflogan.com/'));
                                } else {
                                  return;
                                }
                              },
                              text: contactMethod[index].text,
                              image: contactMethod[index].image,
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 65,
                        ),
                        Text("Social Media ",
                            style: KTextStyle.headline4
                                .copyWith(fontSize: 18, color: KColor.black)),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 17, bottom: 141),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  List.generate(socialMedia.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: KSocialMediaButton(
                                    onPressed: () {
                                      //
                                      launchUrl(Uri.parse(
                                          'http://www.instagram.com/best.of.logan'));
                                    },
                                    image: socialMedia[index].image!,
                                    height: 30,
                                    width: 30,
                                  ),
                                );
                              }),
                            ),
                          ),
                        )
                      ],
                    )),
                const SizedBox(
                  height: 150,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KContactMethod extends StatefulWidget {
  final String? image;
  final String? text;
  final Function()? onPressed;

  const KContactMethod({Key? key, this.image, this.text, this.onPressed})
      : super(key: key);

  @override
  State<KContactMethod> createState() => _KContactMethodState();
}

class _KContactMethodState extends State<KContactMethod> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Text(widget.text!,
              style: KTextStyle.headline4
                  .copyWith(fontSize: 18, color: KColor.black)),
          const SizedBox(height: 11),
          InkWell(
            onTap: widget.onPressed,
            child: Container(
              height: 58,
              width: 58,
              padding: const EdgeInsets.all(19),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: KColor.white,
                boxShadow: [
                  BoxShadow(
                      color: KColor.black.withOpacity(0.16), blurRadius: 4)
                ],
              ),
              child: Image.asset(
                widget.image!,
                height: 27,
                width: 27,
              ),
            ),
          )
        ],
      ),
    );
  }
}
