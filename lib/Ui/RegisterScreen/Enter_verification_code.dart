
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/security_question.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/submit_button.dart';
import 'package:pinput/pinput.dart';

import '../../Utils/image_path_constants.dart';

class Enter_Varification_Code extends StatefulWidget {
  const Enter_Varification_Code({Key? key}) : super(key: key);

  @override
  State<Enter_Varification_Code> createState() =>
      _Enter_Varification_CodeState();
}

class _Enter_Varification_CodeState extends State<Enter_Varification_Code> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderAppBar(name: AppConstants.enterVerificationCode),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                   
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: TextSpan(
                            text: AppConstants.sentOtp,
                            style: fontStyle,
                            children: [
                              TextSpan(
                                  text: AppConstants.number,
                                  style: fontStyle.copyWith(
                                      fontWeight: FontWeight.w600))
                            ]),
                      ),
                      SizedBox(
                        height: 59,
                      ),
                      Pinput(
                        length: 5,
                        cursor: Container(
                            height: 21.87,
                            width: 2,
                            color: Color(0xff57606F).withOpacity(0.1)),
                        showCursor: true,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        submittedPinTheme: PinTheme(
                          width: 52,
                          height: 52,
                          textStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),
                          decoration: BoxDecoration(
                            color: currentColor,
                           
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: 52,
                          height: 52,
                          textStyle: TextStyle(color: Colors.white),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 19,
                                  color: Color(0xff051B28).withOpacity(.09),
                                  offset: Offset(5.0, 5.0))
                            ],
                           
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xff79244D).withOpacity(0.23),
                            ),
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        defaultPinTheme: PinTheme(
                          width: 52,
                          height: 52,
                          textStyle: TextStyle(color: Colors.white),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xff79244D).withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 270,
                      ),
                     
                      Center(
                        child: Text(
                          AppConstants.second,
                          style: fontStyle,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                              text: AppConstants.rich1L,
                              style: fontStyle,
                              children: [
                                TextSpan(
                                    text: AppConstants.rich2L,
                                    style: fontStyle.copyWith(
                                        color: Color(0xffFB5A57)))
                              ]),
                        ),
                      ),
                     
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CommonButton(
                            btnName: AppConstants.verifyNow,
                            btnOnTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          Security_Questions()));
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderAppBar extends StatelessWidget {
  String name;
  HeaderAppBar({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xffffffff),
      elevation: 0,
      leadingWidth: 40,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset(
            ImagePath.leftArrow,
            height: 28,
            width: 28,
            color: Color(0xff2C3E50),
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        name,
        style: headingStyle.copyWith(
            color: Color(0xff440312),
            fontSize: 20,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
