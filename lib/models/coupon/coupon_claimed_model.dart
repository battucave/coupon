import 'package:flutter/material.dart';
import 'package:logan/constant/asset_path.dart';

class CouponClaimedModel{
  final String?image;
  final String?name;
  final int?percent;
  final String? date;
  final Color? color;

  CouponClaimedModel(this.color,this.name,this.date,this.percent,this.image,);

}

List<CouponClaimedModel> couponClaimed=[
  CouponClaimedModel(const Color(0xFFE8804B), "Starbucks Cofee","01-31-2023",75,AssetPath.starBucks),
  CouponClaimedModel(const Color(0xFF30C3CD), "Sam’s Club","01-31-2023",25,AssetPath.sam),
  CouponClaimedModel(const Color(0xFF1697B7), "Burger King","01-31-2023",25,AssetPath.burgerKing),

];