import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_custom_tab_bar/indicator/linear_indicator.dart';
import 'package:flutter_custom_tab_bar/transform/color_transform.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/getAllCandidateDetailModel.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/HomeScreenDetail/basic_ddetail.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/HomeScreenDetail/careereduction.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/HomeScreenDetail/contact_detail.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/HomeScreenDetail/family_detail.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/HomeScreenDetail/location_detail.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/HomeScreenDetail/lookinfor_detail.dart';
import 'package:matrimonial_app/Ui/Home_screen/Match%20Screen/match_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Drawer/AccountSettingScreen/account_screen.dart';
import 'HomeScreenDetail/hobbies_detail.dart';

class UserDetailScreen extends StatefulWidget {
  var userDetailIndex;
  UserDetailScreen({Key? key, this.userDetailIndex}) : super(key: key);

  @override
  HomeScreenDetailState1 createState() => HomeScreenDetailState1();
}

class HomeScreenDetailState1 extends State<UserDetailScreen>
    with SingleTickerProviderStateMixin {
  GetAllCandidateDetailsModel? _allCandidateDetailsModel;
  final int pageCount = 7;
  late PageController _controller = PageController(initialPage: 0);
  CustomTabBarController _tabBarController = CustomTabBarController();
  TabController? _tabController;
  late ScrollController _scrollController = ScrollController();
  Color _textColor = Colors.white;
  List<String> imaglist = [
    AppConstants.catan,
    AppConstants.ludo,
    AppConstants.rave,
    AppConstants.outdoors,
    AppConstants.cricket,
    AppConstants.sushi,
    AppConstants.mountians,
    AppConstants.broadway,
    AppConstants.pilates
  ];
  List tab = [
    "basicdetail".tr,
    "lookingfor".tr,
    "contact".tr,
    "career".tr,
    "family detail".tr,
    "location".tr,
    "hobbies".tr
  ];

  @override
  void initState() {
    print("user id ::: ${widget.userDetailIndex}");
    _tabController = TabController(length: 7, vsync: this);
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _textColor = _isSliverAppBarExpanded ? Colors.white : Colors.blue;
        });
      });
    super.initState();
    checkConnection();
  }

  bool get _isSliverAppBarExpanded {
    print(_scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight));
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverFillRemaining(
              hasScrollBody: true,
              child: Column(
                children: [
                  /* Container(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              ImagePath.backArrow,
                              height: 30,
                              width: 30,
                            ),
                          ),
                          /*    Padding(
                            padding: EdgeInsets.only(left: 26.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /* Row(
                                  children: [
                                    Text(
                                      _allCandidateDetailsModel != null &&
                                              _allCandidateDetailsModel!.data !=
                                                  null
                                          ? _allCandidateDetailsModel!
                                                  .data!.basicInfo!.name
                                                  .toString() +
                                              "," +
                                              _allCandidateDetailsModel!
                                                  .data!.basicInfo!.age
                                                  .toString()
                                          : "",
                                      style: detailpage.copyWith(
                                          color: AppColors.tabselected),
                                    ),
                                  ],
                                ), */
                                /* Row(
                                  children: [
                                    Image.asset(
                                      ImagePath.detaillocation,
                                      height: 25,
                                      width: 25,
                                      color: AppColors.tabselected,
                                    ),
                                    Text(
                                      "applocation".tr,
                                      style: appBtnStyle.copyWith(
                                          fontSize: 16,
                                          color: AppColors.tabselected),
                                    )
                                  ],
                                ), */
                              ],
                            ),
                          )
                       */
                        ],
                      ),
                    ),
                  ), */
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => Match_screen(
                                  image: _allCandidateDetailsModel!
                                      .data!.basicInfo!.image)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0, top: 2),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 90,
                        decoration: BoxDecoration(
                          color: currentColor,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Image.asset(
                                  ImagePath.leftArrow,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 10),
                              child: (_allCandidateDetailsModel != null &&
                                      _allCandidateDetailsModel!.data != null &&
                                      _allCandidateDetailsModel!
                                              .data!.basicInfo!.image!.length >
                                          0)
                                  ? Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: CachedNetworkImage(
                                            imageUrl: _allCandidateDetailsModel!
                                                .data!.basicInfo!.image
                                                .toString(),
                                            height: 72,
                                            width: 72,
                                            fit: BoxFit.cover),
                                      ),
                                    )
                                  : (_allCandidateDetailsModel != null &&
                                          _allCandidateDetailsModel!.data !=
                                              null &&
                                          _allCandidateDetailsModel!
                                                  .data!.basicInfo!.gender ==
                                              "Male")
                                      ? Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.asset(
                                              ImagePath.profile,
                                              height: 60,
                                              width: 60,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.asset(
                                              ImagePath.femaleProfileUser,
                                              height: 72,
                                              width: 72,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "matchmaking".tr,
                                      style: appBtnStyle.copyWith(fontSize: 14),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _allCandidateDetailsModel != null &&
                                                _allCandidateDetailsModel!
                                                        .data !=
                                                    null &&
                                                _allCandidateDetailsModel!
                                                    .data!.basicInfo!.name
                                                    .toString()
                                                    .isNotEmpty
                                            ? _allCandidateDetailsModel!
                                                    .data!.basicInfo!.name
                                                    .toString()
                                                    .substring(0, 4) +
                                                ", From "
                                            : "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: appBtnStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        _allCandidateDetailsModel != null &&
                                                _allCandidateDetailsModel!
                                                        .data !=
                                                    null &&
                                                _allCandidateDetailsModel!.data!
                                                        .userContact!.state !=
                                                    null
                                            ? _allCandidateDetailsModel!
                                                .data!.userContact!.state
                                                .toString()
                                            : "N/A",
                                        style: appBtnStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) => Match_screen(
                                                  userId:
                                                      widget.userDetailIndex,
                                                  name: _allCandidateDetailsModel!
                                                          .data!
                                                          .basicInfo!
                                                          .firstname
                                                          .toString() +
                                                      " " +
                                                      _allCandidateDetailsModel!
                                                          .data!
                                                          .basicInfo!
                                                          .lastname
                                                          .toString(),
                                                  image:
                                                      _allCandidateDetailsModel!
                                                          .data!
                                                          .basicInfo!
                                                          .image)));
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                          child: Text(
                                        "Click Here",
                                        style: TextStyle(
                                            color: currentColor,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  )
                                  /* GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "clickhere".tr,
                                          style: appBtnStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ), */
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomTabBar(
                    height: 40,
                    tabBarController: _tabBarController,
                    direction: Axis.horizontal,
                    itemCount: pageCount,
                    builder: getTabbarChild,
                    indicator: LinearIndicator(
                        color: Color(0xff57606F),
                        height: 5,
                        bottom: 0,
                        radius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8))),
                    pageController: _controller,
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: PageView.builder(
                      scrollDirection: Axis.vertical,
                      controller: _controller,
                      itemCount: pageCount,
                      itemBuilder: (context, index) {
                        return PageItem(index, widget.userDetailIndex);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTabbarChild(BuildContext context, int index) {
    return TabBarItem(
        transform: ColorsTransform(
            highlightColor: Colors.white,
            normalColor: Colors.black,
            builder: (context, color) {
              return Container(
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  alignment: Alignment.center,
                  constraints: BoxConstraints(minHeight: 35),
                  child: Text(tab[index]));
            }),
        index: index);
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getAllInfoCandidateApi();
      setRecentlyVisitAPI();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getAllInfoCandidateApi();
      setRecentlyVisitAPI();
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

  getAllInfoCandidateApi() async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.getString(USER_TOKEN);
    var userId = int.tryParse(widget.userDetailIndex.toString());
    var response = await dio
        .get(ALLCANDIDATEDETAILURL + "?token=$userToken&user_id=${userId}");
    if (response.statusCode == 200) {
      setState(() {
        _allCandidateDetailsModel =
            GetAllCandidateDetailsModel.fromJson(response.data);
        log("Show candidate Details :: ${_allCandidateDetailsModel!.data!.basicInfo!.name}");
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

  setRecentlyVisitAPI() async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.getString(USER_TOKEN);
    var userId = int.tryParse(widget.userDetailIndex.toString());

    var response = await dio
        .get(SET_RECENTLY_VISITED_URL + "?token=$userToken&user_id=${userId}");
    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        print("User Visited SuccessFully");
      }
      // SetRecentlyVisitModel _setRecentlyVisitModel =
      //     SetRecentlyVisitModel.fromJson(response.data);
      // print(_setRecentlyVisitModel.message);
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

class PageItem extends StatefulWidget {
  final int index;
  var userDetailIndex;
  PageItem(this.index, this.userDetailIndex, {Key? key}) : super(key: key);

  @override
  _PageItemState createState() => _PageItemState();
}

class _PageItemState extends State<PageItem>
    with AutomaticKeepAliveClientMixin {
  GetAllCandidateDetailsModel? _allCandidateDetailsModel;

  List tabName = [];
  @override
  void initState() {
    super.initState();
    tabName = [
      Basic_DDetail(allCandidateDetailsModel: _allCandidateDetailsModel),
      Looking_Detail(allCandidateDetailsModel: _allCandidateDetailsModel),
      Contact_DDetail(
        allCandidateDetailsModel: _allCandidateDetailsModel,
      ),
      Careere_DDetail(
        allCandidateDetailsModel: _allCandidateDetailsModel,
      ),
      Family_Detail(
        allCandidateDetailsModel: _allCandidateDetailsModel,
      ),
      Location_DDetail(
        allCandidateDetailsModel: _allCandidateDetailsModel,
      ),
      Hobbies_DDetail(
        allCandidateDetailsModel: _allCandidateDetailsModel,
      ),
    ];
    getAllInfoCandidateApi();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('build index:${widget.index} page');
    return Container(
      child: tabName[widget.index],
      alignment: Alignment.center,
    );
  }

  getAllInfoCandidateApi() async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.getString(USER_TOKEN);
    var userId = int.tryParse(widget.userDetailIndex.toString());
    CommonUtils.showProgressLoading(context);
    var response = await dio
        .get(ALLCANDIDATEDETAILURL + "?token=$userToken&user_id=${userId}");
    if (response.statusCode == 200) {
      CommonUtils.hideProgressLoading();
      setState(() {
        _allCandidateDetailsModel =
            GetAllCandidateDetailsModel.fromJson(response.data);
        log("Show candidate Details :: ${_allCandidateDetailsModel!.data!.basicInfo!.name}");
      });
      tabName = [
        Basic_DDetail(allCandidateDetailsModel: _allCandidateDetailsModel),
        Looking_Detail(allCandidateDetailsModel: _allCandidateDetailsModel),
        Contact_DDetail(
          allCandidateDetailsModel: _allCandidateDetailsModel,
        ),
        Careere_DDetail(
          allCandidateDetailsModel: _allCandidateDetailsModel,
        ),
        Family_Detail(
          allCandidateDetailsModel: _allCandidateDetailsModel,
        ),
        Location_DDetail(
          allCandidateDetailsModel: _allCandidateDetailsModel,
        ),
        Hobbies_DDetail(
          allCandidateDetailsModel: _allCandidateDetailsModel,
        ),
      ];
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
    }else {
      CommonUtils.hideProgressLoading();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
