import 'package:logan/constant/asset_path.dart';

class NotificationsModel {
  final String? image;
  final String? name;
  final String? time;
  final int? percent;
  final String? date;

  NotificationsModel(
    this.image,
    this.name,
    this.time,
    this.percent,
    this.date,
  );
}

List<NotificationsModel> newNotification = [
  NotificationsModel(AssetPath.starBucks, 'Starbucks Cofee Coupon', '3.42 Pm',
      75, "01-31-2023"),
  NotificationsModel(
      AssetPath.burgerKing, "Burger King Coupon", "3.42 Pm", 25, "01-31-2023"),
  NotificationsModel(
      AssetPath.sam, "Sam’s Club Coupon", '3.42 Pm', 15, "01-31-2023")
];
List<NotificationsModel> earlierNotification = [
  NotificationsModel(AssetPath.starBucks, 'Starbucks Cofee Coupon', '3.42 Pm',
      75, "01-31-2023"),
];
