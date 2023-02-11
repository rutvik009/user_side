import 'dart:developer' as log;
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial_app/Core/Constant/globle.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Today_Match_Detail_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/User_Check_Model.dart'
    as userCheck;
import 'package:matrimonial_app/Ui/Home_screen/Home/HomeScreen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CardStatus { like, dislike, superLike }

class CardProvider extends ChangeNotifier {
  List<Data> _users = [];
  bool _isDragging = false;
  double _angle = 0;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  int _propertiesArrayIndex = 0;
  TodayMatchDetailModel? _todayMatchDetailModel;
  userCheck.UserCheckModel? _userCheckModel;
  userCheck.UserCheckModel? get userCheckModel => _userCheckModel;
  int get propertiesArrayIndex => _propertiesArrayIndex;
  Dio dio = Dio();
  TodayMatchDetailModel? get todayMatchDetailModel => _todayMatchDetailModel;
  bool onetime = false;
  String isfirstlike = "isOneTime";
  var showStaus;
  late ConfettiController _controllerCenter;
  List<String> matches = [];
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

  set todayMatchDetailModel(TodayMatchDetailModel? value) {
    _todayMatchDetailModel = value;
    notifyListeners();
  }

  set groupsame(int value) {
    _propertiesArrayIndex = value;
    notifyListeners();
  }

  List<Data> get users => _users;
  bool get isDragging => _isDragging;
  Offset get position => _position;
  double get angle => _angle;
  List<String> get matchList => matches;
  int a = 0;

  CardProvider() {
    // getTodayMatchDetailAPI();
    resetUsers();
  }

  void setScreenSize(Size screenSize) => _screenSize = screenSize;

  void startPosition(DragStartDetails details) {
    _isDragging = true;

    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;

    final x = _position.dx;
    _angle = 45 * x / _screenSize.width;

    notifyListeners();
  }

  void endPosition() {
    _isDragging = false;
    notifyListeners();

    final status = getStatus(force: true);
    showStaus = status;
    switch (status) {
      case CardStatus.like:
        like();
        break;
      case CardStatus.dislike:
        dislike();
        break;
      case CardStatus.superLike:

      default:
        resetPosition();
    }
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;

    notifyListeners();
  }

  double getStatusOpacity() {
    final delta = 100;
    final pos = max(_position.dx.abs(), _position.dy.abs());
    final opacity = pos / delta;

    return min(opacity, 1);
  }

  CardStatus? getStatus({bool force = false}) {
    final x = _position.dx;
    final y = _position.dy;
    final forceSuperLike = x.abs() < 20;

    if (force) {
      final delta = 100;

      if (x >= delta) {
        return CardStatus.like;
      } else if (x <= -delta) {
        return CardStatus.dislike;
      } else if (y <= -delta / 2 && forceSuperLike) {
        return CardStatus.superLike;
      }
    } else {
      final delta = 20;

      if (y <= -delta * 2 && forceSuperLike) {
        return CardStatus.superLike;
      } else if (x >= delta) {
        return CardStatus.like;
      } else if (x <= -delta) {
        return CardStatus.dislike;
      }
    }
  }

  void dislike() {
    _angle = -20;
    _position -= Offset(2 * _screenSize.width, 0);
    _nextCard();

    notifyListeners();
  }

  void like() {
    _angle = 20;
    _position += Offset(2 * _screenSize.width, 0);
    //getLikeApi();
    notifyListeners();
    _nextCard();
  }

  Future _nextCard() async {
    if (users.isEmpty) return;
    await Future.delayed(Duration(milliseconds: 100));
    _users.removeLast();
    resetPosition();
    AppConstants.index++;
  }

  void resetUsers() {
    if (isDone == "false") {
      if (selectedMatches == 0) {
        _users.clear();
        getNewUserDetailAPI();
        getUserCheck();
        print("new user api");
        log.log("message::: $selectedMatches");
      } else if (selectedMatches == 1) {
        log.log("message::: $selectedMatches");
        print("todays matches api");
        _users.clear();
        getTodayMatchDetailAPI();

        getUserCheck();
      } else {
        _users.clear();
        getMymatchDetialAPI();
        getUserCheck();
      }
    } else {
      resetUsers1();
    }
    // _users = <Data>[];

    notifyListeners();
  }

  void resetUsers1() {
    onetime = true;
  }

  getNewUserDetailAPI() async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    isDone = "true";
    try {
      var response = await dio.get(GET_NEAR_YOU_URL + "?" + queryString);
      if (response.statusCode == 200) {
        print("new user response ::: ${response.data}");
        _todayMatchDetailModel = TodayMatchDetailModel.fromJson(response.data);
        hide = true;
        _todayMatchDetailModel!.data!.forEach((element) {
          _users.add(element);
          // print("User List ${_users[0].firstname}");
        });
        isDone = "false";

        notifyListeners();
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
    isDone = "true";
    try {
      var response =
          await dio.get(GET_TODAY_MATCH_DETAIL_URL + "?" + queryString);
      if (response.statusCode == 200) {
        print("api todays response :: ${response.data}");

        _todayMatchDetailModel = TodayMatchDetailModel.fromJson(response.data);
        hide = true;
        _todayMatchDetailModel!.data!.forEach((element) {
          _users.add(element);
          // print("User List ${_users[0].firstname}");
        });
        // print("data todays:::::::::::: ${_users.length}");
        isDone = "false";

        notifyListeners();
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
    isDone = "true";
    try {
      var response =
          await dio.get(GET_MY_MATCH_DETAIL_URL + "?" + queryString);
      if (response.statusCode == 200) {
        print("api todays response :: ${response.data}");

        _todayMatchDetailModel = TodayMatchDetailModel.fromJson(response.data);
        hide = true;
        _todayMatchDetailModel!.data!.forEach((element) {
          _users.add(element);
          // print("User List ${_users[0].firstname}");
        });
        // print("data todays:::::::::::: ${_users.length}");
        isDone = "false";

        notifyListeners();
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
    } on DioError catch (e) {}
  }

  Future getLikeApi(int index) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": userToken.toString(),
      "user_id": index.toString()
    };

    String queryString = Uri(queryParameters: queryParameters).query;
    log.log("LIKE_URl ::: ${LIKE_URl}");
    try {
      var response = await dio.get(LIKE_URl + "?" + queryString);
      log.log("Like response :: ${response.data}");
      if (response.statusCode == 200) {
        pref.setString(isfirstlike, "true");
        print("api response :: ${response.data}");
        notifyListeners();
      } else if (response.statusCode == 500) {}
    } on DioError catch (e) {}
  }

  getstarprofile(int index) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": userToken.toString(),
      "user_id": index.toString()
      // _todayMatchDetailModel!.data![index].userId.toString()
    };
    String queryString = Uri(queryParameters: queryParameters).query;

    try {
      var response = await dio.get(STAR_URL + "?" + queryString);
      if (response.statusCode == 200) {
        print("api response :: ${response.data}");
        /* 
        Fluttertoast.showToast(
            msg: "Star successfully ",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffE16284),
            textColor: Colors.white,
            fontSize: 16.0); */
        notifyListeners();
        _nextCard();
        /* Fluttertoast.showToast(
            msg: "User set Dislike successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffE16284),
            textColor: Colors.white,
            fontSize: 16.0); */
        print("today match ::: ${response.data}");
      } else if (response.statusCode == 500) {
        /* Fluttertoast.showToast(
            msg: "Internal Server Error",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffE16284),
            textColor: Colors.white,
            fontSize: 16.0); */
      }
    } on DioError catch (e) {}
  }

  getDisLikeApi(int index) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": userToken.toString(),
      "user_id": index.toString()
      // _todayMatchDetailModel!.data![index].userId.toString()
    };
    String queryString = Uri(queryParameters: queryParameters).query;

    try {
      var response = await dio.get(DISLIKE_URl + "?" + queryString);
      if (response.statusCode == 200) {
        print("api response :: ${response.data}");
        notifyListeners();
        /* Fluttertoast.showToast(
            msg: "User set Dislike successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffE16284),
            textColor: Colors.white,
            fontSize: 16.0); */
        print("today match ::: ${response.data}");
      } else if (response.statusCode == 500) {
        /* Fluttertoast.showToast(
            msg: "Internal Server Error",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffE16284),
            textColor: Colors.white,
            fontSize: 16.0); */
      }
    } on DioError catch (e) {}
  }

  getAddArchiveApi(userid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.get(USER_TOKEN);
    var response = await dio
        .get(GET_ADD_ARCHIVE_URL + "?user_id=$userid&token=$userToken");
    if (response.statusCode == 200) {
      if (response.data['data'] == 1) {
        log.log("Archive");
        /* Fluttertoast.showToast(
            msg: "Dislike successfully ",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffE16284),
            textColor: Colors.white,
            fontSize: 16.0); */
      } else {}
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
  }

  getUserCheck() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.get(USER_TOKEN);
    var response = await dio.get(USER_CHECK_URL + "?token=$userToken");
    if (response.statusCode == 200) {
      _userCheckModel = userCheck.UserCheckModel.fromJson(response.data);
      print("user check  response ::: ${_userCheckModel!.data!.paymentStatus}");
      // notifyListeners();
    }
  }
}
