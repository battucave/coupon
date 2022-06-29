import 'package:logan/constant/asset_path.dart';

class ServicesModel{
  final String?image;
  final String?text;

  ServicesModel(this.text,this.image);

}

List<ServicesModel> servicesCategory=[
  ServicesModel("Plumbers", AssetPath.plumber),
  ServicesModel("Roofers", AssetPath.roof),
  ServicesModel("Builders", AssetPath.builder),
];