import 'package:flutter/material.dart';
import 'package:logan/models/notification/notifications_model.dart';
import 'package:logan/views/global_components/k_bottom_navigation_bar.dart';
import 'package:logan/views/screens/notification/components/notification_card.dart';
import 'package:logan/views/styles/b_style.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.3,
          backgroundColor: KColor.offWhite,
          title: Text(
            'Notifications',
            style: KTextStyle.headline2.copyWith(fontSize: 22, color: KColor.black),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: KSize.getHeight(context, 25)),
              Padding(
                  padding: EdgeInsets.only(left: KSize.getWidth(context, 25)),
                  child: Text(
                    newNotification.isNotEmpty ? "New" : '',
                    style: KTextStyle.headline2.copyWith(fontSize: 18, color: KColor.primary),
                  )),
              Column(
                children: List.generate(newNotification.length, (index) {
                  return NotificationCard(
                    image: newNotification[index].image,
                    name: newNotification[index].name,
                    time: newNotification[index].time,
                    percent: newNotification[index].percent,
                    date: newNotification[index].date,
                  );
                }),
              ),
              newNotification.isNotEmpty ? SizedBox(height: KSize.getHeight(context, 25)) : Container(),
              Padding(
                  padding: EdgeInsets.only(left: KSize.getWidth(context, 25)),
                  child: Text(
                    earlierNotification.isNotEmpty ? "Earlier" : '',
                    style: KTextStyle.headline2.copyWith(fontSize: 18, color: KColor.primary),
                  )),
              Column(
                children: List.generate(earlierNotification.length, (index) {
                  return NotificationCard(
                    image: earlierNotification[index].image,
                    name: earlierNotification[index].name,
                    time: earlierNotification[index].time,
                    percent: earlierNotification[index].percent,
                    date: earlierNotification[index].date,
                  );
                }),
              ),
              const SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }
}
