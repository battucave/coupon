import 'package:flutter/material.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/utils/extensions.dart';
import 'package:logan/views/global_components/k_back_button.dart';
import 'package:logan/views/styles/b_style.dart';

class TermsConditonScreen extends StatefulWidget {
  const TermsConditonScreen({Key? key}) : super(key: key);

  @override
  State<TermsConditonScreen> createState() => _TermsConditonScreenState();
}

class _TermsConditonScreenState extends State<TermsConditonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.screenHeight,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(AssetPath.authBackground), fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 25), vertical: KSize.getHeight(context, 72)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const KBackButton(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 46),
                  child: Text(
                    "Terms and Conditions",
                    style: KTextStyle.headline4.copyWith(
                      fontSize: 26,
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    width: context.screenWidth - 40,
                    decoration: BoxDecoration(color: KColor.white, borderRadius: BorderRadius.circular(24), boxShadow: [
                      BoxShadow(
                        color: KColor.black.withOpacity(0.16),
                        blurRadius: 8,
                      )
                    ]),
                    child: Column(
                      children: [
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Morbi blandit cursus risus at ultrices mi tempus imperdiet.",
                          style: KTextStyle.headline2.copyWith(fontSize: 16, color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Morbi blandit cursus risus at ultrices mi tempus imperdiet.",
                          style: KTextStyle.headline2.copyWith(fontSize: 16, color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Morbi blandit cursus risus at ultrices mi tempus imperdiet.",
                          style: KTextStyle.headline2.copyWith(fontSize: 16, color: KColor.black.withOpacity(0.4)),
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
