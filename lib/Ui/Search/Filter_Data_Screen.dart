import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/User_Detail_Screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Notification/chat_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../ModelClass/Get_Filter_Model.dart';

class FilterDataScreen extends StatefulWidget {
  List<Data>? filterData;
  FilterDataScreen({Key? key, required this.filterData}) : super(key: key);

  @override
  State<FilterDataScreen> createState() => _FilterDataScreenState();
}

class _FilterDataScreenState extends State<FilterDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _filterbar(),
          (widget.filterData != null)
              ? Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16,bottom: 20),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 17.0,
                          mainAxisSpacing: 17.0,
                          mainAxisExtent: 235,
                        ),
                        itemCount: (widget.filterData != null)
                            ? widget.filterData!.length
                            : 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => UserDetailScreen(
                                    userDetailIndex:
                                        widget.filterData![index].userId,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 210,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: currentColor, width: 5),
                                borderRadius: BorderRadius.circular(
                                    18), /* color: currentColor */
                              ),
                              child: Container(
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(13.0),
                                      child: widget.filterData != null &&
                                              widget.filterData![index]
                                                  .profileImage!.isNotEmpty
                                          ? /* (widget.filterData![
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
                                                                      : */
                                          CachedNetworkImage(
                                              imageUrl: widget
                                                  .filterData![index]
                                                  .profileImage![0]
                                                  .filePath
                                                  .toString(),
                                              fit: BoxFit.cover,
                                              height: 235,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            )
                                          : (widget.filterData != null &&
                                                  widget.filterData![index]
                                                          .gender ==
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
                                    // Spacer(),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        height: 75,
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
                                              left: 8, right: 0, top: 5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  (widget.filterData !=
                                                          null /* &&
                                                                                  widget.filterData![index].isAgent == "1" */
                                                      )
                                                      ? Image.asset(
                                                          ImagePath.dualprofile,
                                                          color: currentColor,
                                                          height: 16,
                                                          width: 16,
                                                        )
                                                      : Container(),
                                                  (widget.filterData !=
                                                          null /* &&
                                                                                  _nearYouMatchModel!.data![index].isAgent == "1" */
                                                      )
                                                      ? SizedBox(
                                                          width: 5,
                                                        )
                                                      : SizedBox(),
                                                  Expanded(
                                                    child: Text(
                                                      widget.filterData != null
                                                          ? widget
                                                                  .filterData![
                                                                      index]
                                                                  .firstname
                                                                  .toString() +
                                                              ', ' +
                                                              widget
                                                                  .filterData![
                                                                      index]
                                                                  .age
                                                                  .toString()
                                                          : AppConstants.joseph,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: fontStyle.copyWith(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 0,
                                              ),
                                              Padding(
                                                padding: (widget.filterData !=
                                                        null /* &&
                                                                                _nearYouMatchModel!.data![index].isAgent ==
                                                                                    "1" */
                                                    )
                                                    ? EdgeInsets.only(
                                                        left: 18.0)
                                                    : EdgeInsets.only(left: 00),
                                                child: Text(
                                                  widget.filterData != null
                                                      ? widget
                                                              .filterData![
                                                                  index]
                                                              .gender
                                                              .toString() +
                                                          ' | ' +
                                                          widget
                                                              .filterData![
                                                                  index]
                                                              .height
                                                              .toString()
                                                      : AppConstants.castText,
                                                  style: matchscroll.copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0,
                                                    right: 8,
                                                    bottom: 5),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    /// ----------- firebase chat module start -----------

                                                    Uuid uuid = Uuid();
                                                    String chatId = "";
                                                    String uuId = uuid.v4();
                                                    SharedPreferences prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    String? userId = await prefs
                                                        .getString(USER_ID);
                                                    String? userName =
                                                        await prefs.getString(
                                                            FULLNAME);
                                                    String? userProfile =
                                                        await prefs.getString(
                                                            PROFILEIMAGE);
                                                    FirebaseFirestore
                                                        firestore =
                                                        FirebaseFirestore
                                                            .instance;
                                                    bool? alreadyChat = false;
                                                    List chatData = [];
                                                    CommonUtils
                                                        .showProgressLoading(
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
                                                        List chatList =
                                                            value.data()![
                                                                    "chats"] ??
                                                                [];
                                                        for (var i = 0;
                                                            i < chatList.length;
                                                            i++) {
                                                          if (chatList[i]
                                                                  ['userId'] ==
                                                              widget
                                                                  .filterData![
                                                                      index]
                                                                  .userId
                                                                  .toString()) {
                                                            setState(() {
                                                              log("already chat true");
                                                              alreadyChat =
                                                                  true;
                                                              chatId = chatList[
                                                                          i]
                                                                      ['chatId']
                                                                  .toString();
                                                            });
                                                            break;
                                                          } else {
                                                            log("already chat false");
                                                            setState(() {
                                                              alreadyChat =
                                                                  false;
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
                                                            "userId": widget
                                                                .filterData![
                                                                    index]
                                                                .userId
                                                                .toString(),
                                                            "userName": widget
                                                                .filterData![
                                                                    index]
                                                                .firstname
                                                                .toString(),
                                                            "userProfile": widget
                                                                .filterData![
                                                                    index]
                                                                .profileImage![
                                                                    0]
                                                                .filePath
                                                                .toString(),
                                                          });
                                                        });

                                                        await firestore
                                                            .collection("Users")
                                                            .doc(userId)
                                                            .set(
                                                                {
                                                              "chats": FieldValue
                                                                  .arrayUnion(
                                                                      chatData),
                                                            },
                                                                SetOptions(
                                                                    merge:
                                                                        true));
                                                        List chats = [];
                                                        firestore
                                                            .collection("Users")
                                                            .doc(widget
                                                                .filterData![
                                                                    index]
                                                                .userId
                                                                .toString())
                                                            .get()
                                                            .then((value) {
                                                          setState(() {
                                                            chats =
                                                                value.data()![
                                                                    "chats"];
                                                          });
                                                        });

                                                        setState(() {
                                                          chats.add({
                                                            "chatId": uuId,
                                                            "userId": userId,
                                                            "userName":
                                                                userName,
                                                            "userProfile":
                                                                userProfile,
                                                          });
                                                        });
                                                        await firestore
                                                            .collection("Users")
                                                            .doc(widget
                                                                .filterData![
                                                                    index]
                                                                .userId
                                                                .toString())
                                                            .set(
                                                                {
                                                              "chats": FieldValue
                                                                  .arrayUnion(
                                                                      chats),
                                                            },
                                                                SetOptions(
                                                                    merge:
                                                                        true));
                                                        log("uuid new");
                                                        CommonUtils
                                                            .hideProgressLoading();
                                                        Navigator.push(
                                                            context,
                                                            CupertinoPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Chat_screen(
                                                                          userId: widget
                                                                              .filterData![index]
                                                                              .userId
                                                                              .toString(),
                                                                          chatId:
                                                                              uuId,
                                                                          image: (widget.filterData != null && widget.filterData![index].profileImage!.isNotEmpty)
                                                                              ? widget.filterData![index].profileImage![0].filePath.toString()
                                                                              : "",
                                                                          name: widget.filterData![index].firstname.toString() +
                                                                              ' ' +
                                                                              widget.filterData![index].lastname.toString(),
                                                                        )));
                                                      } else {
                                                        log("uuid old");
                                                        CommonUtils
                                                            .hideProgressLoading();
                                                        Navigator.push(
                                                            context,
                                                            CupertinoPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Chat_screen(
                                                                          userId: widget
                                                                              .filterData![index]
                                                                              .userId
                                                                              .toString(),
                                                                          chatId:
                                                                              chatId,
                                                                          image: (widget.filterData != null && widget.filterData![index].profileImage!.isNotEmpty)
                                                                              ? widget.filterData![index].profileImage![0].filePath.toString()
                                                                              : "",
                                                                          name: widget.filterData![index].firstname.toString() +
                                                                              ' ' +
                                                                              widget.filterData![index].lastname.toString(),
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
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                        color: currentColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(9)),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'Message',
                                                      style:
                                                          appBtnStyle.copyWith(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white),
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
                    ),
                  ),
                )
              : Center(
                heightFactor: 40.0,
                child: Text("No Filter Data Found!"))
        ],
      ),
    );
  }

  _filterbar() {
    var height = MediaQuery.of(context).size.height;
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Align(
          alignment: Alignment.center,
          child: Image.asset(
            ImagePath.backArrow,
            color: Colors.black,
            height: height * 0.050,
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        AppConstants.filter,
        style: message,
      ),
    );
  }
}
