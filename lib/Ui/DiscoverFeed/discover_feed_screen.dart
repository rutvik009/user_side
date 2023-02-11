import 'dart:developer';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/All_Count_Users_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Get_Recently_Visit_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Matchmaker_nearyou_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Near_You_Match_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Today_Match_Detail_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/getLikedByYouModel.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/get_MyMatch_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/get_refer_by_agent_model.dart';
import 'package:matrimonial_app/Ui/DiscoverFeed/Skeleton_Discover_Screen.dart';
import 'package:matrimonial_app/Ui/DiscoverFeed/benefits.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Drawer/ProfileScreen/profile_screenn.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/User_Detail_Screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Notification/chat_screen.dart';
import 'package:matrimonial_app/Ui/Search/filter_screen.dart';
import 'package:matrimonial_app/Ui/Search/search_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/Utils/value_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../ModelClass/UserPanel_ModelClass/Recently_Visited_You_Model.dart';

class DiscoverFeed extends StatefulWidget {
  DiscoverFeed({Key? key}) : super(key: key);

  @override
  State<DiscoverFeed> createState() => _DiscoverFeedState();
}

class _DiscoverFeedState extends State<DiscoverFeed> {
  getLikedByYouModel? _likedByYouModel;
  GetRecentlyVisitModel? _getRecentlyVisitModel;
  TodayMatchDetailModel? _todayMatchDetailModel;
  NearYouMatchModel? _nearYouMatchModel;
  MatchmakerNearYouModel? _matchmakerNearYouModel;
  GetMyMatchModel? _getMyMatchModel;
  AllCountUsersModel? _allCountUsersModel;
  GetReferbyAgentModel? _getReferbyAgentModel;
  RecentlyVisitedToYouModel? _recentlyVisitedToYouModel;
  Dio dio = Dio();
  int selectedMatches = 0;
  String? selectedgender;
  int? changeIndex;
  List<Map<String, dynamic>> match = [];
  bool isLoading = false;

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
      body: (isLoading)
          ? Skeleton_Discover()
          : Column(
              children: [
                AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leadingWidth: 40,
                  centerTitle: true,
                  title: Text(
                    "discover".tr,
                    style: headingStyle.copyWith(
                        color: Color(0xff440312),
                        fontSize: 21,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: width,
                          color: Color(0xffffffff),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 16),
                                child:
                                    Text("match maker".tr, style: matchermake),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              _matchmakerNearYouModel != null
                                  ? Container(
                                      height: 105,
                                      // color: Colors.amberAccent,
                                      child: ListView.builder(
                                          itemCount: (_matchmakerNearYouModel !=
                                                      null &&
                                                  _matchmakerNearYouModel !=
                                                      null)
                                              ? _matchmakerNearYouModel!
                                                  .data!.length
                                              : 0,
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            String?
                                                name =
                                                _matchmakerNearYouModel !=
                                                            null &&
                                                        _matchmakerNearYouModel!
                                                                .data !=
                                                            null
                                                    ? capitalizeWords(
                                                        _matchmakerNearYouModel!
                                                                .data![index]
                                                                .firstname
                                                                .toString() +
                                                            ' ' +
                                                            _matchmakerNearYouModel!
                                                                .data![index]
                                                                .lastname
                                                                .toString())
                                                    : AppConstants.stevesmith;
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15, right: 8),
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        CupertinoPageRoute(
                                                          builder: (context) =>
                                                              Benefits(
                                                            selectIndex: index,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: (_matchmakerNearYouModel != null &&
                                                            _matchmakerNearYouModel!
                                                                    .data !=
                                                                null &&
                                                            _matchmakerNearYouModel!
                                                                    .data![
                                                                        index]
                                                                    .profileImage!
                                                                    .length >
                                                                0)
                                                        ? Container(
                                                            height: 80,
                                                            width: 80,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              // shape:
                                                              //     BoxShape.circle,
                                                              border:
                                                                  Border.all(
                                                                width: 2,
                                                                color:
                                                                    currentColor,
                                                              ),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: _matchmakerNearYouModel!
                                                                    .data![
                                                                        index]
                                                                    .profileImage![
                                                                        0]
                                                                    .filePath
                                                                    .toString(),
                                                                height: 67,
                                                                width: 67,
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                          )
                                                        : _matchmakerNearYouModel!
                                                                    .data![
                                                                        index]
                                                                    .gender ==
                                                                "Male"
                                                            ? Container(
                                                                // height: 67,
                                                                // width: 67,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        width:
                                                                            2,
                                                                        color:
                                                                            currentColor)),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  child: Image.asset(
                                                                      ImagePath
                                                                          .maleProfile,
                                                                      height:
                                                                          75),
                                                                ),
                                                              )
                                                            : ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                child:
                                                                    Image.asset(
                                                                  ImagePath
                                                                      .femaleProfile,
                                                                  height: 78,
                                                                ),
                                                              ),
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    name.length > 10
                                                        ? name.substring(
                                                                0, 10) +
                                                            '...'
                                                        : name,
                                                    style: TextStyle(),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                    )
                                  : Center(
                                      /* child: Column(
                                children: [
                                  Image.asset(
                                    ImagePath.malerobot,
                                    height: 72,
                                  ),
                                  Text(AppConstants.waiting)
                                ],
                              ) */
                                      ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: width,
                                height: 230,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        ImagePath.coffe,
                                      ),
                                      fit: BoxFit.cover),
                                ),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 35, top: 140),
                                      child: GestureDetector(
                                        onTap: () {
                                          _greateDialogBox();
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 101,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: AppColors.colorWhite),
                                          child: Center(
                                            child: Text(
                                              AppConstants.join,
                                              style: join,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => Search_screen(),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16, right: 16),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xffF6F6F6),
                                    ),
                                    width: width,
                                    height: 49,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          ImagePath.search,
                                          width: 15.9,
                                          height: 15.9,
                                        ),
                                        Text(
                                          "discover search".tr,
                                          style: searchid,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    Filter_screen(),
                                              ),
                                            );
                                          },
                                          child: Image.asset(
                                            ImagePath.filterimage,
                                            height: height * 0.030,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                height: 35,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: List.generate(
                                    match.length,
                                    (index) => Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedMatches = index;
                                          });
                                          if (selectedMatches == 0) {
                                            getNearYouMatchAPI();
                                          } else if (selectedMatches == 1) {
                                            getRecentlyAPI();
                                            GetRecentlyVisitedToYouAPI();
                                          } else {
                                            getTodayMatchDetailAPI();
                                          }
                                        },
                                        child: Container(
                                            decoration: selectedMatches == index
                                                ? BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: currentColor)
                                                : BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: AppColors
                                                            .containeborder)),
                                            child: Center(
                                                child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(match[index][NAME],
                                                  style: selectedMatches ==
                                                          index
                                                      ? containertext.copyWith(
                                                          color: Colors.white)
                                                      : containertext),
                                            ))),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  AppConstants.foryou,
                                  style: matchermake,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              // Near you data
                              (selectedMatches == 0)
                                  ? _nearYouMatchModel != null &&
                                          _nearYouMatchModel!.data != null &&
                                          _nearYouMatchModel!.data!.length > 0
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: GridView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 17.0,
                                              mainAxisSpacing: 17.0,
                                              mainAxisExtent: 235,
                                            ),
                                            itemCount: (_nearYouMatchModel !=
                                                        null &&
                                                    _nearYouMatchModel!.data !=
                                                        null)
                                                ? _nearYouMatchModel!
                                                    .data!.length
                                                : 0,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    CupertinoPageRoute(
                                                      builder: (context) =>
                                                          UserDetailScreen(
                                                        userDetailIndex:
                                                            _nearYouMatchModel!
                                                                .data![index]
                                                                .userId,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: 210,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: currentColor,
                                                        width: 5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18), /* color: currentColor */
                                                  ),
                                                  child: Container(
                                                    child: Stack(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      13.0),
                                                          child: _nearYouMatchModel != null &&
                                                                  _nearYouMatchModel!
                                                                          .data !=
                                                                      null &&
                                                                  _nearYouMatchModel!
                                                                      .data![
                                                                          index]
                                                                      .profileImage!
                                                                      .isNotEmpty
                                                              ? (_nearYouMatchModel!
                                                                          .data![
                                                                              index]
                                                                          .blurImage ==
                                                                      1)
                                                                  ? ImageFiltered(
                                                                      imageFilter: ImageFilter.blur(
                                                                          sigmaX:
                                                                              5,
                                                                          sigmaY:
                                                                              5),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        imageUrl: _nearYouMatchModel!
                                                                            .data![index]
                                                                            .profileImage![0]
                                                                            .filePath
                                                                            .toString(),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        height:
                                                                            235,
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                      ),
                                                                    )
                                                                  : CachedNetworkImage(
                                                                      imageUrl: _nearYouMatchModel!
                                                                          .data![
                                                                              index]
                                                                          .profileImage![
                                                                              0]
                                                                          .filePath
                                                                          .toString(),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      height:
                                                                          235,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                    )
                                                              : (_nearYouMatchModel != null &&
                                                                      _nearYouMatchModel!
                                                                              .data !=
                                                                          null &&
                                                                      _nearYouMatchModel!
                                                                              .data![index]
                                                                              .gender ==
                                                                          "Male")
                                                                  ? Image.asset(
                                                                      ImagePath
                                                                          .profile,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      height:
                                                                          207,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                    )
                                                                  : Image.asset(
                                                                      ImagePath
                                                                          .femaleProfileUser,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      height:
                                                                          207,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                    ),
                                                        ),
                                                        // Spacer(),
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          child: Container(
                                                            height: 75,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                      0xffffffff)
                                                                  .withOpacity(
                                                                      0.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            13),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        13),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 8,
                                                                      right: 0,
                                                                      top: 5),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      (_nearYouMatchModel != null &&
                                                                              _nearYouMatchModel!.data != null &&
                                                                              _nearYouMatchModel!.data![index].isAgent == "1")
                                                                          ? Image.asset(
                                                                              ImagePath.dualprofile,
                                                                              color: currentColor,
                                                                              height: 16,
                                                                              width: 16,
                                                                            )
                                                                          : Container(),
                                                                      (_nearYouMatchModel != null &&
                                                                              _nearYouMatchModel!.data != null &&
                                                                              _nearYouMatchModel!.data![index].isAgent == "1")
                                                                          ? SizedBox(
                                                                              width: 5,
                                                                            )
                                                                          : SizedBox(),
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          _nearYouMatchModel != null && _nearYouMatchModel!.data != null
                                                                              ? capitalizeWords(_nearYouMatchModel!.data![index].firstname.toString()) + ' | ' + _nearYouMatchModel!.data![index].age.toString()
                                                                              : AppConstants.joseph,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          maxLines:
                                                                              1,
                                                                          style: fontStyle.copyWith(
                                                                              color: Colors.black,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w600),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    width: 0,
                                                                  ),
                                                                  Padding(
                                                                    padding: (_nearYouMatchModel != null &&
                                                                            _nearYouMatchModel!.data !=
                                                                                null &&
                                                                            _nearYouMatchModel!.data![index].isAgent ==
                                                                                "1")
                                                                        ? EdgeInsets.only(
                                                                            left:
                                                                                18.0)
                                                                        : EdgeInsets.only(
                                                                            left:
                                                                                00),
                                                                    child: Text(
                                                                      _nearYouMatchModel != null &&
                                                                              _nearYouMatchModel!.data !=
                                                                                  null
                                                                          ? _nearYouMatchModel!.data![index].gender.toString() +
                                                                              ' | ' +
                                                                              _nearYouMatchModel!.data![index].height.toString()
                                                                          : AppConstants.castText,
                                                                      style: matchscroll.copyWith(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left: 0,
                                                                        right:
                                                                            8,
                                                                        bottom:
                                                                            5),
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        /// ----------- firebase chat module start -----------

                                                                        Uuid
                                                                            uuid =
                                                                            Uuid();
                                                                        String
                                                                            chatId =
                                                                            "";
                                                                        String
                                                                            uuId =
                                                                            uuid.v4();
                                                                        SharedPreferences
                                                                            prefs =
                                                                            await SharedPreferences.getInstance();
                                                                        String?
                                                                            userId =
                                                                            await prefs.getString(USER_ID);
                                                                        String?
                                                                            userName =
                                                                            await prefs.getString(FULLNAME);
                                                                        String?
                                                                            userProfile =
                                                                            await prefs.getString(PROFILEIMAGE);
                                                                        FirebaseFirestore
                                                                            firestore =
                                                                            FirebaseFirestore.instance;
                                                                        bool?
                                                                            alreadyChat =
                                                                            false;
                                                                        List
                                                                            chatData =
                                                                            [];
                                                                        CommonUtils.showProgressLoading(
                                                                            context);

                                                                        firestore
                                                                            .collection("Users")
                                                                            .doc(userId)
                                                                            .get()
                                                                            .then((value) async {
                                                                          if (value.data() ==
                                                                              null) {
                                                                            log("new user chat");
                                                                            setState(() {
                                                                              alreadyChat = false;
                                                                            });
                                                                          } else {
                                                                            List
                                                                                chatList =
                                                                                value.data()!["chats"] ?? [];
                                                                            for (var i = 0;
                                                                                i < chatList.length;
                                                                                i++) {
                                                                              if (chatList[i]['userId'] == _nearYouMatchModel!.data![index].userId.toString()) {
                                                                                setState(() {
                                                                                  log("already chat true");
                                                                                  alreadyChat = true;
                                                                                  chatId = chatList[i]['chatId'].toString();
                                                                                });
                                                                                break;
                                                                              } else {
                                                                                log("already chat false");
                                                                                setState(() {
                                                                                  alreadyChat = false;
                                                                                });
                                                                              }
                                                                            }
                                                                          }
                                                                        }).then((value) async {
                                                                          if (alreadyChat! ==
                                                                              false) {
                                                                            setState(() {
                                                                              chatData.add({
                                                                                "chatId": uuId,
                                                                                "userId": _nearYouMatchModel!.data![index].userId.toString(),
                                                                                "userName": _nearYouMatchModel!.data![index].firstname.toString(),
                                                                                "userProfile": (_nearYouMatchModel!.data![index].profileImage!.isNotEmpty) ? _nearYouMatchModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                              });
                                                                            });

                                                                            await firestore.collection("Users").doc(userId).set({
                                                                              "chats": FieldValue.arrayUnion(chatData),
                                                                            }, SetOptions(merge: true));
                                                                            List
                                                                                chats =
                                                                                [];
                                                                            firestore.collection("Users").doc(_nearYouMatchModel!.data![index].userId.toString()).get().then((value) {
                                                                              setState(() {
                                                                                chats = value.data()!["chats"];
                                                                              });
                                                                            });

                                                                            setState(() {
                                                                              chats.add({
                                                                                "chatId": uuId,
                                                                                "userId": userId,
                                                                                "userName": userName,
                                                                                "userProfile": userProfile,
                                                                              });
                                                                            });
                                                                            await firestore.collection("Users").doc(_nearYouMatchModel!.data![index].userId.toString()).set({
                                                                              "chats": FieldValue.arrayUnion(chats),
                                                                            }, SetOptions(merge: true));
                                                                            log("uuid new");
                                                                            CommonUtils.hideProgressLoading();
                                                                            Navigator.push(
                                                                                context,
                                                                                CupertinoPageRoute(
                                                                                    builder: (context) => Chat_screen(
                                                                                          userId: _nearYouMatchModel!.data![index].userId.toString(),
                                                                                          chatId: uuId,
                                                                                          image: (_nearYouMatchModel != null && _nearYouMatchModel!.data!.isNotEmpty && _nearYouMatchModel!.data![index].profileImage!.isNotEmpty) ? _nearYouMatchModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                          name: _nearYouMatchModel!.data![index].firstname.toString() + ' ' + _nearYouMatchModel!.data![index].lastname.toString(),
                                                                                        )));
                                                                          } else {
                                                                            log("uuid old");
                                                                            CommonUtils.hideProgressLoading();
                                                                            Navigator.push(
                                                                                context,
                                                                                CupertinoPageRoute(
                                                                                    builder: (context) => Chat_screen(
                                                                                          userId: _nearYouMatchModel!.data![index].userId.toString(),
                                                                                          chatId: chatId,
                                                                                          image: (_nearYouMatchModel != null && _nearYouMatchModel!.data!.isNotEmpty && _nearYouMatchModel!.data![index].profileImage!.isNotEmpty) ? _nearYouMatchModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                          name: _nearYouMatchModel!.data![index].firstname.toString() + ' ' + _nearYouMatchModel!.data![index].lastname.toString(),
                                                                                        )));
                                                                          }
                                                                        });
                                                                        /* firestore
                                                                            .collection(
                                                                                "Users")
                                                                            .where("userId",
                                                                                isEqualTo: userId)
                                                                            .get()
                                                                            .then((value) {
                                                                          value
                                                                              .docs
                                                                              .forEach((element) {
                                                                            if (element.data()["chats"] !=
                                                                                null) {
                                                                              setState(() {
                                                                                chatData = element.data()["chats"];
                                                                              });
                                                                              element.data()["chats"].forEach((value) {
                                                                                log("user id :: ${value["userId"].toString()}");
                                                                                log("user id :: ${_nearYouMatchModel!.data![index].userId.toString()}");
                                                                                log("user id :: ${value["userId"].toString() == _nearYouMatchModel!.data![index].userId.toString()}");
                                                                                if (value["userId"].toString() == _nearYouMatchModel!.data![index].userId.toString()) {
                                                                                  log("already chat true");
                                                                                  setState(() {
                                                                                    alreadyChat = true;
                                                                                    chatId = value["chatId"].toString();
                                                                                  });
                                                                                }
                                                                              });
                                                                            } else {
                                                                              log("already chat false");
                                                                              setState(() {
                                                                                alreadyChat = false;
                                                                              });
                                                                            }
                                                                          });
                                                                        }).then((value) {
                                                                          if (alreadyChat! ==
                                                                              false) {
                                                                            setState(() {
                                                                              chatData.add({
                                                                                "chatId": uuId,
                                                                                "userId": _nearYouMatchModel!.data![index].userId.toString(),
                                                                                "userName": _nearYouMatchModel!.data![index].firstname.toString(),
                                                                                "userProfile": _nearYouMatchModel!.data![index].profileImage![0].filePath.toString(),
                                                                              });
                                                                            });

                                                                            firestore.collection("Users").doc(userId).set({
                                                                              "chats": FieldValue.arrayUnion(chatData),
                                                                            }, SetOptions(merge: true));
                                                                            List
                                                                                chats =
                                                                                [];
                                                                            firestore.collection("Users").doc(_nearYouMatchModel!.data![index].userId.toString()).get().then((value) {
                                                                              setState(() {
                                                                                chats = value.data()!["chats"];
                                                                              });
                                                                            });

                                                                            setState(() {
                                                                              chats.add({
                                                                                "chatId": uuId,
                                                                                "userId": userId,
                                                                                "userName": userName,
                                                                                "userProfile": userProfile,
                                                                              });
                                                                            });
                                                                            firestore.collection("Users").doc(_nearYouMatchModel!.data![index].userId.toString()).set({
                                                                              "chats": FieldValue.arrayUnion(chats),
                                                                            }, SetOptions(merge: true));
                                                                            log("uuid new");
                                                                            Navigator.push(
                                                                                context,
                                                                                CupertinoPageRoute(
                                                                                    builder: (context) => Chat_screen(
                                                                                          userId: _nearYouMatchModel!.data![index].userId.toString(),
                                                                                          chatId: uuId,
                                                                                          image: (_nearYouMatchModel != null && _nearYouMatchModel!.data!.isNotEmpty && _nearYouMatchModel!.data![index].profileImage!.isNotEmpty) ? _nearYouMatchModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                          name: _nearYouMatchModel!.data![index].firstname.toString() + ' ' + _nearYouMatchModel!.data![index].lastname.toString(),
                                                                                        )));
                                                                          } else {
                                                                            log("uuid old");

                                                                            Navigator.push(
                                                                                context,
                                                                                CupertinoPageRoute(
                                                                                    builder: (context) => Chat_screen(
                                                                                          userId: _nearYouMatchModel!.data![index].userId.toString(),
                                                                                          chatId: chatId,
                                                                                          image: (_nearYouMatchModel != null && _nearYouMatchModel!.data!.isNotEmpty && _nearYouMatchModel!.data![index].profileImage!.isNotEmpty) ? _nearYouMatchModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                          name: _nearYouMatchModel!.data![index].firstname.toString() + ' ' + _nearYouMatchModel!.data![index].lastname.toString(),
                                                                                        )));
                                                                          }
                                                                        }); */

                                                                        /// ----------- firebase chat module end -----------
                                                                        /*  Navigator.push(
                                                                            context,
                                                                            CupertinoPageRoute(
                                                                                builder: (context) => Chat_screen(
                                                                                      image: (_nearYouMatchModel != null && _nearYouMatchModel!.data!.isNotEmpty && _nearYouMatchModel!.data![index].profileImage!.isNotEmpty) ? _nearYouMatchModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                      name: _nearYouMatchModel!.data![index].firstname.toString() + ' ' + _nearYouMatchModel!.data![index].lastname.toString(),
                                                                                    ))); */
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        height:
                                                                            25,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                currentColor,
                                                                            borderRadius:
                                                                                BorderRadius.circular(9)),
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Text(
                                                                          'Message',
                                                                          style: appBtnStyle.copyWith(
                                                                              fontSize: 12,
                                                                              color: Colors.white),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : Center(
                                          child: Text(
                                              "We Don`t Have Match Near You!"))
                                  // Recently Visited Data
                                  : (selectedMatches == 1)
                                      ? _getRecentlyVisitModel != null &&
                                              _getRecentlyVisitModel!.data !=
                                                  null &&
                                              _getRecentlyVisitModel!
                                                      .data!.length >
                                                  0
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16),
                                              child: GridView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 17.0,
                                                  mainAxisSpacing: 17.0,
                                                  mainAxisExtent: 235,
                                                ),
                                                itemCount:
                                                    (_getRecentlyVisitModel !=
                                                                null &&
                                                            _getRecentlyVisitModel!
                                                                    .data !=
                                                                null)
                                                        ? _getRecentlyVisitModel!
                                                            .data!.length
                                                        : 0,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      print(
                                                          "user id:::: ${_getRecentlyVisitModel!.data![index].userId}");
                                                      Navigator.push(
                                                          context,
                                                          CupertinoPageRoute(
                                                              builder: (context) => UserDetailScreen(
                                                                  userDetailIndex:
                                                                      _getRecentlyVisitModel!
                                                                          .data![
                                                                              index]
                                                                          .userId)));
                                                    },
                                                    child: Container(
                                                      height: 210,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: currentColor,
                                                            width: 5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(0),
                                                        child: Container(
                                                          height: 210,
                                                          child: Stack(
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            13.0),
                                                                child: _getRecentlyVisitModel != null &&
                                                                        _getRecentlyVisitModel!.data !=
                                                                            null &&
                                                                        _getRecentlyVisitModel!
                                                                            .data![
                                                                                index]
                                                                            .profileImage!
                                                                            .isNotEmpty
                                                                    ? (_getRecentlyVisitModel!.data![index].blurImage ==
                                                                            1)
                                                                        ? ImageFiltered(
                                                                            imageFilter:
                                                                                ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                                                            child:
                                                                                CachedNetworkImage(
                                                                              imageUrl: _getRecentlyVisitModel!.data![index].profileImage![0].filePath.toString(),
                                                                              fit: BoxFit.cover,
                                                                              height: 235,
                                                                              width: MediaQuery.of(context).size.width,
                                                                            ),
                                                                          )
                                                                        : CachedNetworkImage(
                                                                            imageUrl:
                                                                                _getRecentlyVisitModel!.data![index].profileImage![0].filePath.toString(),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            height:
                                                                                235,
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                          )
                                                                    : (_getRecentlyVisitModel != null &&
                                                                            _getRecentlyVisitModel!.data !=
                                                                                null &&
                                                                            _getRecentlyVisitModel!.data![index].gender ==
                                                                                "Male")
                                                                        ? Image
                                                                            .asset(
                                                                            ImagePath.profile,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            height:
                                                                                207,
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                          )
                                                                        : Image
                                                                            .asset(
                                                                            ImagePath.femaleProfileUser,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            height:
                                                                                207,
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                          ),
                                                              ),

                                                              // Spacer(),
                                                              Align(
                                                                alignment: Alignment
                                                                    .bottomCenter,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          0),
                                                                  child:
                                                                      Container(
                                                                    height: 75,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                              0xffffffff)
                                                                          .withOpacity(
                                                                              0.5),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        bottomRight:
                                                                            Radius.circular(13),
                                                                        bottomLeft:
                                                                            Radius.circular(13),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              8,
                                                                          right:
                                                                              14,
                                                                          top:
                                                                              5),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              (_getRecentlyVisitModel != null && _getRecentlyVisitModel!.data != null && _getRecentlyVisitModel!.data![index].isAgent == "1")
                                                                                  ? Image.asset(
                                                                                      ImagePath.dualprofile,
                                                                                      color: currentColor,
                                                                                      height: 16,
                                                                                      width: 16,
                                                                                    )
                                                                                  : Container(),
                                                                              (_getRecentlyVisitModel != null && _getRecentlyVisitModel!.data != null && _getRecentlyVisitModel!.data![index].isAgent == "1")
                                                                                  ? SizedBox(
                                                                                      width: 5,
                                                                                    )
                                                                                  : SizedBox(),
                                                                              Expanded(
                                                                                child: Text(
                                                                                  _getRecentlyVisitModel != null && _getRecentlyVisitModel!.data != null ? capitalizeWords(_getRecentlyVisitModel!.data![index].firstname.toString()) + ' | ' + _getRecentlyVisitModel!.data![index].age.toString() : AppConstants.joseph,
                                                                                  maxLines: 1,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: fontStyle.copyWith(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Text(
                                                                            _getRecentlyVisitModel != null && _getRecentlyVisitModel!.data != null
                                                                                ? _getRecentlyVisitModel!.data![index].gender.toString() + ' | ' + _getRecentlyVisitModel!.data![index].height.toString()
                                                                                : AppConstants.castText,
                                                                            style: matchscroll.copyWith(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Colors.black),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 5,
                                                                                right: 0,
                                                                                bottom: 5),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () async {
                                                                                /// ----------- firebase chat module start -----------

                                                                                Uuid uuid = Uuid();
                                                                                String chatId = "";
                                                                                String uuId = uuid.v4();
                                                                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                                String? userId = await prefs.getString(USER_ID);
                                                                                String? userName = await prefs.getString(FULLNAME);
                                                                                String? userProfile = await prefs.getString(PROFILEIMAGE);
                                                                                FirebaseFirestore firestore = FirebaseFirestore.instance;
                                                                                bool? alreadyChat = false;
                                                                                List chatData = [];
                                                                                CommonUtils.showProgressLoading(context);

                                                                                firestore.collection("Users").doc(userId).get().then((value) async {
                                                                                  if (value.data() == null) {
                                                                                    log("new user chat");
                                                                                    setState(() {
                                                                                      alreadyChat = false;
                                                                                    });
                                                                                  } else {
                                                                                    List chatList = value.data()!["chats"] ?? [];
                                                                                    for (var i = 0; i < chatList.length; i++) {
                                                                                      if (chatList[i]['userId'] == _getRecentlyVisitModel!.data![index].userId.toString()) {
                                                                                        setState(() {
                                                                                          log("already chat true");
                                                                                          alreadyChat = true;
                                                                                          chatId = chatList[i]['chatId'].toString();
                                                                                        });
                                                                                        break;
                                                                                      } else {
                                                                                        log("already chat false");
                                                                                        setState(() {
                                                                                          alreadyChat = false;
                                                                                        });
                                                                                      }
                                                                                    }
                                                                                  }
                                                                                }).then((value) async {
                                                                                  if (alreadyChat! == false) {
                                                                                    setState(() {
                                                                                      chatData.add({
                                                                                        "chatId": uuId,
                                                                                        "userId": _getRecentlyVisitModel!.data![index].userId.toString(),
                                                                                        "userName": _getRecentlyVisitModel!.data![index].firstname.toString(),
                                                                                        "userProfile": (_getRecentlyVisitModel!.data![index].profileImage!.isNotEmpty) ? _getRecentlyVisitModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                      });
                                                                                    });

                                                                                    await firestore.collection("Users").doc(userId).set({
                                                                                      "chats": FieldValue.arrayUnion(chatData),
                                                                                    }, SetOptions(merge: true));
                                                                                    List chats = [];
                                                                                    firestore.collection("Users").doc(_getRecentlyVisitModel!.data![index].userId.toString()).get().then((value) {
                                                                                      setState(() {
                                                                                        chats = value.data()!["chats"];
                                                                                      });
                                                                                    });

                                                                                    setState(() {
                                                                                      chats.add({
                                                                                        "chatId": uuId,
                                                                                        "userId": userId,
                                                                                        "userName": userName,
                                                                                        "userProfile": userProfile,
                                                                                      });
                                                                                    });
                                                                                    await firestore.collection("Users").doc(_getRecentlyVisitModel!.data![index].userId.toString()).set({
                                                                                      "chats": FieldValue.arrayUnion(chats),
                                                                                    }, SetOptions(merge: true));
                                                                                    log("uuid new");
                                                                                    CommonUtils.hideProgressLoading();
                                                                                    Navigator.push(
                                                                                        context,
                                                                                        CupertinoPageRoute(
                                                                                            builder: (context) => Chat_screen(
                                                                                                  userId: _getRecentlyVisitModel!.data![index].userId.toString(),
                                                                                                  chatId: uuId,
                                                                                                  image: (_getRecentlyVisitModel != null && _getRecentlyVisitModel!.data!.isNotEmpty && _getRecentlyVisitModel!.data![index].profileImage!.isNotEmpty) ? _getRecentlyVisitModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                                  name: _getRecentlyVisitModel!.data![index].firstname.toString() + ' ' + _getRecentlyVisitModel!.data![index].lastname.toString(),
                                                                                                )));
                                                                                  } else {
                                                                                    log("uuid old");
                                                                                    CommonUtils.hideProgressLoading();
                                                                                    Navigator.push(
                                                                                        context,
                                                                                        CupertinoPageRoute(
                                                                                            builder: (context) => Chat_screen(
                                                                                                  userId: _getRecentlyVisitModel!.data![index].userId.toString(),
                                                                                                  chatId: chatId,
                                                                                                  image: (_getRecentlyVisitModel != null && _getRecentlyVisitModel!.data!.isNotEmpty && _getRecentlyVisitModel!.data![index].profileImage!.isNotEmpty) ? _getRecentlyVisitModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                                  name: _getRecentlyVisitModel!.data![index].firstname.toString() + ' ' + _getRecentlyVisitModel!.data![index].lastname.toString(),
                                                                                                )));
                                                                                  }
                                                                                });
                                                                                /* await firestore.collection("Users").where("userId", isEqualTo: _getRecentlyVisitModel!.data![index].userId.toString()).get().then((value) async {
                                                                                  value.docs.forEach((element) async {
                                                                                    if (element.data()["chats"] != null) {
                                                                                      setState(() {
                                                                                        chatData = element.data()["chats"];
                                                                                      });
                                                                                      element.data()["chats"].forEach((value) {
                                                                                        log("user id :: ${value["userId"].toString()}");
                                                                                        log("user id :: ${_getRecentlyVisitModel!.data![index].userId.toString()}");
                                                                                        log("user id :: ${value["userId"].toString() == _getRecentlyVisitModel!.data![index].userId.toString()}");
                                                                                        if (value["userId"].toString() == _getRecentlyVisitModel!.data![index].userId.toString()) {
                                                                                          setState(() {
                                                                                            alreadyChat = true;
                                                                                            chatId = value["chatId"].toString();
                                                                                          });
                                                                                        }
                                                                                      });
                                                                                    } else {
                                                                                      setState(() {
                                                                                        alreadyChat = false;
                                                                                      });
                                                                                    }
                                                                                  });
                                                                                }).whenComplete(() async {
                                                                                  if (alreadyChat! == false) {
                                                                                    setState(() {
                                                                                      chatData.add({
                                                                                        "chatId": uuId,
                                                                                        "userId": _getRecentlyVisitModel!.data![index].userId.toString(),
                                                                                        "userName": _getRecentlyVisitModel!.data![index].firstname.toString(),
                                                                                        "userProfile": _getRecentlyVisitModel!.data![index].profileImage![0].filePath.toString(),
                                                                                      });
                                                                                    });

                                                                                    await firestore.collection("Users").doc(userId).set({
                                                                                      "chats": FieldValue.arrayUnion(chatData),
                                                                                    }, SetOptions(merge: true));
                                                                                    List chats = [];
                                                                                    firestore.collection("Users").doc(_getRecentlyVisitModel!.data![index].userId.toString()).get().then((value) {
                                                                                      setState(() {
                                                                                        chats = value.data()!["chats"];
                                                                                      });
                                                                                    });

                                                                                    setState(() {
                                                                                      chats.add({
                                                                                        "chatId": uuId,
                                                                                        "userId": userId,
                                                                                        "userName": userName,
                                                                                        "userProfile": userProfile,
                                                                                      });
                                                                                    });
                                                                                    await firestore.collection("Users").doc(_getRecentlyVisitModel!.data![index].userId.toString()).set({
                                                                                      "chats": FieldValue.arrayUnion(chats),
                                                                                    }, SetOptions(merge: true));
                                                                                    log("uuid new");
                                                                                    Navigator.push(
                                                                                        context,
                                                                                        CupertinoPageRoute(
                                                                                            builder: (context) => Chat_screen(
                                                                                                  userId: _getRecentlyVisitModel!.data![index].userId.toString(),
                                                                                                  chatId: uuId,
                                                                                                  image: (_getRecentlyVisitModel != null && _getRecentlyVisitModel!.data!.isNotEmpty && _getRecentlyVisitModel!.data![index].profileImage!.isNotEmpty) ? _getRecentlyVisitModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                                  name: _getRecentlyVisitModel!.data![index].firstname.toString() + ' ' + _getRecentlyVisitModel!.data![index].lastname.toString(),
                                                                                                )));
                                                                                  } else {
                                                                                    log("uuid old");

                                                                                    Navigator.push(
                                                                                        context,
                                                                                        CupertinoPageRoute(
                                                                                            builder: (context) => Chat_screen(
                                                                                                  userId: _getRecentlyVisitModel!.data![index].userId.toString(),
                                                                                                  chatId: chatId,
                                                                                                  image: (_getRecentlyVisitModel != null && _getRecentlyVisitModel!.data!.isNotEmpty && _getRecentlyVisitModel!.data![index].profileImage!.isNotEmpty) ? _getRecentlyVisitModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                                  name: _getRecentlyVisitModel!.data![index].firstname.toString() + ' ' + _getRecentlyVisitModel!.data![index].lastname.toString(),
                                                                                                )));
                                                                                  }
                                                                                }); */

                                                                                /// ----------- firebase chat module end -----------

                                                                                /*  Navigator.push(
                                                                                  context,
                                                                                  CupertinoPageRoute(
                                                                                    builder: (context) => Chat_screen(
                                                                                      image: (_getRecentlyVisitModel != null && _getRecentlyVisitModel!.data!.isNotEmpty && _getRecentlyVisitModel!.data![index].profileImage!.isNotEmpty) ? _getRecentlyVisitModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                      name: _getRecentlyVisitModel!.data![index].firstname.toString() + ' ' + _getRecentlyVisitModel!.data![index].lastname.toString(),
                                                                                    ),
                                                                                  ),
                                                                                ); */
                                                                              },
                                                                              child: Container(
                                                                                width: MediaQuery.of(context).size.width,
                                                                                height: 25,
                                                                                decoration: BoxDecoration(color: currentColor, borderRadius: BorderRadius.circular(9)),
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  'Message',
                                                                                  style: appBtnStyle.copyWith(fontSize: 12, color: Colors.white),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
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
                                            )
                                          : Center(
                                              child: Text(
                                                  "We Don`t Have Recently Match For You"))
                                      // Today Match Data
                                      : (selectedMatches == 2)
                                          ? _todayMatchDetailModel != null &&
                                                  _todayMatchDetailModel!
                                                          .data !=
                                                      null &&
                                                  _todayMatchDetailModel!
                                                          .data!.length >
                                                      0
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16, right: 16),
                                                  child: GridView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.zero,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 17.0,
                                                      mainAxisSpacing: 17.0,
                                                      mainAxisExtent: 235,
                                                    ),
                                                    itemCount: (_todayMatchDetailModel !=
                                                                null &&
                                                            _todayMatchDetailModel!
                                                                    .data !=
                                                                null)
                                                        ? _todayMatchDetailModel!
                                                            .data!.length
                                                        : 0,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              CupertinoPageRoute(
                                                                  builder: (context) => UserDetailScreen(
                                                                      userDetailIndex: _todayMatchDetailModel!
                                                                          .data![
                                                                              index]
                                                                          .userId)));
                                                        },
                                                        child: Container(
                                                          height: 210,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    currentColor,
                                                                width: 5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        18),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    0),
                                                            child: Container(
                                                              height: 210,
                                                              child: Stack(
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            13.0),
                                                                    child: _todayMatchDetailModel != null &&
                                                                            _todayMatchDetailModel!.data !=
                                                                                null &&
                                                                            _todayMatchDetailModel!.data![index].profileImage!.isNotEmpty
                                                                        ? (_todayMatchDetailModel!.data![index].blurImage == 1)
                                                                            ? ImageFiltered(
                                                                                imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                                                                child: CachedNetworkImage(
                                                                                  imageUrl: _todayMatchDetailModel!.data![index].profileImage![0].filePath.toString(),
                                                                                  fit: BoxFit.cover,
                                                                                  height: 235,
                                                                                  width: MediaQuery.of(context).size.width,
                                                                                ),
                                                                              )
                                                                            : CachedNetworkImage(
                                                                                imageUrl: _todayMatchDetailModel!.data![index].profileImage![0].filePath.toString(),
                                                                                fit: BoxFit.cover,
                                                                                height: 235,
                                                                                width: MediaQuery.of(context).size.width,
                                                                              )
                                                                        : (_todayMatchDetailModel != null && _todayMatchDetailModel!.data != null && _todayMatchDetailModel!.data![index].gender == "Male")
                                                                            ? Image.asset(
                                                                                ImagePath.profile,
                                                                                fit: BoxFit.cover,
                                                                                height: 207,
                                                                                width: MediaQuery.of(context).size.width,
                                                                              )
                                                                            : Image.asset(
                                                                                ImagePath.femaleProfileUser,
                                                                                fit: BoxFit.cover,
                                                                                height: 207,
                                                                                width: MediaQuery.of(context).size.width,
                                                                              ),
                                                                  ),

                                                                  // Spacer(),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomCenter,
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          75,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(0xffffffff)
                                                                            .withOpacity(0.5),
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          bottomRight:
                                                                              Radius.circular(13),
                                                                          bottomLeft:
                                                                              Radius.circular(13),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                8,
                                                                            right:
                                                                                14,
                                                                            top:
                                                                                5),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                (_todayMatchDetailModel != null && _todayMatchDetailModel!.data != null && _todayMatchDetailModel!.data![index].isAgent == "1")
                                                                                    ? Image.asset(
                                                                                        ImagePath.dualprofile,
                                                                                        color: currentColor,
                                                                                        height: 16,
                                                                                        width: 16,
                                                                                      )
                                                                                    : Container(),
                                                                                (_todayMatchDetailModel != null && _todayMatchDetailModel!.data != null && _todayMatchDetailModel!.data![index].isAgent == "1")
                                                                                    ? SizedBox(
                                                                                        width: 5,
                                                                                      )
                                                                                    : SizedBox(),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    _todayMatchDetailModel != null && _todayMatchDetailModel!.data != null ? capitalizeWords(_todayMatchDetailModel!.data![index].firstname.toString()) + ' | ' + _todayMatchDetailModel!.data![index].age.toString() : AppConstants.joseph,
                                                                                    maxLines: 1,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: fontStyle.copyWith(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Padding(
                                                                              padding: (_todayMatchDetailModel != null && _todayMatchDetailModel!.data != null && _todayMatchDetailModel!.data![index].isAgent == "1") ? EdgeInsets.only(left: 20) : EdgeInsets.only(left: 00),
                                                                              child: Text(
                                                                                _todayMatchDetailModel != null && _todayMatchDetailModel!.data != null ? _todayMatchDetailModel!.data![index].gender.toString() + ' | ' + _todayMatchDetailModel!.data![index].height.toString() : AppConstants.castText,
                                                                                style: matchscroll.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 5, right: 0, bottom: 5),
                                                                              child: GestureDetector(
                                                                                onTap: () async {
                                                                                  /// ----------- firebase chat module start -----------

                                                                                  Uuid uuid = Uuid();
                                                                                  String chatId = "";
                                                                                  String uuId = uuid.v4();
                                                                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                                  String? userId = await prefs.getString(USER_ID);
                                                                                  String? userName = await prefs.getString(FULLNAME);
                                                                                  String? userProfile = await prefs.getString(PROFILEIMAGE);
                                                                                  log("user profile & user name ======= ${userName} ==== $userProfile");
                                                                                  FirebaseFirestore firestore = FirebaseFirestore.instance;
                                                                                  bool? alreadyChat = false;
                                                                                  List chatData = [];
                                                                                  CommonUtils.showProgressLoading(context);
                                                                                  firestore.collection("Users").doc(userId).get().then((value) async {
                                                                                    if (value.data() == null) {
                                                                                      log("new user chat");
                                                                                      setState(() {
                                                                                        alreadyChat = false;
                                                                                      });
                                                                                    } else {
                                                                                      List chatList = value.data()!["chats"] ?? [];
                                                                                      for (var i = 0; i < chatList.length; i++) {
                                                                                        if (chatList[i]['userId'] == _todayMatchDetailModel!.data![index].userId.toString()) {
                                                                                          setState(() {
                                                                                            log("already chat true");
                                                                                            alreadyChat = true;
                                                                                            chatId = chatList[i]['chatId'].toString();
                                                                                          });
                                                                                          break;
                                                                                        } else {
                                                                                          log("already chat false");
                                                                                          setState(() {
                                                                                            alreadyChat = false;
                                                                                          });
                                                                                        }
                                                                                      }
                                                                                    }
                                                                                  }).then((value) async {
                                                                                    if (alreadyChat! == false) {
                                                                                      setState(() {
                                                                                        chatData.add({
                                                                                          "chatId": uuId,
                                                                                          "userId": _todayMatchDetailModel!.data![index].userId.toString(),
                                                                                          "userName": _todayMatchDetailModel!.data![index].firstname.toString(),
                                                                                          "userProfile": (_todayMatchDetailModel!.data![index].profileImage!.isNotEmpty) ? _todayMatchDetailModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                        });
                                                                                      });

                                                                                      await firestore.collection("Users").doc(userId).set({
                                                                                        "chats": FieldValue.arrayUnion(chatData),
                                                                                      }, SetOptions(merge: true));
                                                                                      List chats = [];
                                                                                      firestore.collection("Users").doc(_todayMatchDetailModel!.data![index].userId.toString()).get().then((value) {
                                                                                        setState(() {
                                                                                          chats = value.data()!["chats"];
                                                                                        });
                                                                                      });

                                                                                      setState(() {
                                                                                        chats.add({
                                                                                          "chatId": uuId,
                                                                                          "userId": userId,
                                                                                          "userName": userName,
                                                                                          "userProfile": userProfile,
                                                                                        });
                                                                                      });
                                                                                      await firestore.collection("Users").doc(_todayMatchDetailModel!.data![index].userId.toString()).set({
                                                                                        "chats": FieldValue.arrayUnion(chats),
                                                                                      }, SetOptions(merge: true));
                                                                                      log("uuid new");
                                                                                      CommonUtils.hideProgressLoading();
                                                                                      Navigator.push(
                                                                                          context,
                                                                                          CupertinoPageRoute(
                                                                                              builder: (context) => Chat_screen(
                                                                                                    userId: _todayMatchDetailModel!.data![index].userId.toString(),
                                                                                                    chatId: uuId,
                                                                                                    image: (_todayMatchDetailModel != null && _todayMatchDetailModel!.data!.isNotEmpty && _todayMatchDetailModel!.data![index].profileImage!.isNotEmpty) ? _todayMatchDetailModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                                    name: _todayMatchDetailModel!.data![index].firstname.toString() + ' ' + _todayMatchDetailModel!.data![index].lastname.toString(),
                                                                                                  )));
                                                                                    } else {
                                                                                      log("uuid old");
                                                                                      CommonUtils.hideProgressLoading();
                                                                                      Navigator.push(
                                                                                          context,
                                                                                          CupertinoPageRoute(
                                                                                              builder: (context) => Chat_screen(
                                                                                                    userId: _todayMatchDetailModel!.data![index].userId.toString(),
                                                                                                    chatId: chatId,
                                                                                                    image: (_todayMatchDetailModel != null && _todayMatchDetailModel!.data!.isNotEmpty && _todayMatchDetailModel!.data![index].profileImage!.isNotEmpty) ? _todayMatchDetailModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                                    name: _todayMatchDetailModel!.data![index].firstname.toString() + ' ' + _todayMatchDetailModel!.data![index].lastname.toString(),
                                                                                                  )));
                                                                                    }
                                                                                  });

                                                                                  /* await firestore.collection("Users").where("userId", isEqualTo: userId).get().then((value) async {
                                                                                    value.docs.forEach((element) async {
                                                                                      if (element.data()["chats"] != null) {
                                                                                        setState(() {
                                                                                          chatData = element.data()["chats"];
                                                                                        });
                                                                                        element.data()["chats"].forEach((value) {
                                                                                          log("user id :: ${value["userId"].toString()}");
                                                                                          log("user id :: ${_todayMatchDetailModel!.data![index].userId.toString()}");
                                                                                          log("user id :: ${value["userId"].toString() == _todayMatchDetailModel!.data![index].userId.toString()}");
                                                                                          if (value["userId"].toString() == _todayMatchDetailModel!.data![index].userId.toString()) {
                                                                                            setState(() {
                                                                                              alreadyChat = true;
                                                                                              chatId = value["chatId"].toString();
                                                                                            });
                                                                                          }
                                                                                        });
                                                                                      } else {
                                                                                        setState(() {
                                                                                          alreadyChat = false;
                                                                                        });
                                                                                      }
                                                                                    });
                                                                                  }).whenComplete(() async {
                                                                                    if (alreadyChat! == false) {
                                                                                      setState(() {
                                                                                        chatData.add({
                                                                                          "chatId": uuId,
                                                                                          "userId": _todayMatchDetailModel!.data![index].userId.toString(),
                                                                                          "userName": _todayMatchDetailModel!.data![index].firstname.toString(),
                                                                                          "userProfile": _todayMatchDetailModel!.data![index].profileImage![0].filePath.toString(),
                                                                                        });
                                                                                      });

                                                                                      await firestore.collection("Users").doc(userId).set({
                                                                                        "chats": FieldValue.arrayUnion(chatData),
                                                                                      }, SetOptions(merge: true));
                                                                                      List chats = [];
                                                                                      firestore.collection("Users").doc(_todayMatchDetailModel!.data![index].userId.toString()).get().then((value) {
                                                                                        setState(() {
                                                                                          chats = value.data()!["chats"];
                                                                                        });
                                                                                      });

                                                                                      setState(() {
                                                                                        chats.add({
                                                                                          "chatId": uuId,
                                                                                          "userId": userId,
                                                                                          "userName": userName,
                                                                                          "userProfile": userProfile,
                                                                                        });
                                                                                      });
                                                                                      await firestore.collection("Users").doc(_todayMatchDetailModel!.data![index].userId.toString()).set({
                                                                                        "chats": FieldValue.arrayUnion(chats),
                                                                                      }, SetOptions(merge: true));
                                                                                      log("uuid new");
                                                                                      Navigator.push(
                                                                                          context,
                                                                                          CupertinoPageRoute(
                                                                                              builder: (context) => Chat_screen(
                                                                                                    userId: _todayMatchDetailModel!.data![index].userId.toString(),
                                                                                                    chatId: uuId,
                                                                                                    image: (_todayMatchDetailModel != null && _todayMatchDetailModel!.data!.isNotEmpty && _todayMatchDetailModel!.data![index].profileImage!.isNotEmpty) ? _todayMatchDetailModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                                    name: _todayMatchDetailModel!.data![index].firstname.toString() + ' ' + _todayMatchDetailModel!.data![index].lastname.toString(),
                                                                                                  )));
                                                                                    } else {
                                                                                      log("uuid old");

                                                                                      Navigator.push(
                                                                                          context,
                                                                                          CupertinoPageRoute(
                                                                                              builder: (context) => Chat_screen(
                                                                                                    userId: _todayMatchDetailModel!.data![index].userId.toString(),
                                                                                                    chatId: chatId,
                                                                                                    image: (_todayMatchDetailModel != null && _todayMatchDetailModel!.data!.isNotEmpty && _todayMatchDetailModel!.data![index].profileImage!.isNotEmpty) ? _todayMatchDetailModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                                    name: _todayMatchDetailModel!.data![index].firstname.toString() + ' ' + _todayMatchDetailModel!.data![index].lastname.toString(),
                                                                                                  )));
                                                                                    }
                                                                                  }); */

                                                                                  /// ----------- firebase chat module end -----------
                                                                                  /*  Navigator.push(
                                                                                      context,
                                                                                      CupertinoPageRoute(
                                                                                          builder: (context) => Chat_screen(
                                                                                                image: (_todayMatchDetailModel != null && _todayMatchDetailModel!.data!.isNotEmpty && _todayMatchDetailModel!.data![index].profileImage!.isNotEmpty) ? _todayMatchDetailModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                                name: _todayMatchDetailModel!.data![index].firstname.toString() + ' ' + _todayMatchDetailModel!.data![index].lastname.toString(),
                                                                                              ))); */
                                                                                },
                                                                                child: Container(
                                                                                  width: MediaQuery.of(context).size.width,
                                                                                  height: 25,
                                                                                  decoration: BoxDecoration(color: currentColor, borderRadius: BorderRadius.circular(9)),
                                                                                  alignment: Alignment.center,
                                                                                  child: Text(
                                                                                    'Message',
                                                                                    style: appBtnStyle.copyWith(fontSize: 12, color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
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
                                                )
                                              : Center(
                                                  child: Text(
                                                      "We Don`t Have Today`s Match"))
                                          : Container(),
                              SizedBox(
                                height: 30,
                              ),
                              (selectedMatches == 0)
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Text(
                                        "referred by".tr,
                                        style: matchermake,
                                      ),
                                    )
                                  : (selectedMatches == 1)
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16),
                                          child: Text(
                                            "VisitedToYou".tr,
                                            style: matchermake,
                                          ),
                                        )
                                      : Container(),
                              SizedBox(
                                height: 15,
                              ),
                              (selectedMatches == 0)
                                  ? _getReferbyAgentModel != null &&
                                          _getReferbyAgentModel!
                                              .data!.isNotEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          child: GridView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 17.0,
                                              mainAxisSpacing: 17.0,
                                              mainAxisExtent: 235,
                                            ),
                                            itemCount:
                                                _getReferbyAgentModel != null &&
                                                        _getReferbyAgentModel!
                                                                .data !=
                                                            null
                                                    ? _getReferbyAgentModel!
                                                        .data!.length
                                                    : 0,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    CupertinoPageRoute(
                                                        builder: (context) =>
                                                            UserDetailScreen(
                                                                userDetailIndex:
                                                                    _getReferbyAgentModel!
                                                                        .data![
                                                                            index]
                                                                        .userId)),
                                                  );
                                                  String? selectId;
                                                  setState(() {
                                                    selectId =
                                                        _getReferbyAgentModel!
                                                            .data![index].userId
                                                            .toString();
                                                  });

                                                  log(selectId.toString());
                                                },
                                                child: Container(
                                                  height: 210,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                      color: currentColor),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(4),
                                                    child: Container(
                                                      height: 210,
                                                      child: Stack(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        13.0),
                                                            child: _getReferbyAgentModel != null &&
                                                                    _getReferbyAgentModel!
                                                                            .data !=
                                                                        null &&
                                                                    _getReferbyAgentModel!
                                                                        .data![
                                                                            index]
                                                                        .profileImage!
                                                                        .isNotEmpty
                                                                ? (_getReferbyAgentModel!
                                                                            .data![
                                                                                index]
                                                                            .blurImage ==
                                                                        1)
                                                                    ? ImageFiltered(
                                                                        imageFilter: ImageFilter.blur(
                                                                            sigmaX:
                                                                                5,
                                                                            sigmaY:
                                                                                5),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl: _getReferbyAgentModel!
                                                                              .data![index]
                                                                              .profileImage![0]
                                                                              .filePath
                                                                              .toString(),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          height:
                                                                              235,
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                        ),
                                                                      )
                                                                    : CachedNetworkImage(
                                                                        imageUrl: _getReferbyAgentModel!
                                                                            .data![index]
                                                                            .profileImage![0]
                                                                            .filePath
                                                                            .toString(),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        height:
                                                                            235,
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                      )
                                                                : (_getReferbyAgentModel != null &&
                                                                        _getReferbyAgentModel!.data !=
                                                                            null &&
                                                                        _getReferbyAgentModel!.data![index].gender ==
                                                                            "Male")
                                                                    ? Image
                                                                        .asset(
                                                                        ImagePath
                                                                            .profile,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        height:
                                                                            207,
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                      )
                                                                    : Image
                                                                        .asset(
                                                                        ImagePath
                                                                            .femaleProfileUser,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        height:
                                                                            207,
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                      ),
                                                          ),
                                                          // Spacer(),
                                                          Align(
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: Container(
                                                              height: 75,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                        0xffffffff)
                                                                    .withOpacity(
                                                                        0.9),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          13),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          13),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 8,
                                                                        right:
                                                                            14,
                                                                        top: 5),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        (_getReferbyAgentModel != null &&
                                                                                _getReferbyAgentModel!.data != null &&
                                                                                _getReferbyAgentModel!.data![index].isAgent == "1")
                                                                            ? Image.asset(
                                                                                ImagePath.dualprofile,
                                                                                color: currentColor,
                                                                                height: 16,
                                                                                width: 16,
                                                                              )
                                                                            : Container(),
                                                                        (_getReferbyAgentModel != null &&
                                                                                _getReferbyAgentModel!.data != null &&
                                                                                _getReferbyAgentModel!.data![index].isAgent == "1")
                                                                            ? SizedBox(
                                                                                width: 5,
                                                                              )
                                                                            : SizedBox(),
                                                                        Container(
                                                                          width:
                                                                              width * 0.29,
                                                                          child:
                                                                              Text(
                                                                            _getReferbyAgentModel != null && _getReferbyAgentModel!.data != null
                                                                                ? capitalizeWords(_getReferbyAgentModel!.data![index].firstname!) +
                                                                                    /* +
                                                                    _getMyMatchModel!
                                                                        .data![
                                                                            index]
                                                                        .lastname! + */
                                                                                    " | " +
                                                                                    _getReferbyAgentModel!.data![index].age.toString()
                                                                                : '',
                                                                            style: fontStyle.copyWith(
                                                                                color: Colors.black,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w600),
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      width: 15,
                                                                    ),
                                                                    Text(
                                                                      _getReferbyAgentModel != null &&
                                                                              _getReferbyAgentModel!.data !=
                                                                                  null
                                                                          ? _getReferbyAgentModel!.data![index].gender.toString() +
                                                                              ' | ' +
                                                                              _getReferbyAgentModel!.data![index].height.toString()
                                                                          : "",
                                                                      style: matchscroll.copyWith(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              5,
                                                                          right:
                                                                              0,
                                                                          bottom:
                                                                              5),
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () async {
                                                                          /// ----------- firebase chat module start -----------

                                                                          Uuid
                                                                              uuid =
                                                                              Uuid();
                                                                          String
                                                                              chatId =
                                                                              "";
                                                                          String
                                                                              uuId =
                                                                              uuid.v4();
                                                                          SharedPreferences
                                                                              prefs =
                                                                              await SharedPreferences.getInstance();
                                                                          String?
                                                                              userId =
                                                                              await prefs.getString(USER_ID);
                                                                          String?
                                                                              userName =
                                                                              await prefs.getString(FULLNAME);
                                                                          String?
                                                                              userProfile =
                                                                              await prefs.getString(PROFILEIMAGE);
                                                                          FirebaseFirestore
                                                                              firestore =
                                                                              FirebaseFirestore.instance;
                                                                          bool?
                                                                              alreadyChat =
                                                                              false;
                                                                          List
                                                                              chatData =
                                                                              [];
                                                                          CommonUtils.showProgressLoading(
                                                                              context);
                                                                          firestore
                                                                              .collection("Users")
                                                                              .doc(userId)
                                                                              .get()
                                                                              .then((value) async {
                                                                            if (value.data() ==
                                                                                null) {
                                                                              log("new user chat");
                                                                              setState(() {
                                                                                alreadyChat = false;
                                                                              });
                                                                            } else {
                                                                              List chatList = value.data()!["chats"] ?? [];
                                                                              for (var i = 0; i < chatList.length; i++) {
                                                                                if (chatList[i]['userId'] == _getReferbyAgentModel!.data![index].userId.toString()) {
                                                                                  setState(() {
                                                                                    log("already chat true");
                                                                                    alreadyChat = true;
                                                                                    chatId = chatList[i]['chatId'].toString();
                                                                                  });
                                                                                  break;
                                                                                } else {
                                                                                  log("already chat false");
                                                                                  setState(() {
                                                                                    alreadyChat = false;
                                                                                  });
                                                                                }
                                                                              }
                                                                            }
                                                                          }).then((value) async {
                                                                            if (alreadyChat! ==
                                                                                false) {
                                                                              setState(() {
                                                                                chatData.add({
                                                                                  "chatId": uuId,
                                                                                  "userId": _getReferbyAgentModel!.data![index].userId.toString(),
                                                                                  "userName": _getReferbyAgentModel!.data![index].firstname.toString(),
                                                                                  "userProfile": (_getReferbyAgentModel!.data![index].profileImage!.isNotEmpty) ? _getReferbyAgentModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                });
                                                                              });

                                                                              await firestore.collection("Users").doc(userId).set({
                                                                                "chats": FieldValue.arrayUnion(chatData),
                                                                              }, SetOptions(merge: true));
                                                                              List chats = [];
                                                                              firestore.collection("Users").doc(_getReferbyAgentModel!.data![index].userId.toString()).get().then((value) {
                                                                                setState(() {
                                                                                  chats = value.data()!["chats"];
                                                                                });
                                                                              });

                                                                              setState(() {
                                                                                chats.add({
                                                                                  "chatId": uuId,
                                                                                  "userId": userId,
                                                                                  "userName": userName,
                                                                                  "userProfile": userProfile,
                                                                                });
                                                                              });
                                                                              await firestore.collection("Users").doc(_getReferbyAgentModel!.data![index].userId.toString()).set({
                                                                                "chats": FieldValue.arrayUnion(chats),
                                                                              }, SetOptions(merge: true));
                                                                              log("uuid new");
                                                                              CommonUtils.hideProgressLoading();
                                                                              Navigator.push(
                                                                                  context,
                                                                                  CupertinoPageRoute(
                                                                                      builder: (context) => Chat_screen(
                                                                                            userId: _getReferbyAgentModel!.data![index].userId.toString(),
                                                                                            chatId: uuId,
                                                                                            image: (_getReferbyAgentModel != null && _getReferbyAgentModel!.data!.isNotEmpty && _getReferbyAgentModel!.data![index].profileImage!.isNotEmpty) ? _getReferbyAgentModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                            name: _getReferbyAgentModel!.data![index].firstname.toString() + ' ' + _getReferbyAgentModel!.data![index].lastname.toString(),
                                                                                          )));
                                                                            } else {
                                                                              log("uuid old");
                                                                              CommonUtils.hideProgressLoading();
                                                                              Navigator.push(
                                                                                  context,
                                                                                  CupertinoPageRoute(
                                                                                      builder: (context) => Chat_screen(
                                                                                            userId: _getReferbyAgentModel!.data![index].userId.toString(),
                                                                                            chatId: chatId,
                                                                                            image: (_getReferbyAgentModel != null && _getReferbyAgentModel!.data!.isNotEmpty && _getReferbyAgentModel!.data![index].profileImage!.isNotEmpty) ? _getReferbyAgentModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                            name: _getReferbyAgentModel!.data![index].firstname.toString() + ' ' + _getReferbyAgentModel!.data![index].lastname.toString(),
                                                                                          )));
                                                                            }
                                                                          });

                                                                          /* await firestore
                                                                              .collection("Users")
                                                                              .where("userId", isEqualTo: userId)
                                                                              .get()
                                                                              .then((value) async {
                                                                            value.docs.forEach((element) async {
                                                                              if (element.data()["chats"] != null) {
                                                                                setState(() {
                                                                                  chatData = element.data()["chats"];
                                                                                });
                                                                                element.data()["chats"].forEach((value) {
                                                                                  log("user id :: ${value["userId"].toString()}");
                                                                                  log("user id :: ${_getReferbyAgentModel!.data![index].userId.toString()}");
                                                                                  log("user id :: ${value["userId"].toString() == _getReferbyAgentModel!.data![index].userId.toString()}");
                                                                                  if (value["userId"].toString() == _getReferbyAgentModel!.data![index].userId.toString()) {
                                                                                    setState(() {
                                                                                      alreadyChat = true;
                                                                                      chatId = value["chatId"].toString();
                                                                                    });
                                                                                  }
                                                                                });
                                                                              } else {
                                                                                setState(() {
                                                                                  alreadyChat = false;
                                                                                });
                                                                              }
                                                                            });
                                                                          }).whenComplete(() async {
                                                                            if (alreadyChat! ==
                                                                                false) {
                                                                              setState(() {
                                                                                chatData.add({
                                                                                  "chatId": uuId,
                                                                                  "userId": _getReferbyAgentModel!.data![index].userId.toString(),
                                                                                  "userName": _getReferbyAgentModel!.data![index].firstname.toString(),
                                                                                  "userProfile": _getReferbyAgentModel!.data![index].profileImage![0].filePath.toString(),
                                                                                });
                                                                              });

                                                                              await firestore.collection("Users").doc(userId).set({
                                                                                "chats": FieldValue.arrayUnion(chatData),
                                                                              }, SetOptions(merge: true));
                                                                              List chats = [];
                                                                              firestore.collection("Users").doc(_getReferbyAgentModel!.data![index].userId.toString()).get().then((value) {
                                                                                setState(() {
                                                                                  chats = value.data()!["chats"];
                                                                                });
                                                                              });

                                                                              setState(() {
                                                                                chats.add({
                                                                                  "chatId": uuId,
                                                                                  "userId": userId,
                                                                                  "userName": userName,
                                                                                  "userProfile": userProfile,
                                                                                });
                                                                              });
                                                                              await firestore.collection("Users").doc(_getReferbyAgentModel!.data![index].userId.toString()).set({
                                                                                "chats": FieldValue.arrayUnion(chats),
                                                                              }, SetOptions(merge: true));
                                                                              log("uuid new");
                                                                              Navigator.push(
                                                                                  context,
                                                                                  CupertinoPageRoute(
                                                                                      builder: (context) => Chat_screen(
                                                                                            userId: _getReferbyAgentModel!.data![index].userId.toString(),
                                                                                            chatId: uuId,
                                                                                            image: (_getReferbyAgentModel != null && _getReferbyAgentModel!.data!.isNotEmpty && _getReferbyAgentModel!.data![index].profileImage!.isNotEmpty) ? _getReferbyAgentModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                            name: _getReferbyAgentModel!.data![index].firstname.toString() + ' ' + _getReferbyAgentModel!.data![index].lastname.toString(),
                                                                                          )));
                                                                            } else {
                                                                              log("uuid old");

                                                                              Navigator.push(
                                                                                  context,
                                                                                  CupertinoPageRoute(
                                                                                      builder: (context) => Chat_screen(
                                                                                            userId: _getReferbyAgentModel!.data![index].userId.toString(),
                                                                                            chatId: chatId,
                                                                                            image: (_getReferbyAgentModel != null && _getReferbyAgentModel!.data!.isNotEmpty && _getReferbyAgentModel!.data![index].profileImage!.isNotEmpty) ? _getReferbyAgentModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                            name: _getReferbyAgentModel!.data![index].firstname.toString() + ' ' + _getReferbyAgentModel!.data![index].lastname.toString(),
                                                                                          )));
                                                                            }
                                                                          }); */

                                                                          /// ----------- firebase chat module end -----------
                                                                          /*  Navigator
                                                                              .push(
                                                                            context,
                                                                            CupertinoPageRoute(
                                                                              builder: (context) => Message_screen(),
                                                                            ),
                                                                          ); */
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          height:
                                                                              25,
                                                                          decoration: BoxDecoration(
                                                                              color: currentColor,
                                                                              borderRadius: BorderRadius.circular(9)),
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            'Message',
                                                                            style:
                                                                                appBtnStyle.copyWith(fontSize: 12, color: Colors.white),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
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
                                        )
                                      : Center(
                                          child: Text(
                                              "We Don`t Have Referred By Your Match Maker "),
                                        )
                                  : (selectedMatches == 1)
                                      ? _recentlyVisitedToYouModel != null &&
                                              _recentlyVisitedToYouModel!
                                                  .data!.isNotEmpty
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16),
                                              child: GridView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 17.0,
                                                  mainAxisSpacing: 17.0,
                                                  mainAxisExtent: 235,
                                                ),
                                                itemCount: _recentlyVisitedToYouModel !=
                                                            null &&
                                                        _recentlyVisitedToYouModel!
                                                                .data !=
                                                            null
                                                    ? _recentlyVisitedToYouModel!
                                                        .data!.length
                                                    : 0,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        CupertinoPageRoute(
                                                            builder: (context) => UserDetailScreen(
                                                                userDetailIndex:
                                                                    _recentlyVisitedToYouModel!
                                                                        .data![
                                                                            index]
                                                                        .userId)),
                                                      );
                                                      String? selectId;
                                                      setState(() {
                                                        selectId =
                                                            _recentlyVisitedToYouModel!
                                                                .data![index]
                                                                .userId
                                                                .toString();
                                                      });

                                                      log(selectId.toString());
                                                    },
                                                    child: Container(
                                                      height: 210,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(18),
                                                          color: currentColor),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        child: Container(
                                                          height: 210,
                                                          child: Stack(
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            13.0),
                                                                child: _recentlyVisitedToYouModel != null &&
                                                                        _recentlyVisitedToYouModel!.data !=
                                                                            null &&
                                                                        _recentlyVisitedToYouModel!
                                                                            .data![
                                                                                index]
                                                                            .profileImage!
                                                                            .isNotEmpty
                                                                    ? (_recentlyVisitedToYouModel!.data![index].blurImage ==
                                                                            1)
                                                                        ? ImageFiltered(
                                                                            imageFilter:
                                                                                ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                                                            child:
                                                                                CachedNetworkImage(
                                                                              imageUrl: _recentlyVisitedToYouModel!.data![index].profileImage![0].filePath.toString(),
                                                                              fit: BoxFit.cover,
                                                                              height: 235,
                                                                              width: MediaQuery.of(context).size.width,
                                                                            ),
                                                                          )
                                                                        : CachedNetworkImage(
                                                                            imageUrl:
                                                                                _recentlyVisitedToYouModel!.data![index].profileImage![0].filePath.toString(),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            height:
                                                                                235,
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                          )
                                                                    : (_recentlyVisitedToYouModel != null &&
                                                                            _recentlyVisitedToYouModel!.data !=
                                                                                null &&
                                                                            _recentlyVisitedToYouModel!.data![index].gender ==
                                                                                "Male")
                                                                        ? Image
                                                                            .asset(
                                                                            ImagePath.profile,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            height:
                                                                                207,
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                          )
                                                                        : Image
                                                                            .asset(
                                                                            ImagePath.femaleProfileUser,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            height:
                                                                                207,
                                                                            width:
                                                                                MediaQuery.of(context).size.width,
                                                                          ),
                                                              ),
                                                              // Spacer(),
                                                              Align(
                                                                alignment: Alignment
                                                                    .bottomCenter,
                                                                child:
                                                                    Container(
                                                                  height: 75,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                            0xffffffff)
                                                                        .withOpacity(
                                                                            0.5),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              13),
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              13),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left: 8,
                                                                        right:
                                                                            14,
                                                                        top: 5),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            (_recentlyVisitedToYouModel != null && _recentlyVisitedToYouModel!.data != null && _recentlyVisitedToYouModel!.data![index].isAgent == "1")
                                                                                ? Image.asset(
                                                                                    ImagePath.dualprofile,
                                                                                    color: currentColor,
                                                                                    height: 16,
                                                                                    width: 16,
                                                                                  )
                                                                                : Container(),
                                                                            (_recentlyVisitedToYouModel != null && _recentlyVisitedToYouModel!.data != null && _recentlyVisitedToYouModel!.data![index].isAgent == "1")
                                                                                ? SizedBox(
                                                                                    width: 5,
                                                                                  )
                                                                                : SizedBox(),
                                                                            Container(
                                                                              width: width * 0.29,
                                                                              child: Text(
                                                                                _recentlyVisitedToYouModel != null && _recentlyVisitedToYouModel!.data != null
                                                                                    ? capitalizeWords(_recentlyVisitedToYouModel!.data![index].firstname!) +
                                                                                        /* +
                                                                _getMyMatchModel!
                                                                    .data![
                                                                        index]
                                                                    .lastname! + */
                                                                                        " | " +
                                                                                        _recentlyVisitedToYouModel!.data![index].age.toString()
                                                                                    : '',
                                                                                style: fontStyle.copyWith(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              15,
                                                                        ),
                                                                        Text(
                                                                          _recentlyVisitedToYouModel != null && _recentlyVisitedToYouModel!.data != null
                                                                              ? _recentlyVisitedToYouModel!.data![index].gender.toString() + ' | ' + _recentlyVisitedToYouModel!.data![index].height.toString()
                                                                              : "",
                                                                          style: matchscroll.copyWith(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Colors.black),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 5,
                                                                              right: 0,
                                                                              bottom: 5),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () async {
                                                                              /// ----------- firebase chat module start -----------
                                                                              Uuid uuid = Uuid();
                                                                              String chatId = "";
                                                                              String uuId = uuid.v4();
                                                                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                              String? userId = await prefs.getString(USER_ID);
                                                                              String? userName = await prefs.getString(FULLNAME);
                                                                              String? userProfile = await prefs.getString(PROFILEIMAGE);
                                                                              FirebaseFirestore firestore = FirebaseFirestore.instance;
                                                                              bool? alreadyChat = false;
                                                                              List chatData = [];
                                                                              CommonUtils.showProgressLoading(context);
                                                                              firestore.collection("Users").doc(userId).get().then((value) async {
                                                                                if (value.data() == null) {
                                                                                  log("new user chat");
                                                                                  setState(() {
                                                                                    alreadyChat = false;
                                                                                  });
                                                                                } else {
                                                                                  List chatList = value.data()!["chats"] ?? [];
                                                                                  for (var i = 0; i < chatList.length; i++) {
                                                                                    if (chatList[i]['userId'] == _recentlyVisitedToYouModel!.data![index].userId.toString()) {
                                                                                      setState(() {
                                                                                        log("already chat true");
                                                                                        alreadyChat = true;
                                                                                        chatId = chatList[i]['chatId'].toString();
                                                                                      });
                                                                                      break;
                                                                                    } else {
                                                                                      log("already chat false");
                                                                                      setState(() {
                                                                                        alreadyChat = false;
                                                                                      });
                                                                                    }
                                                                                  }
                                                                                }
                                                                              }).then((value) async {
                                                                                if (alreadyChat! == false) {
                                                                                  setState(() {
                                                                                    chatData.add({
                                                                                      "chatId": uuId,
                                                                                      "userId": _recentlyVisitedToYouModel!.data![index].userId.toString(),
                                                                                      "userName": _recentlyVisitedToYouModel!.data![index].firstname.toString(),
                                                                                      "userProfile": (_recentlyVisitedToYouModel!.data![index].profileImage!.isNotEmpty) ? _recentlyVisitedToYouModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                    });
                                                                                  });

                                                                                  await firestore.collection("Users").doc(userId).set({
                                                                                    "chats": FieldValue.arrayUnion(chatData),
                                                                                  }, SetOptions(merge: true));
                                                                                  List chats = [];
                                                                                  firestore.collection("Users").doc(_recentlyVisitedToYouModel!.data![index].userId.toString()).get().then((value) {
                                                                                    setState(() {
                                                                                      chats = value.data()!["chats"];
                                                                                    });
                                                                                  });

                                                                                  setState(() {
                                                                                    chats.add({
                                                                                      "chatId": uuId,
                                                                                      "userId": userId,
                                                                                      "userName": userName,
                                                                                      "userProfile": userProfile,
                                                                                    });
                                                                                  });
                                                                                  await firestore.collection("Users").doc(_recentlyVisitedToYouModel!.data![index].userId.toString()).set({
                                                                                    "chats": FieldValue.arrayUnion(chats),
                                                                                  }, SetOptions(merge: true));
                                                                                  log("uuid new");
                                                                                  CommonUtils.hideProgressLoading();
                                                                                  Navigator.push(
                                                                                      context,
                                                                                      CupertinoPageRoute(
                                                                                          builder: (context) => Chat_screen(
                                                                                                userId: _recentlyVisitedToYouModel!.data![index].userId.toString(),
                                                                                                chatId: uuId,
                                                                                                image: (_recentlyVisitedToYouModel != null && _recentlyVisitedToYouModel!.data!.isNotEmpty && _recentlyVisitedToYouModel!.data![index].profileImage!.isNotEmpty) ? _recentlyVisitedToYouModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                                name: _recentlyVisitedToYouModel!.data![index].firstname.toString() + ' ' + _recentlyVisitedToYouModel!.data![index].lastname.toString(),
                                                                                              )));
                                                                                } else {
                                                                                  log("uuid old");
                                                                                  CommonUtils.hideProgressLoading();
                                                                                  Navigator.push(
                                                                                      context,
                                                                                      CupertinoPageRoute(
                                                                                          builder: (context) => Chat_screen(
                                                                                                userId: _recentlyVisitedToYouModel!.data![index].userId.toString(),
                                                                                                chatId: chatId,
                                                                                                image: (_recentlyVisitedToYouModel != null && _recentlyVisitedToYouModel!.data!.isNotEmpty && _recentlyVisitedToYouModel!.data![index].profileImage!.isNotEmpty) ? _recentlyVisitedToYouModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                                name: _recentlyVisitedToYouModel!.data![index].firstname.toString() + ' ' + _recentlyVisitedToYouModel!.data![index].lastname.toString(),
                                                                                              )));
                                                                                }
                                                                              });

                                                                              /* await firestore.collection("Users").where("userId", isEqualTo: userId).get().then((value) async {
                                                                                value.docs.forEach((element) async {
                                                                                  if (element.data()["chats"] != null) {
                                                                                    setState(() {
                                                                                      chatData = element.data()["chats"];
                                                                                    });
                                                                                    element.data()["chats"].forEach((value) {
                                                                                      log("user id :: ${value["userId"].toString()}");
                                                                                      log("user id :: ${_recentlyVisitedToYouModel!.data![index].userId.toString()}");
                                                                                      log("user id :: ${value["userId"].toString() == _recentlyVisitedToYouModel!.data![index].userId.toString()}");
                                                                                      if (value["userId"].toString() == _recentlyVisitedToYouModel!.data![index].userId.toString()) {
                                                                                        setState(() {
                                                                                          alreadyChat = true;
                                                                                          chatId = value["chatId"].toString();
                                                                                        });
                                                                                      }
                                                                                    });
                                                                                  } else {
                                                                                    setState(() {
                                                                                      alreadyChat = false;
                                                                                    });
                                                                                  }
                                                                                });
                                                                              }).whenComplete(() async {
                                                                                if (alreadyChat! == false) {
                                                                                  setState(() {
                                                                                    chatData.add({
                                                                                      "chatId": uuId,
                                                                                      "userId": _recentlyVisitedToYouModel!.data![index].userId.toString(),
                                                                                      "userName": _recentlyVisitedToYouModel!.data![index].firstname.toString(),
                                                                                      "userProfile": _recentlyVisitedToYouModel!.data![index].profileImage![0].filePath.toString(),
                                                                                    });
                                                                                  });

                                                                                  await firestore.collection("Users").doc(userId).set({
                                                                                    "chats": FieldValue.arrayUnion(chatData),
                                                                                  }, SetOptions(merge: true));
                                                                                  List chats = [];
                                                                                  firestore.collection("Users").doc(_recentlyVisitedToYouModel!.data![index].userId.toString()).get().then((value) {
                                                                                    setState(() {
                                                                                      chats = value.data()!["chats"];
                                                                                    });
                                                                                  });

                                                                                  setState(() {
                                                                                    chats.add({
                                                                                      "chatId": uuId,
                                                                                      "userId": userId,
                                                                                      "userName": userName,
                                                                                      "userProfile": userProfile,
                                                                                    });
                                                                                  });
                                                                                  await firestore.collection("Users").doc(_recentlyVisitedToYouModel!.data![index].userId.toString()).set({
                                                                                    "chats": FieldValue.arrayUnion(chats),
                                                                                  }, SetOptions(merge: true));
                                                                                  log("uuid new");
                                                                                  Navigator.push(
                                                                                      context,
                                                                                      CupertinoPageRoute(
                                                                                          builder: (context) => Chat_screen(
                                                                                                userId: _recentlyVisitedToYouModel!.data![index].userId.toString(),
                                                                                                chatId: uuId,
                                                                                                image: (_recentlyVisitedToYouModel != null && _recentlyVisitedToYouModel!.data!.isNotEmpty && _recentlyVisitedToYouModel!.data![index].profileImage!.isNotEmpty) ? _recentlyVisitedToYouModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                                name: _recentlyVisitedToYouModel!.data![index].firstname.toString() + ' ' + _recentlyVisitedToYouModel!.data![index].lastname.toString(),
                                                                                              )));
                                                                                } else {
                                                                                  log("uuid old");

                                                                                  Navigator.push(
                                                                                      context,
                                                                                      CupertinoPageRoute(
                                                                                          builder: (context) => Chat_screen(
                                                                                                userId: _recentlyVisitedToYouModel!.data![index].userId.toString(),
                                                                                                chatId: chatId,
                                                                                                image: (_recentlyVisitedToYouModel != null && _recentlyVisitedToYouModel!.data!.isNotEmpty && _recentlyVisitedToYouModel!.data![index].profileImage!.isNotEmpty) ? _recentlyVisitedToYouModel!.data![index].profileImage![0].filePath.toString() : "",
                                                                                                name: _recentlyVisitedToYouModel!.data![index].firstname.toString() + ' ' + _recentlyVisitedToYouModel!.data![index].lastname.toString(),
                                                                                              )));
                                                                                }
                                                                              }); */

                                                                              /// ----------- firebase chat module end -----------
                                                                              /*   Navigator.push(
                                                                                context,
                                                                                CupertinoPageRoute(
                                                                                  builder: (context) => Message_screen(),
                                                                                ),
                                                                              ); */
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.of(context).size.width,
                                                                              height: 25,
                                                                              decoration: BoxDecoration(color: currentColor, borderRadius: BorderRadius.circular(9)),
                                                                              alignment: Alignment.center,
                                                                              child: Text(
                                                                                'Message',
                                                                                style: appBtnStyle.copyWith(fontSize: 12, color: Colors.white),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
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
                                            )
                                          : Center(
                                              child: Text(
                                                  "We Don`t Have Recently Visited To You! "),
                                            )
                                      : Container(),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // getAllCountUsersAPI();
      getNearYouMatchAPI();
      getMatchmakerNearyou();
      // getTodayMatchDetailAPI();
      // getRecentlyAPI();
      getMyMatchApi();
      getReferbyAgent();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // getAllCountUsersAPI();
      getNearYouMatchAPI();
      // getTodayMatchDetailAPI();
      // getRecentlyAPI();
      getMatchmakerNearyou();
      getMyMatchApi();
      getReferbyAgent();
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

  getAllCountUsersAPI() async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    try {
      if (mounted) {
        String queryString = Uri(queryParameters: queryParameters).query;
        log("url :: >> ${GET_ALL_COUNT_USER_URL + "?" + queryString}");
        var response =
            await dio.get(GET_ALL_COUNT_USER_URL + "?" + queryString);

        if (response.statusCode == 200) {
          setState(() {
            _allCountUsersModel = AllCountUsersModel.fromJson(response.data);
          });
        }
      }
    } on Exception catch (e) {
      log("error ::  ${e.toString()}");
    }
  }

  getNearYouMatchAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    setState(() {
      isLoading = true;
    });
    // CommonUtils.showProgressLoading(context);
    String queryString = Uri(queryParameters: queryParameters).query;
    try {
      var response = await dio.get(GET_NEAR_YOU_URL + "?" + queryString);
      if (response.statusCode == 200) {
        setState(() {
          _nearYouMatchModel = NearYouMatchModel.fromJson(response.data);
        });
        getRecentlyAPI();

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

  getRecentlyAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    // CommonUtils.showProgressLoading(context);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    try {
      var response = await dio.get(GET_RECENTLY_VISIT_URL + "?" + queryString);
      if (response.statusCode == 200) {
        // CommonUtils.hideProgressLoading();
        setState(() {
          _getRecentlyVisitModel =
              GetRecentlyVisitModel.fromJson(response.data);
        });
        getTodayMatchDetailAPI();
        print("recent visit ::: ${response.data}");
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
    } on DioError catch (e) {
      CommonUtils.hideProgressLoading();
    }
  }

  getTodayMatchDetailAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    try {
      var response =
          await dio.get(GET_TODAY_MATCH_DETAIL_URL + "?" + queryString);
      if (response.statusCode == 200) {
        setState(() {
          _todayMatchDetailModel =
              TodayMatchDetailModel.fromJson(response.data);
        });
        match = [
          {
            NAME: "nearyou".tr +
                "(" +
                _nearYouMatchModel!.data!.length.toString() +
                ")",
          },
          {
            NAME: "recentlyvisited".tr +
                "(" +
                _getRecentlyVisitModel!.data!.length.toString() +
                ")",
          },
          {
            NAME: "todaymatch".tr +
                "(" +
                _todayMatchDetailModel!.data!.length.toString() +
                ")",
          }
        ];
        setState(() {
          isLoading = false;
        });
        // CommonUtils.hideProgressLoading();
        print("today match ::: ${response.data}");
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
        });
        print("match maker :::: ${response.data}");
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

  getReferbyAgent() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    try {
      log("URL :::: " + GET_REFER_BY_AGENT_URL + "?" + queryString);
      var response = await dio.get(GET_REFER_BY_AGENT_URL + "?" + queryString);
      if (response.statusCode == 200) {
        setState(() {
          _getReferbyAgentModel = GetReferbyAgentModel.fromJson(response.data);
        });
        print("refer visit ::: ${response.data}");
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

  GetRecentlyVisitedToYouAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    try {
      var response =
          await dio.get(GET_RECENTLY_VISITED_YOU_URL + "?" + queryString);
      if (response.statusCode == 200) {
        setState(() {
          _recentlyVisitedToYouModel =
              RecentlyVisitedToYouModel.fromJson(response.data);
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

  getMyMatchApi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    try {
      log("URL :::: " + GET_MY_MATCH_URL + "?" + queryString);
      var response = await dio.get(GET_MY_MATCH_URL + "?" + queryString);
      if (response.statusCode == 200) {
        setState(() {
          _getMyMatchModel = GetMyMatchModel.fromJson(response.data);
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

  _contactDialogBox() {
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
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Chat Now",
                          style: online.copyWith(fontSize: 14),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Image.asset(
                          ImagePath.callframe,
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Call Now",
                          style: online.copyWith(fontSize: 14),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Image.asset(
                          ImagePath.messageframe,
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Mail Now",
                          style: online.copyWith(fontSize: 14),
                        )
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
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => Benefits()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: AppColors.appColor,
                              borderRadius: BorderRadius.circular(9)),
                          alignment: Alignment.center,
                          child: Text(
                            'Contact Now',
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
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => Benefits()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              color: currentColor,
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
}
