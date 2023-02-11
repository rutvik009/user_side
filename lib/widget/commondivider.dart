
import 'package:flutter/material.dart';

class Common_divider extends StatelessWidget {
  const Common_divider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      width: MediaQuery.of(context).size.width * 4,
      color: Color(0xffEDF1F5),
    );
  }
}
