
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';

class HomeAppbar extends StatelessWidget {
  String name;
  HomeAppbar({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 40,
    
      centerTitle: true,
      title: Text(
        name,
        style: headingStyle.copyWith(
            color: Color(0xff440312),
            fontSize: 21,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
