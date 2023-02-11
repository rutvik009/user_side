import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:developer' as printLog;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/candidate_match_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/get_refer_by_agent_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/user_profile_about_model.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Match%20Screen/Match_Details.dart';
import 'package:matrimonial_app/Ui/Home_screen/Notification/chat_screen.dart';
import 'package:matrimonial_app/Ui/Login/login_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class Match_screen extends StatefulWidget {
  String? image;
  String? name;
  var userId;

  Match_screen({this.image, this.name, Key? key, this.userId})
      : super(key: key);

  @override
  State<Match_screen> createState() => _Match_screenState();
}

class _Match_screenState extends State<Match_screen> {
  GlobalKey previewContainer = new GlobalKey();
  MatchCandidateModel? _matchCandidateModel;
  UserAboutMeModel? _userAboutMeModel;
  GetReferbyAgentModel? _getReferbyAgentModel;
  Dio dio = Dio();
  @override
  void initState() {
    checkConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double angle = -5.0 * pi / 180.0;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          bottomNavigationBar: Container(
            height: 115,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    ImagePath.background,
                  ),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          /// ----------- firebase chat module start -----------

                          Uuid uuid = Uuid();
                          String chatId = "";
                          String uuId = uuid.v4();
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String? userId = await prefs.getString(USER_ID);
                          String? userName = await prefs.getString(FULLNAME);
                          String? userProfile =
                              await prefs.getString(PROFILEIMAGE);
                          FirebaseFirestore firestore =
                              FirebaseFirestore.instance;
                          bool alreadyChat = false;
                          List chatData = [];
                          CommonUtils.showProgressLoading(context);

                          firestore
                              .collection("Users")
                              .doc(userId)
                              .get()
                              .then((value) async {
                            if (value.data() == null) {
                              printLog.log("new user chat");
                              setState(() {
                                alreadyChat = false;
                              });
                            } else {
                              List chatList = value.data()!["chats"] ?? [];
                              for (var i = 0; i < chatList.length; i++) {
                                if (chatList[i]['userId'] ==
                                    widget.userId.toString()) {
                                  setState(() {
                                    printLog.log("already chat true");
                                    alreadyChat = true;
                                    chatId = chatList[i]['chatId'].toString();
                                  });
                                  break;
                                } else {
                                  printLog.log("already chat false");
                                  setState(() {
                                    alreadyChat = false;
                                  });
                                }
                              }
                            }
                          }).then((value) async {
                            if (alreadyChat == false) {
                              setState(() {
                                chatData.add({
                                  "chatId": uuId,
                                  "userId": widget.userId.toString(),
                                  "userName": widget.name.toString(),
                                  "userProfile": widget.image.toString(),
                                });
                              });

                              await firestore
                                  .collection("Users")
                                  .doc(userId)
                                  .set({
                                "chats": FieldValue.arrayUnion(chatData),
                              }, SetOptions(merge: true));
                              List chats = [];
                              firestore
                                  .collection("Users")
                                  .doc(
                                    widget.userId.toString(),
                                  )
                                  .get()
                                  .then((value) {
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
                              await firestore
                                  .collection("Users")
                                  .doc(
                                    widget.userId.toString(),
                                  )
                                  .set({
                                "chats": FieldValue.arrayUnion(chats),
                              }, SetOptions(merge: true));
                              printLog.log("uuid new");
                              CommonUtils.hideProgressLoading();
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => Chat_screen(
                                            userId: widget.userId.toString(),
                                            chatId: uuId,
                                            image: widget.image.toString(),
                                            name: widget.name.toString(),
                                          )));
                            } else {
                              printLog.log("uuid old");
                              CommonUtils.hideProgressLoading();
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => Chat_screen(
                                            userId: widget.userId.toString(),
                                            chatId: chatId,
                                            image: widget.image.toString(),
                                            name: widget.name.toString(),
                                          )));
                            }
                          });

                          /* firestore
                              .collection("Users")
                              // .where("userId", isEqualTo: userId)
                              .snapshots()
                              .listen((result) {
                            printLog.log(
                                "listen part :::::::::: ${result.docs.length}");
                            if (result.size > 0) {
                              result.docs.forEach((element) {
                                printLog.log("value element part");
                                element.data()['chats'].forEach((res) {
                                  if (res['userId'] == userId) {
                                    printLog.log("match user id");
                                    if (element.data()["chats"] != null) {
                                      setState(() {
                                        chatData = element.data()["chats"];
                                      });
                                      element["chats"].forEach((value) {
                                        if (value["userId"].toString() ==
                                            widget.userId.toString()) {
                                          printLog.log("already chat true");
                                          setState(() {
                                            alreadyChat = true;
                                            chatId = value["chatId"].toString();
                                          });
                                        }
                                      });
                                    } else {
                                      printLog.log("already chat false");
                                      setState(() {
                                        alreadyChat = false;
                                      });
                                    }
                                  }
                                });
                              });
                            } else {
                              printLog.log("docs size else part");
                            }
                          }).onData((value) {
                            printLog.log("ondata part :::: $value");
                            if (alreadyChat! == false) {
                              setState(() {
                                chatData.add({
                                  "chatId": uuId,
                                  "userId": widget.userId.toString(),
                                  "userName": widget.name,
                                  "userProfile": widget.image,
                                });
                              });

                              firestore.collection("Users").doc(userId).set({
                                "chats": FieldValue.arrayUnion(chatData),
                              }, SetOptions(merge: true));
                              List chats = [];
                              firestore
                                  .collection("Users")
                                  .doc(widget.userId.toString())
                                  .get()
                                  .then((value) {
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
                              firestore
                                  .collection("Users")
                                  .doc(widget.userId.toString())
                                  .set({
                                "chats": FieldValue.arrayUnion(chats),
                              }, SetOptions(merge: true));
                              printLog.log("uuid new");
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => Chat_screen(
                                            userId: widget.userId.toString(),
                                            chatId: uuId,
                                            image: widget.userId.toString(),
                                            name: widget.name.toString(),
                                          )));
                            } else {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => Chat_screen(
                                            userId: widget.userId.toString(),
                                            chatId: chatId,
                                            image: widget.image.toString(),
                                            name: widget.name.toString(),
                                          )));
                            }
                          }); */

                          /* .whenComplete(() {
                            if (alreadyChat! == false) {
                              setState(() {
                                chatData.add({
                                  "chatId": uuId,
                                  "userId": widget.userId,
                                  "userName": widget.name,
                                  "userProfile": widget.image,
                                });
                              });

                              firestore.collection("Users").doc(userId).set({
                                "chats": FieldValue.arrayUnion(chatData),
                              }, SetOptions(merge: true));
                              List chats = [];
                              firestore
                                  .collection("Users")
                                  .doc(widget.userId.toString())
                                  .get()
                                  .then((value) {
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
                              firestore
                                  .collection("Users")
                                  .doc(widget.userId.toString())
                                  .set({
                                "chats": FieldValue.arrayUnion(chats),
                              }, SetOptions(merge: true));
                              printLog.log("uuid new");
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => Chat_screen(
                                            userId: widget.userId.toString(),
                                            chatId: uuId,
                                            image: widget.userId.toString(),
                                            name: widget.name.toString(),
                                          )));
                            } else {
                              printLog.log("uuid old");

                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => Chat_screen(
                                            userId: widget.userId.toString(),
                                            chatId: chatId,
                                            image: widget.image.toString(),
                                            name: widget.name.toString(),
                                          )));
                            }
                          }); */

                          /// ----------- firebase chat module end -----------
                          /*  Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => Chat_screen(
                                        name: widget.name,
                                        image: widget.image,
                                      ))); */
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2 - 25,
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.colorWhite,
                              borderRadius: BorderRadius.circular(9)),
                          alignment: Alignment.center,
                          child: Text('Say "Hi!"',
                              style: btnname.copyWith(fontSize: 17)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MatchDetails(
                                      image1: (_userAboutMeModel != null &&
                                              _userAboutMeModel!.data != null &&
                                              _userAboutMeModel!.data!
                                                      .profileImage!.length >
                                                  0)
                                          ? _userAboutMeModel!
                                              .data!.profileImage![0].filePath
                                              .toString()
                                          : "",
                                      image2: widget.image,
                                      id: widget.userId)));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2 - 25,
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.colorWhite,
                              borderRadius: BorderRadius.circular(9)),
                          alignment: Alignment.center,
                          child: Text(
                            'View More Details',
                            style: btnname.copyWith(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppConstants.skip,
                      style: appBtnStyle.copyWith(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // backgroundColor: currentColor,
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: InkWell(
                  onTap: () async {
                    _captureSocialPng();
                    /* if (Platform.isAndroid) {
                  var url = widget.image.toString();
                  var response = await get(Uri.parse(url));
                  final documentDirectory =
                      (await getExternalStorageDirectory())!.path;
                  File imgFile = new File('$documentDirectory/flutter.png');
                  imgFile.writeAsBytesSync(response.bodyBytes);
    
                  Share.shareFiles(
                    [('$documentDirectory/flutter.png')],
                    subject: 'URL conversion + Share',
                    text: widget.name,
                  );
                } else {
                  Share.share(
                    widget.name.toString(),
                    subject: 'URL conversion + Share',
                  );
                } */
                  },
                  child: Image.asset(
                    ImagePath.shareframe,
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
                  color: Colors.white,
                  width: width * 0.070,
                  height: height * 0.04,
                ),
              ),
            ),
          ),
          body: RepaintBoundary(
            key: previewContainer,
            child: Container(
              height: height * 10,
              width: width * 10,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      ImagePath.background,
                    ),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 55),
                child: Column(
                  children: [
                    // _matchappbar(),
                    // screen contain
                    Column(
                      children: [
                        Text(
                          AppConstants.congratulation,
                          style:
                              congrates.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppConstants.matchtext,
                              style: match,
                            ),
                            Transform.rotate(
                              angle: angle,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Container(
                                  width: 114,
                                  color: Colors.white,
                                  child: Transform.rotate(
                                    angle: -angle,
                                    child: Text(
                                      AppConstants.match1,
                                      style: match1,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.026,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(ImagePath.matchimage))),
                          height: 138,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _userAboutMeModel != null &&
                                      _userAboutMeModel!.data != null &&
                                      _userAboutMeModel!
                                          .data!.profileImage!.isNotEmpty &&
                                      _userAboutMeModel!
                                              .data!.profileImage!.length >
                                          0
                                  ? CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          (CachedNetworkImageProvider(
                                        _userAboutMeModel!
                                            .data!.profileImage![0].filePath
                                            .toString(),
                                      )),
                                    )
                                  : Container(),
                              SizedBox(
                                width: 35,
                              ),
                              ClipOval(
                                  clipBehavior: Clip.none,
                                  child: widget.image != null &&
                                          widget.image!.isNotEmpty
                                      ? CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.transparent,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                            widget.image!,
                                          ))
                                      : Container()),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                height: 30,
                                width: width,
                                //  color: Colors.black,
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 32),
                                  child: Text(
                                    _userAboutMeModel != null &&
                                            _userAboutMeModel!.data != null &&
                                            _userAboutMeModel!.data!.fullName !=
                                                null
                                        ? _userAboutMeModel!.data!.fullName
                                            .toString()
                                            .split(" ")
                                            .first
                                        : "",
                                    maxLines: 1,
                                    // overflow: TextOverflow.ellipsis,
                                    style: match.copyWith(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                height: 30,
                                width: width,
                                //  color: Colors.blue,
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    widget.name != null
                                        ? widget.name.toString()
                                        : "",
                                    overflow: TextOverflow.ellipsis,
                                    style: match.copyWith(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            /* Spacer(),
                        Text(_userAboutMeModel!.data!.fullName.toString(),style: match.copyWith(fontSize: 18,color: Colors.white),),
                        SizedBox(width: 15),
                        Text(widget.name.toString(),style: match.copyWith(fontSize: 18,color: Colors.white),),
                        Spacer(), */
                          ],
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 0, bottom: 8),
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ImagePath.note,
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          AppConstants.kundli,
                                          style: congrates.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          _matchCandidateModel != null &&
                                                  _matchCandidateModel!
                                                      .data!.kundli!.isNotEmpty
                                              ? " " +
                                                  _matchCandidateModel!
                                                      .data!.kundli
                                                      .toString()
                                              : "",
                                          style: congrates.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "%",
                                          style: congrates.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      AppConstants.kundlimatch,
                                      style: congrates.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.white.withOpacity(0.8)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.008,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 16, top: 0, bottom: 8),
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/FoodHebitWhite.png',
                                  // ImagePath.foodHebitWhite,
                                  height: 23,
                                ),
                                SizedBox(
                                  width: width * 0.040,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          AppConstants.food,
                                          style: congrates.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          _matchCandidateModel != null &&
                                                  _matchCandidateModel!
                                                      .data!.kundli!.isNotEmpty
                                              ? " " +
                                                  _matchCandidateModel!
                                                      .data!.habits
                                                      .toString()
                                              : "",
                                          style: congrates.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "%",
                                          style: congrates.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      width: width * 0.73,
                                      child: Text(
                                        AppConstants.foodhabits,
                                        style: congrates.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color:
                                                Colors.white.withOpacity(0.8)),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 0, bottom: 8),
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ImagePath.bag,
                                  height: 20,
                                ),
                                SizedBox(
                                  width: width * 0.040,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          AppConstants.occupation,
                                          style: congrates.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          _matchCandidateModel != null &&
                                                  _matchCandidateModel!
                                                      .data!.kundli!.isNotEmpty
                                              ? " " +
                                                  _matchCandidateModel!
                                                      .data!.occupation
                                                      .toString()
                                              : "",
                                          style: congrates.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "%",
                                          style: congrates.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      width: width * 0.73,
                                      child: Text(
                                        AppConstants.occupationlist,
                                        style: congrates.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color:
                                                Colors.white.withOpacity(0.8)),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 0, bottom: 8),
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ImagePath.people,
                                  height: 20,
                                ),
                                SizedBox(
                                  width: width * 0.040,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          AppConstants.castmatch,
                                          style: congrates.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          _matchCandidateModel != null &&
                                                  _matchCandidateModel!
                                                      .data!.kundli!.isNotEmpty
                                              ? " " +
                                                  _matchCandidateModel!
                                                      .data!.caste
                                                      .toString()
                                              : "",
                                          style: congrates.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "%",
                                          style: congrates.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      width: width * 0.73,
                                      child: Text(
                                        AppConstants.castmatchlist,
                                        style: congrates.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color:
                                                Colors.white.withOpacity(0.8)),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                      ],
                    ),
                    /*  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MatchDetails(
                                    image1: _userAboutMeModel!
                                        .data!.profileImage![0].filePath
                                        .toString(),
                                    image2: widget.image)));
                      },
                      child: Container(
                        height: 20,
                        color: Colors.transparent,
                        child: Text(
                          "View More Details",
                          style: TextStyle(
                              color: AppColors.colorWhite,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ), */
                    //Spacer(),
                    // butons
                  ],
                ),
              ),
            ),
          )),
    );
  }

  _matchappbar() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 120,
      child: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              onTap: () async {
                _captureSocialPng();
                /* if (Platform.isAndroid) {
                  var url = widget.image.toString();
                  var response = await get(Uri.parse(url));
                  final documentDirectory =
                      (await getExternalStorageDirectory())!.path;
                  File imgFile = new File('$documentDirectory/flutter.png');
                  imgFile.writeAsBytesSync(response.bodyBytes);

                  Share.shareFiles(
                    [('$documentDirectory/flutter.png')],
                    subject: 'URL conversion + Share',
                    text: widget.name,
                  );
                } else {
                  Share.share(
                    widget.name.toString(),
                    subject: 'URL conversion + Share',
                  );
                } */
              },
              child: Image.asset(
                ImagePath.shareframe,
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
              color: Colors.white,
              width: width * 0.070,
              height: height * 0.04,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _captureSocialPng() {
    List<String> imagePaths = [];
    final RenderBox box = context.findRenderObject() as RenderBox;
    return new Future.delayed(const Duration(milliseconds: 20), () async {
      RenderRepaintBoundary? boundary = previewContainer.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;

      ui.Image image = await boundary!.toImage();
      final directory = (await getApplicationDocumentsDirectory()).path;
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      File imgFile = new File('$directory/screenshot.jpg');
      imagePaths.add(imgFile.path);
      imgFile.writeAsBytes(pngBytes).then((value) async {
        await Share.shareFiles(imagePaths,
            subject: 'Share',
            text: 'Congratulation',
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      }).catchError((onError) {
        print(onError);
      });
    });
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getcandidatematchApi();
      getProfileAPI();
      getReferbyAgent();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getcandidatematchApi();
      getProfileAPI();
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

  getReferbyAgent() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    try {
      var response = await dio.get(GET_REFER_BY_AGENT_URL + "?" + queryString);
      if (response.statusCode == 200) {
        setState(() {
          _getReferbyAgentModel = GetReferbyAgentModel.fromJson(response.data);
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

  getcandidatematchApi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    try {
      var response = await dio.get(GET_Candidate_Match_URL + "?" + queryString);
      if (response.statusCode == 200) {
        setState(() {
          _matchCandidateModel = MatchCandidateModel.fromJson(response.data);
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
}
