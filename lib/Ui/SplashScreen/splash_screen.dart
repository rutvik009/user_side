import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/Ui/DetailsScreen/Upload_Images.dart';
import 'package:matrimonial_app/Ui/DetailsScreen/details_screen.dart';
import 'package:matrimonial_app/Ui/DetailsScreen/upload_image.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';

import 'package:matrimonial_app/Ui/Home_screen/Home/Drawer_Screen.dart';
import 'package:matrimonial_app/Ui/Login/login_screen.dart';
import 'package:matrimonial_app/Ui/OnBoardingScreen/onBoardingView/onBoardingScreen.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({Key? key}) : super(key: key);

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  bool? showOnboarding;
  bool? showLogin;
  bool? showRegister;
  bool? showPersonalDetails;
  bool? showUploadImage;
  bool? showOtp;
  bool? exeShowLogin;
  bool? exeShowOtp;
  int? selectColor;
  String? mobileNo;
  getOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      exeShowOtp = prefs.getBool(EXESHOWOTP);
      exeShowLogin = prefs.getBool(EXESHOWLOGIN);
      showOnboarding = prefs.getBool(SHOWONBOARDING);
      showLogin = prefs.getBool(SHOWLOGIN);
      showRegister = prefs.getBool(SHOWREGISTER);
      showPersonalDetails = prefs.getBool(SHOWPERSONALDETAILS);
      showUploadImage = prefs.getBool(SHOWUPLOADIMAGE);
      showOtp = prefs.getBool(SHOWOTPSCREEN);
      selectColor = prefs.getInt(SELECTCOLOR);
      mobileNo = prefs.getString(USER_MOBILE);
      log("show login user ++++++ " + showLogin.toString());
      log(" show otp user ------------ " + showOtp.toString());
      log("show Register user ++++++ " + showRegister.toString());
      log(" show personal ------------ " + showPersonalDetails.toString());
      log(" show image ------------ " + showUploadImage.toString());

      if (showOnboarding == null || showLogin == null) {
        prefs.setBool(SHOWONBOARDING, false);
        prefs.setBool(SHOWLOGIN, false);
        prefs.setBool(SHOWOTPSCREEN, false);
        prefs.setBool(SHOWPERSONALDETAILS, false);
        prefs.setBool(SHOWUPLOADIMAGE, false);
      } else if (exeShowLogin == null) {
        prefs.setBool(EXESHOWLOGIN, false);
        prefs.setBool(EXESHOWOTP, false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setFirstTime("true");
    getOnboarding();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          if (showOnboarding == true) {
            if (showLogin == true && showOtp == true) {
              if (selectColor == 4284717308) {
                currentGradient = [
                  Color(0xff6398FC),
                  Color(0xff6398FC),
                ];
                currentColor = Color(0xff6398FC);
                isSelected = 1;
              } else if (selectColor == 4293817602) {
                currentGradient = [
                  const Color(0xffEE7502),
                  const Color(0xffEE7502),
                ];
                currentColor = const Color(0xffEE7502);
                isSelected = 2;
              } else {
                currentGradient = [Color(0xffFC7358), Color(0xffFA2457)];
                currentColor = Color.fromARGB(255, 250, 65, 65);
                isSelected = 0;
              }

              Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(
                    builder: (context) => Zoom(),
                  ),
                  (route) => false);
            } /* else if (exeShowLogin == true && exeShowOtp == true) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DrawerScreen()),
                  (route) => false);
            } */ else {
              if (showRegister == true && showPersonalDetails == false) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Detail_screen(
                        userNumber: mobileNo!,
                      ),
                    ));
              } else if (showRegister == true && showUploadImage == false) {
                //  SharedPreferences prefs = await SharedPreferences.getInstance();
                // String userId = await prefs.getString(USER_ID)!;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => /* DetailScreen2 */UploadImages(
                      userNumber: mobileNo!, /* docId: userId, */
                    ),
                  ),
                );
              } else {
                log("Login $showLogin");
                Navigator.of(context).pushAndRemoveUntil(
                    CupertinoPageRoute(
                      builder: (context) => Login(),
                    ),
                    (route) => false);
              }
            }
          } else {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => Onboarding()));
          }
        });
      }
    });
  }

  void setFirstTime(status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("isFirstTime") != "false") {
      prefs.setString("isFirstTime", status);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(ImagePath.appLogo))),
        ),
      ),
    );
  }
}
