
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';

class NextButton extends StatelessWidget {
  String btnName;
  VoidCallback btnOnTap;
  NextButton({Key? key, required this.btnName, required this.btnOnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: btnOnTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 55,
        decoration: BoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          btnName,
          style: nextBtnStyle,
        ),
      ),
    );
  }
}
