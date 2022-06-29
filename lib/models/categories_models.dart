import 'package:logan/constant/asset_path.dart';

class Categories {
  final String? image;
  final String? text;

  Categories(this.text, this.image);
}

List<Categories> categoriesItem = [
  Categories("Eats", AssetPath.eat),
  Categories("Drinks", AssetPath.drink),
  Categories("Desserts", AssetPath.dessert),
  Categories("Beauty & Spa", AssetPath.beauty),
  Categories("Automative", AssetPath.auto),
  Categories("Medical", AssetPath.medical),
  Categories("Services", AssetPath.service),
  Categories("View All", AssetPath.view),
];

List<Categories> categoriesViewsItem = [
  Categories("Eats", AssetPath.eat),
  Categories("Drinks", AssetPath.drink),
  Categories("Desserts", AssetPath.dessert),
  Categories("Beauty & Spa", AssetPath.beauty),
  Categories("Automative", AssetPath.auto),
  Categories("Medical", AssetPath.medical),
  Categories("Services", AssetPath.service),
  Categories("Grocery", AssetPath.grocery),
  Categories("Aggie", AssetPath.aggie),
  Categories("Hotel", AssetPath.hotel),
  Categories("Events", AssetPath.events),
  Categories("Home & Garden", AssetPath.homeGarden),
  Categories("Tour", AssetPath.tour),
];
