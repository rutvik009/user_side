import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Get_benefits_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Matchmaker_nearyou_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Near_You_Match_Model.dart';
import 'package:matrimonial_app/Ui/DiscoverFeed/ExecutiveProfileScreen/executive_profile_screen.dart';
import 'package:matrimonial_app/Ui/DiscoverFeed/ExecutiveProfileScreen/review_screen.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Drawer/ProfileScreen/profile_screenn.dart';
import 'package:matrimonial_app/Ui/choose%20Plan/choose_plan_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/Utils/value_constant.dart';
import 'package:matrimonial_app/widget/commonappbar_search.dart';
import 'package:matrimonial_app/widget/submit_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class Benefits extends StatefulWidget {
  int? selectIndex;
  Benefits({Key? key, this.selectIndex}) : super(key: key);

  @override
  State<Benefits> createState() => _BenefitsState();
}

class _BenefitsState extends State<Benefits> {
  bool isOpen = false;
  bool isOpen1 = false;
  bool isOpen2 = false;
  bool isOpen3 = false;
  bool isOpen4 = false;
  Dio dio = Dio();
  int? changeIndex;
  void showHide(int i) {
    setState(() {
      isOpen = !isOpen;
    });
  }

  void showHide1(int i) {
    setState(() {
      isOpen1 = !isOpen1;
    });
  }

  void showHide2(int i) {
    setState(() {
      isOpen2 = !isOpen2;
    });
  }

  void showHide3(int i) {
    setState(() {
      isOpen3 = !isOpen3;
    });
  }

  void showHide4(int i) {
    setState(() {
      isOpen4 = !isOpen4;
    });
  }

  GetBenefitsModel? _getBenefitsModel;
  List<Map<String, dynamic>> benefits = [
    {
      NAME: AppConstants.exp,
    },
    {
      NAME: AppConstants.exp1,
    },
    {
      NAME: AppConstants.exp2,
    }
  ];
  NearYouMatchModel? _nearYouMatchModel;
  MatchmakerNearYouModel? _matchmakerNearYouModel;
  String? exeUserName;
  @override
  void initState() {
    changeIndex = widget.selectIndex;
    checkConnection();
    super.initState();
  }

  double? _ratingValue;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Column(
        children: [
          CommonAppbar1(name: "benefits".tr),
          Container(
            height: 6,
            color: Color(0xffEDF1F5),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Text(
                            "managalkaryam".tr,
                            style: matchmaker,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Text(
                            _getBenefitsModel != null &&
                                    _getBenefitsModel!.data != null
                                ? _getBenefitsModel!
                                    .data![0].commonquestion![0].question
                                    .toString()
                                : "",
                            style: earn,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '.',
                                style: bullet,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  _getBenefitsModel != null &&
                                          _getBenefitsModel!.data != null
                                      ? _getBenefitsModel!
                                          .data![0].commonquestion![0].answer
                                          .toString()
                                      : "",
                                  textAlign: TextAlign.start,
                                  style: bullet,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Text(
                            _getBenefitsModel != null &&
                                    _getBenefitsModel!.data != null
                                ? _getBenefitsModel!
                                    .data![0].commonquestion![1].question
                                    .toString()
                                : "",
                            style: earn,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '.',
                                style: bullet,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  _getBenefitsModel != null &&
                                          _getBenefitsModel!.data != null
                                      ? _getBenefitsModel!
                                          .data![0].commonquestion![1].answer
                                          .toString()
                                      : "",
                                  textAlign: TextAlign.start,
                                  style: bullet,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: width,
                          height: 2,
                          color: Color(0xffEDF1F5),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CarouselSlider.builder(
                          itemCount: (_matchmakerNearYouModel != null &&
                                  _matchmakerNearYouModel!.data != null)
                              ? _matchmakerNearYouModel!.data!.length
                              : 0,
                          options: CarouselOptions(
                            onPageChanged: (val, reason) {
                              setState(() {
                                changeIndex = val;
                                exeUserName = _matchmakerNearYouModel!
                                        .data![changeIndex!].firstname
                                        .toString() +
                                    " " +
                                    _matchmakerNearYouModel!
                                        .data![changeIndex!].lastname
                                        .toString();
                              });

                              log("Exe Name::::::> ${_matchmakerNearYouModel!.data![changeIndex!].firstname.toString()}");

                              print("object ::: $val");
                            },
                            autoPlay: false,
                            reverse: false,
                            enlargeCenterPage: true,
                            viewportFraction: 0.9,
                            height: 297,
                            initialPage: changeIndex!,
                          ),
                          itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) =>
                              Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff1ffffff).withOpacity(0.1),
                                  blurRadius: 10,
                                )
                              ],
                              border: Border.all(width: 2, color: currentColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    Executive_Profile(
                                                  image: (_matchmakerNearYouModel!
                                                          .data![changeIndex!]
                                                          .profileImage!
                                                          .isNotEmpty)
                                                      ? _matchmakerNearYouModel!
                                                          .data![changeIndex!]
                                                          .profileImage![0]
                                                          .filePath
                                                          .toString()
                                                      : "",
                                                  gender:
                                                      _matchmakerNearYouModel!
                                                          .data![changeIndex!]
                                                          .gender,
                                                  name: _matchmakerNearYouModel!
                                                          .data![changeIndex!]
                                                          .firstname
                                                          .toString() +
                                                      ' ' +
                                                      _matchmakerNearYouModel!
                                                          .data![changeIndex!]
                                                          .lastname
                                                          .toString(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                              width: 50,
                                              height: 50,
                                              child: (_matchmakerNearYouModel != null &&
                                                      _matchmakerNearYouModel!
                                                              .data !=
                                                          null &&
                                                      _matchmakerNearYouModel!
                                                              .data![itemIndex]
                                                              .profileImage!
                                                              .length >
                                                          0)
                                                  /*  */
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              width: 2,
                                                              color:
                                                                  currentColor)),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              _matchmakerNearYouModel!
                                                                  .data![
                                                                      itemIndex]
                                                                  .profileImage![
                                                                      0]
                                                                  .filePath
                                                                  .toString(),
                                                          height: 72,
                                                          width: 72,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    )
                                                  : _matchmakerNearYouModel !=
                                                              null &&
                                                          _matchmakerNearYouModel!
                                                                  .data !=
                                                              null &&
                                                          _matchmakerNearYouModel!
                                                                  .data![
                                                                      changeIndex!]
                                                                  .gender ==
                                                              "Male"
                                                      ? Container(
                                                          height: 98,
                                                          width: 98,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                  width: 2,
                                                                  color:
                                                                      currentColor)),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            child: Image.asset(
                                                                ImagePath
                                                                    .maleProfile,
                                                                height: 70),
                                                          ),
                                                        )
                                                      : Image.asset(
                                                          ImagePath
                                                              .femaleProfile,
                                                          height: 72,
                                                        )),
                                        ),
                                        SizedBox(
                                          width: 13,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 235,
                                              child: Text(
                                                _matchmakerNearYouModel !=
                                                            null &&
                                                        _matchmakerNearYouModel!
                                                                .data![
                                                                    changeIndex!]
                                                                .firstname !=
                                                            null
                                                    ? _matchmakerNearYouModel!
                                                            .data![changeIndex!]
                                                            .firstname
                                                            .toString() +
                                                        ' ' +
                                                        _matchmakerNearYouModel!
                                                            .data![changeIndex!]
                                                            .lastname
                                                            .toString()
                                                    : AppConstants.stevesmith,
                                                /*  benefits[itemIndex][NAME], */
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: sonu.copyWith(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Text(
                                              AppConstants.professional,
                                              style: online,
                                            ),
                                            RatingBar(
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                glow: false,
                                                itemSize: 22,
                                                ratingWidget: RatingWidget(
                                                    full: const Icon(Icons.star,
                                                        color: Colors.orange),
                                                    half: const Icon(
                                                      Icons.star_half,
                                                      color: Colors.orange,
                                                    ),
                                                    empty: Icon(
                                                      Icons.star_outline,
                                                      color: Colors.orange,
                                                    )),
                                                onRatingUpdate: (value) {
                                                  setState(() {
                                                    _ratingValue = value;
                                                  });
                                                })
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  Review_screen()));
                                    },
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 17.0, left: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  AppConstants.communicate,
                                                  style: online.copyWith(
                                                      fontSize: 14),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      ImagePath.fillstar,
                                                      width: 24,
                                                      height: 24,
                                                    ),
                                                    Text(
                                                      '5.0',
                                                      style: TextStyle(
                                                          color: Colors.amber),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  AppConstants.esponsive,
                                                  style: online.copyWith(
                                                      fontSize: 14),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      ImagePath.halfstar,
                                                      width: 24,
                                                      height: 24,
                                                    ),
                                                    Text(
                                                      '4.5',
                                                      style: TextStyle(
                                                          color: Colors.amber),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  AppConstants.honest,
                                                  style: online.copyWith(
                                                      fontSize: 14),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      ImagePath.fillstar,
                                                      width: 24,
                                                      height: 24,
                                                    ),
                                                    Text(
                                                      '5.0',
                                                      style: TextStyle(
                                                          color: Colors.amber),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, left: 16),
                                    child: Container(
                                      height: 3,
                                      color:
                                          Color(0xffD1D1D1).withOpacity(0.35),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            AppConstants.initial,
                                            style:
                                                online.copyWith(fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            AppConstants.price,
                                            style: price,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 26,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            AppConstants.initial,
                                            style:
                                                online.copyWith(fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            AppConstants.price1,
                                            style: price,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Text(
                                      AppConstants.parefered,
                                      style: prefered,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // _greateDialogBox();
                                        },
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                ImagePath.whatsapp,
                                                width: 19,
                                                height: 19,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                AppConstants.whatsApp,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 35,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // _greateDialogBox();
                                        },
                                        child: Container(
                                          child: Row(children: [
                                            Image.asset(
                                              ImagePath.calling1,
                                              width: 19,
                                              height: 19,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(AppConstants.call)
                                          ]),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 35,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          onTap:
                                          () {
                                            // _greateDialogBox();
                                          };
                                        },
                                        child: Container(
                                          child: Row(children: [
                                            Image.asset(
                                              ImagePath.mangal,
                                              width: 19,
                                              height: 19,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(AppConstants.chat)
                                          ]),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            "commonquestion".tr,
                            style: matchermake,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            showHide(0);
                          },
                          child: isOpen == false
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 17, right: 17, top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _getBenefitsModel != null &&
                                                _getBenefitsModel!.data != null
                                            ? _getBenefitsModel!.data![0]
                                                .commonquestion![0].question
                                                .toString()
                                            : "",
                                        style: earn,
                                      ),
                                      Image.asset(
                                        ImagePath.plus,
                                        width: 18,
                                        height: 18,
                                      )
                                    ],
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(width: 16),
                                        Text(
                                          _getBenefitsModel != null &&
                                                  _getBenefitsModel!.data !=
                                                      null
                                              ? _getBenefitsModel!.data![0]
                                                  .commonquestion![0].question
                                                  .toString()
                                              : "",
                                          style: headerstyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.remove),
                                        SizedBox(width: 16),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(
                                        _getBenefitsModel != null &&
                                                _getBenefitsModel!.data != null
                                            ? _getBenefitsModel!.data![0]
                                                .commonquestion![0].answer
                                                .toString()
                                            : "",
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
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Divider(),
                        ),
                        GestureDetector(
                          onTap: () {
                            showHide1(0);
                          },
                          child: isOpen1 == false
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 17, right: 17, top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _getBenefitsModel != null &&
                                                _getBenefitsModel!.data != null
                                            ? _getBenefitsModel!.data![0]
                                                .commonquestion![1].question
                                                .toString()
                                            : "",
                                        style: earn,
                                      ),
                                      Image.asset(
                                        ImagePath.plus,
                                        width: 18,
                                        height: 18,
                                      )
                                    ],
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(width: 16),
                                        Text(
                                          _getBenefitsModel != null &&
                                                  _getBenefitsModel!.data !=
                                                      null
                                              ? _getBenefitsModel!.data![0]
                                                  .commonquestion![1].question
                                                  .toString()
                                              : "",
                                          style: headerstyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.remove),
                                        SizedBox(width: 16),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(
                                        _getBenefitsModel != null &&
                                                _getBenefitsModel!.data != null
                                            ? _getBenefitsModel!.data![0]
                                                .commonquestion![1].answer
                                                .toString()
                                            : "",
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
                        /* Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Divider(),
                        ),
                        GestureDetector(
                          onTap: () {
                            showHide2(0);
                          },
                          child: isOpen2 == false
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 17, right: 17, top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        /*   _getBenefitsModel != null &&
                                                _getBenefitsModel!.data != null
                                            ? _getBenefitsModel!
                                                .data![0].benefit![2].question
                                                .toString()
                                            : */
                                        "",
                                        style: earn,
                                      ),
                                      Image.asset(
                                        ImagePath.plus,
                                        width: 18,
                                        height: 18,
                                      )
                                    ],
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(width: 16),
                                        Text(
                                          /* _getBenefitsModel != null &&
                                                  _getBenefitsModel!.data !=
                                                      null
                                              ? _getBenefitsModel!
                                                  .data![0].benefit![2].question
                                                  .toString()
                                              : */
                                          "",
                                          style: headerstyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.remove),
                                        SizedBox(width: 16),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(
                                        /*  _getBenefitsModel != null &&
                                                _getBenefitsModel!.data != null
                                            ? _getBenefitsModel!
                                                .data![0].benefit![2].answer
                                                .toString()
                                            : */
                                        "",
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
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Divider(),
                        ),
                        GestureDetector(
                          onTap: () {
                            showHide3(0);
                          },
                          child: isOpen3 == false
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 17, right: 17, top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        /* _getBenefitsModel != null &&
                                                _getBenefitsModel!.data != null
                                            ? _getBenefitsModel!
                                                .data![0].benefit![3].question
                                                .toString()
                                            : */
                                        "",
                                        style: earn,
                                      ),
                                      Image.asset(
                                        ImagePath.plus,
                                        width: 18,
                                        height: 18,
                                      )
                                    ],
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(width: 16),
                                        Text(
                                          /*  _getBenefitsModel != null &&
                                                  _getBenefitsModel!.data !=
                                                      null
                                              ? _getBenefitsModel!
                                                  .data![0].benefit![3].question
                                                  .toString()
                                              : */
                                          "",
                                          style: headerstyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.remove),
                                        SizedBox(width: 16),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(
                                        /*  _getBenefitsModel != null &&
                                                _getBenefitsModel!.data != null
                                            ? _getBenefitsModel!
                                                .data![0].benefit![3].answer
                                                .toString()
                                            : */
                                        "",
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
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Divider(),
                        ),
                        GestureDetector(
                          onTap: () {
                            showHide4(0);
                          },
                          child: isOpen4 == false
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 17, right: 17, top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        /*  _getBenefitsModel != null &&
                                                _getBenefitsModel!.data != null
                                            ? _getBenefitsModel!
                                                .data![0].benefit![4].question
                                                .toString()
                                            :  */
                                        "",
                                        style: earn,
                                      ),
                                      Image.asset(
                                        ImagePath.plus,
                                        width: 18,
                                        height: 18,
                                      )
                                    ],
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(width: 16),
                                        Text(
                                          /*  _getBenefitsModel != null &&
                                                  _getBenefitsModel!.data !=
                                                      null
                                              ? _getBenefitsModel!
                                                  .data![0].benefit![4].question
                                                  .toString()
                                              : */
                                          "",
                                          style: headerstyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.remove),
                                        SizedBox(width: 16),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Text(
/*                                         _getBenefitsModel != null &&
                                                _getBenefitsModel!.data != null
                                            ? _getBenefitsModel!
                                                .data![0].benefit![4].answer
                                                .toString()
                                            : */
                                        "",
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
                        ), */
                        SizedBox(
                          height: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: CommonButton(
                              btnName: 'Subscribe To ' + capitalizeWords(exeUserName.toString()),
                              btnOnTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const Chooseplan_screen()));
                              }),
                        ),
                        SizedBox(
                          height: 35,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _greateDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(10),
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              height: 208,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            child: Image.asset(ImagePath.cross,
                                height: 24, width: 24)),
                        SizedBox(width: 8),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                            ImagePath.offlineimage,
                          ),
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              AppConstants.sonu,
                              style: sonu,
                            ),
                            Text(
                              AppConstants.lastseen,
                              style: online,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          ImagePath.chatframe,
                          width: 25,
                          height: 25,
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Image.asset(
                          ImagePath.callframe,
                          width: 25,
                          height: 25,
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Image.asset(
                          ImagePath.messageframe,
                          width: 25,
                          height: 25,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: AppColors.appColor,
                              borderRadius: BorderRadius.circular(9)),
                          alignment: Alignment.center,
                          child: Text(
                            'Request to show',
                            style: appBtnStyle,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      CommonUtils.showProgressLoading(context);
      getBenefits();
      getMatchmakerNearyou();
      getNearYouMatchAPI();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      CommonUtils.hideProgressLoading();
      getBenefits();
      getMatchmakerNearyou();
      getNearYouMatchAPI();
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

  getNearYouMatchAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    try {
      var response = await dio.get(GET_NEAR_YOU_URL + "?" + queryString);
      if (response.statusCode == 200) {
        setState(() {
          _nearYouMatchModel = NearYouMatchModel.fromJson(response.data);
        });
        print("Near you match ::: ${response.data}");
      } else if (response.statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Internal Server Error",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffE16284),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } on DioError catch (e) {}
  }

  getMatchmakerNearyou() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    try {
      log("URL :::: " + GET_MY_MATCH_URL + "?" + queryString);
      var response =
          await dio.get(GET_MATCHMAKER_NEAR_YOU_URL + "?" + queryString);
      if (response.statusCode == 200) {
        setState(() {
          _matchmakerNearYouModel =
              MatchmakerNearYouModel.fromJson(response.data);
          exeUserName = _matchmakerNearYouModel!.data![changeIndex!].firstname.toString() +
              " " +
              _matchmakerNearYouModel!.data![changeIndex!].lastname.toString();
        });
        print("recent visit ::: ${response.data}");
      } else if (response.statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Internal Server Error",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffE16284),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) {
        print("404");
      }
      CommonUtils.hideProgressLoading();
    }
  }

  getBenefits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    CommonUtils.showProgressLoading(context);
    var response =
        await http.get(Uri.parse(GET_BENEFITS_URL + "?" + queryString));

    if (response.statusCode == 200) {
      CommonUtils.hideProgressLoading();
      if (mounted) {
        setState(() {
          _getBenefitsModel =
              GetBenefitsModel.fromJson(jsonDecode(response.body));
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
    }
  }
}
