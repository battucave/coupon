import 'package:logan/constant/asset_path.dart';

class BrandsModel{
  final String?image;
  final String?text;

  BrandsModel(this.text,this.image);

}

List<BrandsModel> brandsItem=[
  BrandsModel("Starbucks", AssetPath.starBucks),
  BrandsModel("Sam's Club", AssetPath.sam),
  BrandsModel("Burger king", AssetPath.burgerKing),
    BrandsModel("Burger king", AssetPath.burgerKing),
];