// ignore_for_file: unused_element, must_be_immutable, unnecessary_null_comparison

import 'dart:convert';
import 'dart:developer';

import 'package:blur/blur.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:matrimonial_app/Core/Constant/globle.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/GetProfile_Details/Get_Basic_Detail_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Notificatio_Count_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/user_profile_about_model.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/ContactUs/contact_us.dart';
import 'package:matrimonial_app/Ui/Drawer/RefferalScreen/refferal_screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/BottomBar.dart';
import 'package:matrimonial_app/Ui/Login/login_screen.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/security_question.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:matrimonial_app/Ui/Drawer/ProfileScreen/profile_screenn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../Utils/app_constants.dart';
import '../../../Utils/image_path_constants.dart';
import '../../../Utils/text_styles.dart';
import '../../Drawer/AccountSettingScreen/account_screen.dart';
import '../Notification/notification.dart';

const Color p = Color(0xff416d69);
final ZoomDrawerController z = ZoomDrawerController();
NotificationCountModel? _notificationCountModel;

class Zoom extends StatefulWidget {
  int? selectedIndex;
  Zoom({Key? key, this.selectedIndex}) : super(key: key);

  @override
  _ZoomState createState() => _ZoomState();
}

class _ZoomState extends State<Zoom> {
  UserAboutMeModel? _userAboutMeModel;
  GetBasicDetailModel? _getBasicDetailModel;
  int? blurValue = 0;

  String capitalizeWords(String text) {
    List<String> words = text.split(' ');
    for (int i = 0; i < words.length; i++) {
      words[i] = words[i][0].toUpperCase() + words[i].substring(1);
    }
    return words.join(' ');
  }

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: z,
      borderRadius: 24,
      style: DrawerStyle.defaultStyle,
      showShadow: false,
      openCurve: Curves.slowMiddle,
      slideWidth: MediaQuery.of(context).size.width * 0.73,
      mainScreenTapClose: true,
      disableDragGesture: true,
      duration: Duration(milliseconds: 500),
      angle: 0.0,
      mainScreen: BottombarScreen(
        onfun: "isOntap",
        selectedIndex: widget.selectedIndex,
      ),
      menuBackgroundColor: currentColor,
      menuScreen: Padding(
        padding: EdgeInsets.only(left: 8.0, top: 80),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 71,
                        height: 71,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(width: 2, color: Colors.white)),
                        child: (_userAboutMeModel != null &&
                                _userAboutMeModel!.data != null &&
                                _userAboutMeModel!.data!.profileImage!.length >
                                    0)
                            ? _userAboutMeModel!.data!.blurImage == 1
                                ? Blur(
                                    blur: 1,
                                    borderRadius: BorderRadius.circular(50),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        _userAboutMeModel!
                                            .data!.profileImage![0].filePath
                                            .toString(),
                                        height: 71,
                                        width: 71,
                                        fit: BoxFit.cover,
                                      ),
                                    ))
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        _userAboutMeModel!
                                            .data!.profileImage![0].filePath
                                            .toString()),
                                  )
                            : (_getBasicDetailModel != null &&
                                    _getBasicDetailModel!.data != null &&
                                    _getBasicDetailModel!.data!.gender ==
                                        "Male")
                                ? CircleAvatar(
                                    backgroundImage:
                                        AssetImage(ImagePath.profile),
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        AssetImage(ImagePath.femaleProfileUser),
                                  ),
                      ),
                      Positioned(
                        top: 50,
                        left: 50,
                        child: _userAboutMeModel != null &&
                                _userAboutMeModel!.data!.activeStatus != null &&
                                _userAboutMeModel!.data!.activeStatus == "1"
                            ? Container(
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff31F173),
                                  ),
                                  height: 12,
                                  width: 12,
                                ),
                              )
                            : Container(
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffD2D2D2)
                                      // Color(0xff31F173),
                                      ),
                                  height: 12,
                                  width: 12,
                                ),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          _userAboutMeModel != null &&
                                  _userAboutMeModel!.data != null
                              ? capitalizeWords(_userAboutMeModel!.data!.fullName.toString())
                              : AppConstants.elonMusk,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: elon,
                        ),
                      ),
                      /* Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          _userAboutMeModel != null &&
                                  _userAboutMeModel!.data != null
                              ? _userAboutMeModel!.data!.email.toString()
                              : AppConstants.elonMuskUserName,
                          style: homestyle.copyWith(
                              color: Colors.white.withOpacity(0.60)),
                        ),
                      ), */
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                splashColor: Colors.grey.withOpacity(0.5),
                splashFactory: InkRipple.splashFactory,
                onTap: () async {
                  String? data;
                  final result = await Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => Account_Setting(
                              gender: _getBasicDetailModel!.data!.gender)));
                  setState(() {
                    data = result;
                  });
                  if (data == "blurImg") {
                    getProfileAPI();
                    /* setState(() {
                      blurValue;
                    }); */
                  }
                  log("blur image ----------- $data");
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset(ImagePath.profiledrawer),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        "account settings".tr,
                        style: homestyle.copyWith(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              InkWell(
                splashColor: Colors.grey.withOpacity(0.5),
                splashFactory: InkRipple.splashFactory,
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const Notification_Screen()));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset(ImagePath.notifydrawer),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        "notification".tr,
                        style: homestyle.copyWith(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              InkWell(
                splashColor: Colors.grey.withOpacity(0.5),
                splashFactory: InkRipple.splashFactory,
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => Security_Questions()));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset(ImagePath.lockdrawer),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        "security".tr,
                        style: homestyle.copyWith(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              InkWell(
                splashColor: Colors.grey.withOpacity(0.5),
                splashFactory: InkRipple.splashFactory,
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => Profile(
                                fromValue: "Drawer",
                              )));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset(ImagePath.linkeddrawer),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        "linked accounts".tr,
                        style: homestyle.copyWith(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              InkWell(
                splashColor: Colors.grey.withOpacity(0.5),
                splashFactory: InkRipple.splashFactory,
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (contex) => Contact_Us()));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset(ImagePath.helpdrawer),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        "help center".tr,
                        style: homestyle.copyWith(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              InkWell(
                splashColor: Colors.grey.withOpacity(0.5),
                splashFactory: InkRipple.splashFactory,
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => Refferal_screen()));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset(ImagePath.refreldrawer),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        "refferal".tr,
                        style: homestyle.copyWith(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              InkWell(
                splashColor: Colors.grey.withOpacity(0.5),
                splashFactory: InkRipple.splashFactory,
                onTap: () {
                  _logoutDialogBox();
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Image.asset(ImagePath.logoutdrawer),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        "logout".tr,
                        style: homestyle.copyWith(fontSize: 15),
                      )
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

  checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getProfileAPI();
      getBasicDetail();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getProfileAPI();
      getBasicDetail();
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Alert"),
              content: const Text("Check Your Internet Connection"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Ok")),
              ],
            );
          });
    }
  }

  getProfileAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response =
        await http.get(Uri.parse(GET_PROFILE_ABOUT + "?" + queryString));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 'Token is Expired') {
        pref.setString(USER_TOKEN, "");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (dialogcontext) => Login()),
            (route) => false);
      } else {
        setState(() {
          _userAboutMeModel =
              UserAboutMeModel.fromJson(jsonDecode(response.body));

          log("profile res=========== " + response.body);
        });
      }
    } else if (response.statusCode == 500) {
      Fluttertoast.showToast(
          msg: "Internal Server Error",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xffE16284),
          textColor: Colors.white,
          fontSize: 16.0);
    } else {}
  }

  getBasicDetail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {"token": token.toString()};
    String queryString = Uri(queryParameters: queryParameters).query;
    var response =
        await http.get(Uri.parse(GET_BASIC_DETAIL_URL + "?" + queryString));
    if (response.statusCode == 200) {
      _getBasicDetailModel =
          GetBasicDetailModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 429) {
      getBasicDetail();
    } else if (response.statusCode == 500) {
      Fluttertoast.showToast(
          msg: "Internal Server Error",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xffE16284),
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      // CommonUtils.hideProgressLoading();
    }
  }

  _logoutDialogBox() {
    return showDialog(
      context: context,
      builder: (BuildContext dialogcontext) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          content: Container(
            height: 270,
            width: MediaQuery.of(context).size.width / 1.2,
            decoration: BoxDecoration(
              boxShadow: [
                const BoxShadow(blurRadius: 10.0, color: Colors.black)
              ],
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(dialogcontext);
                      },
                      child: Image.asset(ImagePath.greyCross,
                          height: 28, width: 28),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                currentColor == Color(0xff6398FC)
                    ? Image.asset(ImagePath.deleteBlue, height: 60, width: 60)
                    : currentColor == const Color(0xffEE7502)
                        ? Image.asset(ImagePath.deleteOrange,
                            height: 60, width: 60)
                        : Image.asset(ImagePath.logout, height: 60, width: 60),
                const SizedBox(height: 20),
                Text(
                  "wanttologout".tr,
                  style: headingStyle.copyWith(
                    color: const Color(0xff333F52),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    "ourteam".tr,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: headingStyle.copyWith(
                      color: const Color(0xffAFAFAF),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      setState(() {
                        // blurValue = false;
                        String token = prefs.getString(USER_TOKEN)!;
                        if (token != null) {
                          logout(token);
                          prefs.setBool(SHOWLOGIN, false);
                          prefs.setBool(SHOWOTPSCREEN, false);
                          prefs.setBool(SOCIAL_GOOGLE, false);
                        }
                        // prefs.clear();
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                          color: currentColor,
                          borderRadius: BorderRadius.circular(9)),
                      alignment: Alignment.center,
                      child: Text(
                        "logout".tr,
                        style: appBtnStyle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  logout(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.get(
      Uri.parse(LOGOUT_URL + "?token=$token"),
    );

    if (response.statusCode == 200) {
      print(response.body);
      prefs.setString(USER_TOKEN, "");
      prefs.setString(SWIPEVAL, "0");
      // SchedulerBinding.instance!.addPostFrameCallback((_) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (dialogcontext) => Login()),
          (route) => false);
      // });
    } else if (response.statusCode == 500) {
      Fluttertoast.showToast(
          msg: "Internal Server Error",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xffE16284),
          textColor: Colors.white,
          fontSize: 16.0);
    } else {}
  }
}
