import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:matrimonial_app/Core/Constant/globle.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/User_Check_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/getAllCandidateDetailModel.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/submit_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Contact_DDetail extends StatefulWidget {
  GetAllCandidateDetailsModel? allCandidateDetailsModel;
  Contact_DDetail({Key? key, this.allCandidateDetailsModel}) : super(key: key);
  @override
  ContactDDetailScreen createState() => ContactDDetailScreen();
}

class ContactDDetailScreen extends State<Contact_DDetail> {
  bool isShowData = false;
  UserCheckModel? _userCheckModel;
  void initState() {
    super.initState();
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8, top: 5),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                Container(
                                  width: width / 2 - 10,
                                  child: Text(
                                    "contactno".tr,
                                    style: TextStyle(
                                      color: Color(
                                        0xff838994,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(':'),
                                Container(
                                  width: width / 2 - 10,
                                  child: (isShowData == false
                                      ? Text(
                                          widget.allCandidateDetailsModel !=
                                                      null &&
                                                  widget.allCandidateDetailsModel!
                                                          .data !=
                                                      null &&
                                                  widget.allCandidateDetailsModel!
                                                          .data!.userContact !=
                                                      null
                                              ? (widget
                                                              .allCandidateDetailsModel!
                                                              .data!
                                                              .userContact!
                                                              .mobile !=
                                                          null &&
                                                      widget
                                                              .allCandidateDetailsModel!
                                                              .data!
                                                              .userContact!
                                                              .mobile !=
                                                          '')
                                                  ? " " +
                                                      widget
                                                          .allCandidateDetailsModel!
                                                          .data!
                                                          .userContact!
                                                          .mobile
                                                          .toString()
                                                          .substring(0, 5) +
                                                      "*****"
                                                  : " N/A"
                                              : "",
                                          style: TextStyle(height: 1.5),
                                        )
                                      : Text(
                                          widget.allCandidateDetailsModel !=
                                                      null &&
                                                  widget.allCandidateDetailsModel!
                                                          .data !=
                                                      null &&
                                                  widget.allCandidateDetailsModel!
                                                          .data!.userContact !=
                                                      null
                                              ? (widget
                                                              .allCandidateDetailsModel!
                                                              .data!
                                                              .userContact!
                                                              .mobile !=
                                                          null &&
                                                      widget
                                                              .allCandidateDetailsModel!
                                                              .data!
                                                              .userContact!
                                                              .mobile !=
                                                          '')
                                                  ? " " +
                                                      widget
                                                          .allCandidateDetailsModel!
                                                          .data!
                                                          .userContact!
                                                          .mobile
                                                          .toString()
                                                  : " N/A"
                                              : "",
                                          style: TextStyle(height: 1.5),
                                        )),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                Container(
                                  width: width / 2 - 10,
                                  child: Text(
                                    "alternate no".tr,
                                    style: TextStyle(
                                      color: Color(
                                        0xff838994,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(':'),
                                Container(
                                  width: width / 2 - 10,
                                  child: (isShowData == false
                                      ? Text(
                                          widget.allCandidateDetailsModel !=
                                                      null &&
                                                  widget.allCandidateDetailsModel!
                                                          .data !=
                                                      null &&
                                                  widget.allCandidateDetailsModel!
                                                          .data!.userContact !=
                                                      null
                                              ? (widget
                                                              .allCandidateDetailsModel!
                                                              .data!
                                                              .userContact!
                                                              .altMobile !=
                                                          null &&
                                                      widget
                                                              .allCandidateDetailsModel!
                                                              .data!
                                                              .userContact!
                                                              .altMobile !=
                                                          '')
                                                  ? " " +
                                                      widget
                                                          .allCandidateDetailsModel!
                                                          .data!
                                                          .userContact!
                                                          .altMobile
                                                          .toString()
                                                          .substring(0, 5) +
                                                      "*****"
                                                  : " N/A"
                                              : "",
                                          style: TextStyle(height: 1.5),
                                        )
                                      : Text(
                                          widget.allCandidateDetailsModel !=
                                                      null &&
                                                  widget.allCandidateDetailsModel!
                                                          .data !=
                                                      null &&
                                                  widget.allCandidateDetailsModel!
                                                          .data!.userContact !=
                                                      null
                                              ? (widget
                                                              .allCandidateDetailsModel!
                                                              .data!
                                                              .userContact!
                                                              .altMobile !=
                                                          null &&
                                                      widget
                                                              .allCandidateDetailsModel!
                                                              .data!
                                                              .userContact!
                                                              .altMobile !=
                                                          '')
                                                  ? " " +
                                                      widget
                                                          .allCandidateDetailsModel!
                                                          .data!
                                                          .userContact!
                                                          .altMobile
                                                          .toString()
                                                  : " N/A"
                                              : "",
                                          style: TextStyle(height: 1.5),
                                        )),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                Container(
                                  width: width / 2 - 10,
                                  child: Text(
                                    "emailid".tr,
                                    style: TextStyle(
                                      color: Color(
                                        0xff838994,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(':'),
                                Container(
                                  width: width / 2 - 10,
                                  child: (isShowData == false)
                                      ? Text(
                                          widget.allCandidateDetailsModel != null &&
                                                  widget.allCandidateDetailsModel!.data !=
                                                      null &&
                                                  widget.allCandidateDetailsModel!
                                                          .data!.userContact !=
                                                      null
                                              ? (widget
                                                              .allCandidateDetailsModel!
                                                              .data!
                                                              .userContact!
                                                              .email !=
                                                          null &&
                                                      widget
                                                              .allCandidateDetailsModel!
                                                              .data!
                                                              .userContact!
                                                              .email !=
                                                          '')
                                                  ? " " +
                                                      widget
                                                          .allCandidateDetailsModel!
                                                          .data!
                                                          .userContact!
                                                          .email
                                                          .toString()
                                                          .replaceRange(
                                                              0,
                                                              widget.allCandidateDetailsModel!.data!.userContact!.email.indexOf("@") - 0,
                                                              "*******")
                                                  : " N/A"
                                              : "",
                                          style: TextStyle(height: 1.5),
                                        )
                                      : Text(
                                          widget.allCandidateDetailsModel !=
                                                      null &&
                                                  widget.allCandidateDetailsModel!
                                                          .data !=
                                                      null &&
                                                  widget.allCandidateDetailsModel!
                                                          .data!.userContact !=
                                                      null
                                              ? (widget
                                                              .allCandidateDetailsModel!
                                                              .data!
                                                              .userContact!
                                                              .email !=
                                                          null &&
                                                      widget
                                                              .allCandidateDetailsModel!
                                                              .data!
                                                              .userContact!
                                                              .email !=
                                                          '')
                                                  ? " " +
                                                      widget
                                                          .allCandidateDetailsModel!
                                                          .data!
                                                          .userContact!
                                                          .email
                                                          .toString()
                                                  : " N/A"
                                              : "",
                                          style: TextStyle(height: 1.5),
                                        ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                Container(
                                  width: width / 2 - 10,
                                  child: Text(
                                    "address".tr,
                                    style: TextStyle(
                                      color: Color(
                                        0xff838994,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(':'),
                                Container(
                                    width: width / 2 - 10,
                                    child: Text(
                                      widget.allCandidateDetailsModel != null &&
                                              widget.allCandidateDetailsModel!
                                                      .data !=
                                                  null &&
                                              widget.allCandidateDetailsModel!
                                                      .data!.userContact !=
                                                  null
                                          ? (widget
                                                          .allCandidateDetailsModel!
                                                          .data!
                                                          .userContact!
                                                          .address !=
                                                      null &&
                                                  widget
                                                          .allCandidateDetailsModel!
                                                          .data!
                                                          .userContact!
                                                          .address !=
                                                      '')
                                              ? " " +
                                                  widget
                                                      .allCandidateDetailsModel!
                                                      .data!
                                                      .userContact!
                                                      .address
                                                      .toString()
                                              : " N/A"
                                          : "",
                                      /* "", */
                                      style: TextStyle(height: 1.5),
                                    ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                Container(
                                  width: width / 2 - 10,
                                  child: Text(
                                    "state".tr,
                                    style: TextStyle(
                                      color: Color(
                                        0xff838994,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(':'),
                                Container(
                                  width: width / 2 - 10,
                                  child: Text(
                                    widget.allCandidateDetailsModel != null &&
                                            widget.allCandidateDetailsModel!
                                                    .data !=
                                                null &&
                                            widget.allCandidateDetailsModel!
                                                    .data!.userContact !=
                                                null
                                        ? (widget.allCandidateDetailsModel!.data!
                                                        .userContact!.state !=
                                                    null &&
                                                widget
                                                        .allCandidateDetailsModel!
                                                        .data!
                                                        .userContact!
                                                        .state !=
                                                    '')
                                            ? " " +
                                                widget.allCandidateDetailsModel!
                                                    .data!.userContact!.state
                                                    .toString()
                                            : " N/A"
                                        : "",
                                    style: TextStyle(height: 1.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                Container(
                                  width: width / 2 - 10,
                                  child: Text(
                                    "pincode".tr,
                                    style: TextStyle(
                                      color: Color(
                                        0xff838994,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(':'),
                                Container(
                                  width: width / 2 - 10,
                                  child: (isShowData == false)
                                      ? Text(
                                          widget.allCandidateDetailsModel != null &&
                                                  widget.allCandidateDetailsModel!.data !=
                                                      null &&
                                                  widget.allCandidateDetailsModel!
                                                          .data!.userContact !=
                                                      null
                                              ? (widget.allCandidateDetailsModel!.data!.userContact!.pincode != null &&
                                                      widget
                                                              .allCandidateDetailsModel!
                                                              .data!
                                                              .userContact!
                                                              .pincode !=
                                                          '')
                                                  ? " " +
                                                      widget
                                                          .allCandidateDetailsModel!
                                                          .data!
                                                          .userContact!
                                                          .pincode
                                                          .toString()
                                                          .replaceRange(
                                                              0,
                                                              widget
                                                                      .allCandidateDetailsModel!
                                                                      .data!
                                                                      .userContact!
                                                                      .pincode!
                                                                      .length -
                                                                  0,
                                                              "******")
                                                  : " N/A"
                                              : "",
                                          style: TextStyle(height: 1.5),
                                        )
                                      : Text(
                                          widget.allCandidateDetailsModel !=
                                                      null &&
                                                  widget.allCandidateDetailsModel!
                                                          .data !=
                                                      null &&
                                                  widget.allCandidateDetailsModel!
                                                          .data!.userContact !=
                                                      null
                                              ? (widget
                                                              .allCandidateDetailsModel!
                                                              .data!
                                                              .userContact!
                                                              .pincode !=
                                                          null &&
                                                      widget
                                                              .allCandidateDetailsModel!
                                                              .data!
                                                              .userContact!
                                                              .pincode !=
                                                          '')
                                                  ? " " +
                                                      widget
                                                          .allCandidateDetailsModel!
                                                          .data!
                                                          .userContact!
                                                          .pincode
                                                          .toString()
                                                  : " N/A"
                                              : "",
                                          style: TextStyle(height: 1.5),
                                        ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                Container(
                                  width: width / 2 - 10,
                                  child: Text(
                                    "country".tr,
                                    style: TextStyle(
                                      color: Color(
                                        0xff838994,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(':'),
                                Container(
                                  width: width / 2 - 10,
                                  child: Text(
                                    widget.allCandidateDetailsModel != null &&
                                            widget.allCandidateDetailsModel!
                                                    .data !=
                                                null &&
                                            widget.allCandidateDetailsModel!
                                                    .data!.userContact !=
                                                null
                                        ? (widget.allCandidateDetailsModel!.data!
                                                        .userContact!.country !=
                                                    null &&
                                                widget
                                                        .allCandidateDetailsModel!
                                                        .data!
                                                        .userContact!
                                                        .country !=
                                                    '')
                                            ? " " +
                                                widget.allCandidateDetailsModel!
                                                    .data!.userContact!.country
                                                    .toString()
                                            : " N/A"
                                        : "",
                                    style: TextStyle(height: 1.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          _userCheckModel != null && _userCheckModel!.data !=null
              ? (isPreminum == true ||
                      _userCheckModel!.data!.paymentStatus == 1)
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 16),
                      child: CommonButton(
                          btnName: "Request to edit",
                          btnOnTap: () {
                            setState(() {
                              isShowData = true;
                            });
                          }),
                    )
                  : Container()
              : Container()
        ],
      ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getUserCheck();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getUserCheck();
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Alert"),
              content: Text("Check Your Internet Connection"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok")),
              ],
            );
          });
    }
  }

  getUserCheck() async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.get(USER_TOKEN);
    var response = await dio.get(USER_CHECK_URL + "?token=$userToken");
    if (response.statusCode == 200) {
      setState(() {
        _userCheckModel = UserCheckModel.fromJson(response.data);
      });

      print("user check  response ::: ${_userCheckModel!.data!.paymentStatus}");
    }
  }

  Widget detailtext(String text) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
        child: Text(text, style: detailtextname),
      ),
    );
  }

  Widget detailedit(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: AppColors.borderdetail,
            width: 1,
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 8.0, right: 8.0, top: 12, bottom: 12),
          child: Text(
            text,
            style: detaileditname,
          ),
        ),
      ),
    );
  }
}
