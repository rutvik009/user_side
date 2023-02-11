import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:matrimonial_app/Core/Constant/globle.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';

class CommunicationDailogBox extends StatefulWidget {
  const CommunicationDailogBox({Key? key}) : super(key: key);

  @override
  State<CommunicationDailogBox> createState() => _CommunicationDailogBoxState();
}

int isSelected = 0;

String mkImage = ImagePath.eMangalKaryaMsg;
String mailImage = ImagePath.eMailMsg;

class _CommunicationDailogBoxState extends State<CommunicationDailogBox> {
  /* List<List<Color>> _col = [
    [
      Color(0xffFC7358),
      Color(0xffFA2457),
    ],
    [
      Color(0xff6398FC),
      Color(0xff6398FC),
    ],
    [
      const Color(0xffEE7502),
      const Color(0xffEE7502),
    ],
  ]; */

  List imageList = [
    ImagePath.eMangalKaryaMsg,
    ImagePath.eWpMsg,
    ImagePath.eMailMsg,
  ];

  void setCommunication(int index) {
    setState(() {
      isSelected = index;
      mkImage = imageList[index];
      mailImage = imageList[index][2];
    });
    log(index.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 8),
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: Container(
        height: 160,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child:
                        Image.asset(ImagePath.greyCross, height: 28, width: 28),
                  ),
                  SizedBox(width: 8),
                ],
              ),
              Text(
                "prefreede".tr,
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(imageList.length, (index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        setCommunication(index);
                      });
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Account_Setting(
                                    fromValue: "Communication",
                                  )));
                    },
                    child: Image.asset(
                      imageList[index],
                      height: 45,
                      width: 45,
                    ),
                  );
                }),
              ),
              SizedBox(height: 5)
            ],
          ),
        ),
      ),
    );
    /* 
    AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16),
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: Container(
        height: 180,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child:
                        Image.asset(ImagePath.greyCross, height: 28, width: 28),
                  ),
                  SizedBox(width: 8),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "prefreede".tr,
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      tapMk();
                      /* setState(() {
                        isTapMk = true;
                      }); */
                      log("isTapMk ::::: ${isTapMk.toString()}");
                      Navigator.pop(context, false);
                    },
                    child: Image.asset(
                      ImagePath.eMangalKaryaMsg,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      tapWP(); /* setState(() {
                        isTapWp = true;
                      }); */
                      log("isTapWp ::::: ${isTapWp.toString()}");
                      Navigator.pop(context, false);
                    },
                    child: Image.asset(
                      ImagePath.eWpMsg,
                      height: 45,
                      width: 45,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      tapMAIL();
                      /* setState(() {
                        isTapMail = true;
                      }); */
                      log("isTapMail ::::: ${isTapMail.toString()}");
                      Navigator.pop(context, false);
                    },
                    child: Image.asset(
                      ImagePath.eMailMsg,
                      height: 45,
                      width: 45,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
   */
  }

  void tapMk() {
    setState(() {
      isTapMk = true;
    });
  }

  void tapWP() {
    setState(() {
      isTapWp = true;
    });
  }

  void tapMAIL() {
    setState(() {
      isTapMail = true;
    });
  }
}
