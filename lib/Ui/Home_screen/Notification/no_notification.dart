import 'package:flutter/material.dart';

class NoNotification extends StatefulWidget {
  const NoNotification({Key? key}) : super(key: key);

  @override
  State<NoNotification> createState() => _NoNotificationState();
}

class _NoNotificationState extends State<NoNotification> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Expanded(
        child: Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/notifications.png",
            height: 182,
            width: 182,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Ohh No, No Notifications Found",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xff440312)),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "It’s seems you have no notifications here.\nKindly check again or contact us for trouble.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xff000000)),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    ));
  }
}
