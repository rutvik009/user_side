import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/add_usermatching_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/get_Addarchive_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/user_match_detail_model.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/Drawer_Screen.dart';
import 'package:matrimonial_app/Ui/Login/login_screen.dart';
import 'package:matrimonial_app/Ui/Matrimonial%20Like/like_screen.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/widget/submit_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../ModelClass/UserPanel_ModelClass/user_profile_about_model.dart';

class MatchDetails extends StatefulWidget {
  String? image1;
  String? image2;
  var id;
  String? fromValue;

  MatchDetails({Key? key, this.image1, this.image2, this.id, this.fromValue})
      : super(key: key);

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {
  AddUserMatchingModel? _addUserMatchingModel = AddUserMatchingModel();
  UserMatchDetailModel? _userMatchDetailModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnection();
    print("image get :::: ${widget.image2}");
    print("userid::::::${widget.id} ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _matchappbar(),
          Container(
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage(ImagePath.MatchImgBg))),
            height: 138,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: (widget.image1!.isNotEmpty)
                        ? DecorationImage(
                            image: NetworkImage(widget.image1.toString()),
                            fit: BoxFit.cover)
                        : DecorationImage(
                            image: AssetImage(ImagePath.femaleProfileUser),
                            // "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png"),
                          ),
                    shape: BoxShape.circle,
                  ),
                  height: 130,
                  width: 100,
                ),
                SizedBox(
                  width: 35,
                ),
                Container(
                  decoration: BoxDecoration(
                    image: (widget.image2!.isNotEmpty)
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(
                                widget.image2.toString()),
                            fit: BoxFit.cover)
                        : DecorationImage(
                            image: AssetImage(ImagePath.femaleProfileUser),
                            // "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png"),
                          ),
                    shape: BoxShape.circle,
                  ),
                  height: 130,
                  width: 100,
                )
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagePath.note,
                color: Colors.black,
                height: 20,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                _userMatchDetailModel != null &&
                        _userMatchDetailModel!.data != null
                    ? "Kundaili - " +
                        _userMatchDetailModel!.data!.kundli!.totalPercentage
                            .toString() +
                        "%🔥"
                    : "",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                  children: List.generate(
                _userMatchDetailModel != null &&
                        _userMatchDetailModel!.data != null &&
                        _userMatchDetailModel!.data!.kundli!.list!.isNotEmpty
                    ? _userMatchDetailModel!.data!.kundli!.list!.length
                    : 0,
                (index) => Text(
                  _userMatchDetailModel != null &&
                          _userMatchDetailModel!.data != null
                      ? _userMatchDetailModel!.data!.kundli!.list![index]
                          .toString()
                      : "",
                  /*  "Varna - 5%", */
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff333333),
                      fontWeight: FontWeight.w400),
                ),
              )

                  /* [
                  Text(
                    _userMatchDetailModel != null &&
                        _userMatchDetailModel!.data != null
                    ? 
                        _userMatchDetailModel!.data!.kundli!.list![0]
                            .toString() 
                    : "",
                   /*  "Varna - 5%", */
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "Vasya - 12%",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "Tara - 8%",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w400),
                  ),
                ], */
                  ),
              /* Container(
                  height: 50,
                  child: VerticalDivider(
                    color: Color(0xff333333).withOpacity(0.15),
                    thickness: 1,
                  )),
              Column(
                children: [
                  Text(
                    "Varna - 5%",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "Vasya - 8%",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "Tara - 4%",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ), */
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: Color(0xff333333).withOpacity(0.15),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagePath.foodHobies,
                color: Colors.black,
                height: 23,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                _userMatchDetailModel != null &&
                        _userMatchDetailModel!.data != null
                    ? "Food habits - " +
                        _userMatchDetailModel!.data!.foodHabits!.totalPercentage
                            .toString() +
                        "%🔥"
                    : "",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                  children: List.generate(
                _userMatchDetailModel != null &&
                        _userMatchDetailModel!.data != null &&
                        _userMatchDetailModel!
                            .data!.foodHabits!.list!.isNotEmpty
                    ? _userMatchDetailModel!.data!.foodHabits!.list!.length
                    : 0,
                (index) => Text(
                  _userMatchDetailModel != null &&
                          _userMatchDetailModel!.data != null
                      ? _userMatchDetailModel!.data!.foodHabits!.list![index]
                          .toString()
                      : "",
                  /*  "Varna - 5%", */
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff333333),
                      fontWeight: FontWeight.w400),
                ),
              )
                  /* [
                  Text("Varna - 5%"),
                  Text("Vasya - 12%"),
                  Text("Tara - 8%"),
                ], */
                  ),
              /* Container(
                  height: 50,
                  child: VerticalDivider(
                    color: Color(0xff333333).withOpacity(0.15),
                    thickness: 1,
                  )),
              Column(
                children: [
                  Text("Varna - 5%"),
                  Text("Vasya - 8%"),
                  Text("Tara - 4%"),
                ],
              ), */
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: Color(0xff333333).withOpacity(0.15),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagePath.bag,
                color: Colors.black,
                height: 20,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                _userMatchDetailModel != null &&
                        _userMatchDetailModel!.data != null
                    ? "Occupation - " +
                        _userMatchDetailModel!
                            .data!.occupations!.totalPercentage
                            .toString() +
                        "%🔥"
                    : "",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _userMatchDetailModel != null &&
                        _userMatchDetailModel!.data != null &&
                        _userMatchDetailModel!
                            .data!.occupations!.list!.isNotEmpty
                    ? _userMatchDetailModel!.data!.occupations!.list!.length
                    : 0,
                (index) => Row(
                  children: [
                    Text(
                      _userMatchDetailModel != null &&
                              _userMatchDetailModel!.data != null
                          ? _userMatchDetailModel!
                              .data!.occupations!.list![index]
                              .toString()
                          : "",
                      /*  "Varna - 5%", */
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff333333),
                          fontWeight: FontWeight.w400),
                    ),
                    index == 0
                        ? Container(
                            height: 20,
                            child: VerticalDivider(
                              color: Color(0xff333333).withOpacity(0.15),
                              thickness: 1,
                            ))
                        : Container(),
                  ],
                ),
              )
              /* [
              Text(
                "IT Field - 15%",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w400),
              ),
              Container(
                  height: 20,
                  child: VerticalDivider(
                    color: Color(0xff333333).withOpacity(0.15),
                    thickness: 1,
                  )),
              Text(
                "Engineer - 10%",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w400),
              ),
            ], */
              ),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: Color(0xff333333).withOpacity(0.15),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagePath.people,
                color: Colors.black,
                height: 20,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                _userMatchDetailModel != null &&
                        _userMatchDetailModel!.data != null
                    ? "Cast - " +
                        _userMatchDetailModel!.data!.caste!.totalPercentage
                            .toString() +
                        "%🔥"
                    : "",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _userMatchDetailModel != null &&
                        _userMatchDetailModel!.data != null &&
                        _userMatchDetailModel!
                            .data!.occupations!.list!.isNotEmpty
                    ? _userMatchDetailModel!.data!.caste!.list!.length
                    : 0,
                (index) => Row(
                  children: [
                    Text(
                      _userMatchDetailModel != null &&
                              _userMatchDetailModel!.data != null
                          ? _userMatchDetailModel!.data!.caste!.list![index]
                              .toString()
                          : "",
                      /*  "Varna - 5%", */
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff333333),
                          fontWeight: FontWeight.w400),
                    ),
                    /* index == 0
                        ? Container(
                            height: 20,
                            child: VerticalDivider(
                              color: Color(0xff333333).withOpacity(0.15),
                              thickness: 1,
                            ))
                        : Container(), */
                  ],
                ),
              )
              /* [
              Text(
                "Brahmin - 13%",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w400),
              ),
              Container(
                  height: 20,
                  child: VerticalDivider(
                    color: Color(0xff333333).withOpacity(0.15),
                    thickness: 1,
                  )),
              Text(
                "Brahmin - 12%",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w400),
              ),
            ], */
              ),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: Color(0xff333333).withOpacity(0.15),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagePath.people,
                color: Colors.black,
                height: 20,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                _userMatchDetailModel != null &&
                        _userMatchDetailModel!.data != null
                    ? "Gotra - " +
                        _userMatchDetailModel!.data!.gotra!.totalPercentage
                            .toString() +
                        "%🔥"
                    : "",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _userMatchDetailModel != null &&
                        _userMatchDetailModel!.data != null &&
                        _userMatchDetailModel!
                            .data!.occupations!.list!.isNotEmpty
                    ? _userMatchDetailModel!.data!.gotra!.list!.length
                    : 0,
                (index) => Row(
                  children: [
                    Text(
                      _userMatchDetailModel != null &&
                              _userMatchDetailModel!.data != null
                          ? _userMatchDetailModel!.data!.gotra!.list![index]
                              .toString()
                          : "",
                      /*  "Varna - 5%", */
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff333333),
                          fontWeight: FontWeight.w400),
                    ),
                    /* index == 0
                        ? Container(
                            height: 20,
                            child: VerticalDivider(
                              color: Color(0xff333333).withOpacity(0.15),
                              thickness: 1,
                            ))
                        : Container(), */
                  ],
                ),
              )
              /* [
              Text(
                "Angad - 20%",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w400),
              ),
              Container(
                  height: 20,
                  child: VerticalDivider(
                    color: Color(0xff333333).withOpacity(0.15),
                    thickness: 1,
                  )),
              Text(
                "Angirasa - 10%",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w400),
              ),
            ], */
              ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: widget.fromValue == "InProgress"
                ? CommonButton(
                    btnName: "Remove From In Progress",
                    btnOnTap: () {
                      getAddArchiveApi(widget.id);
                      /*  setState(() {
                    getAddmatchingProfile();
                  }); */
                    })
                : CommonButton(
                    btnName: "Move to In Progress",
                    btnOnTap: () {
                      getAddmatchingProfile();
                    }),
          ),
        ],
      ),
    );
  }

  _matchappbar() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 70,
      child: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              onTap: () async {
                if (Platform.isAndroid) {
                  var url = widget.image2.toString();
                  var response = await get(Uri.parse(url));
                  final documentDirectory =
                      (await getExternalStorageDirectory())!.path;
                  File imgFile = new File('$documentDirectory/flutter.png');
                  imgFile.writeAsBytesSync(response.bodyBytes);

                  Share.shareFiles(
                    [('$documentDirectory/flutter.png')],
                    subject: 'URL conversion + Share',
                  );
                } else {}
              },
              child: Image.asset(
                ImagePath.shareframe,
                color: Colors.black,
                height: height * 0.020,
                width: width * 0.070,
              ),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              ImagePath.backArrow,
              color: Colors.black,
              width: width * 0.070,
              height: height * 0.05,
            ),
          ),
        ),
      ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getUserMatchDetailsAPI();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getUserMatchDetailsAPI();
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

  getAddmatchingProfile() async {
    Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var authToken = prefs.getString(USER_TOKEN);
    final queryParameters = {
      "token": authToken.toString(),
    };
    var data = {"matching_id": widget.id.toString()};
    log("add matching params ::::::::: $data");

    String queryString = Uri(queryParameters: queryParameters).query;

    var response = await dio.post(GET_ADD_MATCHING_PROFILE + "?" + queryString,
        data: data);
    if (response.statusCode == 200) {
      var data = response.data;

      setState(() {
        _addUserMatchingModel = AddUserMatchingModel.fromJson(data);

        Fluttertoast.showToast(
            msg: _addUserMatchingModel!.message.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffE16284),
            textColor: Colors.white,
            fontSize: 16.0);
      });

      log("GetUserImage response ::::::::${response.data}");
      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => Zoom(
                    selectedIndex: 2,
                  )));
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

  getAddArchiveApi(String likeByYouId) async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userToken = pref.get(USER_TOKEN);
    var response = await dio
        .get(GET_ADD_ARCHIVE_URL + "?user_id=$likeByYouId&token=$userToken");
    if (response.statusCode == 200) {
      if (response.data['data'] == 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Zoom(
                      selectedIndex: 2,
                    )));
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
          GetAddarchiveModel _getAddarchiveModel =
              GetAddarchiveModel.fromJson(response.data);
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

  getUserMatchDetailsAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var authToken = prefs.getString(USER_TOKEN);
    final queryParameters = {
      "token": authToken.toString(),
    };
    // var data = {"matching_id": widget.id.toString()};

    String queryString = Uri(queryParameters: queryParameters).query;

    var response = await http.get(
      Uri.parse(GET_USER_MATCH_DETAIL_URL + "?" + queryString), /* body: data */
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      setState(() {
        _userMatchDetailModel = UserMatchDetailModel.fromJson(data);
      });

      log("UserMatchDetails response ::::::::${response.body}");
      /* Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => Zoom(
                    selectedIndex: 2,
                  ))); */
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
}
