
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';

class Dashboardappbar extends StatelessWidget {
  String name;
  Dashboardappbar({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 40,
          /* leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Image.asset(
                ImagePath.leftArrow,
                height: 28,
                width: 28,
                color: Color(0xff2C3E50),
              ),
            ),
          ), */
          centerTitle: true,
          title: Text(
            name,
            style: headingStyle.copyWith(
                color: Color(0xff440312),
                fontSize: 21,
                fontWeight: FontWeight.w600),
          ),
        ));
  }
}
