import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/GetProfile_Details/Get_Basic_Detail_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/getLikedByYouModel.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/get_Addarchive_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/get_ArchiveModel.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/get_Star_profile_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/get_revert_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/get_user_matching_profile_model.dart';
import 'package:matrimonial_app/ModelClass/delete_archive_model.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Drawer/ProfileScreen/profile_screenn.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/User_Detail_Screen.dart';
import 'package:matrimonial_app/Ui/Login/login_screen.dart';
import 'package:matrimonial_app/Ui/Matrimonial%20Like/See_All_likeProfile.dart';
import 'package:matrimonial_app/Ui/Matrimonial%20Like/like_story.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/Utils/value_constant.dart';
import 'package:matrimonial_app/widget/homeappbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ModelClass/UserPanel_ModelClass/Update_Profile_Details/archive_model.dart';
import '../../ModelClass/UserPanel_ModelClass/user_profile_about_model.dart';
import '../Home_screen/Match Screen/Match_Details.dart';
import 'package:http/http.dart' as http;

class Like_screen extends StatefulWidget {
  const Like_screen({Key? key}) : super(key: key);

  @override
  State<Like_screen> createState() => _Like_screenState();
}

class _Like_screenState extends State<Like_screen>
    with TickerProviderStateMixin {
  String? selectedGender;

  getPrefData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    selectedGender = pref.getString(SELECTGENDER);
    print("gender :::$selectedGender");
  }

  UserAboutMeModel? _userAboutMeModel;
  String? likeByYouId;

  bool isSelectAll = false;
  List<ArchiveModel> archiveDeleteList = [];
  Dio dio = Dio();
  getLikedByYouModel? _likedByYouModel;
  GetArchiveModel? _getArchiveModel;
  bool isDeleteSelected = false;
  GetRevertModel? _getRevertModel;
  GetDeleteArchiveModel? _deleteArchiveModel;
  GetStarProfileModel? _getStarProfileModel;
  GetAddarchiveModel? _getAddarchiveModel;
  GetUserMatchingProfileModel? _getUserMatchingProfileModel;
  List deleteIdList = [];
  List<Map<String, dynamic>> recentlylike = [
    {
      IMAGE: ImagePath.likeimage,
      NAME: AppConstants.josephtitle,
    },
    {
      IMAGE: ImagePath.likeimage1,
      NAME: AppConstants.jamesText,
    },
  ];
  List<Map<String, dynamic>> recommendedList = [
    {
      IMAGE: ImagePath.likeimage,
      NAME: AppConstants.josephtitle,
    },
    {
      IMAGE: ImagePath.likeimage1,
      NAME: AppConstants.jamesText,
    },
  ];

  TabController? _tabController;

  List imageList = [];
  @override
  void initState() {
    super.initState();
    getPrefData();
    _tabController = TabController(length: 3, vsync: this);

    checkConnection();
    getUsermatchingProfileAPi();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            HomeAppbar(
              name: "matrimonial".tr,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                height: 45,
                width: width,
                decoration: BoxDecoration(
                  color: currentColor.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: TabBar(
                  onTap: (ind) {
                    print("index tab ::: $ind");
                    if (ind == 0) {
                      getLikedByYouAPi();
                    }
                  },
                  labelStyle: TextStyle(fontSize: 11),
                  indicatorPadding: EdgeInsets.all(5),
                  controller: _tabController,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: currentColor),
                  unselectedLabelColor: currentColor,
                  tabs: [
                    Tab(
                      child: Text("like by".tr,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600, fontSize: 13)),
                    ),
                    Tab(
                      child: Text(
                          selectedGender == "Male"
                              /*  genderSelecter == 'Male' */
                              ? "Like by him".tr
                              : "Like by her".tr,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600, fontSize: 13)),
                    ),
                    Tab(
                      child: Text("archive".tr,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600, fontSize: 13)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  /// Like By You===>
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "recently liked".tr,
                                style: nextBtnStyle.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 19),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              SeeAllLikeProfile()));
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      AppConstants.seeall,
                                      style:
                                          seeall.copyWith(color: currentColor),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Image.asset(
                                      ImagePath.pinkforward,
                                      color: currentColor,
                                      width: 6,
                                      height: 9,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _likedByYouModel != null &&
                                  _likedByYouModel!.data!.isNotEmpty
                              ? GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 17.0,
                                    mainAxisSpacing: 10.0,
                                    mainAxisExtent: 220,
                                  ),
                                  itemCount: _likedByYouModel != null &&
                                          _likedByYouModel!.data != null
                                      ? _likedByYouModel!.data!.length
                                      : 0,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                UserDetailScreen(
                                                    userDetailIndex:
                                                        _likedByYouModel!
                                                            .data![index]
                                                            .userId),
                                          ),
                                        );
                                        var selectedId = _likedByYouModel!
                                            .data![index].userId
                                            .toString();
                                        log(selectedId);
                                      },
                                      child: Container(
                                        height: 220,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xffECECEC)),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: currentColor),
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Container(
                                            height: 207,
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  child: _likedByYouModel !=
                                                              null &&
                                                          _likedByYouModel!
                                                                  .data !=
                                                              null &&
                                                          _likedByYouModel!
                                                              .data![index]
                                                              .profileImage!
                                                              .isNotEmpty
                                                      ? (_likedByYouModel!
                                                                  .data![index]
                                                                  .blurImage ==
                                                              1)
                                                          ? ImageFiltered(
                                                              imageFilter:
                                                                  ImageFilter.blur(
                                                                      sigmaX: 5,
                                                                      sigmaY:
                                                                          5),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: _likedByYouModel!
                                                                    .data![
                                                                        index]
                                                                    .profileImage![
                                                                        0]
                                                                    .filePath
                                                                    .toString(),
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 207,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                              ),
                                                            )
                                                          : CachedNetworkImage(
                                                              imageUrl: _likedByYouModel!
                                                                  .data![index]
                                                                  .profileImage![
                                                                      0]
                                                                  .filePath
                                                                  .toString(),
                                                              fit: BoxFit.cover,
                                                              height: 207,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                            )
                                                      : (_likedByYouModel !=
                                                                  null &&
                                                              _likedByYouModel!
                                                                      .data !=
                                                                  null &&
                                                              _likedByYouModel!
                                                                      .data![
                                                                          index]
                                                                      .gender ==
                                                                  "Male")
                                                          ? Image.asset(
                                                              ImagePath.profile,
                                                              fit: BoxFit.cover,
                                                              height: 207,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                            )
                                                          : Image.asset(
                                                              ImagePath
                                                                  .femaleProfileUser,
                                                              fit: BoxFit.cover,
                                                              height: 207,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                            ),
                                                ),
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              right: 8,
                                                              left: 8),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                likeByYouId =
                                                                    _likedByYouModel!
                                                                        .data![
                                                                            index]
                                                                        .userId
                                                                        .toString();
                                                                getAddArchiveApi();
                                                              });
                                                            },
                                                            child: Container(
                                                              color: Colors
                                                                  .transparent,
                                                              child:
                                                                  Image.asset(
                                                                ImagePath
                                                                    .likeframe,
                                                                width: 28,
                                                                height: 28,
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              List<String>
                                                                  storiesList =
                                                                  [];
                                                              imageList.clear();
                                                              for (var i = 0;
                                                                  i <
                                                                      _likedByYouModel!
                                                                          .data!
                                                                          .length;
                                                                  i++) {
                                                                if (_likedByYouModel!
                                                                        .data![
                                                                            index]
                                                                        .userId! ==
                                                                    _likedByYouModel!
                                                                        .data![
                                                                            i]
                                                                        .userId) {
                                                                  for (var j =
                                                                          0;
                                                                      j <
                                                                          _likedByYouModel!
                                                                              .data![i]
                                                                              .profileImage!
                                                                              .length;
                                                                      j++) {
                                                                    setState(
                                                                        () {
                                                                      imageList.add(_likedByYouModel!
                                                                          .data![
                                                                              i]
                                                                          .profileImage![j]);
                                                                    });
                                                                  }
                                                                }
                                                              }
                                                              setState(() {
                                                                storiesList =
                                                                    List.generate(
                                                                        imageList
                                                                            .length,
                                                                        (index) {
                                                                  return imageList
                                                                          .isEmpty
                                                                      ? "http://www.goodmorningimagesdownload.com/wp-content/uploads/2019/12/Love-Images-1.jpg"
                                                                      : imageList[
                                                                              index]
                                                                          .filePath
                                                                          .toString();
                                                                });
                                                              });
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          LikeStoryView(
                                                                            story:
                                                                                storiesList,
                                                                          )));
                                                            },
                                                            child: Container(
                                                              height: 20,
                                                              width: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                        0xff000000)
                                                                    .withOpacity(
                                                                        0.5),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  left: 6,
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      (_likedByYouModel != null &&
                                                                              _likedByYouModel!.data !=
                                                                                  null)
                                                                          ? _likedByYouModel!
                                                                              .data![index]
                                                                              .profileImage!
                                                                              .length
                                                                              .toString()
                                                                          : "",
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .colorWhite,
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Image.asset(
                                                                      ImagePath
                                                                          .camera,
                                                                      height:
                                                                          12,
                                                                      width: 12,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 0),
                                                      child: Container(
                                                        height: 34,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color(
                                                                  0xffffffff)
                                                              .withOpacity(0.9),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    13),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    13),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8,
                                                                  right: 14),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  _likedByYouModel != null &&
                                                                          _likedByYouModel!.data !=
                                                                              null &&
                                                                          _likedByYouModel!.data![index].firstname !=
                                                                              '' &&
                                                                          _likedByYouModel!.data![index].lastname !=
                                                                              ''
                                                                      ? _likedByYouModel!
                                                                              .data![
                                                                                  index]
                                                                              .firstname
                                                                              .toString() +
                                                                          " " +
                                                                          _likedByYouModel!
                                                                              .data![index]
                                                                              .lastname
                                                                              .toString()
                                                                      : 'N/A',
                                                                  maxLines: 1,
                                                                  style: fontStyle.copyWith(
                                                                      color: Colors
                                                                          .black,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis),
                                                                  // overflow:
                                                                  //     TextOverflow
                                                                  //         .ellipsis,
                                                                ),
                                                              ),
                                                              (_likedByYouModel != null &&
                                                                      _likedByYouModel!
                                                                              .data !=
                                                                          null &&
                                                                      _likedByYouModel!
                                                                              .data![index]
                                                                              .isAgent ==
                                                                          "1")
                                                                  ? Image.asset(
                                                                      ImagePath
                                                                          .blackuse,
                                                                      color:
                                                                          currentColor,
                                                                      width: 22,
                                                                      height:
                                                                          22,
                                                                    )
                                                                  : Container()
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: Text(
                                      "We Don't Have Recently Liked For You")),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "recommended".tr,
                            style: nextBtnStyle.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 19),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          /* Center(
                            child: Text(
                              "No recently recommended for you",
                            ),
                          ), */
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 17.0,
                              mainAxisSpacing: 10.0,
                              mainAxisExtent: 220,
                            ),
                            itemCount: recommendedList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              UserDetailScreen()));
                                },
                                child: Container(
                                  height: 220,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xffECECEC)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: currentColor),
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Container(
                                      height: 207,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                recommendedList[index][IMAGE]),
                                            fit: BoxFit.cover),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 8, left: 8),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image.asset(
                                                  ImagePath.likeframe,
                                                  width: 28,
                                                  height: 28,
                                                ),
                                                Container(
                                                  height: 20,
                                                  width: 34,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff000000)
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 6,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          '2',
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .colorWhite,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Image.asset(
                                                          ImagePath.camera,
                                                          height: 12,
                                                          width: 12,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0),
                                            child: Container(
                                              height: 34,
                                              decoration: BoxDecoration(
                                                color: Color(0xffffffff)
                                                    .withOpacity(0.5),
                                                borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(13),
                                                  bottomLeft:
                                                      Radius.circular(13),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 14),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        recommendedList[index]
                                                            [NAME],
                                                        style:
                                                            fontStyle.copyWith(
                                                                color: Colors
                                                                    .white),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Image.asset(
                                                      ImagePath.peopleframe,
                                                      width: 22,
                                                      height: 22,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Top Picked",
                            style: nextBtnStyle.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 19),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _getStarProfileModel != null &&
                                  _getStarProfileModel!.data!.isNotEmpty
                              ? GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 17.0,
                                    mainAxisSpacing: 10.0,
                                    mainAxisExtent: 220,
                                  ),
                                  itemCount: _getStarProfileModel != null &&
                                          _getStarProfileModel!.data != null
                                      ? _getStarProfileModel!.data!.length
                                      : 0,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                UserDetailScreen(
                                                    userDetailIndex:
                                                        _getStarProfileModel!
                                                            .data![index]
                                                            .userId),
                                          ),
                                        );
                                        var selectedId = _getStarProfileModel!
                                            .data![index].userId
                                            .toString();
                                        log(selectedId);
                                      },
                                      child: Container(
                                        height: 220,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xffECECEC)),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: currentColor),
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Container(
                                            height: 207,
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  child: _getStarProfileModel != null &&
                                                          _getStarProfileModel!
                                                                  .data !=
                                                              null &&
                                                          _getStarProfileModel!
                                                              .data![index]
                                                              .profileImage!
                                                              .isNotEmpty
                                                      ? (_getStarProfileModel!
                                                                  .data![index]
                                                                  .blurImage ==
                                                              1)
                                                          ? ImageFiltered(
                                                              imageFilter:
                                                                  ImageFilter.blur(
                                                                      sigmaX: 5,
                                                                      sigmaY:
                                                                          5),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: _getStarProfileModel!
                                                                    .data![
                                                                        index]
                                                                    .profileImage![
                                                                        0]
                                                                    .filePath
                                                                    .toString(),
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 207,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                              ),
                                                            )
                                                          : CachedNetworkImage(
                                                              imageUrl: _getStarProfileModel!
                                                                  .data![index]
                                                                  .profileImage![
                                                                      0]
                                                                  .filePath
                                                                  .toString(),
                                                              fit: BoxFit.cover,
                                                              height: 207,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                            )
                                                      : (_getStarProfileModel != null &&
                                                              _getStarProfileModel!
                                                                      .data !=
                                                                  null &&
                                                              _getStarProfileModel!
                                                                      .data![
                                                                          index]
                                                                      .gender ==
                                                                  "Male")
                                                          ? Image.asset(
                                                              ImagePath.profile,
                                                              fit: BoxFit.cover,
                                                              height: 207,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                            )
                                                          : Image.asset(
                                                              ImagePath
                                                                  .femaleProfileUser,
                                                              fit: BoxFit.cover,
                                                              height: 207,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                            ),
                                                ),
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              right: 8,
                                                              left: 8),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                likeByYouId =
                                                                    _getStarProfileModel!
                                                                        .data![
                                                                            index]
                                                                        .userId
                                                                        .toString();
                                                              });
                                                              getAddArchiveApi();
                                                            },
                                                            child: Container(
                                                              color: Colors
                                                                  .transparent,
                                                              child:
                                                                  Image.asset(
                                                                ImagePath
                                                                    .likeframe,
                                                                width: 28,
                                                                height: 28,
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              List<String>
                                                                  storiesList =
                                                                  [];
                                                              imageList.clear();
                                                              for (var i = 0;
                                                                  i <
                                                                      _getStarProfileModel!
                                                                          .data!
                                                                          .length;
                                                                  i++) {
                                                                if (_getStarProfileModel!
                                                                        .data![
                                                                            index]
                                                                        .userId! ==
                                                                    _getStarProfileModel!
                                                                        .data![
                                                                            i]
                                                                        .userId) {
                                                                  for (var j =
                                                                          0;
                                                                      j <
                                                                          _getStarProfileModel!
                                                                              .data![i]
                                                                              .profileImage!
                                                                              .length;
                                                                      j++) {
                                                                    setState(
                                                                        () {
                                                                      imageList.add(_getStarProfileModel!
                                                                          .data![
                                                                              i]
                                                                          .profileImage![j]);
                                                                    });
                                                                  }
                                                                }
                                                              }
                                                              setState(() {
                                                                storiesList =
                                                                    List.generate(
                                                                        imageList
                                                                            .length,
                                                                        (index) {
                                                                  return imageList
                                                                          .isEmpty
                                                                      ? "http://www.goodmorningimagesdownload.com/wp-content/uploads/2019/12/Love-Images-1.jpg"
                                                                      : imageList[
                                                                              index]
                                                                          .filePath
                                                                          .toString();
                                                                });
                                                              });
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          LikeStoryView(
                                                                            story:
                                                                                storiesList,
                                                                          )));
                                                            },
                                                            child: Container(
                                                              height: 20,
                                                              width: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                        0xff000000)
                                                                    .withOpacity(
                                                                        0.5),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  left: 6,
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      (_getStarProfileModel != null &&
                                                                              _getStarProfileModel!.data !=
                                                                                  null)
                                                                          ? _getStarProfileModel!
                                                                              .data![index]
                                                                              .profileImage!
                                                                              .length
                                                                              .toString()
                                                                          : "1",
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .colorWhite,
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Image.asset(
                                                                      ImagePath
                                                                          .camera,
                                                                      height:
                                                                          12,
                                                                      width: 12,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 0),
                                                      child: Container(
                                                        height: 34,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color(
                                                                  0xffffffff)
                                                              .withOpacity(0.9),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    13),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    13),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8,
                                                                  right: 14),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  _getStarProfileModel != null &&
                                                                          _getStarProfileModel!.data !=
                                                                              null &&
                                                                          _getStarProfileModel!.data![index].firstname !=
                                                                              '' &&
                                                                          _getStarProfileModel!.data![index].lastname !=
                                                                              ''
                                                                      ? _getStarProfileModel!
                                                                              .data![
                                                                                  index]
                                                                              .firstname
                                                                              .toString() +
                                                                          " " +
                                                                          _getStarProfileModel!
                                                                              .data![index]
                                                                              .lastname
                                                                              .toString()
                                                                      : 'N/A',
                                                                  maxLines: 1,
                                                                  style: fontStyle.copyWith(
                                                                      color: Colors
                                                                          .black,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis),
                                                                  // overflow:
                                                                  //     TextOverflow
                                                                  //         .ellipsis,
                                                                ),
                                                              ),
                                                              (_getStarProfileModel != null &&
                                                                      _getStarProfileModel!
                                                                              .data !=
                                                                          null &&
                                                                      _getStarProfileModel!
                                                                              .data![index]
                                                                              .isAgent ==
                                                                          "1")
                                                                  ? Image.asset(
                                                                      ImagePath
                                                                          .blackuse,
                                                                      color:
                                                                          currentColor,
                                                                      width: 22,
                                                                      height:
                                                                          22,
                                                                    )
                                                                  : Container()
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child:
                                      Text("We Don't Have Top Picked For You")),
                          /*     GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 17.0,
                              mainAxisSpacing: 10.0,
                              mainAxisExtent: 220,
                            ),
                            itemCount: recommendedList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              UserDetailScreen()));
                                },
                                child: Container(
                                  height: 220,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xffECECEC)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: currentColor),
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Container(
                                      height: 207,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                recommendedList[index][IMAGE]),
                                            fit: BoxFit.cover),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 8, left: 8),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image.asset(
                                                  ImagePath.likeframe,
                                                  width: 28,
                                                  height: 28,
                                                ),
                                                Container(
                                                  height: 20,
                                                  width: 34,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff000000)
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 6,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          '2',
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .colorWhite,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Image.asset(
                                                          ImagePath.camera,
                                                          height: 12,
                                                          width: 12,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0),
                                            child: Container(
                                              height: 34,
                                              decoration: BoxDecoration(
                                                color: Color(0xffffffff)
                                                    .withOpacity(0.5),
                                                borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(13),
                                                  bottomLeft:
                                                      Radius.circular(13),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 14),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        recommendedList[index]
                                                            [NAME],
                                                        style:
                                                            fontStyle.copyWith(
                                                                color: Colors
                                                                    .white),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Image.asset(
                                                      ImagePath.peopleframe,
                                                      width: 22,
                                                      height: 22,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                       */
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "In Progress",
                            style: nextBtnStyle.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 19),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _getUserMatchingProfileModel != null &&
                                  _getUserMatchingProfileModel!.data!.isNotEmpty
                              ? GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 17.0,
                                    mainAxisSpacing: 10.0,
                                    mainAxisExtent: 220,
                                  ),
                                  itemCount: _getUserMatchingProfileModel !=
                                              null &&
                                          _getUserMatchingProfileModel!.data !=
                                              null
                                      ? _getUserMatchingProfileModel!
                                          .data!.length
                                      : 0,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => MatchDetails(
                                              id: _getUserMatchingProfileModel!
                                                  .data![index].userId
                                                  .toString(),
                                              image2:
                                                  _getUserMatchingProfileModel!
                                                      .data![index]
                                                      .profileImage![0]
                                                      .filePath
                                                      .toString(),
                                              image1: _userAboutMeModel!.data!
                                                  .profileImage![0].filePath
                                                  .toString(),
                                              fromValue: "InProgress",
                                            ),
                                          ),
                                        );
                                        var selectedId =
                                            _getUserMatchingProfileModel!
                                                .data![index].userId
                                                .toString();
                                        log("selected id:::::${selectedId}");
                                      },
                                      child: Container(
                                        height: 220,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xffECECEC)),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: currentColor),
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Container(
                                            height: 207,
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  child: _getUserMatchingProfileModel != null &&
                                                          _getUserMatchingProfileModel!.data !=
                                                              null &&
                                                          _getUserMatchingProfileModel!
                                                              .data![index]
                                                              .profileImage!
                                                              .isNotEmpty
                                                      ? (_getUserMatchingProfileModel!
                                                                  .data![index]
                                                                  .blurImage ==
                                                              1)
                                                          ? ImageFiltered(
                                                              imageFilter:
                                                                  ImageFilter.blur(
                                                                      sigmaX: 5,
                                                                      sigmaY:
                                                                          5),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: _getUserMatchingProfileModel!
                                                                    .data![
                                                                        index]
                                                                    .profileImage![
                                                                        0]
                                                                    .filePath
                                                                    .toString(),
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 207,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                              ),
                                                            )
                                                          : CachedNetworkImage(
                                                              imageUrl: _getUserMatchingProfileModel!
                                                                  .data![index]
                                                                  .profileImage![
                                                                      0]
                                                                  .filePath
                                                                  .toString(),
                                                              fit: BoxFit.cover,
                                                              height: 207,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                            )
                                                      : (_getUserMatchingProfileModel != null &&
                                                              _getUserMatchingProfileModel!
                                                                      .data !=
                                                                  null &&
                                                              _getUserMatchingProfileModel!
                                                                      .data![
                                                                          index]
                                                                      .gender ==
                                                                  "Male")
                                                          ? Image.asset(
                                                              ImagePath.profile,
                                                              fit: BoxFit.cover,
                                                              height: 207,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                            )
                                                          : Image.asset(
                                                              ImagePath
                                                                  .femaleProfileUser,
                                                              fit: BoxFit.cover,
                                                              height: 207,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                            ),
                                                  /*  Image.asset(
                                                              "assets/images/no_image.png",
                                                              fit: BoxFit.cover,
                                                              height: 207,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                            ), */
                                                ),
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              right: 8,
                                                              left: 8),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                likeByYouId =
                                                                    _getUserMatchingProfileModel!
                                                                        .data![
                                                                            index]
                                                                        .userId
                                                                        .toString();
                                                                getAddArchiveApi();
                                                              });
                                                            },
                                                            child: Container(
                                                              color: Colors
                                                                  .transparent,
                                                              child:
                                                                  Image.asset(
                                                                ImagePath
                                                                    .likeframe,
                                                                width: 28,
                                                                height: 28,
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              List<String>
                                                                  storiesList =
                                                                  [];
                                                              imageList.clear();
                                                              for (var i = 0;
                                                                  i <
                                                                      _getUserMatchingProfileModel!
                                                                          .data!
                                                                          .length;
                                                                  i++) {
                                                                if (_getUserMatchingProfileModel!
                                                                        .data![
                                                                            index]
                                                                        .userId! ==
                                                                    _getUserMatchingProfileModel!
                                                                        .data![
                                                                            i]
                                                                        .userId) {
                                                                  for (var j =
                                                                          0;
                                                                      j <
                                                                          _getUserMatchingProfileModel!
                                                                              .data![i]
                                                                              .profileImage!
                                                                              .length;
                                                                      j++) {
                                                                    setState(
                                                                        () {
                                                                      imageList.add(_getUserMatchingProfileModel!
                                                                          .data![
                                                                              i]
                                                                          .profileImage![j]);
                                                                    });
                                                                  }
                                                                }
                                                              }
                                                              setState(() {
                                                                storiesList =
                                                                    List.generate(
                                                                        imageList
                                                                            .length,
                                                                        (index) {
                                                                  return imageList
                                                                          .isEmpty
                                                                      ? "http://www.goodmorningimagesdownload.com/wp-content/uploads/2019/12/Love-Images-1.jpg"
                                                                      : imageList[
                                                                              index]
                                                                          .filePath
                                                                          .toString();
                                                                });
                                                              });
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          LikeStoryView(
                                                                            story:
                                                                                storiesList,
                                                                          )));
                                                            },
                                                            child: Container(
                                                              height: 20,
                                                              width: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                        0xff000000)
                                                                    .withOpacity(
                                                                        0.5),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  left: 6,
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      (_getUserMatchingProfileModel != null &&
                                                                              _getUserMatchingProfileModel!.data !=
                                                                                  null)
                                                                          ? _getUserMatchingProfileModel!
                                                                              .data![index]
                                                                              .profileImage!
                                                                              .length
                                                                              .toString()
                                                                          : "1",
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .colorWhite,
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Image.asset(
                                                                      ImagePath
                                                                          .camera,
                                                                      height:
                                                                          12,
                                                                      width: 12,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 0),
                                                      child: Container(
                                                        height: 34,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color(
                                                                  0xffffffff)
                                                              .withOpacity(0.9),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    13),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    13),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8,
                                                                  right: 14),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  _getUserMatchingProfileModel != null &&
                                                                          _getUserMatchingProfileModel!.data !=
                                                                              null &&
                                                                          _getUserMatchingProfileModel!.data![index].firstname !=
                                                                              '' &&
                                                                          _getUserMatchingProfileModel!.data![index].lastname !=
                                                                              ''
                                                                      ? _getUserMatchingProfileModel!
                                                                              .data![
                                                                                  index]
                                                                              .firstname
                                                                              .toString() +
                                                                          " " +
                                                                          _getUserMatchingProfileModel!
                                                                              .data![index]
                                                                              .lastname
                                                                              .toString()
                                                                      : 'N/A',
                                                                  maxLines: 1,
                                                                  style: fontStyle.copyWith(
                                                                      color: Colors
                                                                          .black,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis),
                                                                  // overflow:
                                                                  //     TextOverflow
                                                                  //         .ellipsis,
                                                                ),
                                                              ),
                                                              (_getUserMatchingProfileModel != null &&
                                                                      _getUserMatchingProfileModel!
                                                                              .data !=
                                                                          null &&
                                                                      _getUserMatchingProfileModel!
                                                                              .data![index]
                                                                              .isAgent ==
                                                                          "1")
                                                                  ? Image.asset(
                                                                      ImagePath
                                                                          .blackuse,
                                                                      color:
                                                                          currentColor,
                                                                      width: 22,
                                                                      height:
                                                                          22,
                                                                    )
                                                                  : Container()
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: Text(
                                      "We Don't Have In Progress For You")),
                        ],
                      ),
                    ),
                  ),

                  /// Like by him===>
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Recently Liked",
                          // "toprated".tr,
                          style: nextBtnStyle.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 19),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 8.0,
                            mainAxisExtent: 220,
                          ),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            UserDetailScreen()));
                              },
                              child: Container(
                                height: 220,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xffECECEC)),
                                    borderRadius: BorderRadius.circular(20),
                                    color: currentColor),
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Container(
                                    height: 207,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xffECECEC)),
                                      borderRadius: BorderRadius.circular(14),
                                      image: DecorationImage(
                                          image: AssetImage(
                                            ImagePath.likeimage,
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, right: 8, left: 8),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 34,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff000000)
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 6,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        '2',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .colorWhite,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Image.asset(
                                                        ImagePath.camera,
                                                        height: 12,
                                                        width: 12,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 0),
                                          child: Container(
                                            height: 34,
                                            decoration: BoxDecoration(
                                              color: Color(0xffffffff)
                                                  .withOpacity(0.9),
                                              borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 14),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    AppConstants.joseph,
                                                    style: fontStyle.copyWith(
                                                        color: Colors.black),
                                                  ),
                                                  Image.asset(
                                                    ImagePath.blackuse,
                                                    color: currentColor,
                                                    width: 22,
                                                    height: 22,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  /// Archive===>
                  SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Recently Archived",
                                // "recentlyarchive".tr,
                                style: nextBtnStyle.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 19),
                              ),
                              isDeleteSelected
                                  ? Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            print("delete");
                                            setDeleteArchiveAllAPI();
                                          },
                                          child: Image.asset(
                                            "assets/images/delete.png",
                                            width: 28,
                                            height: 28,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            print("unselected");
                                            deleteIdList.clear;
                                            setState(() {
                                              isDeleteSelected = false;
                                            });
                                            for (int i = 0;
                                                i < archiveDeleteList.length;
                                                i++) {
                                              setState(() {
                                                archiveDeleteList[i]
                                                    .isSelected = false;
                                              });
                                            }
                                          },
                                          child: Image.asset(
                                            ImagePath.likecross,
                                            width: 28,
                                            height: 28,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _getArchiveModel != null
                              ? GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 8.0,
                                    mainAxisExtent: 220,
                                  ),
                                  itemCount: _getArchiveModel != null &&
                                          _getArchiveModel!.data!.length != 0
                                      ? _getArchiveModel!.data!.length
                                      : 0,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                UserDetailScreen(
                                              userDetailIndex: _getArchiveModel!
                                                  .data![index].userId,
                                            ),
                                          ),
                                        );
                                      },
                                      onLongPress: () {
                                        setState(() {
                                          isDeleteSelected = true;
                                          archiveDeleteList[index].isSelected =
                                              !archiveDeleteList[index]
                                                  .isSelected!;
                                        });
                                        if (archiveDeleteList[index]
                                                .isSelected ==
                                            true) {
                                          deleteIdList.add(_getArchiveModel!
                                              .data![index].userId);
                                        }
                                        log("long press  ${_getArchiveModel!.data![index].userId!}");
                                      },
                                      child: Container(
                                        height: 220,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xffECECEC)),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: currentColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Container(
                                            height: 207,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xffECECEC)),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              /*   image: _getArchiveModel!.data !=
                                                          null &&
                                                      _getArchiveModel!
                                                              .data![index]
                                                              .profileImage!
                                                              .length >
                                                          0
                                                  ? DecorationImage(
                                                      image:
                                                          CachedNetworkImageProvider(
                                                              _getArchiveModel!
                                                                  .data![index]
                                                                  .profileImage![
                                                                      0]
                                                                  .filePath
                                                                  .toString()),
                                                      fit: BoxFit.cover)
                                                  : DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: (_getArchiveModel!
                                                                  .data![index]
                                                                  .gender ==
                                                              "Male")
                                                          ? AssetImage(
                                                              ImagePath.profile,
                                                            )
                                                          : AssetImage(
                                                              ImagePath
                                                                  .femaleProfileUser,
                                                            ),
                                                    ), */
                                            ),
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  child: _getArchiveModel !=
                                                              null &&
                                                          _getArchiveModel!
                                                                  .data !=
                                                              null &&
                                                          _getArchiveModel!
                                                              .data![index]
                                                              .profileImage!
                                                              .isNotEmpty
                                                      ? (_getArchiveModel!
                                                                  .data![index]
                                                                  .blurImage ==
                                                              1)
                                                          ? ImageFiltered(
                                                              imageFilter:
                                                                  ImageFilter.blur(
                                                                      sigmaX: 5,
                                                                      sigmaY:
                                                                          5),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: _getArchiveModel!
                                                                    .data![
                                                                        index]
                                                                    .profileImage![
                                                                        0]
                                                                    .filePath
                                                                    .toString(),
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 207,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                              ),
                                                            )
                                                          : CachedNetworkImage(
                                                              imageUrl: _getArchiveModel!
                                                                  .data![index]
                                                                  .profileImage![
                                                                      0]
                                                                  .filePath
                                                                  .toString(),
                                                              fit: BoxFit.cover,
                                                              height: 207,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                            )
                                                      : (_getArchiveModel !=
                                                                  null &&
                                                              _getArchiveModel!
                                                                      .data !=
                                                                  null &&
                                                              _getArchiveModel!
                                                                      .data![
                                                                          index]
                                                                      .gender ==
                                                                  "Male")
                                                          ? Image.asset(
                                                              ImagePath.profile,
                                                              fit: BoxFit.cover,
                                                              height: 207,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                            )
                                                          : Image.asset(
                                                              ImagePath
                                                                  .femaleProfileUser,
                                                              fit: BoxFit.cover,
                                                              height: 207,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                            ),
                                                ),
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10,
                                                          right: 0,
                                                          left: 8),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          isDeleteSelected
                                                              ? GestureDetector(
                                                                  onTap: () {
                                                                    print(
                                                                        "tap to select");
                                                                    setState(
                                                                        () {
                                                                      isDeleteSelected =
                                                                          true;
                                                                      archiveDeleteList[
                                                                              index]
                                                                          .isSelected = !archiveDeleteList[
                                                                              index]
                                                                          .isSelected!;
                                                                    });
                                                                    if (archiveDeleteList[index]
                                                                            .isSelected ==
                                                                        true) {
                                                                      deleteIdList.add(_getArchiveModel!
                                                                          .data![
                                                                              index]
                                                                          .userId);
                                                                    } else {
                                                                      for (var i =
                                                                              0;
                                                                          i < deleteIdList.length;
                                                                          i++) {
                                                                        if (archiveDeleteList[index].isSelected ==
                                                                            false) {
                                                                          if (deleteIdList[i] ==
                                                                              _getArchiveModel!.data![index].userId) {
                                                                            deleteIdList.removeAt(i);
                                                                          }
                                                                        }
                                                                      }
                                                                    }

                                                                    log("delete list ::: $deleteIdList");
                                                                  },
                                                                  child: Icon(
                                                                    archiveDeleteList[index].isSelected ==
                                                                            true
                                                                        ? Icons
                                                                            .check_box
                                                                        : Icons
                                                                            .check_box_outline_blank,
                                                                    color: Colors
                                                                        .red,
                                                                  ))
                                                              : GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      _deleteDialogBox(
                                                                          index);
                                                                    });
                                                                  },
                                                                  child: Image
                                                                      .asset(
                                                                    ImagePath
                                                                        .likecross,
                                                                    width: 28,
                                                                    height: 28,
                                                                  ),
                                                                ),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 8.0),
                                                            child: Container(
                                                              height: 20,
                                                              width: 34,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                        0xff000000)
                                                                    .withOpacity(
                                                                        0.5),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  left: 6,
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      _getArchiveModel!.data !=
                                                                              null
                                                                          ? _getArchiveModel!
                                                                              .data![index]
                                                                              .profileImage!
                                                                              .length
                                                                              .toString()
                                                                          : "0",
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .colorWhite,
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Image.asset(
                                                                      ImagePath
                                                                          .camera,
                                                                      height:
                                                                          12,
                                                                      width: 12,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 0),
                                                      child: Container(
                                                        height: 34,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color(
                                                                  0xffffffff)
                                                              .withOpacity(0.9),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    13),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    13),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8,
                                                                  right: 14),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  _getArchiveModel!
                                                                              .data !=
                                                                          null
                                                                      ? _getArchiveModel!
                                                                              .data![
                                                                                  index]
                                                                              .firstname
                                                                              .toString() +
                                                                          " " +
                                                                          _getArchiveModel!
                                                                              .data![
                                                                                  index]
                                                                              .lastname
                                                                              .toString()
                                                                      : AppConstants
                                                                          .joseph,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: fontStyle
                                                                      .copyWith(
                                                                          color:
                                                                              Colors.black),
                                                                ),
                                                              ),
                                                              (_getArchiveModel != null &&
                                                                      _getArchiveModel!
                                                                              .data !=
                                                                          null &&
                                                                      _getArchiveModel!
                                                                              .data![index]
                                                                              .isAgent ==
                                                                          "1")
                                                                  ? Image.asset(
                                                                      ImagePath
                                                                          .blackuse,
                                                                      color:
                                                                          currentColor,
                                                                      width: 22,
                                                                      height:
                                                                          22,
                                                                    )
                                                                  : Container()
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Center(child: Text("No Data Found")),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _deleteDialogBox(index) {
    return showDialog(
      context: context,
      builder: (BuildContext dialogcontext) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          content: Container(
            height: 150,
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
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Text(
                    "Do you want to Restore this profile or Delete this profile?",
                    textAlign: TextAlign.center,
                    style: headingStyle.copyWith(
                      color: const Color(0xff333F52),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            getRestoreDataApi(index);
                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: 40,
                          decoration: BoxDecoration(
                              color: currentColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(9)),
                          alignment: Alignment.center,
                          child: Text(
                            "Restore",
                            style: appBtnStyle.copyWith(color: currentColor),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            getDeleteArchive(index);
                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: 40,
                          decoration: BoxDecoration(
                              color: currentColor,
                              borderRadius: BorderRadius.circular(9)),
                          alignment: Alignment.center,
                          child: Text(
                            "Delete",
                            style: appBtnStyle,
                          ),
                        ),
                      ),
                    ],
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

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getBasicDetail();
      getLikedByYouAPi();
      getArchiveAPi();
      getStarProfile();
      getUsermatchingProfileAPi();
      getProfileAPI();
      //getDeleteArchive();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getBasicDetail();
      getLikedByYouAPi();
      getArchiveAPi();
      getStarProfile();
      getUsermatchingProfileAPi();
      getProfileAPI();
      //getDeleteArchive();
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

  getBasicDetail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {"token": token.toString()};
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_BASIC_DETAIL_URL + "?" + queryString);
    if (response.statusCode == 200) {
      CommonUtils.hideProgressLoading();
      GetBasicDetailModel _getBasicDetailModel =
          GetBasicDetailModel.fromJson(response.data);
      setState(() {
        selectedGender = _getBasicDetailModel.data!.gender.toString();
      });
    } else if (response.statusCode == 429) {
      CommonUtils.hideProgressLoading();
      getBasicDetail();
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
      // CommonUtils.hideProgressLoading();
    }
  }

  getLikedByYouAPi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": userToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    log("urls::::::;===> ${GET_LIKEDBYYOU_URL + "?" + queryString}");
    var response = await dio.get(GET_LIKEDBYYOU_URL + "?" + queryString);
    if (response.statusCode == 200) {
      var result = response.data;
      if (result['success'] == true) {
        if (result['data'].length > 0) {
          setState(() {
            _likedByYouModel = getLikedByYouModel.fromJson(result);
          });
        } else {
          setState(() {
            _likedByYouModel = null;
          });
        }
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

  setDeleteArchiveAllAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": userToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var params = {"user_id": deleteIdList};
    log("delete archive params ::: $params");
    var response = await dio.post(SET_DELETE_ARCHIVE_ALL + "?" + queryString,
        data: params);
    if (response.statusCode == 200) {
      getArchiveAPi();
      setState(() {
        isDeleteSelected = false;
        deleteIdList.clear();
      });
      log("delete archive response ::: ${response.data}");
    }
  }

  getUsermatchingProfileAPi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": userToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_USER_MATCHING_PROFILE + "?" + queryString);
    if (response.statusCode == 200) {
      setState(() {
        _getUserMatchingProfileModel =
            GetUserMatchingProfileModel.fromJson(response.data);
      });
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

  getStarProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": userToken.toString(),
    };
    try {
      String queryString = Uri(queryParameters: queryParameters).query;
      log("urls::::::;===> ${GET_STAR_PROFILE_URL + "?" + queryString}");
      var response = await dio.get(GET_STAR_PROFILE_URL + "?" + queryString);
      if (response.statusCode == 200) {
        setState(() {
          _getStarProfileModel = GetStarProfileModel.fromJson(response.data);
        });
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
    } catch (e) {
      log("star error :::$e");
    }
  }

  getArchiveAPi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": userToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_ARCHIVE_URL + "?" + queryString);
    if (response.statusCode == 200) {
      var result = response.data;
      log("archive ===>  ${result}");
      if (result['success'] == true) {
        if (result['data'].length > 0) {
          log("in here archuive get");
          setState(
            () {
              _getArchiveModel = GetArchiveModel.fromJson(result);
            },
          );
          for (int i = 0; i < _getArchiveModel!.data!.length; i++) {
            setState(() {
              archiveDeleteList.add(ArchiveModel(
                  isSelected: false,
                  userId: _getArchiveModel!.data![i].userId));
            });
          }
        } else {
          setState(
            () {
              _getArchiveModel = null;
            },
          );
        }
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

  getAddArchiveApi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.get(USER_TOKEN);
    var response = await dio
        .get(GET_ADD_ARCHIVE_URL + "?user_id=$likeByYouId&token=$userToken");
    if (response.statusCode == 200) {
      if (response.data['data'] == 1) {
        getLikedByYouAPi();
        getArchiveAPi();
        getStarProfile();
        getUsermatchingProfileAPi();
        Fluttertoast.showToast(
            msg: "Archive successfully ",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffE16284),
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        setState(() {
          _getAddarchiveModel = GetAddarchiveModel.fromJson(response.data);
        });
        log("Archive complete");
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

  getDeleteArchive(int index) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.get(USER_TOKEN);
    var response = await dio.get(GET_DELETE_ARCHIVE_URL +
        "?token=$userToken&user_id=${_getArchiveModel!.data![index].userId.toString()}");
    log("inrespp======> ${response}");
    if (response.statusCode == 200) {
      // if (response.data['data'] == 1) {
      if (response.data['success'] == true) {
        Fluttertoast.showToast(
            msg: "User delete successfully ",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffE16284),
            textColor: Colors.white,
            fontSize: 16.0);
        getArchiveAPi();
      } else {
        setState(() {
          _deleteArchiveModel = GetDeleteArchiveModel.fromJson(response.data);
        });
        log("Archive Delete complete");
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

  getRestoreDataApi(int index) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.get(USER_TOKEN);
    var response = await dio.get(GET_REVERT_ARCHIVE_URL +
        "?token=$userToken&user_id=${_getArchiveModel!.data![index].userId.toString()}");
    log("inrespp======> ${response}");
    if (response.statusCode == 200) {
      // if (response.data['data'] == 1) {
      if (response.data['success'] == true) {
        Fluttertoast.showToast(
            msg: "User Revert Back Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffE16284),
            textColor: Colors.white,
            fontSize: 16.0);
        getArchiveAPi();
      } else {
        setState(() {
          _getRevertModel = GetRevertModel.fromJson(response.data);
        });
        log("Archive Delete complete");
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

class ProfileImage1 {
  String? filePath;

  ProfileImage1({this.filePath});

  ProfileImage1.fromJson(Map<String, dynamic> json) {
    filePath = json['file_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_path'] = this.filePath;
    return data;
  }
}
