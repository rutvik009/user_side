// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';

class CommonButton extends StatelessWidget {
  String btnName;
  VoidCallback btnOnTap;
  CommonButton({Key? key, required this.btnName, required this.btnOnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: btnOnTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 54,
        decoration: BoxDecoration(
            color: currentColor, borderRadius: BorderRadius.circular(9)),
        alignment: Alignment.center,
        child: Text(
          btnName,
          style: appBtnStyle,
        ),
      ),
    );
  }
}
