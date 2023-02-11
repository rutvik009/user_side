import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/getNotificationModel.dart'
    as notification;
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/getNotificationReadModel.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/User_Detail_Screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Notification/no_notification.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notification_Screen extends StatefulWidget {
  const Notification_Screen({Key? key}) : super(key: key);

  @override
  State<Notification_Screen> createState() => _Notification_ScreenState();
}

class _Notification_ScreenState extends State<Notification_Screen> {
  int? _selectedIndex;
  Dio dio = Dio();
  notification.getNotificationModel? _notificationModel;
  getNotificationReadModel? _notificationReadModel;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leadingWidth: 40,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context, "Notifcation");
              },
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
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
              "notification".tr,
              style: headingStyle.copyWith(
                  color: Color(0xff440312),
                  fontSize: 21,
                  fontWeight: FontWeight.w600),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CommonAppbar1(name: "notification".tr),
            (_notificationModel != null &&
                    _notificationModel!.data != null &&
                    _notificationModel!.data == 0)
                ? NoNotification()
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          /* (_notificationModel != null &&
                                  _notificationModel!.data != null &&
                                  _notificationModel!.data == 0)
                              ? Center(child: Text("You have no notification"))
                              : Center(child: Text("You have no notification")), */
                          /*   Container(
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: _notificationModel != null &&
                                            _notificationModel!.data != null
                                        ? _notificationModel!.data!.length
                                        : 0,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      UserDetailScreen(
                                                        userDetailIndex:
                                                            _notificationModel!
                                                                .data![index]
                                                                .userId,
                                                      )));
                                        },
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 53,
                                                width: 53,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(
                                                        color: currentColor,
                                                        width: 2)),
                                                child: /*  Text(
                                                "${_notificationModel!.data![index].image}")  */
                                                    _notificationModel!
                                                                .data![index]
                                                                .image !=
                                                            null
                                                        ? CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(
                                                              _notificationModel!
                                                                  .data![index]
                                                                  .image!
                                                                  .filePath
                                                                  .toString(),
                                                            ),
                                                          )
                                                        : CircleAvatar(
                                                            backgroundImage:
                                                                AssetImage(
                                                                    "assets/images/no_image.png"),
                                                          ),
                                              ),
                                              SizedBox(
                                                width: 13,
                                              ),
                                              Expanded(
                                                child: Text(
                                                    _notificationModel !=
                                                                null &&
                                                            _notificationModel!
                                                                    .data !=
                                                                null
                                                        ? _notificationModel!
                                                            .data![index]
                                                            .notification
                                                            .toString()
                                                        : "",
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: mark.copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            _notificationModel!
                                                                        .data![
                                                                            index]
                                                                        .read ==
                                                                    '1'
                                                                ? FontWeight
                                                                    .normal
                                                                : FontWeight
                                                                    .w600)),
                                              ),
                                              SizedBox(
                                                width: 33,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _onItemTapped(index);
                                                    log(_notificationModel!
                                                        .data![index]
                                                        .notificationId
                                                        .toString());
                                                    getNotificationReadApi(
                                                        index);
                                                  });
                                                },
                                                child: Container(
                                                  height: 31,
                                                  width: 81,
                                                  decoration:
                                                      _notificationModel!
                                                                  .data![index]
                                                                  .read ==
                                                              '0'
                                                          ? BoxDecoration(
                                                              color:
                                                                  currentColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            )
                                                          : BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              border: Border.all(
                                                                  color: Color(
                                                                      0xffCBCBCB),
                                                                  width: 1),
                                                            ),
                                                  child: Center(
                                                      child: Text(
                                                    _notificationModel!
                                                                .data![index]
                                                                .read ==
                                                            '0'
                                                        ? 'View'
                                                        : 'Message',
                                                    style: _notificationModel!
                                                                .data![index]
                                                                .read ==
                                                            '0'
                                                        ? mess1
                                                        : mess,
                                                  )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        thickness: 1,
                                      );
                                    },
                                  ),
                                ),
                              */
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Current Week",
                                /*  "last week".tr, */
                                style: month,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          (_notificationModel != null &&
                                  _notificationModel!.data != null &&
                                  _notificationModel!.data!.week!.length == 0)
                              ? Center(child: Text("You have no notification"))
                              : Container(
                                  child: ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: _notificationModel != null &&
                                            _notificationModel!.data != null
                                        ? _notificationModel!.data!.week!.length
                                        : 0,
                                    itemBuilder: (context, index) {
                                      return /* Center(
                                    child: Text("You have no notification")); */

                                          Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        UserDetailScreen(
                                                      userDetailIndex:
                                                          _notificationModel!
                                                              .data!
                                                              .week![index]
                                                              .userId,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: 53,
                                                width: 53,
                                                child: _notificationModel !=
                                                            null &&
                                                        _notificationModel!
                                                                .data !=
                                                            null &&
                                                        _notificationModel!
                                                                .data!
                                                                .week![index]
                                                                .image !=
                                                            null
                                                    ? CircleAvatar(
                                                        backgroundImage:
                                                            CachedNetworkImageProvider(
                                                          _notificationModel!
                                                              .data!
                                                              .week![index]
                                                              .image!
                                                              .filePath
                                                              .toString(),
                                                        ),
                                                      )
                                                    : CircleAvatar(
                                                        backgroundImage: AssetImage(
                                                            "assets/images/no_image.png"),
                                                      ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 13,
                                            ),
                                            Expanded(
                                              child: Text(
                                                  _notificationModel != null &&
                                                          _notificationModel!
                                                                  .data !=
                                                              null
                                                      ? _notificationModel!
                                                          .data!
                                                          .week![index]
                                                          .notification
                                                          .toString()
                                                      : "",
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: mark.copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          _notificationModel!
                                                                      .data!
                                                                      .week![
                                                                          index]
                                                                      .read ==
                                                                  '1'
                                                              ? FontWeight
                                                                  .normal
                                                              : FontWeight
                                                                  .w600)),
                                            ),
                                            /*  RichText(
                                        text: TextSpan(
                                            text: 'Your Friend ',
                                            style: friend.copyWith(
                                                fontWeight: FontWeight.w600),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      'Mark Parker \nGoing Live  -2 min',
                                                  style: mark)
                                            ]),
                                      ), */
                                            SizedBox(
                                              width: 33,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _onItemTapped(index);
                                                  log(_notificationModel!
                                                      .data!
                                                      .week![index]
                                                      .notificationId
                                                      .toString());
                                                  getNotificationReadApi(
                                                      _notificationModel!
                                                          .data!
                                                          .week![index]
                                                          .notificationId
                                                          .toString());
                                                });
                                              },
                                              child: Container(
                                                height: 31,
                                                width: 81,
                                                decoration: _notificationModel!
                                                            .data!
                                                            .week![index]
                                                            .read ==
                                                        '0'
                                                    ? BoxDecoration(
                                                        color: currentColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      )
                                                    : BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xffCBCBCB),
                                                            width: 1),
                                                      ),
                                                child: Center(
                                                    child: Text(
                                                  _notificationModel!
                                                              .data!
                                                              .week![index]
                                                              .read ==
                                                          '0'
                                                      ? 'View'
                                                      : 'Message',
                                                  style: _notificationModel!
                                                              .data!
                                                              .week![index]
                                                              .read ==
                                                          '0'
                                                      ? mess1
                                                      : mess,
                                                )),
                                              ),
                                            ),
                                            /* _message() */
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Divider();
                                    },
                                  ),
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Older",
                                // "this month".tr,
                                style: month,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          (_notificationModel != null &&
                                  _notificationModel!.data != null &&
                                  _notificationModel!.data!.year!.length == 0)
                              ? Center(child: Text("You have no notification"))
                              : Container(
                                  child: ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: _notificationModel != null &&
                                            _notificationModel!.data != null
                                        ? _notificationModel!.data!.year!.length
                                        : 0,
                                    itemBuilder: (context, index) {
                                      return /* Center(
                                    child: Text("You have no notification")); */

                                          Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        UserDetailScreen(
                                                      userDetailIndex:
                                                          _notificationModel!
                                                              .data!
                                                              .year![index]
                                                              .userId,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: 53,
                                                width: 53,
                                                child: _notificationModel !=
                                                            null &&
                                                        _notificationModel!
                                                                .data !=
                                                            null &&
                                                        _notificationModel!
                                                                .data!
                                                                .year![index]
                                                                .image!
                                                                .filePath !=
                                                            null
                                                    ? CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                                _notificationModel!
                                                                    .data!
                                                                    .year![
                                                                        index]
                                                                    .image!
                                                                    .filePath
                                                                    .toString()),
                                                      )
                                                    : CircleAvatar(
                                                        backgroundImage:
                                                            AssetImage(ImagePath
                                                                .userdefault),
                                                      ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 13,
                                            ),
                                            Expanded(
                                              child: Text(
                                                  _notificationModel != null &&
                                                          _notificationModel!
                                                                  .data !=
                                                              null
                                                      ? _notificationModel!
                                                          .data!
                                                          .year![index]
                                                          .notification
                                                          .toString()
                                                      : "",
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: mark.copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          _notificationModel!
                                                                      .data!
                                                                      .year![
                                                                          index]
                                                                      .read ==
                                                                  '1'
                                                              ? FontWeight
                                                                  .normal
                                                              : FontWeight
                                                                  .w600)),
                                            ),
                                            /*  RichText(
                                        text: TextSpan(
                                            text: 'Your Friend ',
                                            style: friend.copyWith(
                                                fontWeight: FontWeight.w600),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      'Mark Parker \nGoing Live  -2 min',
                                                  style: mark)
                                            ]),
                                      ), */
                                            SizedBox(
                                              width: 33,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _onItemTapped(index);
                                                  log(_notificationModel!
                                                      .data!
                                                      .year![index]
                                                      .notificationId
                                                      .toString());
                                                  getNotificationReadApi(
                                                      _notificationModel!
                                                          .data!
                                                          .year![index]
                                                          .notificationId
                                                          .toString());
                                                });
                                              },
                                              child: Container(
                                                height: 31,
                                                width: 81,
                                                decoration: _notificationModel!
                                                            .data!
                                                            .year![index]
                                                            .read ==
                                                        '0'
                                                    ? BoxDecoration(
                                                        color: currentColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      )
                                                    : BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xffCBCBCB),
                                                            width: 1),
                                                      ),
                                                child: Center(
                                                    child: Text(
                                                  _notificationModel!
                                                              .data!
                                                              .year![index]
                                                              .read ==
                                                          '0'
                                                      ? 'View'
                                                      : 'Message',
                                                  style: _notificationModel!
                                                              .data!
                                                              .year![index]
                                                              .read ==
                                                          '0'
                                                      ? mess1
                                                      : mess,
                                                )),
                                              ),
                                            ),
                                            /* _message() */
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Divider();
                                    },
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getNotificationAPi();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getNotificationAPi();
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

  getNotificationAPi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": userToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_NOTIFICATION_URL + "?" + queryString);
    if (response.statusCode == 200) {
      var result = response.data;
      if (result['success'] == true) {
        setState(() {
          _notificationModel =
              notification.getNotificationModel.fromJson(result);
        });
      }

      print(response.data);
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
    }
  }

  getNotificationReadApi(var notificationId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    CommonUtils.showProgressLoading(context);
    var userToken = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": userToken.toString(),
      "notification_id": notificationId,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_NOTIFICATIONREAD_URL + "?" + queryString);
    if (response.statusCode == 200) {
      CommonUtils.hideProgressLoading();
      getNotificationReadModel _notificationReadModel =
          getNotificationReadModel.fromJson(response.data);
      getNotificationAPi();
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
    }
  }
}

/* import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/getNotificationModel.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/getNotificationReadModel.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/User_Detail_Screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Notification/chat_screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Notification/no_notification.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/Utils/value_constant.dart';
import 'package:matrimonial_app/widget/commonappbar_search.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notification_Screen extends StatefulWidget {
  const Notification_Screen({Key? key}) : super(key: key);

  @override
  State<Notification_Screen> createState() => _Notification_ScreenState();
}

class _Notification_ScreenState extends State<Notification_Screen> {
  int? _selectedIndex;
  Dio dio = Dio();
  getNotificationModel? _notificationModel;
  getNotificationReadModel? _notificationReadModel;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppbar1(name: "notification".tr),
            (_notificationModel != null &&
                    _notificationModel!.data != null &&
                    _notificationModel!.data!.week!.length == 0)
                ? NoNotification()
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          /* (_notificationModel != null &&
                                  _notificationModel!.data != null &&
                                  _notificationModel!.data!.length > 0)
                              ? Container(
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: _notificationModel != null &&
                                            _notificationModel!.data != null
                                        ? _notificationModel!.data!.length
                                        : 0,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      UserDetailScreen(
                                                        userDetailIndex:
                                                            _notificationModel!
                                                                .data![index]
                                                                .userId,
                                                      )));
                                        },
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 53,
                                                width: 53,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(
                                                        color: currentColor,
                                                        width: 2)),
                                                child: /*  Text(
                                                "${_notificationModel!.data![index].image}")  */
                                                    _notificationModel!
                                                                .data![index]
                                                                .image !=
                                                            null
                                                        ? CircleAvatar(
                                                            backgroundImage: NetworkImage(
                                                                _notificationModel!
                                                                    .data![
                                                                        index]
                                                                    .image!
                                                                    .filePath
                                                                    .toString()))
                                                        : CircleAvatar(
                                                            backgroundImage:
                                                                AssetImage(
                                                                    "assets/images/no_image.png"),
                                                          ),
                                              ),
                                              SizedBox(
                                                width: 13,
                                              ),
                                              Expanded(
                                                child: Text(
                                                    _notificationModel !=
                                                                null &&
                                                            _notificationModel!
                                                                    .data !=
                                                                null
                                                        ? _notificationModel!
                                                            .data![index]
                                                            .notification
                                                            .toString()
                                                        : "",
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: mark.copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            _notificationModel!
                                                                        .data![
                                                                            index]
                                                                        .read ==
                                                                    '1'
                                                                ? FontWeight
                                                                    .normal
                                                                : FontWeight
                                                                    .w600)),
                                              ),
                                              SizedBox(
                                                width: 33,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _onItemTapped(index);
                                                    log(_notificationModel!
                                                        .data![index]
                                                        .notificationId
                                                        .toString());
                                                    getNotificationReadApi(
                                                        index);
                                                  });
                                                },
                                                child: Container(
                                                  height: 31,
                                                  width: 81,
                                                  decoration:
                                                      _notificationModel!
                                                                  .data![index]
                                                                  .read ==
                                                              '0'
                                                          ? BoxDecoration(
                                                              color:
                                                                  currentColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            )
                                                          : BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              border: Border.all(
                                                                  color: Color(
                                                                      0xffCBCBCB),
                                                                  width: 1),
                                                            ),
                                                  child: Center(
                                                      child: Text(
                                                    _notificationModel!
                                                                .data![index]
                                                                .read ==
                                                            '0'
                                                        ? 'View'
                                                        : 'Message',
                                                    style: _notificationModel!
                                                                .data![index]
                                                                .read ==
                                                            '0'
                                                        ? mess1
                                                        : mess,
                                                  )),
                                                ),
                                              ),
                                              
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        thickness: 1,
                                      );
                                    },
                                  ),
                                )
                              : Container(),
                             SizedBox(
                            height: 20,
                          ), */
                         Row(
                            children: [
                              Text(
                                "last week".tr,
                                style: month,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Center(
                                    child: Text("You have no notification"));

                                /*   Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 53,
                                        width: 53,
                                        child: CircleAvatar(
                                          backgroundImage:
                                              AssetImage(week[index][IMAGE]),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            text: 'Your Friend ',
                                            style: friend.copyWith(
                                                fontWeight: FontWeight.w600),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      'Mark Parker \nGoing Live  -2 min',
                                                  style: mark)
                                            ]),
                                      ),
                                      SizedBox(
                                        width: 33,
                                      ),
                                      _message()
                                    ],
                                  ),
                                );
                               */
                              },
                              separatorBuilder: (context, index) {
                                return Divider();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "this month".tr,
                                style: month,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Center(
                                    child: Text("You have no notification"));
                                /*    Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 53,
                                        width: 53,
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              lastmonth[index][IMAGE]),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            text: 'Your Friend ',
                                            style: friend.copyWith(
                                                fontWeight: FontWeight.w600),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      'Mark Parker \nGoing Live  -2 min',
                                                  style: mark)
                                            ]),
                                      ),
                                      SizedBox(
                                        width: 33,
                                      ),
                                      _message()
                                    ],
                                  ),
                                );
                               */
                              },
                              separatorBuilder: (context, index) {
                                return Divider();
                              },
                            ),
                          )
                        
                        ],
                      ),
                    ),
                  ),SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  _view() {
    return Container(
      height: 31,
      width: 81,
      decoration: BoxDecoration(
          color: Color(0xffFB5A57),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Color(0xffCBCBCB), width: 1)),
      child: Center(
          child: Text(
        AppConstants.view,
        style: mess.copyWith(color: Colors.white),
      )),
    );
  }

  _message() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => Chat_screen()));
      },
      child: Container(
        height: 31,
        width: 81,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Color(0xffCBCBCB), width: 1)),
        child: Center(
            child: Text(
          AppConstants.messageWord,
          style: mess,
        )),
      ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getNotificationAPi();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getNotificationAPi();
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

  getNotificationAPi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": userToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_NOTIFICATION_URL + "?" + queryString);
    if (response.statusCode == 200) {
      var result = response.data;
      if (result['success'] == true) {
        setState(() {
          _notificationModel = getNotificationModel.fromJson(result);
        });
      }

      print(response.data);
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
    }
  }

  /* getNotificationReadApi(int index) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": userToken.toString(),
      "notification_id":
          _notificationModel!.data![index].notificationId.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_NOTIFICATIONREAD_URL + "?" + queryString);
    if (response.statusCode == 200) {
      getNotificationReadModel _notificationReadModel =
          getNotificationReadModel.fromJson(response.data);
      getNotificationAPi();
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
    }
  } */
}
 */