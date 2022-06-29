import 'package:flutter/material.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/views/global_components/k_bottom_navigation_bar.dart';
import 'package:logan/views/global_components/k_button.dart';
import 'package:logan/views/global_components/k_dialog.dart';
import 'package:logan/views/screens/auth/login_screen.dart';
import 'package:logan/views/screens/profile/contact_us_screen.dart';
import 'package:logan/views/screens/profile/edit_profile_screen.dart';
import 'package:logan/views/screens/profile/privacy_policy_screen.dart';
import 'package:logan/views/screens/profile/terms_condition_screen.dart';
import 'package:logan/views/styles/b_style.dart';

class ProfileScreen extends StatefulWidget {
  final String? name;
  final String? phone;
  final String? mail;
  final String? card;

  const ProfileScreen({Key? key, this.card, this.mail, this.name, this.phone}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        FocusScope.of(context).unfocus();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const KBottomNavigationBar()));

        return Future<bool>.value(true);
      },
      child: Scaffold(
        backgroundColor: KColor.offWhite,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 60, bottom: 25, left: 25, right: 25),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(AssetPath.edit, height: 23, width: 23),
                          ),
                        )),
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: KColor.black.withOpacity(0.16), blurRadius: 6, spreadRadius: 5)],
                      color: KColor.primary,
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                    ),
                  ),
                  Positioned(
                      bottom: -45,
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                          radius: 50,
                          child: ClipRRect(borderRadius: BorderRadius.circular(50), child: Image.asset(AssetPath.profileImg)),
                        ),
                      ))
                ],
              ),
              const SizedBox(height: 70),
              Center(
                child: Text(
                  "Marven Steward",
                  style: KTextStyle.headline2.copyWith(fontSize: 20, color: KColor.primary),
                ),
              ),
              Center(
                child: Text("marvensteward@gmail.com", style: KTextStyle.headline2.copyWith(fontSize: 14, color: KColor.black.withOpacity(0.5))),
              ),
              SizedBox(height: KSize.getHeight(context, 23)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _kContact(context, '(435) 555-5555', AssetPath.phone1, KColor.orange.withOpacity(0.1)),
                  const SizedBox(width: 30),
                  _kContact(context, '84040', AssetPath.card, KColor.blue.withOpacity(0.2))
                ],
              ),
              SizedBox(height: KSize.getHeight(context, 12)),
              Padding(
                padding: EdgeInsets.only(left: KSize.getWidth(context, 25), top: KSize.getHeight(context, 12)),
                child: Text("Settings", style: KTextStyle.headline2.copyWith(fontSize: 18, color: KColor.primary)),
              ),

              /// Settings Items
              KSettingsItem(
                text: 'Terms Of Use',
                navIcon: AssetPath.term,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TermsConditonScreen()));
                },
              ),
              _divider(),
              KSettingsItem(
                text: 'Privacy Policy',
                navIcon: AssetPath.privacy,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()));
                },
              ),
              _divider(),
              KSettingsItem(
                text: 'Contact US',
                navIcon: AssetPath.contact,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactUsScreen()));
                },
              ),
              _divider(),
              KSettingsItem(
                text: 'Signout',
                navIcon: AssetPath.signOut,
                onPressed: () {
                  Navigator.of(context)
                      .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginScreen()), (Route<dynamic> route) => false);
                },
              ),
              _divider(),
              KSettingsItem(
                text: 'Delete account',
                navIcon: AssetPath.delete,
                onPressed: () {
                  KDialog.kShowDialog(
                      context: context,
                      dialogContent: Dialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)), //this right here
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20),
                                    decoration: const BoxDecoration(
                                        color: KColor.orange,
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))),
                                    child: Center(
                                      child: Text("Alert Title Here", style: KTextStyle.headline4.copyWith(fontSize: 24, color: KColor.white)),
                                    ),
                                  ),
                                  const SizedBox(height: 31),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 18),
                                    child: Text(
                                      "Alert message here. I will give a list of what text to use.",
                                      textAlign: TextAlign.center,
                                      style: KTextStyle.headline2.copyWith(fontSize: 18, color: KColor.black),
                                    ),
                                  ),
                                  const SizedBox(height: 31),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 18),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: KButton(
                                            isCoupon: true,
                                            text: "Cancel",
                                            onPressed: () => Navigator.pop(context),
                                          ),
                                        ),
                                        const SizedBox(width: 30),
                                        Expanded(
                                          child: KButton(
                                            isCoupon: true,
                                            text: "Confirm",
                                            onPressed: () => Navigator.pop(context),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 62),
                                ],
                              ),
                            ),
                          )));
                },
              ),

              const SizedBox(height: 128),
            ],
          ),
        ),
      ),
    );
  }

  _divider() {
    return Container(
      height: 0.5,
      width: double.infinity,
      color: KColor.black.withOpacity(0.1),
    );
  }
}

class KSettingsItem extends StatelessWidget {
  final String? text;
  final String? navIcon;
  final Function()? onPressed;

  const KSettingsItem({
    Key? key,
    this.navIcon,
    this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        GestureDetector(
          onTap: onPressed,
          child: Container(
            color: KColor.transparent,
            padding: EdgeInsets.symmetric(horizontal: KSize.getWidth(context, 25)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(navIcon!, height: 22, width: 22),
                    SizedBox(width: KSize.getWidth(context, 15)),
                    Text(
                      text!,
                      overflow: TextOverflow.ellipsis,
                      style: KTextStyle.headline2.copyWith(fontSize: 16, color: KColor.black.withOpacity(0.5)),
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios_outlined, size: 15)
              ],
            ),
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}

_kContact(context, String? text, String? image, Color? color) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        height: 58,
        width: 58,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Image.asset(image!, height: 27, width: 27),
      ),
      const SizedBox(height: 10),
      Text(
        text!,
        overflow: TextOverflow.ellipsis,
        style: KTextStyle.headline2.copyWith(fontSize: 14, color: KColor.black.withOpacity(0.5)),
      )
    ],
  );
}
