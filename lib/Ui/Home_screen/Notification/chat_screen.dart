import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Notification/Chat_Database_Handler.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' as foundation;
import '../../../Core/Constant/value_constants.dart';

class Chat_screen extends StatefulWidget {
  String? name;
  String? image;
  String? chatId;
  Function? onBack;
  String? userId;

  Chat_screen(
      {Key? key, this.name, this.image, this.chatId, this.onBack, this.userId})
      : super(key: key);

  @override
  State<Chat_screen> createState() => _Chat_screenState();
}

class _Chat_screenState extends State<Chat_screen> {
  int? changeIndex;
  List chatData = [];
  TextEditingController chatController = TextEditingController();
  List<DocumentSnapshot> listMessage = [];
  final ScrollController listScrollController = ScrollController();
  File? file;
  String userId = "";
  int _limit = 20;
  int _limitIncrement = 20;
  bool emojiShowing = false;
  Stream<QuerySnapshot>? _usersStream;

  _scrollListener() {
    if (!listScrollController.hasClients) return;
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange &&
        _limit <= listMessage.length) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void readLocal() async {
    _usersStream = FirebaseFirestore.instance
        .collection('Chats')
        .orderBy('time', descending: true)
        .where("chatId", isEqualTo: widget.chatId)
        .snapshots();
  }

  @override
  void initState() {
    // getChatData();
    getUser();
    listScrollController.addListener(_scrollListener);
    readLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("user id ::: ${widget.userId}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _chatappbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
              child: _usersStream == null
                  ? Container(
                      color: Colors.yellow,
                    )
                  : StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Chats')
                          .where("chatId", isEqualTo: widget.chatId)
                          .orderBy('time', descending: true)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          listMessage = snapshot.data!.docs;
                          // log("Krupa ::: ${listMessage.first.data.toString()}");
                          if (listMessage.length > 0) {
                            return ListView.builder(
                              padding: EdgeInsets.all(10),
                              itemBuilder: (context, index) {
                                return buildItem(
                                    index, snapshot.data!.docs[index]);
                              },

                              itemCount: snapshot.data?.docs.length,
                              reverse: true,
                              // controller: listScrollController,
                            );
                          } else {
                            return Center(
                                child: Text("No message here yet..."));
                          }
                        } else {
                          return Container();
                          /* return Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ); */
                        }
                      },
                    )),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*  Text(
                  "Joseph wind is typing...",
                  style: TextStyle(
                      color: Color(
                        0xff3A4167,
                      ),
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),*/ /*  Text(
                  "Joseph wind is typing...",
                  style: TextStyle(
                      color: Color(
                        0xff3A4167,
                      ),
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),*/
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 10, right: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff000000).withOpacity(0.1),
                          offset: Offset(0.5, 0.5),
                          blurRadius: 10)
                    ],
                    border: Border.all(color: Color(0xffE1E1E1), width: 0.5),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  emojiShowing = !emojiShowing;
                                });
                              },
                              child: Icon(
                                emojiShowing
                                    ? Icons.keyboard
                                    : Icons.emoji_emotions,
                                color: currentColor,
                                size: 30,
                              ),
                            ),
                          ),

                          // Container(
                          //   width: 25,
                          //   height: 25,
                          //   child: Image.asset(ImagePath.smily),
                          // ),
                          // Padding(
                          //     padding: const EdgeInsets.only(
                          //         top: 10, bottom: 10, left: 10, right: 10),
                          //     child: Container(
                          //       height: 60,
                          //       width: 1,
                          //       color: Color(0xffBCBCBC),
                          //     )),
                          /* GestureDetector(
                            onTap: () {
                              getImageFromGallery();
                            },
                            child: Container(
                              width: 25,
                              height: 25,
                              child: Image.asset(ImagePath.sharefile),
                            ),
                          ), */
                        ],
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          child: TextField(
                        controller: chatController,
                        readOnly: emojiShowing ? true : false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type here....',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              if (chatController.text.isNotEmpty) {
                                ChatDatabaseHandler.sendMessages(
                                    chatController.text,
                                    widget.chatId.toString(),
                                    widget.userId.toString(),
                                    widget.name.toString(),
                                    widget.image.toString(),
                                    widget.onBack);
                                chatController.clear();
                                // setMsg();
                              }
                            },
                            child: Container(
                                padding: EdgeInsets.all(8),
                                width: 15,
                                height: 15,
                                child: Image.asset(ImagePath.shareImage)),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
                Offstage(
                  offstage: !emojiShowing,
                  child: SizedBox(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: EmojiPicker(
                        textEditingController: chatController,
                        config: Config(
                          columns: 7,
                          /* emojiSizeMax: 32 *
                              (foundation.defaultTargetPlatform ==
                                      TargetPlatform.iOS
                                  ? 1.30
                                  : 1.0), */
                          verticalSpacing: 0,
                          horizontalSpacing: 0,
                          gridPadding: EdgeInsets.zero,
                          initCategory: Category.RECENT,
                          bgColor: Colors.black87,
                          indicatorColor: currentColor,
                          iconColor: Colors.grey,
                          iconColorSelected: currentColor,
                          backspaceColor: Colors.blue,
                          skinToneDialogBgColor: Colors.black,
                          skinToneIndicatorColor: Colors.black,
                          enableSkinTones: true,
                          showRecentsTab: true,
                          recentsLimit: 28,
                          replaceEmojiOnLimitExceed: false,
                          noRecents: const Text(
                            'No Recents',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black26),
                            textAlign: TextAlign.center,
                          ),
                          loadingIndicator: const SizedBox.shrink(),
                          tabIndicatorAnimDuration: kTabScrollDuration,
                          categoryIcons: const CategoryIcons(),
                          buttonMode: ButtonMode.MATERIAL,
                          checkPlatformCompatibility: true,
                        ),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildItem(int index, DocumentSnapshot document) {
    return Column(
      children: [
        document["userId"] != userId
            ? Align(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: currentColor,
                      ),
                      child: Text(
                        document["message"],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Text(
                      DateFormat('hh:mm').format(
                        (document["time"]).toDate(),
                      ),
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(
                      height: 3,
                    )
                  ],
                ),
              )
            : Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffEBEBEB)),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Text(
                        document["message"],
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Text(
                      DateFormat('hh:mm').format(
                        (document["time"]).toDate(),
                      ),
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(
                      height: 3,
                    )
                  ],
                ),
              ),
      ],
    );
  }

  _chatappbar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(63),
      child: AppBar(
          /* actions: [
            PopupMenuButton(
                icon: Center(
                  child: Container(
                      width: 4,
                      height: 24,
                      child: Image.asset(ImagePath.popupmenu)),
                ),
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("Voice Call"),
                      ),
                      PopupMenuItem(
                        child: Text("Video Call"),
                      ),
                    ])
          ], */
          backgroundColor: Colors.white,
          elevation: 4.0,
          leading: GestureDetector(
            onTap: () {
              CommonUtils.hideProgressLoading();
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 12, right: 0),
              child: Image.asset(
                ImagePath.leftArrow,
                height: 15,
                width: 15,
                color: Color(0xff2C3E50),
              ),
            ),
          ),
          leadingWidth: 48,
          // centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 1),
                  child: Container(
                    // width: 50,
                    // height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: currentColor, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: (widget.image != "")
                          ? CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  NetworkImage(widget.image.toString()),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  AssetImage(ImagePath.userdefault),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 11,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        widget.name.toString(),
                        overflow: TextOverflow.fade,
                        style: headerstyle.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ),
                    /*Text(
                      'Online',
                      style: onlinenow,
                    )*/
                  ],
                )
              ],
            ),
          )),
    );
  }

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userId = await prefs.getString(USER_ID)!;
  }

  void setmsg() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("Chats").add({
      "user": userId,
      "msg": chatController.text,
      "chatId": widget.chatId,
      "time": DateTime.now(),
      "image": "",
      "isImage": false,
    });
    setLastMsg(chatController.text);

    chatController.clear();
  }

  void getImageFromGallery() async {
    final storageRef = FirebaseStorage.instance.ref();
    ImagePicker imagePicker = ImagePicker();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    file = File(image!.path);
    final imagesRef = storageRef.child("images/");
    final TaskSnapshot snapshot = await imagesRef
        .child(file.toString().split("/").last.toString())
        .putFile(file!);

    final String url = await imagesRef
        .child(file.toString().split("/").last.toString())
        .getDownloadURL();
    print("The download URL is " + url);
    setImage(url);
  }

  void setImage(url) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("Chats").add({
      "user": userId,
      "msg": chatController.text,
      "uploadImage": url,
      "isImage": true,
      "chatId": widget.chatId,
      "time": DateTime.now()
    });
    chatController.clear();
    setLastMsg("");

    // getMsg();
  }

  void setLastMsg(msg) async {
    List data = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String userId = await prefs.getString(USER_ID)!;
    await firestore.collection("Users").doc(userId).get().then((value) {
      setState(() {
        data = value.data()!["chats"];
        data.forEach((element) {
          if (element["chatId"] == widget.chatId) {
            setState(() {
              element["lastMsg"] = msg == "" ? "Image" : msg;
              element["lastMsgTime"] = DateTime.now();
            });
          }
        });
      });
    });
    /*  await firestore.collection("Users").doc(userId).update({
      "chats" : FieldValue.arrayUnion(data)
    }); */

    await firestore.collection("Users").doc(userId).set({
      "chats": data,
    }, SetOptions(merge: true));
    if (widget.onBack != null) {
      widget.onBack!();
    }
    ;
  }

// void getChatData() async {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//   firestore.collection("Chats").doc(widget.chatId).get().then((value) {
//     firestore
//         .collection("Chats")
//         .where("chatId", isEqualTo: widget.chatId)
//         .orderBy('time', descending: true)
//         .get()
//         .then((value) {
//       value.docs.forEach((element) {
//         if (element.data().isNotEmpty) {
//
//           setState(() {
//             chatData.add(element.data());
//           });
//         }
//
//       });
//     });
//   });
// }
}

class ChatMessage {
  String messageContent;
  String messageType;

  ChatMessage({required this.messageContent, required this.messageType});
}
