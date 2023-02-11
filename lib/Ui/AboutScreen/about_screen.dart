import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/aboutus_model.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/commonappbar_search.dart';

import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:readmore/readmore.dart';

class About_Screen extends StatefulWidget {
  const About_Screen({Key? key}) : super(key: key);

  @override
  State<About_Screen> createState() => _About_ScreenState();
}

class _About_ScreenState extends State<About_Screen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );
  String? version;
  String? appName;
  bool flag = true;
  bool privacyFlag = true;
  bool termsFlag = true;
  String firstHalf = "";
  String secondHalf = "";
  String thirdHalf = "";
  String aboutfirstHalf = "";
  String aboutsecondHalf = "";
  String aboutthirdHalf = "";
  String privacyfirstHalf = "";
  String privacysecondHalf = "";
  String privacythirdHalf = "";

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
      version = info.version;
      appName = info.appName;
    });
    print(version);
    print(appName);
  }

  AboutUsModel _aboutUsModel = AboutUsModel(success: true);
  List<bool> isOpenPrivacy = [];
  List<bool> isOpenTerms = [];
  List<bool> isOpenAbout = [];
  List<String> aboutList = [
    AppConstants.terms,
    AppConstants.privacy,
    AppConstants.community
  ];
  void showHidePrivacy(int i) {
    setState(() {
      isOpenPrivacy[i] = !isOpenPrivacy[i];
    });
  }

  void showHideAbout(int i) {
    setState(() {
      isOpenAbout[i] = !isOpenAbout[i];
    });
  }

  void showHideTerms(int i) {
    setState(() {
      isOpenTerms[i] = !isOpenTerms[i];
    });
  }

  @override
  void initState() {
   if (mounted) {
      getAbouUs();
   }

    super.initState();

    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              CommonAppbar1(name: AppConstants.aboutUs),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*  Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          "Privacy policy",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.greyColor),
                        ),
                      ), */
                      ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: (_aboutUsModel.data != null &&
                                _aboutUsModel.data!.aboutUs != null)
                            ? _aboutUsModel.data!.aboutUs!.length
                            : 0,
                        itemBuilder: ((context, index) {
                          return Column(
                            children: [
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  showHideAbout(index);
                                },
                                child: isOpenAbout[index] == false
                                    ? Container(
                                        color: Colors.transparent,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(width: 16),
                                            Text(
                                              _aboutUsModel
                                                  .data!.aboutUs![index].title
                                                  .toString(),
                                              style: headerstyle.copyWith(
                                                fontSize: 16,
                                                color: Color(0xff333F52),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Spacer(),
                                            Image.asset(ImagePath.settingArrow,
                                                height: 24, width: 24),
                                            SizedBox(width: 16),
                                          ],
                                        ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            color: Colors.transparent,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(width: 16),
                                                Text(
                                                  _aboutUsModel
                                                      .data!.aboutUs![index].title
                                                      .toString(),
                                                  style: headerstyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Spacer(),
                                                Image.asset(ImagePath.downArrow,
                                                    height: 24, width: 24),
                                                SizedBox(width: 16),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16),
                                              child: (_aboutUsModel.data !=
                                                          null &&
                                                      _aboutUsModel
                                                              .data!.aboutUs !=
                                                          null)
                                                  ? aboutsecondHalf.isEmpty
                                                      ? Html(
                                                          data: aboutfirstHalf,
                                                        )
                                                      : Column(
                                                          children: <Widget>[
                                                            new Html(
                                                                data: flag
                                                                    ? (aboutfirstHalf +
                                                                        "...")
                                                                    : (flag)
                                                                        ? (aboutfirstHalf +
                                                                            aboutsecondHalf)
                                                                        : (aboutfirstHalf +
                                                                            aboutsecondHalf)),
                                                            new InkWell(
                                                              child: new Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: <
                                                                    Widget>[
                                                                  new Text(
                                                                    flag
                                                                        ? "show more"
                                                                        : "show less",
                                                                    style: new TextStyle(
                                                                        color: Colors
                                                                            .blue),
                                                                  ),
                                                                ],
                                                              ),
                                                              onTap: () {
                                                                setState(() {
                                                                  flag = !flag;
                                                                });
                                                              },
                                                            ),
                                                          ],
                                                        )
                                                  : Text(""))
                                        ],
                                      ),
                              ),
                              SizedBox(height: 20),
                            ],
                          );
                        }),
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            thickness: 2,
                            color: Color(0xffF1F2F6),
                          );
                        },
                      ),

                      /*  ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: (_aboutUsModel.data != null &&
                                _aboutUsModel.data!.aboutUs != null)
                            ? _aboutUsModel.data!.aboutUs!.length
                            : 0,
                        itemBuilder: ((context, index) {
                          return Column(
                            children: [
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  showHideAbout(index);
                                },
                                child: isOpenAbout[index] == false
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(width: 16),
                                          Text(
                                            _aboutUsModel
                                                .data!.aboutUs![index].title
                                                .toString(),
                                            style: headerstyle.copyWith(
                                              fontSize: 16,
                                              color: Color(0xff333F52),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Spacer(),
                                          Image.asset(ImagePath.settingArrow,
                                              height: 24, width: 24),
                                          SizedBox(width: 16),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              SizedBox(width: 16),
                                              Text(
                                                _aboutUsModel.data!
                                                    .aboutUs![index].title
                                                    .toString(),
                                                style: headerstyle.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Spacer(),
                                              Image.asset(ImagePath.downArrow,
                                                  height: 24, width: 24),
                                              SizedBox(width: 16),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Text(
                                              _aboutUsModel.data!
                                                  .aboutUs![index].content!,
                                              textAlign: TextAlign.start,
                                              style: headerstyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff67707D),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                              ),
                              SizedBox(height: 20),
                            ],
                          );
                        }),
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            thickness: 2,
                            color: Color(0xffF1F2F6),
                          );
                        },
                      ),
                      */
                      Divider(
                        thickness: 2,
                        color: Color(0xffF1F2F6),
                      ),
                      /*  Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          "About Us",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.greyColor),
                        ),
                      ), */
                      ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: (_aboutUsModel.data != null &&
                                _aboutUsModel.data!.privacyPolicy != null)
                            ? _aboutUsModel.data!.privacyPolicy!.length
                            : 0,
                        itemBuilder: ((context, index) {
                          return Column(
                            children: [
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  showHidePrivacy(index);
                                },
                                child: isOpenPrivacy[index] == false
                                    ? Container(
                                      color: Colors.transparent,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(width: 16),
                                            Text(
                                              _aboutUsModel.data!
                                                  .privacyPolicy![index].title
                                                  .toString(),
                                              style: headerstyle.copyWith(
                                                fontSize: 16,
                                                color: Color(0xff333F52),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Spacer(),
                                            Image.asset(ImagePath.settingArrow,
                                                height: 24, width: 24),
                                            SizedBox(width: 16),
                                          ],
                                        ),
                                    )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            color: Colors.transparent,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(width: 16),
                                                Text(
                                                  _aboutUsModel.data!
                                                      .privacyPolicy![index].title
                                                      .toString(),
                                                  style: headerstyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Spacer(),
                                                Image.asset(ImagePath.downArrow,
                                                    height: 24, width: 24),
                                                SizedBox(width: 16),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16),
                                              child: (_aboutUsModel.data !=
                                                          null &&
                                                      _aboutUsModel.data!
                                                              .privacyPolicy !=
                                                          null)
                                                  ? privacysecondHalf.isEmpty
                                                      ? Html(
                                                          data:
                                                              privacyfirstHalf,
                                                        )
                                                      : Column(
                                                          children: <Widget>[
                                                            new Html(
                                                                data: privacyFlag
                                                                    ? (privacyfirstHalf + "...")
                                                                    : (privacyFlag)
                                                                        ? (privacyfirstHalf + privacysecondHalf)
                                                                        : (privacyfirstHalf + privacysecondHalf)),
                                                            new InkWell(
                                                              child: new Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: <
                                                                    Widget>[
                                                                  new Text(
                                                                    privacyFlag
                                                                        ? "show more"
                                                                        : "show less",
                                                                    style: new TextStyle(
                                                                        color: Colors
                                                                            .blue),
                                                                  ),
                                                                ],
                                                              ),
                                                              onTap: () {
                                                                setState(() {
                                                                  privacyFlag =
                                                                      !privacyFlag;
                                                                });
                                                              },
                                                            ),
                                                          ],
                                                        )
                                                  : Text(""))
                                        ],
                                      ),
                              ),
                              SizedBox(height: 20),
                            ],
                          );
                        }),
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            thickness: 2,
                            color: Color(0xffF1F2F6),
                          );
                        },
                      ),

                      /*  ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: (_aboutUsModel.data != null &&
                                _aboutUsModel.data!.privacyPolicy != null)
                            ? _aboutUsModel.data!.privacyPolicy!.length
                            : 0,
                        itemBuilder: ((context, index) {
                          return Column(
                            children: [
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  showHidePrivacy(index);
                                },
                                child: isOpenPrivacy[index] == false
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(width: 16),
                                          Text(
                                            _aboutUsModel.data!
                                                .privacyPolicy![index].title
                                                .toString(),
                                            style: headerstyle.copyWith(
                                              fontSize: 16,
                                              color: Color(0xff333F52),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Spacer(),
                                          Image.asset(ImagePath.settingArrow,
                                              height: 24, width: 24),
                                          SizedBox(width: 16),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              SizedBox(width: 16),
                                              Text(
                                                _aboutUsModel
                                                    .data!
                                                    .privacyPolicy![index]
                                                    .title
                                                    .toString(),
                                                style: headerstyle.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Spacer(),
                                              Image.asset(ImagePath.downArrow,
                                                  height: 24, width: 24),
                                              SizedBox(width: 16),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Text(
                                              _aboutUsModel
                                                  .data!
                                                  .privacyPolicy![index]
                                                  .content!,
                                              textAlign: TextAlign.start,
                                              style: headerstyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff67707D),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                              ),
                              SizedBox(height: 20),
                            ],
                          );
                        }),
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            thickness: 2,
                            color: Color(0xffF1F2F6),
                          );
                        },
                      ),
                      */
                      Divider(
                        thickness: 2,
                        color: Color(0xffF1F2F6),
                      ),
                      /*  Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          "Terms & Conditions",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.greyColor),
                        ),
                      ), */

                      ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: (_aboutUsModel.data != null &&
                                _aboutUsModel.data!.termCondition != null)
                            ? _aboutUsModel.data!.termCondition!.length
                            : 0,
                        itemBuilder: ((context, index) {
                          return Column(
                            children: [
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  showHideTerms(index);
                                },
                                child: isOpenTerms[index] == false
                                    ? Container(
                                      color: Colors.transparent,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(width: 16),
                                            Text(
                                              _aboutUsModel.data!
                                                  .termCondition![index].title
                                                  .toString(),
                                              style: headerstyle.copyWith(
                                                fontSize: 16,
                                                color: Color(0xff333F52),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Spacer(),
                                            Image.asset(ImagePath.settingArrow,
                                                height: 24, width: 24),
                                            SizedBox(width: 16),
                                          ],
                                        ),
                                    )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            color: Colors.transparent,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(width: 16),
                                                Text(
                                                  _aboutUsModel.data!
                                                      .termCondition![index].title
                                                      .toString(),
                                                  style: headerstyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Spacer(),
                                                Image.asset(ImagePath.downArrow,
                                                    height: 24, width: 24),
                                                SizedBox(width: 16),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16),
                                              child: (_aboutUsModel.data !=
                                                          null &&
                                                      _aboutUsModel.data!
                                                              .termCondition !=
                                                          null)
                                                  ? secondHalf.isEmpty
                                                      ? Html(
                                                          data: firstHalf,
                                                        )
                                                      : Column(
                                                          children: <Widget>[
                                                            new Html(
                                                                data: termsFlag
                                                                    ? (firstHalf +
                                                                        "...")
                                                                    : (termsFlag)
                                                                        ? (firstHalf +
                                                                            secondHalf)
                                                                        : (firstHalf +
                                                                            secondHalf)),
                                                            new InkWell(
                                                              child: new Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: <
                                                                    Widget>[
                                                                  new Text(
                                                                    termsFlag
                                                                        ? "show more"
                                                                        : "show less",
                                                                    style: new TextStyle(
                                                                        color: Colors
                                                                            .blue),
                                                                  ),
                                                                ],
                                                              ),
                                                              onTap: () {
                                                                setState(() {
                                                                  termsFlag =
                                                                      !termsFlag;
                                                                });
                                                              },
                                                            ),
                                                          ],
                                                        )
                                                  : Text(""))
                                        ],
                                      ),
                              ),
                              SizedBox(height: 20),
                            ],
                          );
                        }),
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            thickness: 2,
                            color: Color(0xffF1F2F6),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Text(_packageInfo.appName + ' ' + _packageInfo.version),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  void getAbouUs() async {
    // CommonUtils.showProgressLoading(context);
    var response = await http.get(
      Uri.parse(ABOUT_US),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _aboutUsModel = AboutUsModel.fromJson(jsonDecode(response.body));
        });
      }
      print("privacy policy ::: ${response.body}");
      for (int i = 0; i < _aboutUsModel.data!.privacyPolicy!.length; i++) {
        isOpenPrivacy.add(false);
        if (_aboutUsModel.data!.privacyPolicy![i].content!.length > 20) {
          privacyfirstHalf =
              _aboutUsModel.data!.privacyPolicy![i].content!.substring(0, 200);
          privacysecondHalf = _aboutUsModel.data!.privacyPolicy![i].content!
              .substring(
                  200, _aboutUsModel.data!.privacyPolicy![i].content!.length);
          // thirdHalf = _aboutUsModel.data!.termCondition![i].content!.substring(
          //     400, _aboutUsModel.data!.termCondition![i].content!.length);
        } else {
          privacyfirstHalf = _aboutUsModel.data!.privacyPolicy![i].content!;
          privacysecondHalf = "";
          // thirdHalf = "";
        }
      }
      for (int i = 0; i < _aboutUsModel.data!.aboutUs!.length; i++) {
        isOpenAbout.add(false);
        if (_aboutUsModel.data!.aboutUs![i].content!.length > 20) {
          aboutfirstHalf =
              _aboutUsModel.data!.aboutUs![i].content!.substring(0, 200);
          aboutsecondHalf = _aboutUsModel.data!.aboutUs![i].content!
              .substring(200, _aboutUsModel.data!.aboutUs![i].content!.length);
          // thirdHalf = _aboutUsModel.data!.termCondition![i].content!.substring(
          //     400, _aboutUsModel.data!.termCondition![i].content!.length);
        } else {
          aboutfirstHalf = _aboutUsModel.data!.aboutUs![i].content!;
          aboutsecondHalf = "";
          // thirdHalf = "";
        }
      }
      for (int i = 0; i < _aboutUsModel.data!.termCondition!.length; i++) {
        isOpenTerms.add(false);
        if (_aboutUsModel.data!.termCondition![i].content!.length > 50) {
          firstHalf =
              _aboutUsModel.data!.termCondition![i].content!.substring(0, 900);
          secondHalf = _aboutUsModel.data!.termCondition![i].content!.substring(
              900, _aboutUsModel.data!.termCondition![i].content!.length);
          // thirdHalf = _aboutUsModel.data!.termCondition![i].content!.substring(
          //     400, _aboutUsModel.data!.termCondition![i].content!.length);
        } else {
          firstHalf = _aboutUsModel.data!.termCondition![i].content!;
          secondHalf = "";
          // thirdHalf = "";
        }
      }

      CommonUtils.hideProgressLoading();
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
    } else {
      CommonUtils.hideProgressLoading();
    }
  }
}
