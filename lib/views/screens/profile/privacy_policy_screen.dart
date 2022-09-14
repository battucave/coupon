import 'package:flutter/material.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/utils/extensions.dart';
import 'package:logan/views/global_components/k_back_button.dart';
import 'package:logan/views/styles/b_style.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.screenHeight,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AssetPath.authBackground), fit: BoxFit.fill),
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
                    "Privacy Policy",
                    style: KTextStyle.headline4.copyWith(
                      fontSize: 26,
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    width: context.screenWidth - 40,
                    decoration: BoxDecoration(
                        color: KColor.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: KColor.black.withOpacity(0.16),
                            blurRadius: 8,
                          )
                        ]),
                    child: Column(
                      children: [
                        Text(
                          "Rise Social, LLC built the Best of Logan app as a Commercial app. This SERVICE is provided by Rise Social, LLC and is intended for use as is.",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 18,
                              color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 16,
                              color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 16,
                              color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Best of Logan unless otherwise defined in this Privacy Policy. Information Collection and Use",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 16,
                              color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "For a better experience, while using our Service, we may require you to provide us with certain personally   identifiable information, including but not limited to name, email address, phone number, location . The information that we request will be retained by us and used as described in this privacy policy. \n\n The app does use third-party services that may collect",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 16,
                              color: KColor.black.withOpacity(0.4)),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
