import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatDatabaseHandler {
  static FirebaseFirestore kFirebaseStore = FirebaseFirestore.instance;
  static void sendMessages(String message, String chatId, String receiverId,
      String name, String image, Function? onBack) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? senderId = preferences.getString(USER_ID);
    kFirebaseStore.collection("Chats").add({
      "chatId": chatId,
      "userId": receiverId,
      "userName": name,
      "message": message,
      "uploadImage": "",
      "isImage": false,
      "time": DateTime.now(),
    }).then((value) {
      setLastMsg(message, chatId, onBack, receiverId);
    });
  }

  static void setLastMsg(
      String msg, String chatId, Function? onBack, String ReceiverId) async {
    List data = [];
    List receiverData = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = await prefs.getString(USER_ID);
    await kFirebaseStore.collection("Users").doc(userId).get().then((value) {
      data = value.data()!["chats"];
      data.forEach((element) {
        if (element["chatId"] == chatId) {
          element['isMsg'] = true;
          element["lastMsg"] = msg == "" ? "Image" : msg;
          element["lastMsgTime"] = DateTime.now();
        }
      });
    }).then((value) {
      kFirebaseStore.collection("Users").doc(ReceiverId).get().then((value) {
        receiverData = value.data()!["chats"];
        receiverData.forEach((element) {
          if (element["chatId"] == chatId) {
            element['isMsg'] = true;
            element["lastMsg"] = msg == "" ? "Image" : msg;
            element["lastMsgTime"] = DateTime.now();
          }
        });
      }).then((value) {
        kFirebaseStore.collection("Users").doc(ReceiverId).set({
          "chats": receiverData,
        }, SetOptions(merge: true));
      });
    });

    await kFirebaseStore.collection("Users").doc(userId).set({
      "chats": data,
    }, SetOptions(merge: true));
    if (onBack != null) {
      onBack();
    }
    ;
  }
}
