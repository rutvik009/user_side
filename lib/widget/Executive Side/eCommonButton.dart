import 'package:flutter/material.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';

class ECommonButton extends StatelessWidget {
  String btnName;
  VoidCallback btnOnTap;
  ECommonButton({Key? key, required this.btnName, required this.btnOnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: btnOnTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 54,
        decoration: BoxDecoration(
            gradient: AppColors.appColor, borderRadius: BorderRadius.circular(9)),
        alignment: Alignment.center,
        child: Text(
          btnName,
          style: appBtnStyle,
        ),
      ),
    );
  }
}
