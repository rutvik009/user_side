import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Notification/chat_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/Utils/value_constant.dart';
import 'package:matrimonial_app/src/StoryViewer/stories_for_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Core/Constant/value_constants.dart';

class Message_screen extends StatefulWidget {
  String? fromValue;

  Message_screen({Key? key, this.fromValue}) : super(key: key);

  @override
  State<Message_screen> createState() => _Message_screenState();
}

class _Message_screenState extends State<Message_screen> {
  TextEditingController searchController = TextEditingController();
  String searchValue = "";
  List<Map<String, dynamic>> online = [
    {
      IMAGE: ImagePath.messageonline,
      NAME: AppConstants.sara,
    },
    {
      IMAGE: ImagePath.storyonline1,
      NAME: AppConstants.sophia,
    },
    {
      IMAGE: ImagePath.storyonline2,
      NAME: AppConstants.faye,
    },
    {
      IMAGE: ImagePath.storyonline3,
      NAME: AppConstants.james,
    },
    {
      IMAGE: ImagePath.storyonline2,
      NAME: AppConstants.faye,
    },
    {
      IMAGE: ImagePath.storyonline3,
      NAME: AppConstants.james,
    },
  ];

  List chatData = [];

  @override
  void initState() {
    getChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          widget.fromValue == 'Discover feed'
              ? AppBarScreen(
                  name: "message".tr,
                )
              : AppBarScreen1(name: "message".tr),
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
                            width: 15,
                            height: 15,
                          ),
                          SizedBox(
                            width: width * 0.010,
                          ),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) {
                                setState(() {
                                  searchValue = value;
                                });
                                log("search text :::::: $searchValue");
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "happiness".tr,
                                  hintStyle: happiness),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Stories(
                    circlePadding: 5,
                    displayProgress: true,
                    storyItemList: List.generate(
                      chatData.length <= 5 ? chatData.length : 6,
                      (index) => StoryItem(
                          name: chatData[index]['userName'],
                          thumbnail:
                              NetworkImage(chatData[index]['userProfile']),
                          stories: [
                            Scaffold(
                              body: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/images/story1.jpg',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Scaffold(
                              body: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://images.unsplash.com/photo-1522262590532-a991489a0253?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1854&q=80 ")),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: chatData.length == 0
                        ? Center(
                            child: Text("No Chats Available"),
                          )
                        : chatData.isEmpty
                            ? CircularProgressIndicator()
                            : ListView.separated(
                                shrinkWrap: true,
                                reverse: true,
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: chatData.length,
                                itemBuilder: (context, index) {
                                  if (searchValue.isEmpty) {
                                    return chatData.isEmpty
                                        ? CircularProgressIndicator()
                                        : (chatData[index]['isMsg'] != null)
                                            ? GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                          builder: (context) =>
                                                              Chat_screen(
                                                                onBack: () {
                                                                  getChats();
                                                                },
                                                                userId: chatData[
                                                                        index]
                                                                    ['userId'],
                                                                image: chatData[
                                                                        index][
                                                                    "userProfile"],
                                                                name: chatData[
                                                                        index][
                                                                    "userName"],
                                                                chatId: chatData[
                                                                        index]
                                                                    ["chatId"],
                                                              )));
                                                },
                                                child: Container(
                                                  color: Colors.white,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 53,
                                                        width: 53,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                color:
                                                                    currentColor,
                                                                width: 1)),
                                                        padding:
                                                            EdgeInsets.all(0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
                                                          child: (chatData[
                                                                          index]
                                                                      [
                                                                      "userProfile"] !=
                                                                  "")
                                                              ? CircleAvatar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                    chatData[
                                                                            index]
                                                                        [
                                                                        "userProfile"],
                                                                  ),
                                                                )
                                                              : CircleAvatar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  backgroundImage:
                                                                      AssetImage(
                                                                    ImagePath
                                                                        .userdefault,
                                                                  ),
                                                                ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 13,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: width * 0.7,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    chatData[
                                                                            index]
                                                                        [
                                                                        "userName"],
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 90,
                                                                ),
                                                                Text(
                                                                  DateFormat(
                                                                          'hh:mm a')
                                                                      .format((chatData[index]
                                                                              [
                                                                              "lastMsgTime"])
                                                                          .toDate()),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Container(
                                                            width: width * 0.7,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  chatData[
                                                                          index]
                                                                      [
                                                                      "lastMsg"],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade600),
                                                                ),
                                                                SizedBox(),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container();
                                  }
                                  if (chatData[index]['userName']
                                      .toString()
                                      .toLowerCase()
                                      .startsWith(searchValue.toLowerCase())) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    Chat_screen(
                                                      onBack: () {
                                                        getChats();
                                                      },
                                                      userId: chatData[index]
                                                          ['userId'],
                                                      image: chatData[index]
                                                          ["userProfile"],
                                                      name: chatData[index]
                                                          ["userName"],
                                                      chatId: chatData[index]
                                                          ["chatId"],
                                                    )));
                                      },
                                      child: Container(
                                        color: Colors.white,
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 53,
                                              width: 53,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: currentColor,
                                                      width: 1)),
                                              padding: EdgeInsets.all(0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: (chatData[index]
                                                            ["userProfile"] !=
                                                        "")
                                                    ? CircleAvatar(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          chatData[index]
                                                              ["userProfile"],
                                                        ),
                                                      )
                                                    : CircleAvatar(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        backgroundImage:
                                                            AssetImage(
                                                          ImagePath.userdefault,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 13,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: width * 0.7,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          chatData[index]
                                                              ["userName"],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 90,
                                                      ),
                                                      Text(
                                                        DateFormat('hh:mm a')
                                                            .format((chatData[
                                                                        index][
                                                                    "lastMsgTime"])
                                                                .toDate()),
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Container(
                                                  width: width * 0.7,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        chatData[index]
                                                            ["lastMsg"],
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey.shade600),
                                                      ),
                                                      SizedBox(),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                                separatorBuilder: (context, index) {
                                  if (searchValue.isEmpty) {
                                    return (chatData[index]['isMsg'] != null)
                                        ? Divider()
                                        : Container();
                                  }
                                  if (chatData[index]['userName']
                                      .toString()
                                      .toLowerCase()
                                      .startsWith(searchValue.toLowerCase())) {
                                    return (chatData[index]['isMsg'] != null)
                                        ? Divider()
                                        : Container();
                                  }
                                  return Container();
                                },
                              ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _messagebar() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: Colors.yellow,
      elevation: 0,
      centerTitle: true,
      title: Text(
        "message".tr,
        style: message,
      ),
    );
  }

  void getChats() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = await prefs.getString(USER_ID)!;

    firestore.collection("Users").doc(userId).get().then((value) async {
      if (value.data() != null) {
        setState(() {
          chatData = value.data()!["chats"] ?? [];
        });
      } else {}
    });
  }
}

class AppBarScreen extends StatelessWidget {
  String name;
  AppBarScreen({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 40,
          leading: Container(
            height: 28,
            width: 28,
          ),
          /* GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Image.asset(
                ImagePath.leftArrow,
                height: 28,
                width: 28,
                color: Color(0xff2C3E50),
              ),
            ),
          ), */
          centerTitle: true,
          title: Text(
            name,
            style: headingStyle.copyWith(
                color: Color(0xff440312),
                fontSize: 21,
                fontWeight: FontWeight.w600),
          ),
        ));
  }
}

class AppBarScreen1 extends StatelessWidget {
  String name;
  AppBarScreen1({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 40,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Image.asset(
                ImagePath.leftArrow,
                height: 28,
                width: 28,
                color: Color(0xff2C3E50),
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            name,
            style: headingStyle.copyWith(
                color: Color(0xff440312),
                fontSize: 21,
                fontWeight: FontWeight.w600),
          ),
        ));
  }
}




/* import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:matrimonial_app/Executive%20Ui/Home%20screen/MessageScreen/message_screen.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Notification/chat_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/Utils/value_constant.dart';
import 'package:matrimonial_app/src/StoryViewer/stories_for_flutter.dart';

class Message_screen extends StatefulWidget {
  String? fromValue;
  Message_screen({Key? key, this.fromValue}) : super(key: key);

  @override
  State<Message_screen> createState() => _Message_screenState();
}

class _Message_screenState extends State<Message_screen> {
  List<Map<String, dynamic>> online = [
    {
      IMAGE: ImagePath.messageonline,
      NAME: AppConstants.sara,
    },
    {
      IMAGE: ImagePath.storyonline1,
      NAME: AppConstants.sophia,
    },
    {
      IMAGE: ImagePath.storyonline2,
      NAME: AppConstants.faye,
    },
    {
      IMAGE: ImagePath.storyonline3,
      NAME: AppConstants.james,
    },
    {
      IMAGE: ImagePath.storyonline2,
      NAME: AppConstants.faye,
    },
    {
      IMAGE: ImagePath.storyonline3,
      NAME: AppConstants.james,
    },
  ];
  List<Map<String, dynamic>> onlinechat = [
    {
      IMAGE: ImagePath.chatimage1,
      NAME: AppConstants.joseph1,
      SUBNAME: AppConstants.thanks,
      TIME: AppConstants.time,
    },
    {
      IMAGE: ImagePath.chatimage2,
      NAME: AppConstants.sara,
      SUBNAME: AppConstants.thanks,
      TIME: AppConstants.time,
      COUNT: AppConstants.count,
    },
    {
      IMAGE: ImagePath.chatimage3,
      NAME: AppConstants.faye,
      SUBNAME: AppConstants.thanks,
      TIME: AppConstants.time
    },
    {
      IMAGE: ImagePath.chatimage4,
      NAME: AppConstants.faye,
      SUBNAME: AppConstants.thanks,
      TIME: AppConstants.time
    },
    {
      IMAGE: ImagePath.chatimage5,
      NAME: AppConstants.james,
      SUBNAME: AppConstants.thanks,
      TIME: AppConstants.time
    },
    {
      IMAGE: ImagePath.chatimage6,
      NAME: AppConstants.ellie,
      SUBNAME: AppConstants.thanks,
      TIME: AppConstants.time
    },
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          widget.fromValue == 'Discover feed'
              ? AppBarScreen(
                  name: "message".tr,
                )
              : AppBarScreen1(name: "message".tr),
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
                            width: 15,
                            height: 15,
                          ),
                          SizedBox(
                            width: width * 0.010,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "happiness".tr,
                                  hintStyle: happiness),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Stories(
                    circlePadding: 5,
                    displayProgress: true,
                    storyItemList: List.generate(
                      online.length,
                      (index) => StoryItem(
                          name: online[index][NAME],
                          thumbnail: index == 0
                              ? AssetImage(ImagePath.putstory)
                              : AssetImage(online[index][IMAGE]),
                          stories: [
                            Scaffold(
                              body: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/images/story1.jpg',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Scaffold(
                              body: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://images.unsplash.com/photo-1522262590532-a991489a0253?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1854&q=80 ")),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: onlinechat.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => Chat_screen(image: onlinechat[index][IMAGE],name: onlinechat[index][NAME],)));
                          },
                          child: Container(
                            color: Colors.white,
                            child: Row(
                              children: [
                                Stack(children: [
                                  Container(
                                    height: 53,
                                    width: 53,
                                    child: CircleAvatar(
                                      backgroundImage:
                                          AssetImage(onlinechat[index][IMAGE]),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 00,
                                    child: Container(
                                      height: 16,
                                      width: 16,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      alignment: Alignment.center,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff31F173),
                                        ),
                                        height: 12,
                                        width: 12,
                                      ),
                                    ),
                                  ),
                                ]),
                                SizedBox(
                                  width: 13,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: width * 0.7,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(onlinechat[index][NAME]),
                                          SizedBox(
                                            width: 90,
                                          ),
                                          Text(onlinechat[index][TIME])
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      width: width * 0.7,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          index == 2
                                              ? Text(
                                                  onlinechat[index][SUBNAME],
                                                  style: TextStyle(
                                                      color: currentColor),
                                                )
                                              : Text(
                                                  onlinechat[index][SUBNAME]),
                                          SizedBox(),
                                          index == 2
                                              ? Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                      color: currentColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                      child: Text(
                                                    "4",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )))
                                              : Container()
                                        ],
                                      ),
                                    )
                                  ],
                                ),
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
      ),
    );
  }

  _messagebar() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: Colors.yellow,
      elevation: 0,
      centerTitle: true,
      title: Text(
        "message".tr,
        style: message,
      ),
    );
  }
} */
