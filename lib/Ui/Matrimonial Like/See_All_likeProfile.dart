import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/All_Executive_Candidate_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Update_Profile_Details/archive_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/getLikedByYouModel.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/get_Addarchive_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/get_ArchiveModel.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/get_revert_model.dart';
import 'package:matrimonial_app/ModelClass/delete_archive_model.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/User_Detail_Screen.dart';
import 'package:matrimonial_app/Ui/Matrimonial%20Like/like_story.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SeeAllLikeProfile extends StatefulWidget {
  const SeeAllLikeProfile({Key? key}) : super(key: key);

  @override
  State<SeeAllLikeProfile> createState() => _SeeAllLikeProfileState();
}

class _SeeAllLikeProfileState extends State<SeeAllLikeProfile> {
  getLikedByYouModel? _likedByYouModel;
  String? likeByYouId;

  List<ArchiveModel> archiveDeleteList = [];
  Dio dio = Dio();
  GetArchiveModel? _getArchiveModel;
  bool isDeleteSelected = false;
  GetRevertModel? _getRevertModel;
  GetDeleteArchiveModel? _deleteArchiveModel;
  GetAddarchiveModel? _getAddarchiveModel;
  List imageList = [];
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "Recently Liked",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 16, left: 16),
            child: _likedByYouModel != null &&
                    _likedByYouModel!.data!.isNotEmpty
                ? GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                              builder: (context) => UserDetailScreen(
                                  userDetailIndex:
                                      _likedByYouModel!.data![index].userId),
                            ),
                          );
                          var selectedId =
                              _likedByYouModel!.data![index].userId.toString();
                          log(selectedId);
                        },
                        child: Container(
                          height: 220,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffECECEC)),
                              borderRadius: BorderRadius.circular(20),
                              color: currentColor),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Container(
                              height: 207,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: _likedByYouModel != null &&
                                            _likedByYouModel!.data != null &&
                                            _likedByYouModel!.data![index]
                                                .profileImage!.isNotEmpty
                                        ? CachedNetworkImage(
                                            imageUrl: _likedByYouModel!
                                                .data![index]
                                                .profileImage![0]
                                                .filePath
                                                .toString(),
                                            fit: BoxFit.cover,
                                            height: 207,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          )
                                        : (_likedByYouModel != null &&
                                                _likedByYouModel!.data !=
                                                    null &&
                                                _likedByYouModel!
                                                        .data![index].gender ==
                                                    "Male")
                                            ? Image.asset(
                                                ImagePath.profile,
                                                fit: BoxFit.cover,
                                                height: 207,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              )
                                            : Image.asset(
                                                ImagePath.femaleProfileUser,
                                                fit: BoxFit.cover,
                                                height: 207,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              ),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, right: 8, left: 8),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  likeByYouId =
                                                      _likedByYouModel!
                                                          .data![index].userId
                                                          .toString();
                                                  getAddArchiveApi();
                                                });
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                child: Image.asset(
                                                  ImagePath.likeframe,
                                                  width: 28,
                                                  height: 28,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                List<String> storiesList = [];
                                                imageList.clear();
                                                for (var i = 0;
                                                    i <
                                                        _likedByYouModel!
                                                            .data!.length;
                                                    i++) {
                                                  if (_likedByYouModel!
                                                          .data![index]
                                                          .userId! ==
                                                      _likedByYouModel!
                                                          .data![i].userId) {
                                                    for (var j = 0;
                                                        j <
                                                            _likedByYouModel!
                                                                .data![i]
                                                                .profileImage!
                                                                .length;
                                                        j++) {
                                                      setState(() {
                                                        imageList.add(
                                                            _likedByYouModel!
                                                                .data![i]
                                                                .profileImage![j]);
                                                      });
                                                    }
                                                  }
                                                }
                                                setState(() {
                                                  storiesList = List.generate(
                                                      imageList.length,
                                                      (index) {
                                                    return imageList.isEmpty
                                                        ? "http://www.goodmorningimagesdownload.com/wp-content/uploads/2019/12/Love-Images-1.jpg"
                                                        : imageList[index]
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
                                                        (_likedByYouModel !=
                                                                    null &&
                                                                _likedByYouModel!
                                                                        .data !=
                                                                    null)
                                                            ? _likedByYouModel!
                                                                .data![index]
                                                                .profileImage!
                                                                .length
                                                                .toString()
                                                            : "1",
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
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 0),
                                        child: Container(
                                          height: 34,
                                          decoration: BoxDecoration(
                                            color: Color(0xffffffff)
                                                .withOpacity(0.5),
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(13),
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
                                                Expanded(
                                                  child: Text(
                                                    _likedByYouModel != null &&
                                                            _likedByYouModel!
                                                                    .data !=
                                                                null &&
                                                            _likedByYouModel!
                                                                    .data![
                                                                        index]
                                                                    .firstname !=
                                                                '' &&
                                                            _likedByYouModel!
                                                                    .data![
                                                                        index]
                                                                    .lastname !=
                                                                ''
                                                        ? _likedByYouModel!
                                                                .data![index]
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
                                                        color: Colors.white,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                    // overflow:
                                                    //     TextOverflow
                                                    //         .ellipsis,
                                                  ),
                                                ),
                                                (_getArchiveModel != null &&
                                                        _getArchiveModel!
                                                                .data !=
                                                            null &&
                                                        _getArchiveModel!
                                                                .data![index]
                                                                .isAgent ==
                                                            "0")
                                                    ? Image.asset(
                                                        ImagePath.peopleframe,
                                                        width: 22,
                                                        height: 22,
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
                : Text("")));
  }

  checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getLikedByYouAPi();
      getArchiveAPi();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getLikedByYouAPi();
      getArchiveAPi();
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
