import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/get_userImage_model.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/Drawer_Screen.dart';
import 'package:matrimonial_app/Utils/app_helper.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/submit_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileCoverUploadImageScreen extends StatefulWidget {
  const ProfileCoverUploadImageScreen({Key? key}) : super(key: key);

  @override
  State<ProfileCoverUploadImageScreen> createState() =>
      _ProfileCoverUploadImageScreenState();
}

class _ProfileCoverUploadImageScreenState
    extends State<ProfileCoverUploadImageScreen> {
  GetUserImageModel? _getUserImageModel;
  File? userSelectedProfileImages;
  List<PickedFile> coverImgList = [];
  List<String> coverImgPathList = [];
  List<bool> isSelectCover = [false];
  /* File? userSelectedProfileImages1;
  File? userSelectedProfileImages2;
  File? userSelectedCoverImages1;
  File? userSelectedCoverImages2;
  File? userSelectedCoverImages3;
  File? userSelectedCoverImages4; */

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  _getImageFrom({
    required ImageSource source,
    required bool isCover,
    required int isCoverSequence,
    required int isProfileSequence,
  }) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? _pickedImage =
        await _picker.pickImage(source: source, imageQuality: 85);
    if (_pickedImage != null) {
      CommonUtils.showProgressLoading(context);
      try {
        if (_pickedImage != null) {
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
              if (isCoverSequence == 0) {
                userSelectedProfileImages = _croppedImage;
                setCoverImage("2", PickedFile(userSelectedProfileImages!.path));
              }
            }
          });
        }
      } catch (e) {
        CommonUtils.hideProgressLoading();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      elevation: 0,
      insetPadding: EdgeInsets.only(left: 20, right: 20),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Upload Cover Images'),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.transparent,
              child: Icon(
                Icons.close,
                size: 28,
              ),
            ),
          )
        ],
      ),
      content: Container(
        height: 110,
        // color: Colors.redAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* Text('Profile Picture',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            _getUserImageModel != null &&
                    _getUserImageModel!.data != null &&
                    _getUserImageModel!.data!.profileImage!.isNotEmpty
                ? Container(
                    height: 95,
                    width: 95,
                    // width: width,
                    child: _getUserImageModel != null &&
                            _getUserImageModel!.data != null &&
                            _getUserImageModel!
                                .data!.profileImage!.isNotEmpty &&
                            _getUserImageModel!
                                .data!.profileImage![0].image!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              _getUserImageModel!.data!.profileImage![0].image
                                  .toString(),
                              /* height: 95,
                        width: 95, */
                              fit: BoxFit.cover,
                              // width: 100,
                            ),
                          )
                        : Container(
                            /* height: 95,
                        width: 95, */

                            ),
                    /* Row(
                children: [
                  DottedBorder(
                    color: userSelectedProfileImages1 == null
                        ? Colors.black
                        : Colors.transparent,
                    dashPattern: [8, 4],
                    strokeWidth: 1,
                    strokeCap: StrokeCap.round,
                    borderType: BorderType.RRect,
                    radius: Radius.circular(5),
                    child: Row(
                      children: [
                        Container(
                          height: 90,
                          width: 90,
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
                                          child: const Text('Pick Image')),
                                      actions: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                              onPressed: () async {
                                                /* profileImage =
                                                                      await _openGallery(
                                                                          context); */
                                                Navigator.of(context).pop();
                                                await _getImageFrom(
                                                    source: ImageSource.gallery,
                                                    isCover: false,
                                                    isCoverSequence: 0,
                                                    isProfileSequence: 1);
                                              },
                                              child: const Text('Gallery'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                Navigator.of(context).pop();
                                                await _getImageFrom(
                                                    source: ImageSource.camera,
                                                    isCover: false,
                                                    isCoverSequence: 0,
                                                    isProfileSequence: 1);
                                              },
                                              child: Text('Camera'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: (userSelectedProfileImages1 == null)
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
                                                width: 30,
                                                height: 30,
                                                fit: BoxFit.fill,
                                              )
                                            : Image.asset(
                                                ImagePath.imagepicker,
                                                width: 30,
                                                height: 30,
                                                fit: BoxFit.fill,
                                              )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Container(
                                          height: 90,
                                          width: 100,
                                          child: Image.file(
                                            File(userSelectedProfileImages1!
                                                .path),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                              )
                            ],
                          ),
                        ),
                        // SizedBox(width: 8),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                ],
              ), */

                    /* ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                // padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return 
                  Row(
                    children: [
                      DottedBorder(
                        color: userSelectedProfileImages1 == null
                            ? Colors.black
                            : Colors.transparent,
                        dashPattern: [8, 4],
                        strokeWidth: 1,
                        strokeCap: StrokeCap.round,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(5),
                        child: Row(
                          children: [
                            Container(
                              height: 90,
                              width: 90,
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
                                              child: const Text('Pick Image')),
                                          actions: <Widget>[
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                TextButton(
                                                  onPressed: () async {
                                                    /* profileImage =
                                                                      await _openGallery(
                                                                          context); */
                                                    Navigator.of(context).pop();
                                                    await _getImageFrom(
                                                        source:
                                                            ImageSource.gallery,
                                                        isCover: false,
                                                        isCoverSequence: 0,
                                                        isProfileSequence: 1);
                                                  },
                                                  child: const Text('Gallery'),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();
                                                    await _getImageFrom(
                                                        source:
                                                            ImageSource.camera,
                                                        isCover: false,
                                                        isCoverSequence: 0,
                                                        isProfileSequence: 1);
                                                  },
                                                  child: Text('Camera'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: (userSelectedProfileImages1 == null)
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
                                                    width: 30,
                                                    height: 30,
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.asset(
                                                    ImagePath.imagepicker,
                                                    width: 30,
                                                    height: 30,
                                                    fit: BoxFit.fill,
                                                  )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Container(
                                              height: 90,
                                              width: 100,
                                              child: Image.file(
                                                File(userSelectedProfileImages1!
                                                    .path),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                  )
                                ],
                              ),
                            ),
                            // SizedBox(width: 8),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  );
                },
              ), */
                  )
                : Center(
                    child: Text("No Profile Image"),
                  ),
            SizedBox(height: 8), */
            /*  Text('Cover Picture',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8), */
            Row(
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
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  await _getImageFrom(
                                    source: ImageSource.gallery,
                                    isCover: true,
                                    isCoverSequence: 0,
                                    isProfileSequence: 1,
                                  );
                                },
                                child: const Text('Gallery'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  await _getImageFrom(
                                    source: ImageSource.camera,
                                    isCover: true,
                                    isCoverSequence: 0,
                                    isProfileSequence: 1,
                                  );
                                  /* if (userSelectedProfileImages != null) {
                                    setCoverImage(
                                        "2",
                                        PickedFile(
                                            userSelectedProfileImages!.path));
                                  } */
                                },
                                child: Text('Camera'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                      child: currentColor == Color(0xff6398FC)
                          ? Image.asset(
                              ImagePath.addBlue,
                              // color: currentColor,
                              width: 40,
                              height: 40,
                              fit: BoxFit.fill,
                            )
                          : currentColor == const Color(0xffEE7502)
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
                                )),
                ),
                SizedBox(
                  width: 10,
                ),
                _getUserImageModel != null &&
                        _getUserImageModel!.data != null &&
                        _getUserImageModel!.data!.coverImage!.isNotEmpty
                    ? Container(
                        height: 104,
                        width: width / 1.63,
                        // color: Colors.amber,
                        child: ListView.builder(
                          reverse: false,
                          itemCount: _getUserImageModel != null &&
                                  _getUserImageModel!.data != null &&
                                  _getUserImageModel!.data!.coverImage!
                                      .isNotEmpty /* &&
                          _getUserImageModel!.data!.coverImage!.length != 0 */
                              ? _getUserImageModel!.data!.coverImage!.length
                              : 0,
                          shrinkWrap: true,
                          // padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return DottedBorder(
                              color: _getUserImageModel!
                                          .data!.coverImage![index].image ==
                                      null
                                  ? Colors.black
                                  : Colors.transparent,
                              dashPattern: [8, 4],
                              strokeWidth: 1,
                              strokeCap: StrokeCap.round,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(5),
                              child: Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 97,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                isSelectCover[index] = true;
                                              });
                                              /* for (var i = 0;
                                                  i <
                                                      _getUserImageModel!
                                                          .data!
                                                          .coverImage![index]
                                                          .image!
                                                          .length;
                                                  i++) {
                                                if (_getUserImageModel!
                                                        .data!
                                                        .coverImage![index]
                                                        .imageId ==
                                                    _getUserImageModel!
                                                        .data!
                                                        .coverImage![i]
                                                        .imageId) {
                                                          
                                                        }
                                              } */

                                              log(isSelectCover[index]
                                                  .toString());
                                              /* selectCoverImageAPI(
                                                  _getUserImageModel!
                                                      .data!
                                                      .coverImage![index]
                                                      .image); */
                                              setCoverImageDefaultAPI(index);
                                              log("isSelectCoverImageId:::::${_getUserImageModel!.data!.coverImage![index].imageId.toString()}");
                                            },
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        _getUserImageModel!
                                                            .data!
                                                            .coverImage![index]
                                                            .image
                                                            .toString(),
                                                      ),
                                                      fit: BoxFit.cover),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: (_getUserImageModel!
                                                                  .data!
                                                                  .coverImage![
                                                                      index]
                                                                  .image !=
                                                              null &&
                                                          _getUserImageModel!
                                                                  .data!
                                                                  .coverImage![
                                                                      index]
                                                                  .status ==
                                                              1)
                                                      ? Border.all(
                                                          color: currentColor,
                                                          width: 2)
                                                      : Border.all(
                                                          color: Colors
                                                              .transparent)),
                                              child: isSelectCover[index]
                                                  ? Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 20,
                                                          width: 20,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  currentColor),
                                                          child: Icon(
                                                            Icons.check,
                                                            color: Colors.white,
                                                            size: 17,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Container(),
                                              /* child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    child: (_getUserImageModel!
                                                                .data!
                                                                .coverImage![
                                                                    index]
                                                                .image !=
                                                            null)
                                                        ? Image.network(
                                                            _getUserImageModel!
                                                                .data!
                                                                .coverImage![
                                                                    index]
                                                                .image
                                                                .toString(),
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Container(),
                                                  ),
                                                ) */
                                            ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  // SizedBox(width: 8),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Text("No Cover Image"),
                      ),
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
          child: CommonButton(
            btnName: "Upload",
            btnOnTap: () {
              /* if (isSelectCover) {
                Fluttertoast.showToast(
                  backgroundColor: currentColor,
                  msg: "Set cover image successfully",
                  toastLength: Toast.LENGTH_SHORT,
                );
                Navigator.of(context).pushAndRemoveUntil(
                    CupertinoPageRoute(
                        builder: (context) => Zoom(
                              selectedIndex: 4,
                            )),
                    (route) => false);
              } else { */
              Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(
                      builder: (context) => Zoom(
                            selectedIndex: 4,
                          )),
                  (route) => false);
              // }
            },
          ),
        ),
      ],
    );
  }

  checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getUserWiseImageAPI();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getUserWiseImageAPI();
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

  Future<MultipartFile> getImageTest(String filePath, String fileName) async {
    return await MultipartFile.fromFile(filePath, filename: fileName);
  }

  void setCoverImage(String imageType, PickedFile? image) async {
    Dio dio = Dio();
    // CommonUtils.hideProgressLoading();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userToken = prefs.getString(USER_TOKEN);
    var mobile = prefs.getString(USER_MOBILE);
    // CommonUtils.showProgressLoading(context);
    log("image uplode start  ========= >>>> ");
    List<MultipartFile> uploadListTest = [];
    for (var i = 0; i < coverImgList.length; i++) {
      uploadListTest.add(await getImageTest(
          coverImgList[i].path, coverImgList[i].path.split('/').last));
    }
    FormData formData = FormData.fromMap({
      "image_type_id": imageType,
      "mobile": mobile,
      "image": image != null
          ? await MultipartFile.fromFile(image.path,
              filename: image.path.split('/').last)
          : null,
    });
    print("set coverImage + ${formData}");
    try {
      var response = await dio.post(UPLODE_PROFILE + "?token=" + "$userToken",
          data: formData);
      log(response.data.toString());
      print("${response.data}");
      if (response.statusCode == 200) {
        CommonUtils.hideProgressLoading();

        Fluttertoast.showToast(
          backgroundColor: currentColor,
          msg: "File updated successfully",
          toastLength: Toast.LENGTH_SHORT,
        );
        getUserWiseImageAPI();
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
  }

  /* selectCoverImageAPI(String? image) async {
    Dio dio = Dio();
    // CommonUtils.hideProgressLoading();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userToken = prefs.getString(USER_TOKEN);
    var mobile = prefs.getString(USER_MOBILE);
    FormData formData = FormData.fromMap({
      "image_type": 'old',
      "mobile": mobile,
      "image": image,
    });
    print(formData);
    try {
      var response = await dio.post(UPLODE_PROFILE + "?token=" + "$userToken",
          data: formData);
      log(response.data.toString());
      print(response.data);
      if (response.statusCode == 200) {
        CommonUtils.hideProgressLoading();

        getUserWiseImageAPI();
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
  } */

  getUserWiseImageAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(USER_TOKEN);
    final queryParameters = {
      "token": authToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response =
        await http.get(Uri.parse(GET_USER_IMAGE + "?" + queryString));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _getUserImageModel = GetUserImageModel.fromJson(data);
      });
      for (var i = 0; i < _getUserImageModel!.data!.coverImage!.length; i++) {
        isSelectCover.add(false);
      }
      log("GetUserImage response ::::::::${response.body}");
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

  setCoverImageDefaultAPI(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(USER_TOKEN);
    final queryParameters = {
      "token": authToken.toString(),
    };
    var params = {
      "image_id":
          _getUserImageModel!.data!.coverImage![index].imageId.toString()
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await http.post(
        Uri.parse(
          SET_DEFAULT_COVERIMAGE + "?" + queryString,
        ),
        body: params);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        // _getUserImageModel = GetUserImageModel.fromJson(data);
      });
      for (var i = 0; i < _getUserImageModel!.data!.coverImage!.length; i++) {
        isSelectCover.add(false);
      }
      log("GetUserImage response ::::::::${response.body}");
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
