import 'dart:convert';
import 'dart:developer' as log;
import 'dart:io';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:lottie/lottie.dart';
import 'package:matrimonial_app/Core/Constant/globle.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/All_Count_Users_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Notificatio_Count_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Today_Match_Detail_Model.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/Drawer_Screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Notification/notification.dart';
import 'package:matrimonial_app/Ui/Home_screen/provider/card_provider.dart';
import 'package:matrimonial_app/Ui/Login/login_screen.dart';
import 'package:matrimonial_app/Ui/Search/search_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/story_page_view/story_page_view.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Get_Profile_Data_Model.dart'
    as ProfileData;

import '../../../Core/Constant/CommonUtils.dart';
import '../../../ModelClass/UserPanel_ModelClass/get_user_completion_model.dart';
import '../../RegisterScreen/basic_detail.dart';
import '../../choose Plan/choose_plan_screen.dart';
import '../tinder_card_component.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int selectedMatches = 0;

class _HomeScreenState extends State<HomeScreen> {
  late ConfettiController _controllerCenter;
  DateTime? currentBackPressTime;
  AllCountUsersModel? _allCountUsersModel;
  String likes = '';
  late FirebaseMessaging _firebaseMessaging;
  String fcmToken = '';
  bool intro = false, right = false, left = false, down = false, main = false;
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;
  late DragStartDetails startVerticalDragDetails;
  late DragUpdateDetails updateVerticalDragDetails;
  SharedPreferences? prefs;
  NotificationCountModel? _notificationCountModel;
  GetProfileCompletionModel? _getProfileCompletionModel;
  ProfileData.GetAllProfileDataModel? _getAllProfileDataModel;
  int swipeVal = 0;
  int swipeCount = 0;
  bool isUserCompletion = true;

  final sampleUsers = [
    UserModel([
      StoryModel(ImagePath.swipecard),
      StoryModel(ImagePath.swipecard2),
    ]),
  ];
  List<String> matches = [];
  List<String> imaglist = [
    "coffee",
    "coffee",
    "coffhnbnbee",
    "coffee",
    "coffee",
  ];

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    getFirstTime();
    getSharedPreferences();
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
        IndicatorAnimationCommand.resume);
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 1));
    super.initState();
    checkConnection();
    notificationCountAPI();
    getUserCompletionAPI();
    getSwipeValFun();
    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((token) async {
      if (token != null) {
        if (mounted) {
          setState(() {
            fcmToken = token;
            print("FCM token :" + fcmToken);
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  List swipesIntro = [
    {
      "title": "SLIDE RIGHT TO LIKE",
      "icon": "assets/lottie/swiperight.json",
    },
    {
      "title": "SLIDE LEFT TO SKIP",
      "icon": "assets/lottie/swipeleft.json",
    },
    {
      "title": "SLIDE UP TO SKIP",
      "icon": "assets/lottie/swipeup.json",
    },
  ];
  int card = 0;
  String? ifFirstTimeUser;
  indexChnages(int ind) {
    setState(() {
      selectedMatches = ind;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print("Home screen build method call");

    final provider = Provider.of<CardProvider>(context);
    return WillPopScope(
      onWillPop: () async => _onBackPressed(),
      child: Container(
        height: height,
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        z.toggle!();

                        setState(() {
                          currentColor;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: /*  AppColors.pink */ currentColor
                                .withOpacity(0.3)),
                        child: Center(
                          child: Image.asset(
                            ImagePath.drawer,
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      ImagePath.location,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  Text(
                    (_getAllProfileDataModel != null &&
                            _getAllProfileDataModel!.data != null &&
                            _getAllProfileDataModel!.data!.userLocation !=
                                null &&
                            _getAllProfileDataModel!
                                    .data!.userLocation!.state !=
                                null)
                        ? _getAllProfileDataModel!.data!.userLocation!.state
                                .toString() +
                            "," +
                            _getAllProfileDataModel!.data!.userLocation!.country
                                .toString()
                                .substring(0, 2)
                        : '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    // AppConstants.header,
                    style: const TextStyle(color: AppColors.coffe),
                  )
                ],
              ),
              actions: [
                GestureDetector(
                  onTap: () async {
                    var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Notification_Screen()));
                    if (result == "Notifcation") {
                      notificationCountAPI();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Row(
                      children: [
                        Stack(alignment: Alignment.topRight, children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: currentColor.withOpacity(0.3)),
                            child: Center(
                              child: Image.asset(
                                ImagePath.notify,
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ),
                          Container(
                            height: 15,
                            width: 15,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: currentColor, shape: BoxShape.circle),
                            child: Text(
                              _notificationCountModel != null &&
                                      _notificationCountModel!.data != 0
                                  ? _notificationCountModel!.data.toString()
                                  : _notificationCountModel != null &&
                                          _notificationCountModel!.data! > 99
                                      ? '99+'
                                      : '0',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  InkWell(
                    splashColor: Colors.grey.withOpacity(0.5),
                    splashFactory: InkRipple.splashFactory,
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => Search_screen()));
                    },
                    child: SizedBox(
                      height: 35,
                      width: 35,
                      child: Image.asset(ImagePath.search),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 35,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          // provider.matchList.length,
                          matches.length,
                          (index) => Padding(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: GestureDetector(
                              onTap: () {
                                final provider = Provider.of<CardProvider>(
                                    context,
                                    listen: false);
                                print("index :: $index");
                                AppConstants.index = 0;
                                provider.users.clear();
                                indexChnages(index);
                                /*  setState(() {
                                  selectedMatches = index;
                                }); */

                                provider.resetUsers();
                              },
                              child: Container(
                                  decoration: selectedMatches == index
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          color: currentColor)
                                      : BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          border: Border.all(
                                              color: AppColors.containeborder)),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(matches[index],
                                        style: selectedMatches == index
                                            ? containertext.copyWith(
                                                color: Colors.white)
                                            : containertext),
                                  ))),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 7),
            Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    buildCards(),
                    Align(
                      alignment: Alignment.center,
                      child: ConfettiWidget(
                        // how often it should emit
                        numberOfParticles: 25, // number of particles to emit

                        confettiController: _controllerCenter,
                        blastDirectionality: BlastDirectionality
                            .explosive, // don't specify a direction, blast randomly
                        shouldLoop:
                            false, // start again as soon as the animation is finished
                        colors: const [
                          Colors.yellow,
                          Colors.orange,
                          Colors.yellow,
                          Colors.orange,
                          Colors.yellow,
                          Colors.orange,
                          Colors.yellow,
                          Colors.orange,
                          Colors.yellow,
                        ], // manually specify the colors to be used
                        createParticlePath:
                            drawStar, // define a custom shape/path.
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: 7),
          ],
        ),
      ),
    );
  }

  getSwipeValFun() async {
    log.log("in getswipe ");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String getVal =  prefs.getString(Session.swipeVal) as String;
    log.log("value of share ${prefs.getString(SWIPEVAL)} =====> ${SWIPEVAL} ");
    if (prefs.getString(SWIPEVAL) != null) {
      setState(() {
        swipeVal = int.parse(prefs.getString(SWIPEVAL).toString());
      });
    } else {
      setState(() {
        swipeVal = 0;
      });
    }
    log.log(" final swipe value $swipeVal");
  }

  setSwipeValFun(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // setState(() {
    prefs.setString(SWIPEVAL, value);
    // });
    log.log(
        "in set swipe  :: ${value}  ====== >  ${prefs.getString(SWIPEVAL)}");
    getSwipeValFun();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getNewUserDetailAPI();
      getProfileData();
      // getAllCountUsersAPI();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getNewUserDetailAPI();
      getProfileData();
      // getAllCountUsersAPI();
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

  TodayMatchDetailModel? _newUserDetailModel;
  TodayMatchDetailModel? _myMatchDetailModel;
  getNewUserDetailAPI() async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    // isDone = "true";
    try {
      var response = await dio.get(GET_NEAR_YOU_URL + "?" + queryString);
      if (response.statusCode == 200) {
        print("new user response ::: ${response.data}");
        _newUserDetailModel = TodayMatchDetailModel.fromJson(response.data);
        getMymatchDetialAPI();
      }
    } catch (e) {}
  }

  getTodayMatchDetailAPI() async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    // isDone = "true";
    try {
      var response =
          await dio.get(GET_TODAY_MATCH_DETAIL_URL + "?" + queryString);
      if (response.statusCode == 200) {
        print("api response :: ${response.data}");

        TodayMatchDetailModel _todayMatchDetailModel =
            TodayMatchDetailModel.fromJson(response.data);
        matches = [
          "new".tr + "(" + _newUserDetailModel!.data!.length.toString() + ")",
          "todaymatch".tr +
              "(" +
              _todayMatchDetailModel.data!.length.toString() +
              ")",
          "mymatch".tr +
              "(" +
              _myMatchDetailModel!.data!.length.toString() +
              ")",
        ];
        if (mounted) {
          setState(() {});
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
      }
    } on DioError catch (e) {}
  }

  getMymatchDetialAPI() async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    try {
      var response = await dio.get(GET_MY_MATCH_DETAIL_URL + "?" + queryString);
      if (response.statusCode == 200) {
        print("api todays response :: ${response.data}");

        _myMatchDetailModel = TodayMatchDetailModel.fromJson(response.data);
        getTodayMatchDetailAPI();
        // print("today match ::: ${response.data}");
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
      log.log(e.toString());
    }
  }

  getAllCountUsersAPI() async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_ALL_COUNT_USER_URL + "?" + queryString);
    if (response.statusCode == 200) {
      setState(() {
        _allCountUsersModel = AllCountUsersModel.fromJson(response.data);
      });
      matches = [
        "new".tr +
            "(" +
            _allCountUsersModel!.data!.getNewUsersCount.toString() +
            ")",
        "todaymatch".tr +
            "(" +
            _allCountUsersModel!.data!.getTodayMatchCount.toString() +
            ")",
        "mymatch".tr +
            "(" +
            _allCountUsersModel!.data!.getMyMatchCount.toString() +
            ")",
        // "todaymatch".tr,
      ];
    }
  }

  Widget buildCards() {
    final provider = Provider.of<CardProvider>(context);
    final users = provider.users;
    return hide == false
        // users.isEmpty
        ? Center(
            /*  child: Image.asset(
            ImagePath.noCardImg,
            fit: BoxFit.fill,
          ) */
            /* Text(
              'The End.',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ), */
            )
        : isUserCompletion
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              )
            : swipeVal == 50
                ? int.parse(_getProfileCompletionModel!.data!.profileCompletion
                            .toString()) >=
                        100
                    ? completeYourRegistartionView(
                        "To see more profile please purchase plan",
                        Chooseplan_screen(),
                        "Subscribe Now")
                    : completeYourRegistartionView("Complete Your Registartion",
                        Basic_Detail(), "Complete Now")
                : provider.todayMatchDetailModel != null &&
                        provider.todayMatchDetailModel!.data != null &&
                        provider.todayMatchDetailModel!.data!.length == 0
                    ? Center(
                        child: Image.asset(
                        ImagePath.noCardImg,
                        fit: BoxFit.fill,
                      ))
                    : Stack(
                        // alignment: Alignment.center,
                        children: [
                          ...users
                              .map((user) =>
                                  /* provider.todayMatchDetailModel!.data!.length == 0
                                  ? Center(
                                      child: Image.asset(
                                      ImagePath.noCardImg,
                                      fit: BoxFit.fill,
                                    ))
                                  : */
                                  TinderCardComponent(
                                    user: user,
                                    isFront: users.last == user,
                                    onSuccess: () {
                                      playStar();
                                    },
                                    users: users,
                                    swipeValFun: () {
                                      setState(() {
                                        swipeCount++;
                                      });
                                      /* print("swipe count :::: $swipeCount");
                                  setSwipeValFun(swipeCount.toString());
                                  /*   if (swipeVal == 11) {
                          if (int.parse(_getProfileCompletionModel!
                                  .data!.profileCompletion
                                  .toString()) >=
                              100) {

                                  Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => Chooseplan_screen()));
                            log("in 10000 =====>");
                          } else {

                            log("in else===>");
                          }
                        } */
                                  log.log("swipe value is :: $swipeVal"); */
                                    },
                                  ))
                              .toList(),
                          if (isFirstRegister == true)
                            if (ifFirstTimeUser == "true" && card < 3)
                              GestureDetector(
                                onHorizontalDragEnd: (DragEndDetails drag) {
                                  if (drag.primaryVelocity == null) return;
                                  log.log(
                                      "drag.primaryVelocity :: ${drag.primaryVelocity}");
                                  if (drag.primaryVelocity! < 0 && card < 2) {
                                    log.log("left");
                                    setState(() {
                                      card = card + 1;
                                    });
                                  } else if (drag.primaryVelocity! < -1) {
                                    log.log("up");
                                    setState(() {
                                      ifFirstTimeUser = "false";
                                    });
                                    setFirstTime("false");
                                  } else {
                                    log.log("right");

                                    setState(() {
                                      card = card + 1;
                                    });
                                  }
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.64,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(18)),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.08,
                                        child: Lottie.asset(
                                            swipesIntro[card]["icon"]),
                                      ),
                                      Text(swipesIntro[card]["title"],
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white)),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.58,
                                        child: Divider(
                                          color: Colors.red,
                                          thickness: 2,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "it will only be a match if you both like each other. Try it out!",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white70),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        ],
                      );
  }

  Widget completeYourRegistartionView(String value, screen, String btn) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Visibility(
          visible: true,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.70),
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    height: 280,
                    width: MediaQuery.of(context).size.width / 1.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 8),
                          ],
                        ),
                        SizedBox(height: 13),
                        Image.asset(ImagePath.appLogo, height: 60, width: 60),
                        SizedBox(height: 18),
                        Text(
                          "$value",
                          textAlign: TextAlign.center,
                          style: headingStyle.copyWith(
                            color: Color(0xff333F52),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Text(
                            btn == "Complete Now"
                                ? AppConstants.registerguide
                                : AppConstants.purchaseguide,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: headingStyle.copyWith(
                              color: Color(0xffAFAFAF),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        /*   GestureDetector(
                            onTap: () {
                              // Navigator.of(context).pushAndRemoveUntil(
                              //     CupertinoPageRoute(
                              //       builder: (context) =>
                              //           // HomeScreen()
                              //           Zoom(),
                              //     ),
                              //     (route) => false);
                            },
                            child: Text("Skip Now")),
                       */
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => screen));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              decoration: BoxDecoration(
                                  gradient: AppColors.appColor,
                                  borderRadius: BorderRadius.circular(9)),
                              alignment: Alignment.center,
                              child: Text(
                                "$btn",
                                style: appBtnStyle,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget overlayimage() {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 0) {
          setState(() {});
          right = true;
          left = false;
          down = false;
          main = false;
        }

        if (details.delta.dx < 0) {}
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImagePath.introscreen), fit: BoxFit.fitWidth),
        ),
        child: Column(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Lottie.asset(ImagePath.lottieleftjson,
                          height: 70, width: 70),
                      const Text(AppConstants.lastphoto,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      Lottie.asset(ImagePath.lottierightjson,
                          height: 70, width: 70),
                      const Text(AppConstants.nextphoto,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(AppConstants.openprofile,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    )),
                Lottie.asset(ImagePath.lottieleftjson, height: 70, width: 70),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  Widget overlayimagerightolike() {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 0) {}

        if (details.delta.dx < 0) {
          setState(() {});
          right = false;
          left = true;
          down = false;
          main = false;
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImagePath.righttolike), fit: BoxFit.fitWidth),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Lottie.asset(ImagePath.lottierightjson,
                  height: 70, width: 70),
            ),
            const Text(AppConstants.rightlike,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    fontStyle: FontStyle.italic)),
            Padding(
              padding: const EdgeInsets.only(
                  left: 80.0, right: 80, top: 10, bottom: 15),
              child: Image.asset(
                ImagePath.img2,
              ),
            ),
            const Text(AppConstants.content,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                )),
          ],
        ),
      ),
    );
  }

  Widget overlayimageleftolike() {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 0) {
          setState(() {});
          right = false;
          left = false;
          down = true;
          main = false;
        }
        if (details.delta.dx < 0) {}
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImagePath.righttolike), fit: BoxFit.fitWidth),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Lottie.asset(ImagePath.lottieleftjson, height: 70, width: 70),
            ),
            const Text(AppConstants.leftlike,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    fontStyle: FontStyle.italic)),
            Padding(
              padding: const EdgeInsets.only(
                  left: 80.0, right: 80, top: 10, bottom: 15),
              child: Image.asset(
                ImagePath.img2,
              ),
            ),
            const Text(AppConstants.content,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                )),
          ],
        ),
      ),
    );
  }

  saveBoolValue(bool main) async {
    prefs = await SharedPreferences.getInstance();
    prefs?.setBool("login", main);
  }

  buildGridPopular(List<String> matches, index) {
    return Container(
      height: 30,
      width: 100,
      child: GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(
              left: 1.0, right: 1.0, top: 1.0, bottom: 1.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.50),
              borderRadius: BorderRadius.circular(30),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Text(
              imaglist[index],
              maxLines: 1,
              style: homestyle.copyWith(fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }

  notificationCountAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await http
        .get(Uri.parse(GET_NOTIFICATION_COUNT_URL + "?" + queryString));
    log.log(response.body);
    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _notificationCountModel =
              NotificationCountModel.fromJson(jsonDecode(response.body));
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

  getUserCompletionAPI() async {
    setState(() {
      isUserCompletion = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response =
        await http.get(Uri.parse(GET_USER_COMPLETION_URL + "?" + queryString));
    log.log("get cpmp :::" + response.body);
    if (response.statusCode == 200) {
      setState(() {
        _getProfileCompletionModel =
            GetProfileCompletionModel.fromJson(jsonDecode(response.body));
      });
      setState(() {
        isUserCompletion = false;
      });
    } else if (response.statusCode == 500) {
      CommonUtils.hideProgressLoading();
      setState(() {
        isUserCompletion = false;
      });
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

  getProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(USER_TOKEN);
    final queryParameters = {
      "token": authToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response =
        await http.get(Uri.parse(GET_PROFILE_DATA_URL + "?" + queryString));
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
          _getAllProfileDataModel = ProfileData.GetAllProfileDataModel.fromJson(
              jsonDecode(response.body));
        });
      }

      print("profile All inforamtion ++++++++++++++ ${response.body}");

      print("profile response ::::::: ${response.body}");
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

  Future<bool> _onBackPressed() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: 'Please click BACK again to exit',
          backgroundColor: currentColor,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
      return Future.value(false);
    }
    exit(0);
  }

  void setFirstTime(status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("isFirstTime", status);
    getFirstTime();
  }

  void getFirstTime() async {
    final provider = Provider.of<CardProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ifFirstTimeUser = await prefs.getString("isFirstTime");
    setState(() {});
    provider.resetUsers();
  }

  playStar() {
    _controllerCenter.play();
  }
}

class UserModel {
  UserModel(this.stories);

  final List<StoryModel> stories;
}

class StoryModel {
  StoryModel(this.imageUrl);

  final String imageUrl;
}

class Content {
  final String text;
  final Color color;

  Content({required this.text, required this.color});
}
