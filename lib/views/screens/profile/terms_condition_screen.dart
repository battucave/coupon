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
                    "Terms and Conditions",
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
                          "By downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. You’re not allowed to copy or modify the app, any part of the app, or our trademarks in any way. You’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages or make derivative versions. The app itself, and all the trademarks, copyright, database rights, and other intellectual property rights related to it, still belong to Rise Social, LLC.",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 16,
                              color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Rise Social, LLC is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for.",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 16,
                              color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "The Best of Logan app stores and processes personal data that you have provided to us, to provide our Service. It’s your responsibility to keep your phone and access to the app secure. We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security features and it could mean that the Best of Logan app won’t work properly or at all.",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 16,
                              color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "The app does use third-party services that declare their Terms and Conditions. \nLink to Terms and Conditions of third-party service providers used by the app : https://policies.google.com/terms?hl=en-US",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 16,
                              color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "You should be aware that there are certain things that Rise Social, LLC will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi or provided by your mobile network provider, but Rise Social, LLC cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left.",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 16,
                              color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "If you’re using the app outside of an area with Wi-Fi, you should remember that the terms of the agreement with your mobile network provider will still apply. As a result, you may  be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third-party charges. In using the app, you’re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app. \n\n Along the same lines, Rise Social, LLC cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail the Service, Rise Social, LLC cannot accept responsibility.\n\nWith respect to Rise Social, LLC’s responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavor to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. Rise Social, LLC accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app.\n\nAt some point, we may wish to update the app. The app is currently available on Android &amp; iOS – the requirements for the both systems(and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app. Rise Social, LLC does not promise that it will always update the app so that it is relevant to you and/or works with the Android &amp; iOS version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device.",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 16,
                              color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 20),
                        const Text("Changes to This Terms and Conditions",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        Text(
                          "We may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Terms and Conditions on this page.\nThese terms and conditions are effective as of 2022-07-28.",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 16,
                              color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: const [
                            Text("Contact Us",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "If you have any questions or suggestions about our Terms and Conditions, do not hesitate to contact us at aly@thebestoflogan.com.",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 16,
                              color: KColor.black.withOpacity(0.4)),
                        ),
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
