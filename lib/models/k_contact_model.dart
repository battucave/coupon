import 'package:logan/constant/asset_path.dart';

class KContactModel {
  final String? image;
  final String? text;

  KContactModel(this.text, this.image);
}

List<KContactModel> contactMethod = [
  // KContactModel("Phone", AssetPath.phone),
  KContactModel("Email", AssetPath.mail),
  KContactModel("Website", AssetPath.website),
  // KContactModel("Youtube", AssetPath.youtube),
];

class KSocialMediaModel {
  final String? image;

  KSocialMediaModel(this.image);
}

List<KSocialMediaModel> socialMedia = [
  // KSocialMediaModel(AssetPath.facebook),
  KSocialMediaModel(AssetPath.insta),
  // KSocialMediaModel(AssetPath.twitter),
  // KSocialMediaModel(AssetPath.linkdin),
];
