import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/Ui/DetailsScreen/details_screen.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/submit_button.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Home_screen/Home/Drawer_Screen.dart';

class OTPScreen extends StatefulWidget {
  String text, mobile, email, fromValue;
  bool? isSuccess;
  OTPScreen(
      {Key? key,
      required this.text,
      required this.mobile,
      required this.email,
      required this.fromValue,
      this.isSuccess,
      String? countryCode})
      : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool otperror = false;
  FToast? fToast;
  Timer? _timer;
  int _start = 030;
  String? otp;
  bool isOtpShow = false;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 00) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  final pinController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 100), () {
      isOtpShow = true;
    });
    fToast = FToast();
    fToast!.init(context);

    startTimer();
    Future.delayed(Duration(seconds: 2), () {
      otpShow();
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  void otpShow() {
    Future.delayed(Duration(seconds: 1), () {
      isOtpShow = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffE5E5E5),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, 'isOtpBack');
          },
          child: Center(
              child: Image.asset(
            ImagePath.backArrow,
            width: 28,
            height: 28,
          )),
        ),
        title: Text(
          AppConstants.verification,
          style: fontStyle.copyWith(
            color: Color(0xff333F52),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        color: Color(0xffE5E5E5),
        height: height,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  RichText(
                    text: TextSpan(
                        text: "We have sent an OTP to ",
                        style: fontStyle.copyWith(color: Color(0xff838994)),
                        children: widget.mobile == "" || widget.mobile == null
                            ? [
                                TextSpan(
                                    text: '*****',
                                    style: fontStyle.copyWith(
                                        fontWeight: FontWeight.w600)),
                                TextSpan(
                                    text: widget.email
                                        .substring(widget.email.length - 10),
                                    style: fontStyle.copyWith(
                                        fontWeight: FontWeight.w600))
                              ]
                            : [
                                TextSpan(
                                    text: '+91 XXXXX ',
                                    style: fontStyle.copyWith(
                                        fontWeight: FontWeight.w600)),
                                TextSpan(
                                    text: widget.mobile
                                        .substring(widget.mobile.length - 5),
                                    style: fontStyle.copyWith(
                                        fontWeight: FontWeight.w600))
                              ]),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Pinput(
                    controller: pinController,
                    length: 6,
                    cursor: Container(
                      height: 19.87,
                      width: 2,
                      color: Color(0xff57606F).withOpacity(0.1),
                    ),
                    showCursor: true,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    submittedPinTheme: PinTheme(
                      width: 52,
                      height: 48,
                      textStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400),
                      decoration: BoxDecoration(
                        color: currentColor,
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: 52,
                      height: 48,
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
                      height: 48,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 5, right: 0),
                    child: otperror == true
                        ? Center(
                            child: Text(
                              'Otp is invalid',
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : otperror == false && isOtpShow == false
                            ? Text("")
                            : Center(
                                child: Text('OTP Sent Successfully',
                                    style: TextStyle(color: Colors.red)),
                              ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Text(
                      "00:$_start",
                      style: fontStyle,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                          text: "Didn’t Receive The code?",
                          style: fontStyle.copyWith(
                              color: Color(0xff677294),
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                          children: [
                            TextSpan(
                                text: " Resend Now",
                                style: fontStyle.copyWith(
                                    color: Color(0xffFB5A57),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14))
                          ]),
                    ),
                  ),
                  isOtpShow == true
                      ? Padding(
                          padding: const EdgeInsets.all(16),
                          child: CommonButton(
                              btnName: 'Verify Now', btnOnTap: () {}),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CommonButton(
                            btnName: 'Verify Now',
                            btnOnTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              if (widget.text == pinController.text) {
                                if (widget.isSuccess == true &&
                                    widget.fromValue == "Login") {
                                  // if (widget.fromValue == "Login") {
                                  prefs.setBool(SHOWOTPSCREEN, true);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Zoom()),
                                      (route) => false);
                                } else if (widget.fromValue == "isRegister") {
                                  Navigator.pop(context);
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Detail_screen(
                                          userNumber: widget.mobile,
                                        ),
                                      ));
                                }
                                /*  } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Detail_screen(
                                          userNumber: widget.mobile,
                                        ),
                                      ));
                                } */
                              } else {
                                otperror = true;
                              }
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
