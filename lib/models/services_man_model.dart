import 'package:flutter/material.dart';
import 'package:logan/constant/asset_path.dart';

class ServicesManModel{
  final String?image;
  final String?name;
  final int?percent;
  final String? date;
  final Color? color;

  ServicesManModel(this.color,this.name,this.date,this.percent,this.image);

}

List<ServicesManModel> servicesMan=[
 ServicesManModel(const Color(0xFFE8804B), "Cristian Buehner","01-31-2023",75,AssetPath.buhener),
  ServicesManModel(const Color(0xFF30C3CD), "Jeffrey Keenan","01-31-2023",25,AssetPath.jeffery),
  ServicesManModel(const Color(0xFF1697B7), "Leilani Angel","01-31-2023",25,AssetPath.leilani),

];