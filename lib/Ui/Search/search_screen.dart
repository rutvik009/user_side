import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/GetSearchDataModel.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/User_Detail_Screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/commonappbar_search.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/value_constant.dart';

class Search_screen extends StatefulWidget {
  const Search_screen({Key? key}) : super(key: key);

  @override
  State<Search_screen> createState() => _Search_screenState();
}

class _Search_screenState extends State<Search_screen> {
  Dio dio = Dio();
  TextEditingController searchController = TextEditingController();
  GetSearchDataModel? _searchModel;
  List<Map<String, dynamic>> searchfilter = [
    {
      IMAGE: ImagePath.searchimage,
      NAME: AppConstants.joseph1,
      SUBNAME: AppConstants.ahmadabad,
    },
    {
      IMAGE: ImagePath.searchimage1,
      NAME: AppConstants.sara,
      SUBNAME: AppConstants.surat,
    },
    {
      IMAGE: ImagePath.searchimage2,
      NAME: AppConstants.faye,
      SUBNAME: AppConstants.chennai,
    },
    {
      IMAGE: ImagePath.searchimage3,
      NAME: AppConstants.faye,
      SUBNAME: AppConstants.mumbai,
    },
    {
      IMAGE: ImagePath.searchimage2,
      NAME: AppConstants.faye,
      SUBNAME: AppConstants.chennai,
    },
    {
      IMAGE: ImagePath.searchimage3,
      NAME: AppConstants.faye,
      SUBNAME: AppConstants.mumbai,
    },
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: [
        CommonAppbar1(
          name: "search".tr,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: AppColors.messagesearch,
                    ),
                    height: height * 0.069,
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * 0.020,
                        ),
                        Image.asset(
                          ImagePath.search,
                          height: height * 0.030,
                        ),
                        SizedBox(
                          width: width * 0.010,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: searchController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "discover search".tr,
                                hintStyle: happiness),
                            onChanged: (value) {
                              setState(() {
                                checkConnection();
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: width * 0.020,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                        _searchModel != null && _searchModel!.data!.length > 0
                            ? _searchModel!.data!.length
                            : 0,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setRecentlyVisitAPI(index);

                          log("searchUser::::${_searchModel!.data![index].userId.toString()}");
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                height: 53,
                                width: 53,
                                child: _searchModel != null &&
                                        _searchModel!.data![index].profileImage!
                                            .isNotEmpty
                                    ? CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(
                                            _searchModel!.data![index]
                                                .profileImage![0].filePath
                                                .toString()),
                                      )
                                    : CircleAvatar(
                                        backgroundImage:
                                            AssetImage(ImagePath.searchimage),
                                      ),
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _searchModel != null &&
                                            _searchModel!.data != null
                                        ? _searchModel!.data![index].username
                                            .toString()
                                        : "",
                                    style: name,
                                  ),
                                  Text(
                                    ",",
                                    style: subname,
                                  )
                                ],
                              ),
                              /*  Spacer(),
                              GestureDetector(
                                onTap: () {
                                  _searchModel!.data!.removeAt(index);
                                  setState(() {});
                                },
                                child: Image.asset(
                                  ImagePath.crossimage,
                                  height: height * 0.030,
                                ),
                              ) */
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      searchingUserApi();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      searchingUserApi();
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

  searchingUserApi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": userToken.toString(),
      "search": searchController.text
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_SEARCH + "?" + queryString);
    if (response.statusCode == 200) {
      var result = response.data;
      if (result['success'] == true) {
        setState(() {
          _searchModel = GetSearchDataModel.fromJson(result);
        });
      }
      log(result.toString());
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

  setRecentlyVisitAPI(int index) async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.getString(USER_TOKEN);
    var userId = _searchModel!.data![index].userId.toString();

    var response = await dio
        .get(SET_RECENTLY_VISITED_URL + "?token=$userToken&user_id=${userId}");
    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => UserDetailScreen(
                  userDetailIndex: _searchModel!.data![index].userId)),
        );
        print("User Visited SuccessFully");
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
}
