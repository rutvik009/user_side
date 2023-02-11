/* import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/Ui/DetailsScreen/alert_dialog.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/app_helper.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/submit_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ImageSourceType { gallery, camera }

class DetailScreen2 extends StatefulWidget {
  String userNumber;
  // String docId;
  DetailScreen2({
    Key? key,
    required this.userNumber,
    /* required this.docId */
  }) : super(key: key);

  @override
  State<DetailScreen2> createState() => _DetailScreen2State();
}

class _DetailScreen2State extends State<DetailScreen2> {
  // PickedFile? imageFile;
  PickedFile? imageFile1;
  PickedFile? imageFile2;
  PickedFile? imageFile3;
  Dio dio = Dio();
  PickedFile? profileImage;
  //PickedFile? coverImage;
  List<PickedFile> coverImgList = [];
  List<String> coverImgPathList = [];
  File? userSelectedCoverImages;
  File? userSelectedProfileImages;
  File? userSelectedCoverImages1;
  File? userSelectedProfileImages1;
  File? userSelectedCoverImages2;
  File? userSelectedProfileImages2;
  File? userSelectedCoverImages3;
  File? userSelectedProfileImages3;
  PickedFile? imageFile;
  File? fileImage;
  PickedFile? coverImage;
  bool? isCompleteRegister;

  _getImageFrom(
      {required ImageSource source,
      required bool isCover,
      required int isCoverSequence}) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? _pickedImage =
        await _picker.pickImage(source: source, imageQuality: 85);
    print("pick image");
    if (_pickedImage != null) {
      CommonUtils.showProgressLoading(context);
      try {
        // if (_pickedImage != null) {
        CommonUtils.hideProgressLoading();
        var image = File(_pickedImage.path.toString());
        final _sizeInKbBefore = image.lengthSync() / 1024;
        print('Before Compress $_sizeInKbBefore kb');
        var _compressedImage = await AppHelper.compress(image: image);
        final _sizeInKbAfter = _compressedImage.lengthSync() / 1024;
        print('After Compress $_sizeInKbAfter kb');
        var _croppedImage =
            await AppHelper.cropImage(_compressedImage, isCover);
        if (_croppedImage == null) {
          return;
        }
        setState(() {
          if (isCover == true) {
            if (isCoverSequence == 1) {
              userSelectedCoverImages1 = _croppedImage;
              setCoverImage("2", PickedFile(userSelectedCoverImages1!.path));
            } else if (isCoverSequence == 2) {
              userSelectedCoverImages2 = _croppedImage;
              setCoverImage("2", PickedFile(userSelectedCoverImages2!.path));
            } else if (isCoverSequence == 3) {
              userSelectedCoverImages3 = _croppedImage;
              setCoverImage("2", PickedFile(userSelectedCoverImages3!.path));
            }
          } else {
            userSelectedProfileImages = _croppedImage;
            setCoverImage("1", PickedFile(userSelectedProfileImages!.path));
          }
        });
        // }
      } on Error catch (e) {
        print(" image error part  +++++++ $e");
        CommonUtils.hideProgressLoading();
        log("imgge upload elase part");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        isCompleteRegister = _prefs.getBool(SHOWPERSONALDETAILS) ?? null;

        // if (isCompleteRegister == false) {
        Fluttertoast.showToast(
                timeInSecForIosWeb: 60,
                msg: "Kindly re open the app to continue where you left")
            .then((value) {
          Future.delayed(Duration(seconds: 2), () {
            SystemNavigator.pop();
          });
        });
        // SystemNavigator.pop();
        /* } else {
          Navigator.pop(context);
        } */
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () async {
              SharedPreferences _prefs = await SharedPreferences.getInstance();
              isCompleteRegister = _prefs.getBool(SHOWUPLOADIMAGE) ?? null;

              // if (isCompleteRegister == false) {
              Fluttertoast.showToast(
                      timeInSecForIosWeb: 60,
                      msg: "Kindly re open the app to continue where you left")
                  .then((value) {
                Future.delayed(Duration(seconds: 2), () {
                  SystemNavigator.pop();
                });
              });
              // SystemNavigator.pop();
              /*  } else {
                Navigator.pop(context);
              } */
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset(ImagePath.backArrow),
            ),
          ),
          title: Text(
            AppConstants.upload,
            style: fontStyle.copyWith(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DottedBorder(
                              color: userSelectedProfileImages == null
                                  ? Colors.black
                                  : Colors.transparent,
                              dashPattern: [8, 4],
                              strokeWidth: 1,
                              strokeCap: StrokeCap.round,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(5),
                              child: Column(
                                children: [
                                  Container(
                                    height: height * 0.26,
                                    width: width / 2.4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title: Center(
                                                    child: const Text(
                                                        'Pick Image')),
                                                actions: <Widget>[
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () async {
                                                          /* profileImage =
                                                              await _openGallery(
                                                                  context); */
                                                          // Navigator.of(context)
                                                          //     .pop();
                                                          print(
                                                              "pick image pop");
                                                          await _getImageFrom(
                                                              source:
                                                                  ImageSource
                                                                      .gallery,
                                                              isCover: false,
                                                              isCoverSequence:
                                                                  0);
                                                          /*  Navigator.of(context)
                                                              .pop(); */
                                                          /*  if (userSelectedProfileImages != null && userSelectedProfileImages!
                                                              .path
                                                              .isNotEmpty) {
                                                            setCoverImage(
                                                                "1",
                                                                PickedFile(
                                                                    userSelectedProfileImages!
                                                                        .path));
                                                          } else {} */

                                                          /*    Navigator.pop(
                                                              context); */

                                                          /*   setProfileUpdateAPI(
                                                              "1", profileImage); */
                                                        },
                                                        /* onPressed: () async {
                                                          coverImgList =
                                                              await _openGallery(
                                                                  context);
                                                          setCoverImage(
                                                              "1", profileImage);
                                                        }, */
                                                        child: const Text(
                                                            'Gallery'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          /* profileImage =
                                                              await _openGallery(
                                                                  context); */
                                                          // Navigator.of(context)
                                                          //     .pop();
                                                          print(
                                                              "pick image pop");
                                                          await _getImageFrom(
                                                              source:
                                                                  ImageSource
                                                                      .camera,
                                                              isCover: false,
                                                              isCoverSequence:
                                                                  0);
                                                          /*  Navigator.of(context)
                                                              .pop(); */
                                                          /*  if (userSelectedProfileImages!
                                                              .path
                                                              .isNotEmpty) {
                                                            setCoverImage(
                                                                "1",
                                                                PickedFile(
                                                                    userSelectedProfileImages!
                                                                        .path));
                                                          } else {} */

                                                          /*   setProfileUpdateAPI(
                                                              "1", profileImage); */
                                                        },
                                                        /* onPressed: () async {
                                                          coverImgList =
                                                              await _openCamera(
                                                                  context);
                                                          setCoverImage(
                                                              "1", profileImage);
                                                        }, */
                                                        child: Text('Camera'),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: (userSelectedProfileImages ==
                                                  null)
                                              ? currentColor ==
                                                      Color(0xff6398FC)
                                                  ? Image.asset(
                                                      ImagePath.addBlue,
                                                      // color: currentColor,
                                                      width: 40,
                                                      height: 40,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : currentColor ==
                                                          const Color(
                                                              0xffEE7502)
                                                      ? Image.asset(
                                                          ImagePath.addOrange,
                                                          // color: currentColor,
                                                          width: 40,
                                                          height: 40,
                                                          fit: BoxFit.fill,
                                                        )
                                                      : Image.asset(
                                                          ImagePath.imagepicker,
                                                          width: 40,
                                                          height: 40,
                                                          fit: BoxFit.fill,
                                                        )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Container(
                                                    height: height * 0.26,
                                                    width: width / 2.5,
                                                    child: Image.file(
                                                      File(
                                                          userSelectedProfileImages!
                                                              .path),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text('Profile Picture',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5)
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 17,
                            ),
                            DottedBorder(
                              color: userSelectedCoverImages1 == null
                                  ? Colors.black
                                  : Colors.transparent,
                              dashPattern: [8, 4],
                              strokeWidth: 1,
                              strokeCap: StrokeCap.round,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(5),
                              child: Column(
                                children: [
                                  Container(
                                    height: height * 0.26,
                                    width: width / 2.4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title: Center(
                                                    child: const Text(
                                                        'Pick Image')),
                                                actions: <Widget>[
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () async {
                                                          /* coverImage =
                                                        await _openGallery(
                                                            context); */
                                                          // Navigator.of(context)
                                                          //     .pop();
                                                          await _getImageFrom(
                                                              source:
                                                                  ImageSource
                                                                      .gallery,
                                                              isCover: true,
                                                              isCoverSequence:
                                                                  1);
                                                          /*   Navigator.of(context)
                                                              .pop(); */
                                                          /*  if (userSelectedCoverImages1!
                                                              .path
                                                              .isNotEmpty) {
                                                            setCoverImage(
                                                                "2",
                                                                PickedFile(
                                                                    userSelectedCoverImages1!
                                                                        .path));
                                                          } else {} */
                                                        },
                                                        /*  onPressed: () async {
                                                          coverImgList =
                                                              await _openGallery1(
                                                                  context);
                                                          setCoverImage(
                                                              "2", coverImage);
                                                        }, */
                                                        child: const Text(
                                                            'Gallery'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          /* profileImage =
                                                              await _openGallery(
                                                                  context); */
                                                          // Navigator.of(context)
                                                          //     .pop();
                                                          await _getImageFrom(
                                                              source:
                                                                  ImageSource
                                                                      .camera,
                                                              isCover: true,
                                                              isCoverSequence:
                                                                  1);
                                                          /*  Navigator.of(context)
                                                              .pop(); */
                                                          /*  if (userSelectedCoverImages1!
                                                              .path
                                                              .isNotEmpty) {
                                                            setCoverImage(
                                                                "2",
                                                                PickedFile(
                                                                    userSelectedCoverImages1!
                                                                        .path));
                                                          } else {} */
                                                        },
                                                        child: Text('Camera'),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: (userSelectedCoverImages1 ==
                                                  null)
                                              ? currentColor ==
                                                      Color(0xff6398FC)
                                                  ? Image.asset(
                                                      ImagePath.addBlue,
                                                      // color: currentColor,
                                                      width: 40,
                                                      height: 40,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : currentColor ==
                                                          const Color(
                                                              0xffEE7502)
                                                      ? Image.asset(
                                                          ImagePath.addOrange,
                                                          // color: currentColor,
                                                          width: 40,
                                                          height: 40,
                                                          fit: BoxFit.fill,
                                                        )
                                                      : Image.asset(
                                                          ImagePath.imagepicker,
                                                          width: 40,
                                                          height: 40,
                                                          fit: BoxFit.fill,
                                                        )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Container(
                                                    height: height * 0.26,
                                                    width: width / 2.5,
                                                    child: Image.file(
                                                      File(
                                                          userSelectedCoverImages1!
                                                              .path),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text('Cover Picture',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DottedBorder(
                            color: userSelectedCoverImages2 == null
                                ? Colors.black
                                : Colors.transparent,
                            dashPattern: [8, 4],
                            strokeWidth: 1,
                            strokeCap: StrokeCap.round,
                            borderType: BorderType.RRect,
                            radius: Radius.circular(5),
                            child: Column(
                              children: [
                                Container(
                                  height: height * 0.26,
                                  width: width / 2.4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: Center(
                                                  child:
                                                      const Text('Pick Image')),
                                              actions: <Widget>[
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () async {
                                                        /* coverImage =
                                                        await _openGallery(
                                                            context); */
                                                        // Navigator.of(context)
                                                        //     .pop();
                                                        await _getImageFrom(
                                                            source: ImageSource
                                                                .gallery,
                                                            isCover: true,
                                                            isCoverSequence: 2);
                                                        /*  Navigator.of(context)
                                                            .pop(); */
                                                        /*  if (userSelectedCoverImages2!
                                                            .path.isNotEmpty) {
                                                          setCoverImage(
                                                              "2",
                                                              PickedFile(
                                                                  userSelectedCoverImages2!
                                                                      .path));
                                                        } else {} */
                                                      },
                                                      /*  onPressed: () async {
                                                          coverImgList =
                                                              await _openGallery1(
                                                                  context);
                                                          setCoverImage(
                                                              "2", coverImage);
                                                        }, */
                                                      child:
                                                          const Text('Gallery'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        /* profileImage =
                                                              await _openGallery(
                                                                  context); */
                                                        // Navigator.of(context)
                                                        //     .pop();
                                                        await _getImageFrom(
                                                            source: ImageSource
                                                                .camera,
                                                            isCover: true,
                                                            isCoverSequence: 2);
                                                        /*  Navigator.of(context)
                                                            .pop(); */
                                                        /*  if (userSelectedCoverImages2!
                                                            .path.isNotEmpty) {
                                                          setCoverImage(
                                                              "2",
                                                              PickedFile(
                                                                  userSelectedCoverImages2!
                                                                      .path));
                                                        } else {} */

                                                        /*   setProfileUpdateAPI(
                                                              "1", profileImage); */
                                                      },
                                                      /* onPressed: () async {
                                                          coverImgList =
                                                              await _openCamera1(
                                                                  context);
                                                          setCoverImage(
                                                              "2", coverImage);
                                                        }, */
                                                      child: Text('Camera'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: (userSelectedCoverImages2 ==
                                                null)
                                            ? currentColor == Color(0xff6398FC)
                                                ? Image.asset(
                                                    ImagePath.addBlue,
                                                    // color: currentColor,
                                                    width: 40,
                                                    height: 40,
                                                    fit: BoxFit.fill,
                                                  )
                                                : currentColor ==
                                                        const Color(0xffEE7502)
                                                    ? Image.asset(
                                                        ImagePath.addOrange,
                                                        // color: currentColor,
                                                        width: 40,
                                                        height: 40,
                                                        fit: BoxFit.fill,
                                                      )
                                                    : Image.asset(
                                                        ImagePath.imagepicker,
                                                        width: 40,
                                                        height: 40,
                                                        fit: BoxFit.fill,
                                                      )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Container(
                                                  height: height * 0.26,
                                                  width: width / 2.5,
                                                  child: Image.file(
                                                    File(
                                                        userSelectedCoverImages2!
                                                            .path),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text('Cover Picture',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(height: 5)
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 17,
                          ),
                          DottedBorder(
                            color: userSelectedCoverImages3 == null
                                ? Colors.black
                                : Colors.transparent,
                            dashPattern: [8, 4],
                            strokeWidth: 1,
                            strokeCap: StrokeCap.round,
                            borderType: BorderType.RRect,
                            radius: Radius.circular(5),
                            child: Column(
                              children: [
                                Container(
                                  height: height * 0.26,
                                  width: width / 2.4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: Center(
                                                  child:
                                                      const Text('Pick Image')),
                                              actions: <Widget>[
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () async {
                                                        /* coverImage =
                                                        await _openGallery(
                                                            context); */
                                                        // Navigator.of(context)
                                                        //     .pop();
                                                        await _getImageFrom(
                                                            source: ImageSource
                                                                .gallery,
                                                            isCover: true,
                                                            isCoverSequence: 3);
                                                        /* Navigator.of(context)
                                                            .pop(); */
                                                        /*  if (userSelectedCoverImages3!
                                                            .path.isNotEmpty) {
                                                          setCoverImage(
                                                              "2",
                                                              PickedFile(
                                                                  userSelectedCoverImages3!
                                                                      .path));
                                                        } else {} */
                                                      },
                                                      /*  onPressed: () async {
                                                          coverImgList =
                                                              await _openGallery1(
                                                                  context);
                                                          setCoverImage(
                                                              "2", coverImage);
                                                        }, */
                                                      child:
                                                          const Text('Gallery'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        /* profileImage =
                                                              await _openGallery(
                                                                  context); */
                                                        // Navigator.of(context)
                                                        //     .pop();
                                                        await _getImageFrom(
                                                            source: ImageSource
                                                                .camera,
                                                            isCover: true,
                                                            isCoverSequence: 3);
                                                        /*  if (userSelectedCoverImages3!
                                                            .path.isNotEmpty) {
                                                          setCoverImage(
                                                              "2",
                                                              PickedFile(
                                                                  userSelectedCoverImages3!
                                                                      .path));
                                                        } else {} */

                                                        /*   setProfileUpdateAPI(
                                                              "1", profileImage); */
                                                      },
                                                      /* onPressed: () async {
                                                          coverImgList =
                                                              await _openCamera1(
                                                                  context);
                                                          setCoverImage(
                                                              "2", coverImage);
                                                        }, */
                                                      child: Text('Camera'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: (userSelectedCoverImages3 ==
                                                null)
                                            ? currentColor == Color(0xff6398FC)
                                                ? Image.asset(
                                                    ImagePath.addBlue,
                                                    // color: currentColor,
                                                    width: 40,
                                                    height: 40,
                                                    fit: BoxFit.fill,
                                                  )
                                                : currentColor ==
                                                        const Color(0xffEE7502)
                                                    ? Image.asset(
                                                        ImagePath.addOrange,
                                                        // color: currentColor,
                                                        width: 40,
                                                        height: 40,
                                                        fit: BoxFit.fill,
                                                      )
                                                    : Image.asset(
                                                        ImagePath.imagepicker,
                                                        width: 40,
                                                        height: 40,
                                                        fit: BoxFit.fill,
                                                      )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Container(
                                                  height: height * 0.26,
                                                  width: width / 2.5,
                                                  child: Image.file(
                                                    File(
                                                        userSelectedCoverImages3!
                                                            .path),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Cover Picture',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5)
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Note:",
                              style: fontStyle.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                text: " Add At least",
                                style: fontStyle.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Color(
                                      0xff838994,
                                    ),
                                    fontSize: 15),
                                children: [
                                  TextSpan(text: " two ", style: fontStyle),
                                  TextSpan(
                                    text: "photos for continue \nwith us",
                                    style: fontStyle.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Color(
                                          0xff838994,
                                        ),
                                        fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CommonButton(
                            btnName: "Done",
                            btnOnTap: () async {
                              SharedPreferences _prefs =
                                  await SharedPreferences.getInstance();
                              List images = [];
                              if (imageFile != null) {
                                setState(() {
                                  images.add(imageFile);
                                });
                              }
                              if (imageFile1 != null) {
                                setState(() {
                                  images.add(imageFile1);
                                });
                              }
                              if (imageFile2 != null) {
                                setState(() {
                                  images.add(imageFile2);
                                });
                              }
                              if (imageFile3 != null) {
                                setState(() {
                                  images.add(imageFile3);
                                });
                              }

                              if (userSelectedProfileImages != null &&
                                  userSelectedCoverImages1 != null) {
                                _prefs.setBool(SHOWUPLOADIMAGE, true);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDailog();
                                    });
                              } else {
                                Fluttertoast.showToast(
                                    backgroundColor: currentColor,
                                    msg: "add minimum two image to continue.");
                              }
                              ;
                            }),
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DottedBorder imagepicker(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DottedBorder(
      dashPattern: [8, 4],
      strokeWidth: 1,
      strokeCap: StrokeCap.round,
      borderType: BorderType.RRect,
      radius: Radius.circular(5),
      child: Container(
        height: height * 0.25,
        width: width / 2.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Center(child: const Text('Pick Image')),
                    actions: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              _openGallery(context);
                            },
                            child: const Text('Gallery'),
                          ),
                          TextButton(
                            onPressed: () {
                              _openCamera(context);
                            },
                            child: Text('Camera'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              child: (imageFile == null)
                  ? Image.asset(
                      ImagePath.imagepicker,
                      color: currentColor,
                      width: 40,
                      height: 40,
                      fit: BoxFit.fill,
                    )
                  : Container(
                      height: height * 0.25,
                      width: width / 2.5,
                      child: Image.file(
                        File(imageFile!.path),
                        fit: BoxFit.fill,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(
      () {
        imageFile = pickedFile!;
      },
    );

    // Navigator.pop(context);
    return imageFile;
  }

  Future _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile!;
    });
    // Navigator.pop(context);
    return imageFile;
  }

  void setCoverImage(String imageType, PickedFile? image) async {
    // CommonUtils.hideProgressLoading();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userToken = prefs.getString(USER_TOKEN);
    var mobile = prefs.getString(USER_MOBILE);
    log("image uplode start  ========= >>>> ");
    List<MultipartFile> uploadListTest = [];
    for (var i = 0; i < coverImgList.length; i++) {
      uploadListTest.add(await getImageTest(
          coverImgList[i].path, coverImgList[i].path.split('/').last));
    }
    /* FormData formData = FormData.fromMap({
      "image_type_id": imageType,
      "mobile": mobile,
      "image": uploadListTest
    }); */
    FormData formData = FormData.fromMap({
      "image_type_id": imageType,
      "mobile": mobile,
      "image": image != null
          ? MultipartFile.fromFile(image.path,
              filename: image.path.split('/').last)
          : null,
    });
    print(formData);
    try {
      var response = await dio.post(UPLODE_PROFILE + "?token=" + "$userToken",
          data: formData);
      log(response.data.toString());
      print(response.data);
      if (response.statusCode == 200) {
        /// ----------- firebase chat module start -----------
        /* prefs.setString(
          PROFILEIMAGE, response.data["data"]["file_path"].toString());
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore.collection("Users").doc(widget.docId).set({
        "userProfile": response.data["data"]["file_path"],
      }, SetOptions(merge: true)); */

        /// ----------- firebase chat module end -----------
        CommonUtils.hideProgressLoading();
        Navigator.pop(context);
        Fluttertoast.showToast(
          backgroundColor: currentColor,
          msg: "File updated successfully",
          toastLength: Toast.LENGTH_SHORT,
        );
        log(response.data.toString());
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
      } else {
        CommonUtils.hideProgressLoading();
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) {
        CommonUtils.hideProgressLoading();
      } else if (e.response!.statusCode == 404) {
        CommonUtils.hideProgressLoading();
      }
    }
    ;
  }

  Future<MultipartFile> getImageTest(String filePath, String fileName) async {
    return await MultipartFile.fromFile(filePath, filename: fileName);
  }
}
 */