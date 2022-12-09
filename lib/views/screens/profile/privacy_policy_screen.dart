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
          // image: DecorationImage(
          //     image: AssetImage(AssetPath.authBackground), fit: BoxFit.fill),
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
                          "The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Best of Logan unless otherwise defined in this Privacy Policy.",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 16,
                              color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 20),
                        const Text("Information Collection and Use",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        Text(
                          "For a better experience, while using our Service, we may require you to provide us with certain personally   identifiable information, including but not limited to name, email address, phone number, location . The information that we request will be retained by us and used as described in this privacy policy. \n\n The app does use third-party services that may collect information used to identify you.",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 16,
                              color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 20),
                        Row(
                          children: const [
                            Text("Log Data",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information(through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol(“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 16,
                              color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 20),
                        Row(
                          children: const [
                            Text("Cookies",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory. \n\nThis Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 16,
                              color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 20),
                        Row(
                          children: const [
                            Text("Service Providers",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "We may employ third-party companies and individuals due to the following reasons: \nTo facilitate our Service;\nTo provide the Service on our behalf;\nTo perform Service-related services; or\nTo assist us in analyzing how our Service is used.\n\nWe want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 16,
                              color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 20),
                        Row(
                          children: const [
                            Text("Security",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 16,
                              color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 20),
                        Row(
                          children: const [
                            Text("Links to Other Sites",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 16,
                              color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 20),
                        Row(
                          children: const [
                            Text("Children’s Privacy",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "These Services do not address anyone under the age of 13.We do not knowingly collect personally identifiable information from children under 13 years of age. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do the necessary actions.",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 16,
                              color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 20),
                        const Text("Changes to This Privacy Policy",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        Text(
                          "We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page.\n\nThis policy is effective as of 2022-07-28",
                          style: KTextStyle.headline2.copyWith(
                              fontSize: 16,
                              color: KColor.black.withOpacity(0.4)),
                        ),
                        const SizedBox(height: 10),
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
                          "If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at aly@thebestoflogan.com.",
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
