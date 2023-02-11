import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Get_referCode_model.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Login/login_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:share_plus/share_plus.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Core/Constant/value_constants.dart';
import '../../../ModelClass/UserPanel_ModelClass/Get_referCode_model.dart';

class Refferal_screen extends StatefulWidget {
  const Refferal_screen({Key? key}) : super(key: key);

  @override
  State<Refferal_screen> createState() => _Refferal_screenState();
}

class _Refferal_screenState extends State<Refferal_screen> {
  GetReferCodeModel? _getReferCodeModel;
  final String _code = AppConstants.code;

  void _shareContent() {
    Share.share(_code);
  }

  @override
  void initState() {
    checkConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width,
                height: 50,
                child: Padding(
                  padding: EdgeInsets.only(left: 17),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          ImagePath.backArrow,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      Center(
                          child: Text(
                        "referfriend".tr,
                        style: headingStyle.copyWith(
                            fontSize: 20,
                            color: Color(0xff333F52),
                            fontWeight: FontWeight.w600),
                      ))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
                child: Container(
                  height: 231,
                  width: MediaQuery.of(context).size.width * 4,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                    ImagePath.referscreenimage,
                  ))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 33, 16, 0),
                child: Center(
                  child: Text(
                    "invite".tr,
                    style: headingStyle.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "bonus".tr,
                    textAlign: TextAlign.center,
                    style: headingStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffC4C4C4),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 30, 16, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 54,
                  decoration: BoxDecoration(
                    color: currentColor,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width: 14),
                      GestureDetector(
                          onTap: () {
                            print("object");
                            _shareContent();
                          },
                          child: Image.asset(ImagePath.whiteshare,
                              height: 30, width: 30)),
                      Spacer(),
                      Text(
                        _getReferCodeModel != null
                            ? _getReferCodeModel!.data ?? AppConstants.code
                            : '',
                        style: headingStyle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.colorWhite,
                        ),
                      ),
                    
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: "Copied!",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black.withOpacity(0.5),
                              textColor: Colors.white,
                              fontSize: 16.0);
                          Clipboard.setData(
                              ClipboardData(text: AppConstants.code));
                        },
                        child:
                            Image.asset(ImagePath.copy, height: 30, width: 30),
                      ),
                      SizedBox(width: 14),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 30, 11, 0),
                    child: Divider(thickness: 2, color: Color(0xffC9C9D3)),
                  )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 30, 12, 0),
                    child: Image.asset(ImagePath.emoji, height: 28, width: 34),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(11, 30, 16, 0),
                    child: Divider(thickness: 2, color: Color(0xffC9C9D3)),
                  )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Center(
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "total".tr,
                        style: headingStyle.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffC4C4C4)),
                      ),
                      TextSpan(
                        text: "friend".tr,
                        style: headingStyle.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffFB5A57)),
                      ),
                      TextSpan(
                        text: "joining".tr,
                        style: headingStyle.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffC4C4C4)),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getRefercodeApi();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getRefercodeApi();
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

  getRefercodeApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(USER_TOKEN);
    final queryParameters = {
      "token": authToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response =
        await http.get(Uri.parse(GET_REFERCODE_URL + "?" + queryString));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == "Token is Expired") {
        prefs.setString(USER_TOKEN, "");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (dialogcontext) => Login()),
            (route) => false);
      } else {
        setState(() {
          _getReferCodeModel =
              GetReferCodeModel.fromJson(jsonDecode(response.body));
        });
      }
    } else if (response.statusCode == 500) {
      CommonUtils.hideProgressLoading();
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
