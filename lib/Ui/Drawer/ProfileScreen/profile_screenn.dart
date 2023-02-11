import 'dart:convert';
import 'dart:developer';

import 'dart:io';
import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:countup/countup.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/Skeleton_Loader.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Get_Profile_Data_Model.dart'
    as ProfileData;
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/Religion_model.dart'
    as religion;
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Update_AboutMe_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/age_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/myselfabout_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/qualification_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/updateMyself_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/uploadimage_modal.dart'
    as uploadImage;
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/user_profile_about_model.dart'
    as aboutMe;
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Drawer/ProfileScreen/upload_image_screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/Drawer_Screen.dart';
import 'package:matrimonial_app/Ui/Login/login_screen.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/basic_detail.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/career_education.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/contact.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/famliy_detail.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/hobbies_detail.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/location.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/looking_for.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/app_helper.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/Utils/value_constant.dart';
import 'package:matrimonial_app/widget/commondivider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  String? fromValue;
  Profile({Key? key, this.fromValue}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

List<String> genderdropdown = [AppConstants.girl, AppConstants.boy];
String? dropdowngender;

final List<String> _selectedItems = [];
ProfileData.GetAllProfileDataModel? _getAllProfileDataModel;

aboutMe.UserAboutMeModel? _userAboutMeModel;
bool isEditable = false;
AgeModel? _ageModel;
int _selectedPage = 0;
int currentPage = 0;
String checkGender = "";
Data? _data;
  String capitalizeWords(String text) {
    List<String> words = text.split(' ');
    for (int i = 0; i < words.length; i++) {
      words[i] = words[i][0].toUpperCase() + words[i].substring(1);
    }
    return words.join(' ');
  }

class _ProfileState extends State<Profile> {
  File? userSelectedCoverImages;
  File? userSelectedProfileImages;
  bool isShowLoading = false;

  Dio dio = Dio();

  QualificationModel? _qualificationModel;

  String? profilecomplete;
  mySelfAboutModel? _myselfAboutModel;
  UpdateAboutMeModel? _updateAboutMeModel;

  bool isTextFieldEnable = true;
  List<String> addLanguage = [];
  List<String> _selectedItems = [];

  bool isSelfOneLine = false;
  bool isSelf = false;
  String _selfOneLine = '';
  String _self = '';

  void _showMultiSelect() async {
    final List<String> _items = [
      'Gujarati',
      'Hindi',
      'English',
      'German',
      'Romanian',
      'Spanish',
      'Italian',
      'Korean',
      'French',
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: _items);
      },
    );

    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
  }



  final _picker = ImagePicker();
  PickedFile? imageFile;
  File? fileImage;
  PickedFile? coverImage;

  _getImageFrom({required ImageSource source, required bool isCover}) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? _pickedImage = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );
    // CommonUtils.showProgressLoading(context);
    if (_pickedImage != null) {
      CommonUtils.hideProgressLoading();
      var image = File(_pickedImage.path.toString());
      final _sizeInKbBefore = image.lengthSync() / 1024;
      print('Before Compress $_sizeInKbBefore kb');
      var _compressedImage = await AppHelper.compress(image: image);
      final _sizeInKbAfter = _compressedImage.lengthSync() / 1024;
      print('After Compress $_sizeInKbAfter kb');
      var _croppedImage = await AppHelper.cropImage(_compressedImage, isCover);
      if (_croppedImage == null) {
        return;
      }
      setState(() {
        if (isCover == true) {
          userSelectedCoverImages = _croppedImage;
        } else {
          userSelectedProfileImages = _croppedImage;
        }
      });
    } else{
      CommonUtils.hideProgressLoading();
    }
  }

  final _formkey = GlobalKey<FormState>();
  PickedFile? profileImage;
  String dropdownValue = 'English';
  String dropdownValue1 = 'Girl';
  var TabHeightString = "Aboutme";
  var TabbarHeight = 0;
  String dropdown = AppConstants.hindi;
  String? image;
  TextEditingController mySelfOne = TextEditingController();
  TextEditingController mySelf = TextEditingController();
  FocusNode focusmySelfOne = FocusNode();
  FocusNode focusmySelf = FocusNode();

  List<String> droplanguage = [AppConstants.hindi, AppConstants.english];
  String? dropdownlanguage;

  List<String> married = [AppConstants.nevermarried, AppConstants.married];
  String? marrieddropdown;
  List<Map<String, dynamic>> language = [
    {
      NAME: AppConstants.hindilan,
    },
    {
      NAME: AppConstants.english,
    },
  ];

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: (isShowLoading)
          ? SkeletonLoader()
          : SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 410,
                            child: Stack(
                              children: [
                                (userSelectedCoverImages == null)
                                    ? _userAboutMeModel != null &&
                                            _userAboutMeModel!.data != null &&
                                            _userAboutMeModel!
                                                    .data!.coverImage!.length >
                                                0
                                        ? Container(
                                            width: width,
                                            child: CarouselSlider.builder(
                                              itemCount: 1,
                                              options: CarouselOptions(
                                                  height: 410,
                                                  autoPlay: true,
                                                  pauseAutoPlayInFiniteScroll:
                                                      true,
                                                  enableInfiniteScroll: false,
                                                  viewportFraction: 1.0,
                                                  onPageChanged:
                                                      (index, reason) {
                                                    setState(() {
                                                      currentPage = index;
                                                    });
                                                  }),
                                              itemBuilder: (BuildContext
                                                          context,
                                                      int index,
                                                      int pageViewIndex) =>
                                                  CachedNetworkImage(
                                                      width: width,
                                                      imageUrl:
                                                          _userAboutMeModel!
                                                              .data!
                                                              .coverImage![0]
                                                              .filePath
                                                              .toString(),
                                                      fit: BoxFit.cover),
                                            ),
                                          )
                                        : (_getAllProfileDataModel != null &&
                                                _getAllProfileDataModel!.data!
                                                        .basicInfo!.gender ==
                                                    "Male")
                                            ? Image.asset(
                                                ImagePath.profileBackground,
                                                width: width,
                                                fit: BoxFit.fitHeight)
                                            : Image.asset(
                                                ImagePath.femaleProfileUser,
                                                width: width,
                                                fit: BoxFit.fitHeight)
                                    : Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Image.file(
                                            File(userSelectedCoverImages!.path),
                                            fit: BoxFit.fill),
                                      ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          widget.fromValue == "Drawer"
                                              ? GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                    ),
                                                    height: 30,
                                                    width: 30,
                                                    child: Image.asset(
                                                      ImagePath.leftArrow,
                                                      height: 28,
                                                      width: 28,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Zoom(),
                                                            ),
                                                            (route) => false);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                    ),
                                                    height: 30,
                                                    width: 30,
                                                    child: Image.asset(
                                                      ImagePath.leftArrow,
                                                      height: 28,
                                                      width: 28,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                          Spacer(),
                                          Text(
                                            "profile".tr,
                                            style: homestyle.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20),
                                          ),
                                          SizedBox(width: 35),
                                          Spacer(),
                                        ],
                                      ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog<String>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        StatefulBuilder(
                                                          builder: (BuildContext
                                                                  context,
                                                              void Function(
                                                                      void
                                                                          Function())
                                                                  setState) {
                                                            return ProfileCoverUploadImageScreen();
                                                          },
                                                        ));
                                          },
                                          child: Container(
                                            height: 26,
                                            width: 86,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: Color(0xff333F52)
                                                    .withOpacity(.58)),
                                            child: Center(
                                              child: Text(
                                                "edit image".tr,
                                                style: headerstyle.copyWith(
                                                  color: Color(0xffFFFFFF),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 360),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            Column(
                                              children: [
                                                CircularPercentIndicator(
                                                  backgroundColor:
                                                      Color(0xffEAEAEA),
                                                  animation: true,
                                                  animationDuration: 2000,
                                                  // animationDuration: 5,
                                                  radius: 55.0,
                                                  lineWidth: 6.0,
                                                  percent: _getAllProfileDataModel != null &&
                                                          _getAllProfileDataModel!
                                                                  .data !=
                                                              null &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .profile !=
                                                              null
                                                      ? double.parse(
                                                              _getAllProfileDataModel!
                                                                  .data!
                                                                  .profile!
                                                                  .profileCompletion
                                                                  .toString()) /
                                                          100
                                                      : 0.2,
                                                  startAngle: 150.0,
                                                  center: userSelectedProfileImages ==
                                                          null
                                                      ? _userAboutMeModel != null &&
                                                              _userAboutMeModel!
                                                                      .data !=
                                                                  null &&
                                                              _userAboutMeModel!
                                                                      .data!
                                                                      .profileImage!
                                                                      .length >
                                                                  0
                                                          ? _userAboutMeModel!
                                                                      .data!
                                                                      .blurImage ==
                                                                  1
                                                              ? Blur(
                                                                  blur: 1,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  child:
                                                                      CircleAvatar(
                                                                    radius: 45,
                                                                    backgroundImage:
                                                                        CachedNetworkImageProvider(
                                                                      _userAboutMeModel!
                                                                          .data!
                                                                          .profileImage![
                                                                              0]
                                                                          .filePath
                                                                          .toString(),
                                                                    ),
                                                                  ))
                                                              : CircleAvatar(
                                                                  radius: 45,
                                                                  backgroundImage:
                                                                      CachedNetworkImageProvider(
                                                                    _userAboutMeModel!
                                                                        .data!
                                                                        .profileImage![
                                                                            0]
                                                                        .filePath
                                                                        .toString(),
                                                                  ),
                                                                )
                                                          : (_getAllProfileDataModel !=
                                                                      null &&
                                                                  _getAllProfileDataModel!
                                                                          .data !=
                                                                      null &&
                                                                  _getAllProfileDataModel!
                                                                          .data!
                                                                          .basicInfo!
                                                                          .gender ==
                                                                      "Male")
                                                              ? CircleAvatar(
                                                                  radius: 45,
                                                                  child: Image.asset(
                                                                      ImagePath
                                                                          .profile),
                                                                )
                                                              : CircleAvatar(
                                                                  radius: 45,
                                                                  child: Image.asset(
                                                                      ImagePath
                                                                          .femaleProfileUser),
                                                                )
                                                      : CircleAvatar(
                                                          radius: 45,
                                                          backgroundImage:
                                                              FileImage(
                                                            File(
                                                                userSelectedProfileImages!
                                                                    .path),
                                                          ),
                                                        ),
                                                  progressColor: currentColor,
                                                  animateFromLastPercent: true,
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                ),
                                              ],
                                            ),
                                            Positioned(
                                              bottom: -6,
                                              left: 70,
                                              child: GestureDetector(
                                                onTap: () {
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
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
                                                              onPressed:
                                                                  () async {
                                                                /* profileImage =
                                                              await _openGallery(
                                                                  context); */
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                await _getImageFrom(
                                                                    source: ImageSource
                                                                        .gallery,
                                                                    isCover:
                                                                        false);
                                                                if (userSelectedProfileImages !=
                                                                    null) {
                                                                  await setProfileUpdateAPI(
                                                                      "1",
                                                                      PickedFile(
                                                                          userSelectedProfileImages!
                                                                              .path));
                                                                } else {}

                                                                /*   setProfileUpdateAPI(
                                                              "1", profileImage); */
                                                              },
                                                              child: const Text(
                                                                  'Gallery'),
                                                            ),
                                                            TextButton(
                                                              onPressed:
                                                                  () async {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                await _getImageFrom(
                                                                    source: ImageSource
                                                                        .camera,
                                                                    isCover:
                                                                        false);
                                                                if (userSelectedProfileImages !=
                                                                    null) {
                                                                  setProfileUpdateAPI(
                                                                      "1",
                                                                      PickedFile(
                                                                          userSelectedProfileImages!
                                                                              .path));
                                                                } else {}
                                                              },
                                                              child: Text(
                                                                  'Camera'),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  child: Image.asset(
                                                    ImagePath.editprofile,
                                                    width: 35,
                                                    height: 35,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 60.0, left: 5, right: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _userAboutMeModel != null &&
                                                  _userAboutMeModel!.data !=
                                                      null
                                              ? _userAboutMeModel!
                                                  .data!.fullName
                                                  .toString()
                                              : AppConstants.elonMusk,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: homestyle.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "completion".tr,
                                                style: fontStyle.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              ),
                                              Row(
                                                children: [
                                                  Countup(
                                                    begin: 0,
                                                    end: _getAllProfileDataModel != null &&
                                                            _getAllProfileDataModel!
                                                                    .data !=
                                                                null &&
                                                            _getAllProfileDataModel!
                                                                    .data!
                                                                    .profile !=
                                                                null
                                                        ? double.parse(
                                                            _getAllProfileDataModel!
                                                                .data!
                                                                .profile!
                                                                .profileCompletion
                                                                .toString())
                                                        : 0.0,
                                                    duration:
                                                        Duration(seconds: 2),
                                                    separator: ',',
                                                    suffix: "%",
                                                    style: TextStyle(
                                                        color: currentColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(" now.".tr),
                                                  InkWell(
                                                    onTap: () async {
                                                      String? valueData;
                                                      final result =
                                                          await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              Basic_Detail(),
                                                        ),
                                                      );
                                                      setState(() {
                                                        valueData = result;
                                                      });
                                                      log(valueData.toString());
                                                      if (valueData ==
                                                          "BasicDetail") {
                                                        getProfileData();
                                                        getProfileAboutMe();
                                                      }
                                                    },
                                                    child: Text(
                                                        _getAllProfileDataModel !=
                                                                    null &&
                                                                _getAllProfileDataModel!
                                                                    .data!
                                                                    .profile!
                                                                    .profileCompletion!
                                                                    .isNotEmpty
                                                            ? _getAllProfileDataModel!
                                                                        .data!
                                                                        .profile!
                                                                        .profileCompletion
                                                                        .toString() ==
                                                                    "100"
                                                                ? " Edit Here"
                                                                : "completenow"
                                                                    .tr
                                                            : "",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff12A2AB),
                                                            fontSize: 13,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline)),
                                                  )
                                                ],
                                              ),
                                              /* Container(
                                                child: RichText(
                                                  text: TextSpan(
                                                      text: "completion".tr,
                                                      style: fontStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15),
                                                      children: [
                                                        TextSpan(text: ' \n'),
                
                                                        /* TextSpan(
                                                            text: 
                                                            _getAllProfileDataModel != null &&
                                                                    _getAllProfileDataModel!
                                                                            .data !=
                                                                        null &&
                                                                    _getAllProfileDataModel!
                                                                            .data!
                                                                            .profile !=
                                                                        null
                                                                ? _getAllProfileDataModel!
                                                                        .data!
                                                                        .profile!
                                                                        .profileCompletion
                                                                        .toString() +
                                                                    "%"
                                                                : '0 ' + '% ',
                                                            style: TextStyle(
                                                                color:
                                                                    currentColor,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)), */
                                                        TextSpan(
                                                            text: " now.".tr),
                                                        TextSpan(
                                                            recognizer:
                                                                TapGestureRecognizer()
                                                                  ..onTap =
                                                                      () async {
                                                                    double? abc;
                                                                    abc = double.parse(_getAllProfileDataModel!
                                                                            .data!
                                                                            .profile!
                                                                            .profileCompletion
                                                                            .toString()) /
                                                                        100;
                                                                    print(
                                                                        "percent ::: $abc");
                                                                    /*  String?
                                                                        valueData;
                                                                    final result =
                                                                        await Navigator
                                                                            .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                Basic_Detail(),
                                                                      ),
                                                                    );
                                                                    setState(() {
                                                                      valueData =
                                                                          result;
                                                                    });
                                                                    log(valueData
                                                                        .toString());
                                                                    if (valueData ==
                                                                        "BasicDetail") {
                                                                      getProfileData();
                                                                      getProfileAboutMe();
                                                                    } */
                                                                  },
                                                            text: _getAllProfileDataModel !=
                                                                        null &&
                                                                    _getAllProfileDataModel!
                                                                        .data!
                                                                        .profile!
                                                                        .profileCompletion!
                                                                        .isNotEmpty
                                                                ? _getAllProfileDataModel!
                                                                            .data!
                                                                            .profile!
                                                                            .profileCompletion
                                                                            .toString() ==
                                                                        "100"
                                                                    ? " Edit Here"
                                                                    : "completenow"
                                                                        .tr
                                                                : "",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff12A2AB),
                                                                fontSize: 13,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline))
                                                      ]),
                                                ),
                                              ), */
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (() {
                                  setState(() {
                                    _openFacebook();
                                  });
                                }),
                                child: Container(
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        ImagePath.profileFacebookNew,
                                        width: 28,
                                        height: 22,
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      _fbconnectbutton()
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (() {
                                  setState(() {
                                    _launchInstagram();
                                  });
                                }),
                                child: Container(
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        ImagePath.profileInstaNew,
                                        width: 28,
                                        height: 22,
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      _instaconnectbutton()
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (() {
                                  setState(() {
                                    openTwitter();
                                  });
                                }),
                                child: Container(
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        ImagePath.profiletwitter,
                                        width: 28,
                                        height: 22,
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      _twitterconnectbutton()
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Common_divider(),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  (_getAllProfileDataModel != null &&
                                          _getAllProfileDataModel!
                                                  .data !=
                                              null &&
                                          _getAllProfileDataModel!
                                                  .data!.basicInfo !=
                                              null &&
                                          _getAllProfileDataModel!
                                                  .data!.basicInfo!.createdBy ==
                                              "Myself")
                                      /*   (_getAllProfileDataModel != null &&
                                              _getAllProfileDataModel!.data !=
                                                  null &&
                                              _getAllProfileDataModel!.data!.basicInfo !=
                                                  null &&
                                              _getAllProfileDataModel!
                                                      .data!.basicInfo!.gender ==
                                                  "Male" &&
                                              _getAllProfileDataModel!.data!
                                                      .basicInfo!.createdBy ==
                                                  "Myself") ||
                                          (_getAllProfileDataModel != null &&
                                              _getAllProfileDataModel!.data !=
                                                  null &&
                                              _getAllProfileDataModel!.data!.basicInfo !=
                                                  null &&
                                              _getAllProfileDataModel!
                                                      .data!.basicInfo!.gender ==
                                                  "Female" &&
                                              _getAllProfileDataModel!.data!
                                                      .basicInfo!.createdBy ==
                                                  "Myself") */
                                      ? Text(
                                          "aboutmeoneline".tr,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : (_getAllProfileDataModel !=
                                                  null &&
                                              _getAllProfileDataModel!
                                                      .data !=
                                                  null &&
                                              _getAllProfileDataModel!
                                                      .data!.basicInfo !=
                                                  null &&
                                              _getAllProfileDataModel!.data!
                                                      .basicInfo!.gender ==
                                                  "Female")
                                          ? Text(
                                              "Aboutherinoneline".tr,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              "Abouthiminoneline".tr,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                  (isSelfOneLine == true)
                                      ? GestureDetector(
                                          onTap: () {
                                            // if (_formkey.currentState!
                                            //     .validate()) {
                                            updateAboutMe();
                                            isSelfOneLine = false;
                                            setState(() {});
                                            // }
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                gradient: AppColors.appColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Save',
                                              style: appBtnStyle.copyWith(
                                                  fontSize: 14),
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            focusmySelfOne.requestFocus();
                                            setState(() {
                                              isSelfOneLine = true;
                                              if (isSelfOneLine == true) {
                                                mySelfOne
                                                    .text = _myselfAboutModel!
                                                            .data!
                                                            .myselfoneline ==
                                                        null
                                                    ? ""
                                                    : _myselfAboutModel!
                                                        .data!.myselfoneline
                                                        .toString();
                                              } else {}
                                            });
                                          },
                                          child: Image.asset(
                                            ImagePath.editprofile,
                                            width: 30,
                                            height: 30,
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(height: 10),
                              isSelfOneLine == true
                                  ? TextFormField(
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      controller: mySelfOne,
                                      focusNode: focusmySelfOne,
                                      maxLines: 3,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(350),
                                      ],
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      )),
                                      onFieldSubmitted: (value) {
                                        _selfOneLine = value;
                                        print(value);
                                        setState(() {
                                          _myselfAboutModel!
                                              .data!.myselfoneline = value;
                                        });
                                        setState(() {
                                          updateAboutMe();
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.length == 350) {
                                          return 'You can add maximum 350 characters only';
                                        }
                                      },
                                      onChanged: (value) {
                                        if (_formkey.currentState!.validate()) ;
                                      },
                                    )
                                  : Text(
                                      _myselfAboutModel != null &&
                                              _myselfAboutModel!.data != null
                                          ? (_myselfAboutModel!
                                                      .data!.myselfoneline ==
                                                  null)
                                              ? "No Data"
                                              : _myselfAboutModel!
                                                  .data!.myselfoneline
                                                  .toString()
                                          : "",
                                      style: description1,
                                    ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 5),
                        child: Divider(
                          thickness: 2,
                          color: Color(0xffEDF1F5),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 5),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  /* (_getAllProfileDataModel != null &&
                                              _getAllProfileDataModel!.data !=
                                                  null &&
                                              _getAllProfileDataModel!.data!.basicInfo !=
                                                  null &&
                                              _getAllProfileDataModel!
                                                      .data!.basicInfo!.gender ==
                                                  "Male" &&
                                              _getAllProfileDataModel!.data!
                                                      .basicInfo!.createdBy ==
                                                  "Myself") ||
                                          (_getAllProfileDataModel != null &&
                                              _getAllProfileDataModel!.data !=
                                                  null &&
                                              _getAllProfileDataModel!.data!.basicInfo !=
                                                  null &&
                                              _getAllProfileDataModel!
                                                      .data!.basicInfo!.gender ==
                                                  "Female" &&
                                              _getAllProfileDataModel!.data!
                                                      .basicInfo!.createdBy ==
                                                  "Myself") */
                                  (_getAllProfileDataModel != null &&
                                          _getAllProfileDataModel!
                                                  .data !=
                                              null &&
                                          _getAllProfileDataModel!
                                                  .data!.basicInfo !=
                                              null &&
                                          _getAllProfileDataModel!
                                                  .data!.basicInfo!.createdBy ==
                                              "Myself")
                                      ? Text(
                                          "aboutme".tr,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : (_getAllProfileDataModel !=
                                                  null &&
                                              _getAllProfileDataModel!
                                                      .data !=
                                                  null &&
                                              _getAllProfileDataModel!
                                                      .data!.basicInfo !=
                                                  null &&
                                              _getAllProfileDataModel!.data!
                                                      .basicInfo!.gender ==
                                                  "Female")
                                          ? Text(
                                              "abouther".tr,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              "abouthim".tr,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                  (isSelf == true)
                                      ? GestureDetector(
                                          onTap: () {
                                            updateAboutMe();
                                            isSelf = false;
                                            setState(() {});
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                gradient: AppColors.appColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Save',
                                              style: appBtnStyle.copyWith(
                                                  fontSize: 14),
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            focusmySelf.requestFocus();
                                            setState(() {
                                              isSelf = true;
                                              if (isSelf == true) {
                                                mySelf.text = _myselfAboutModel!
                                                            .data!.myself ==
                                                        null
                                                    ? ""
                                                    : _myselfAboutModel!
                                                        .data!.myself
                                                        .toString();
                                              }
                                            });
                                          },
                                          child: Image.asset(
                                            ImagePath.editprofile,
                                            width: 30,
                                            height: 30,
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              isSelf == true
                                  ? TextFormField(
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      controller: mySelf,
                                      focusNode: focusmySelf,
                                      maxLines: 3,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(350),
                                      ],
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      )),
                                      onFieldSubmitted: (value) {
                                        _self = value;
                                        print(value);
                                        setState(() {
                                          updateAboutMe();
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.length == 350) {
                                          return 'You can add maximum 350 characters only';
                                        }
                                      },
                                      onChanged: (value) {
                                        if (_formkey.currentState!.validate()) ;
                                      },
                                    )
                                  : Text(
                                      _myselfAboutModel != null &&
                                              _myselfAboutModel!.data != null
                                          ? (_myselfAboutModel!.data!.myself ==
                                                  null)
                                              ? "No Data"
                                              : _myselfAboutModel!.data!.myself
                                                  .toString()
                                          : "",
                                      style: description1,
                                    )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: width,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 6.0, right: 6, top: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        "basicdetail".tr,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        String? data;
                                        final value = await Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                Basic_Detail(fromValue: "Edit"),
                                          ),
                                        );
                                        setState(() {
                                          data = value;
                                        });
                                        if (data == "UpdateData") {
                                          getProfileData();
                                        }
                                        log("update data ------------- $data");
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Image.asset(
                                          ImagePath.editprofile,
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 8.0, right: 8, top: 5),
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.only(bottom: 10, top: 10),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "firstname".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            // color:Colors.blue,
                                            width: width / 2 - 10,
                                            child: ReadMoreText(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .firstname !=
                                                              null &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .firstname !=
                                                              '')
                                                      ? " " +
                                                          capitalizeWords(
                                                              _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .firstname
                                                                  .toString())
                                                      : " N/A"
                                                  : "",
                                              trimLines: 1,
                                              colorClickableText: Colors.grey,
                                              trimCollapsedText: "More",
                                              trimExpandedText: "  Less",
                                              trimMode: TrimMode.Line,
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "middlename".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: ReadMoreText(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .middlename !=
                                                          "")
                                                      ? " " +
                                                          capitalizeWords(
                                                              _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .middlename
                                                                  .toString())
                                                      : " N/A"
                                                  : "",
                                              trimLines: 1,
                                              colorClickableText: Colors.grey,
                                              trimCollapsedText: "More",
                                              trimExpandedText: "  Less",
                                              trimMode: TrimMode.Line,
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "lastname".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: ReadMoreText(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .lastname !=
                                                              null &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .lastname !=
                                                              '')
                                                      ? " " +
                                                          capitalizeWords(
                                                              _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .lastname
                                                                  .toString())
                                                      : " N/A"
                                                  : "",
                                              trimLines: 1,
                                              colorClickableText: Colors.grey,
                                              trimCollapsedText: "More",
                                              trimExpandedText: "  Less",
                                              trimMode: TrimMode.Line,
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "emailaddress".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: _getAllProfileDataModel !=
                                                        null &&
                                                    _getAllProfileDataModel!
                                                            .data !=
                                                        null &&
                                                    _getAllProfileDataModel!
                                                            .data!.basicInfo !=
                                                        null
                                                ? (_getAllProfileDataModel!
                                                            .data!
                                                            .basicInfo!
                                                            .email!
                                                            .length <=
                                                        17)
                                                    ? Text(
                                                        (_getAllProfileDataModel!
                                                                        .data!
                                                                        .basicInfo!
                                                                        .email !=
                                                                    null &&
                                                                _getAllProfileDataModel!
                                                                        .data!
                                                                        .basicInfo!
                                                                        .email !=
                                                                    '')
                                                            ? " " +
                                                                _getAllProfileDataModel!
                                                                    .data!
                                                                    .basicInfo!
                                                                    .email
                                                                    .toString()
                                                            : " N/A",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                      )
                                                    : Text(
                                                        _getAllProfileDataModel != null &&
                                                                _getAllProfileDataModel!
                                                                        .data !=
                                                                    null &&
                                                                _getAllProfileDataModel!
                                                                        .data!
                                                                        .basicInfo !=
                                                                    null
                                                            ? (_getAllProfileDataModel!
                                                                            .data!
                                                                            .basicInfo!
                                                                            .email !=
                                                                        null &&
                                                                    _getAllProfileDataModel!
                                                                            .data!
                                                                            .basicInfo!
                                                                            .email !=
                                                                        '')
                                                                ? " " +
                                                                    _getAllProfileDataModel!
                                                                        .data!
                                                                        .basicInfo!
                                                                        .email
                                                                        .toString()
                                                                        .replaceAll(
                                                                            "gmail.com",
                                                                            "...")
                                                                : " N/A"
                                                            : "",
                                                        // overflow:
                                                        //     TextOverflow
                                                        //         .ellipsis,
                                                        // maxLines: 1,
                                                      )
                                                : Container(),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "mobileno".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .mobile !=
                                                              null &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .mobile !=
                                                              '')
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .mobile
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "gender".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .gender !=
                                                              null &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .gender !=
                                                              '')
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .gender
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "age".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .age !=
                                                              null &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .age !=
                                                              '')
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .age
                                                              .toString() +
                                                          " Years"
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "height".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Row(
                                              children: [
                                                Text(
                                                  _getAllProfileDataModel !=
                                                              null &&
                                                          _getAllProfileDataModel!
                                                                  .data !=
                                                              null &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo !=
                                                              null
                                                      ? (_getAllProfileDataModel!
                                                                      .data!
                                                                      .basicInfo!
                                                                      .height !=
                                                                  null &&
                                                              _getAllProfileDataModel!
                                                                      .data!
                                                                      .basicInfo!
                                                                      .height !=
                                                                  '')
                                                          ? " " +
                                                              _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .height
                                                                  .toString() +
                                                              ' Inches'
                                                          : " N/A"
                                                      : "",
                                                  style: TextStyle(height: 1.5),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "weight".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Row(
                                              children: [
                                                Text(
                                                  _getAllProfileDataModel !=
                                                              null &&
                                                          _getAllProfileDataModel!
                                                                  .data !=
                                                              null &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo !=
                                                              null
                                                      ? (_getAllProfileDataModel!
                                                                      .data!
                                                                      .basicInfo!
                                                                      .weight !=
                                                                  null &&
                                                              _getAllProfileDataModel!
                                                                      .data!
                                                                      .basicInfo!
                                                                      .weight !=
                                                                  '')
                                                          ? " " +
                                                              _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .weight
                                                                  .toString()
                                                          : " N/A"
                                                      : "",
                                                  style: TextStyle(height: 1.5),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "manglik".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .manglikType !=
                                                              null &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .manglikType !=
                                                              '')
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .manglikType
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "skintone".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .skinTone !=
                                                          "")
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .skinTone
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "religion".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .religion !=
                                                              '' &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .religion !=
                                                              null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .religion
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "caste".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .caste !=
                                                              null &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .caste !=
                                                              '')
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .caste
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "gotra".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .gotra !=
                                                              null &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .gotra !=
                                                              '')
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .gotra
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "bodytype".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .bodyType !=
                                                              null &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .bodyType !=
                                                              '')
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .bodyType
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "allergic".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .allergicType !=
                                                              null &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .allergicType !=
                                                              '')
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .allergicType
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    checkGender == "Male"
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: width / 2 - 10,
                                                  child: Text(
                                                    "appereance".tr,
                                                    style: TextStyle(
                                                      color: Color(
                                                        0xff838994,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(':'),
                                                Container(
                                                  width: width / 2 - 10,
                                                  child: Text(
                                                    _getAllProfileDataModel !=
                                                                null &&
                                                            _getAllProfileDataModel!
                                                                    .data !=
                                                                null &&
                                                            _getAllProfileDataModel!
                                                                    .data!
                                                                    .basicInfo !=
                                                                null
                                                        ? (_getAllProfileDataModel!
                                                                        .data!
                                                                        .basicInfo!
                                                                        .beardType !=
                                                                    '' &&
                                                                _getAllProfileDataModel!
                                                                        .data!
                                                                        .basicInfo!
                                                                        .beardType !=
                                                                    null)
                                                            ? " " +
                                                                _getAllProfileDataModel!
                                                                    .data!
                                                                    .basicInfo!
                                                                    .beardType
                                                                    .toString()
                                                            : " N/A"
                                                        : "",
                                                    style:
                                                        TextStyle(height: 1.5),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : Container(),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "habit".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .drinkType !=
                                                              '' &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .drinkType !=
                                                              null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .drinkType
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "status".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .maritalStatus !=
                                                          "")
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .maritalStatus
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "dateofbirth".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .dob !=
                                                          "")
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .dob
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "addbirthplace".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .birthPlace !=
                                                          "")
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .birthPlace
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "addbirthtime".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .birthTime !=
                                                          "")
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .birthTime
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "referby".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .referedBy !=
                                                              '' &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .referedBy !=
                                                              null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .referedBy
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "nationality".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .nationality !=
                                                              '' &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .nationality !=
                                                              null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .nationality
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "profile by".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .createdBy !=
                                                              '' &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .basicInfo!
                                                                  .createdBy !=
                                                              null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .createdBy
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: width,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 6, right: 6, top: 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                                width: width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        "lookingfor".tr,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        String? data;
                                        final value = await Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => Looking_for(
                                                fromValue: "Edit",
                                                gender: _getAllProfileDataModel!
                                                    .data!.basicInfo!.gender),
                                          ),
                                        );
                                        setState(() {
                                          data = value;
                                        });
                                        if (data == "UpdateData") {
                                          getProfileData();
                                        }
                                        log("update data ---------$data");
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Image.asset(
                                          ImagePath.editprofile,
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 8.0, right: 8, top: 5),
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.only(bottom: 10, top: 10),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .basicInfo!
                                                              .gender ==
                                                          "Female"
                                                  ? "hisheight".tr
                                                  : "Her height",
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .lookingFor !=
                                                          null
                                                  ? _getAllProfileDataModel!
                                                              .data!
                                                              .lookingFor!
                                                              .heightFrom !=
                                                          null
                                                      ? " " +
                                                          (_getAllProfileDataModel!
                                                                  .data!
                                                                  .lookingFor!
                                                                  .heightFrom
                                                                  .toString() +
                                                              " To " +
                                                              _getAllProfileDataModel!
                                                                  .data!
                                                                  .lookingFor!
                                                                  .heightTo
                                                                  .toString() +
                                                              ' Inches')
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "agerange".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .lookingFor !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .lookingFor!
                                                              .ageFrom !=
                                                          null)
                                                      ? " " +
                                                          (_getAllProfileDataModel!
                                                                  .data!
                                                                  .lookingFor!
                                                                  .ageFrom
                                                                  .toString() +
                                                              " To " +
                                                              _getAllProfileDataModel!
                                                                  .data!
                                                                  .lookingFor!
                                                                  .ageTo
                                                                  .toString() +
                                                              " Years")
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "worktype".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .lookingFor !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .lookingFor!
                                                                  .workType !=
                                                              '' &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .lookingFor!
                                                                  .workType !=
                                                              null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .lookingFor!
                                                              .workType
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "earning".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .lookingFor !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .lookingFor!
                                                                  .annualIncome !=
                                                              '' &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .lookingFor!
                                                                  .annualIncome !=
                                                              null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .lookingFor!
                                                              .annualIncome
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "diettype".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .lookingFor !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .lookingFor!
                                                                  .dietType !=
                                                              '' &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .lookingFor!
                                                                  .dietType !=
                                                              null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .lookingFor!
                                                              .dietType
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "marriatlestatus".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .lookingFor !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .lookingFor!
                                                                  .maritalStatus !=
                                                              '' &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .lookingFor!
                                                                  .maritalStatus !=
                                                              null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .lookingFor!
                                                              .maritalStatus
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "qualities".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .lookingFor !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .lookingFor!
                                                                  .quality !=
                                                              '' &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .lookingFor!
                                                                  .quality !=
                                                              null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .lookingFor!
                                                              .quality
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "caste".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .lookingFor !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .lookingFor!
                                                                  .caste !=
                                                              '' &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .lookingFor!
                                                                  .caste !=
                                                              null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .lookingFor!
                                                              .caste
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "gotra".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .lookingFor !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .lookingFor!
                                                                  .gotra !=
                                                              "" &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .lookingFor!
                                                                  .gotra !=
                                                              null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .lookingFor!
                                                              .gotra
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: width,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 6, right: 6, top: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                                width: width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        "contact".tr,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        String? data;
                                        final value = await Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    Contact_screen(
                                                        fromValue: "Edit")));
                                        setState(() {
                                          data = value;
                                        });
                                        if (data == "UpdateData") {
                                          getProfileData();
                                        }
                                        log("update data ---------$data");
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Image.asset(
                                          ImagePath.editprofile,
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 8.0, right: 8, top: 5),
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.only(bottom: 10, top: 10),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "contactno".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userContact !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .userContact!
                                                              .mobile !=
                                                          null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userContact!
                                                              .mobile
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "alternate no".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userContact !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .userContact!
                                                              .altMobile !=
                                                          null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userContact!
                                                              .altMobile
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "emailid".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: _getAllProfileDataModel !=
                                                    null
                                                ? (_getAllProfileDataModel!
                                                            .data!
                                                            .userContact!
                                                            .email
                                                            .toString()
                                                            .length <=
                                                        17)
                                                    ? Text(
                                                        (_getAllProfileDataModel!
                                                                    .data!
                                                                    .userContact!
                                                                    .email !=
                                                                null)
                                                            ? " " +
                                                                _getAllProfileDataModel!
                                                                    .data!
                                                                    .userContact!
                                                                    .email
                                                                    .toString()
                                                            : " N/A",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            height: 1.5),
                                                      )
                                                    : Text(
                                                        _getAllProfileDataModel != null &&
                                                                _getAllProfileDataModel!
                                                                        .data !=
                                                                    null &&
                                                                _getAllProfileDataModel!
                                                                        .data!
                                                                        .userContact !=
                                                                    null
                                                            ? (_getAllProfileDataModel!
                                                                        .data!
                                                                        .userContact!
                                                                        .email !=
                                                                    null)
                                                                ? " " +
                                                                    _getAllProfileDataModel!
                                                                        .data!
                                                                        .userContact!
                                                                        .email
                                                                        .toString()
                                                                        .replaceAll(
                                                                            "gmail.com",
                                                                            "...")
                                                                : " N/A"
                                                            : "",
                                                        // maxLines: 1,
                                                        // overflow:
                                                        //     TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            height: 1.5),
                                                      )
                                                : Container(),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: width / 2 - 10,
                                                child: Text(
                                                  "address".tr,
                                                  style: TextStyle(
                                                    color: Color(
                                                      0xff838994,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(':'),
                                              Container(
                                                  width: width / 2 - 10,
                                                  child: ReadMoreText(
                                                    _getAllProfileDataModel !=
                                                                null &&
                                                            _getAllProfileDataModel!
                                                                    .data !=
                                                                null &&
                                                            _getAllProfileDataModel!
                                                                    .data!
                                                                    .userContact !=
                                                                null
                                                        ? (_getAllProfileDataModel!
                                                                    .data!
                                                                    .userContact!
                                                                    .address !=
                                                                null)
                                                            ? " " +
                                                                _getAllProfileDataModel!
                                                                    .data!
                                                                    .userContact!
                                                                    .address
                                                                    .toString()
                                                            : " N/A"
                                                        : "",
                                                    trimLines: 1,
                                                    colorClickableText:
                                                        Colors.grey,
                                                    trimCollapsedText: "More",
                                                    trimExpandedText: "  Less",
                                                    trimMode: TrimMode.Line,
                                                    style: TextStyle(
                                                      height: 1.5,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "state".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userContact !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .userContact!
                                                              .state !=
                                                          null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userContact!
                                                              .state
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "pincode".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userContact !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .userContact!
                                                              .pincode !=
                                                          null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userContact!
                                                              .pincode
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "country".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userContact !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .userContact!
                                                              .country !=
                                                          null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userContact!
                                                              .country
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: width,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 6.0, right: 6, top: 0),
                              child: Container(
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        "career".tr,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        String? data;
                                        final value = await Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    Career_Education(
                                                        fromValue: "Edit")));
                                        setState(() {
                                          data = value;
                                        });
                                        if (data == "UpdateData") {
                                          getProfileData();
                                        }
                                        log("update data ---------$data");
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Image.asset(
                                          ImagePath.editprofile,
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 8.0, right: 8, top: 5),
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.only(bottom: 10, top: 10),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "profession".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userCareer !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .userCareer!
                                                                  .profession !=
                                                              '' &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .userCareer!
                                                                  .profession !=
                                                              null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userCareer!
                                                              .profession
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "annualincome".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userCareer !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .userCareer!
                                                                  .annualIncome !=
                                                              '' &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .userCareer!
                                                                  .annualIncome !=
                                                              null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userCareer!
                                                              .annualIncome
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "highestqualification".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userCareer !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .userCareer!
                                                                  .qualification !=
                                                              '' &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .userCareer!
                                                                  .qualification !=
                                                              null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userCareer!
                                                              .qualification
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "englisheligiblitytest".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userCareer !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .userCareer!
                                                                  .education !=
                                                              '' &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .userCareer!
                                                                  .education !=
                                                              null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userCareer!
                                                              .education
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "educationfield".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userCareer !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .userCareer!
                                                              .educationFields !=
                                                          null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userCareer!
                                                              .educationFields
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "universityname".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userCareer !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .userCareer!
                                                              .universityName !=
                                                          null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userCareer!
                                                              .universityName
                                                              .toString() /* .substring(0,12) + ", From" */
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: width,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 6.0, right: 6, top: 0),
                              child: Container(
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        "family detail".tr,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        String? data;
                                        final value = await Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    Family_Detail(
                                                        fromValue: "Edit")));
                                        setState(() {
                                          data = value;
                                        });
                                        if (data == "UpdateData") {
                                          getProfileData();
                                        }
                                        log("update data ---------$data");
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Image.asset(
                                          ImagePath.editprofile,
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 8.0, right: 8, top: 5),
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.only(bottom: 10, top: 10),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "familytype".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userFamily !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .userFamily!
                                                              .familyType !=
                                                          null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userFamily!
                                                              .familyType
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    /* Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: [
                                    Container(
                                      width: width / 2 - 10,
                                      child: Text(
                                        "religion".tr,
                                        style: TextStyle(
                                          color: Color(
                                            0xff838994,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(':'),
                                    Container(
                                      width: width / 2 - 10,
                                      child: Text(
                                        _getAllProfileDataModel != null &&
                                                _getAllProfileDataModel!.data !=
                                                    null &&
                                                _getAllProfileDataModel!
                                                        .data!.userFamily !=
                                                    null
                                            ? (_getAllProfileDataModel!
                                                            .data!
                                                            .userFamily!
                                                            .religion !=
                                                        '' &&
                                                    _getAllProfileDataModel!
                                                            .data!
                                                            .userFamily!
                                                            .religion !=
                                                        null)
                                                ? " " +
                                                    _getAllProfileDataModel!.data!
                                                        .userFamily!.religion
                                                        .toString()
                                                : " N/A"
                                            : "",
                                        style: TextStyle(height: 1.5),
                                      ),
                                    )
                                  ],
                                ),
                              ), */
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "mothertongue".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userFamily !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .userFamily!
                                                              .motherTounge !=
                                                          null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userFamily!
                                                              .motherTounge
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "father's occupation".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userFamily !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .userFamily!
                                                              .fatherOccupation !=
                                                          null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userFamily!
                                                              .fatherOccupation
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "mother's occupation".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userFamily !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .userFamily!
                                                              .motherOccupation !=
                                                          null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userFamily!
                                                              .motherOccupation
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "family income".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userFamily !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .userFamily!
                                                                  .familyIncome !=
                                                              '' &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .userFamily!
                                                                  .familyIncome !=
                                                              null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userFamily!
                                                              .familyIncome
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "noofbrother".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userFamily !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .userFamily!
                                                              .noBrothers !=
                                                          null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userFamily!
                                                              .noBrothers
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "married".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userFamily !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .userFamily!
                                                              .marriedBrothers !=
                                                          null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userFamily!
                                                              .marriedBrothers
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "noofsister".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userFamily !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .userFamily!
                                                              .noSisters !=
                                                          null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userFamily!
                                                              .noSisters
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "married".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userFamily !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .userFamily!
                                                              .marriedSisters !=
                                                          null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userFamily!
                                                              .marriedSisters
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "familybasedoutof".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userFamily !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .userFamily!
                                                              .familyBasedOut !=
                                                          null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userFamily!
                                                              .familyBasedOut
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: width,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 6.0, right: 6, top: 0),
                              child: Container(
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        "location".tr,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        String? data;
                                        final value = await Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    Location_screen(
                                                        fromValue: "Edit")));
                                        setState(() {
                                          data = value;
                                        });
                                        if (data == "UpdateData") {
                                          getProfileData();
                                        }
                                        log("update data ---------$data");
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Image.asset(
                                          ImagePath.editprofile,
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 8.0, right: 8, top: 5),
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.only(bottom: 10, top: 10),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "presently living".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userLocation !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                              .data!
                                                              .userLocation!
                                                              .livingPlace !=
                                                          null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userLocation!
                                                              .livingPlace
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "city".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userLocation !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .userLocation!
                                                                  .city !=
                                                              '' &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .userLocation!
                                                                  .city !=
                                                              null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userLocation!
                                                              .city
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "state".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userLocation !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .userLocation!
                                                                  .state !=
                                                              '' &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .userLocation!
                                                                  .state !=
                                                              null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userLocation!
                                                              .state
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "country".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              _getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userLocation !=
                                                          null
                                                  ? (_getAllProfileDataModel!
                                                                  .data!
                                                                  .userLocation!
                                                                  .country !=
                                                              '' &&
                                                          _getAllProfileDataModel!
                                                                  .data!
                                                                  .userLocation!
                                                                  .country !=
                                                              null)
                                                      ? " " +
                                                          _getAllProfileDataModel!
                                                              .data!
                                                              .userLocation!
                                                              .country
                                                              .toString()
                                                      : " N/A"
                                                  : "",
                                              style: TextStyle(height: 1.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: width,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 6.0, right: 6, top: 0),
                              child: Container(
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        "hobbies".tr,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        String? data;
                                        final value = await Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    Hobbies_Detail(
                                                        fromValue: "Edit")));
                                        setState(() {
                                          data = value;
                                        });
                                        if (data == "UpdateData") {
                                          getProfileData();
                                        }
                                        log("update data ---------$data");
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Image.asset(
                                          ImagePath.editprofile,
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 8.0, right: 8, top: 5),
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.only(bottom: 10, top: 10),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: width / 2 - 10,
                                            child: Text(
                                              "hobbies".tr,
                                              style: TextStyle(
                                                color: Color(
                                                  0xff838994,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(':'),
                                          Container(
                                              width: width / 2 - 10,
                                              child: (_getAllProfileDataModel != null &&
                                                      _getAllProfileDataModel!
                                                              .data !=
                                                          null &&
                                                      _getAllProfileDataModel!
                                                              .data!
                                                              .userHobbies!
                                                              .hobbies!
                                                              .length >
                                                          0)
                                                  ? Wrap(
                                                      children: List.generate(
                                                          _getAllProfileDataModel != null &&
                                                                  _getAllProfileDataModel!
                                                                          .data !=
                                                                      null &&
                                                                  _getAllProfileDataModel!
                                                                          .data!
                                                                          .userHobbies !=
                                                                      null &&
                                                                  _getAllProfileDataModel!
                                                                          .data!
                                                                          .userHobbies!
                                                                          .hobbies!
                                                                          .length !=
                                                                      0
                                                              ? _getAllProfileDataModel!
                                                                  .data!
                                                                  .userHobbies!
                                                                  .hobbies!
                                                                  .length
                                                              : 0,
                                                          (index) => Container(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          8.0),
                                                                  child: Text(_getAllProfileDataModel!.data !=
                                                                              null &&
                                                                          _getAllProfileDataModel!.data!.userHobbies!.hobbies!.length >
                                                                              0
                                                                      ? _getAllProfileDataModel!
                                                                              .data!
                                                                              .userHobbies!
                                                                              .hobbies![index] +
                                                                          ','
                                                                      : "N/A"),
                                                                ),
                                                              )))
                                                  : Text(" N/A"))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      isEditable == true
                          ? Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                AppConstants.language,
                                style: description,
                              ),
                            )
                          : Text(''),
                      isEditable == true ? SizedBox(height: 5) : SizedBox(),
                      isEditable == true
                          ? Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      children: _selectedItems
                                          .map((e) => Chip(
                                                label: Text(e),
                                              ))
                                          .toList(),
                                    ),
                                    SizedBox(width: 5),
                                    InkWell(
                                      onTap: () {
                                        isEditable ? _showMultiSelect() : '';
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 150,
                                        child: DottedBorder(
                                            dashPattern: [3, 3],
                                            radius: Radius.circular(10),
                                            strokeWidth: 0,
                                            strokeCap: StrokeCap.butt,
                                            child: Center(
                                                child: Text(
                                              'Add language',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ))),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      isEditable == true ? SizedBox(height: 10) : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  _fbconnectbutton() {
    return GestureDetector(
      onTap: () {
        _openFacebook();
      },
      child: Container(
        width: 100,
        height: 20,
        decoration: BoxDecoration(
            color: currentColor, borderRadius: BorderRadius.circular(5)),
        alignment: Alignment.center,
        child: Text(
          'Connect',
          style: appBtnStyle.copyWith(fontSize: 15),
        ),
      ),
    );
  }

  _instaconnectbutton() {
    return GestureDetector(
      onTap: () {
        _launchInstagram();
      },
      child: Container(
        width: 100,
        height: 20,
        decoration: BoxDecoration(
            color: currentColor, borderRadius: BorderRadius.circular(5)),
        alignment: Alignment.center,
        child: Text(
          'Connect',
          style: appBtnStyle.copyWith(fontSize: 15),
        ),
      ),
    );
  }

  _twitterconnectbutton() {
    return GestureDetector(
      onTap: () {
        openTwitter();
      },
      child: Container(
        width: 100,
        height: 20,
        decoration: BoxDecoration(
            color: currentColor, borderRadius: BorderRadius.circular(5)),
        alignment: Alignment.center,
        child: Text(
          'Connect',
          style: appBtnStyle.copyWith(fontSize: 15),
        ),
      ),
    );
  }

  openTwitter() async {
    var url = "https://twitter.com/";
    log(url);
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false, enableJavaScript: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchInstagram() async {
    final urlImage =
        "https://media.licdn.com/dms/image/C5603AQGoPa4Q4-yMJw/profile-displayphoto-shrink_400_400/0/1624408054848?e=1677110400&v=beta&t=JRphiNL2_IAdv3Ig-m40GxHtl-yqnbEuz9aveLuMaz8";
    final url = Uri.parse(urlImage);
    final response = await http.get(url);
    final bytes = response.bodyBytes;

    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/image.jpg';
    File(path).writeAsBytesSync(bytes);

    await Share.shareFiles([path], text: "Hello MK");
  }

  _openFacebook() async {
    String fbProtocolUrl;
    if (Platform.isIOS) {
      fbProtocolUrl = 'fb://profile/page_id';
    } else {
      fbProtocolUrl = 'fb://page/page_id';
    }

    String fallbackUrl = 'https://www.facebook.com/page_name';

    try {
      bool launched = await launch(fbProtocolUrl, forceSafariVC: false);

      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false);
    }
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

    Navigator.pop(context);
    return imageFile;
  }

  Future _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile!;
    });
    Navigator.pop(context);
    return imageFile;
  }

  checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        isShowLoading = true;
      });
      getProfileAboutMe();
      getmySelfAbout();
      getProfileData();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isShowLoading = true;
      });
      getProfileAboutMe();
      getProfileData();

      getmySelfAbout();
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

  getQualification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(USER_TOKEN);

    var response = await http.get(Uri.parse(GET_QUALIFICATION_URL));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == "Token is Expired") {
        prefs.setString(USER_TOKEN, "");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (dialogcontext) => Login()),
            (route) => false);
      }
      if (mounted) {
        setState(() {
          _qualificationModel =
              QualificationModel.fromJson(jsonDecode(response.body));
          log("data data dtad dtadtd");
          log(_qualificationModel!.data![0].id.toString());
        });
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

  getAge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(USER_TOKEN);
    print(authToken);

    var response = await http.get(
      Uri.parse(GET_AGE_URL),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == "Token is Expired") {
        prefs.setString(USER_TOKEN, "");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (dialogcontext) => Login()),
            (route) => false);
      }
      if (mounted) {
        setState(() {
          _ageModel = AgeModel.fromJson(jsonDecode(response.body));
        });
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

  getProfileAboutMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(USER_TOKEN);
    print(authToken);
    final queryParameters = {
      "token": authToken.toString(),
    };
    if (mounted) {
      String queryString = Uri(queryParameters: queryParameters).query;
      var response =
          await http.get(Uri.parse(GET_PROFILE_ABOUT + "?" + queryString));
      log("response ===========> ${response.body.toString()}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "Token is Expired") {
          prefs.setString(USER_TOKEN, "");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (dialogcontext) => Login()),
              (route) => false);
        }
        if (mounted) {
          setState(() {
            _userAboutMeModel =
                aboutMe.UserAboutMeModel.fromJson(jsonDecode(response.body));
          });
          setState(() {
            isShowLoading = false;
          });
        }
      } else if (response.statusCode == 404) {
        getProfileAboutMe();
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
    }
  }

  Future setProfileUpdateAPI(String imageType, PickedFile? image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CommonUtils.showProgressLoading(context);
    var token = prefs.getString(USER_TOKEN);
    var mobile = prefs.getString(USER_MOBILE);
    log("image uplode start  ========= >>>> ");
    FormData formData = FormData.fromMap({
      "image_type_id": imageType,
      "mobile": mobile,
      "image": image != null
          ? await MultipartFile.fromFile(image.path,
              filename: image.path.split('/').last)
          : null,
    });
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    var response = await dio.post(UPLODE_PROFILE, data: formData);
    log(response.data.toString());
    if (response.statusCode == 200) {
      uploadImage.UploadimageModal _uploadimageModal =
          uploadImage.UploadimageModal.fromJson(response.data);

      {
        if (mounted) {
          Fluttertoast.showToast(
            msg: "File updated successfully",
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      }
      CommonUtils.hideProgressLoading();
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
  }

  getmySelfAbout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(USER_TOKEN);

    print(authToken);
    final queryParameters = {"token": authToken.toString()};
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await http.get(
      Uri.parse(GET_MYSELFTEXT_ABOUT + "?" + queryString),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == "Token is Expired") {
        prefs.setString(USER_TOKEN, "");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (dialogcontext) => Login()),
            (route) => false);
      }
      setState(() {
        _myselfAboutModel =
            mySelfAboutModel.fromJson(jsonDecode(response.body));
      });
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
  }

  updateAboutMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(USER_TOKEN);
    final queryParameters = {
      "token": authToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var params = {
      "myselfoneline": isSelfOneLine == false && mySelfOne.text.isEmpty
          ? _myselfAboutModel!.data!.myselfoneline == null
              ? ""
              : _myselfAboutModel!.data!.myselfoneline
          : mySelfOne.text,
      "myself": isSelf == false && mySelf.text.isEmpty
          ? _myselfAboutModel!.data!.myself == null
              ? ""
              : _myselfAboutModel!.data!.myself
          : mySelf.text
    };
    var response = await http.post(
        Uri.parse(UPDATE_MYSELFTEXT_ABOUT_URL + "?" + queryString),
        body: params);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == "Token is Expired") {
        prefs.setString(USER_TOKEN, "");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (dialogcontext) => Login()),
            (route) => false);
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
        setState(() {
          _updateAboutMeModel =
              UpdateAboutMeModel.fromJson(jsonDecode(response.body));
          isSelfOneLine = false;
          isSelf = false;
          getmySelfAbout();
        });
      }
    }
  }

  getProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(USER_TOKEN);
    final queryParameters = {
      "token": authToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response =
        await http.get(Uri.parse(GET_PROFILE_DATA_URL + "?" + queryString));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == "Token is Expired") {
        prefs.setString(USER_TOKEN, "");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (dialogcontext) => Login()),
            (route) => false);
      } else {
        setState(() {
          _getAllProfileDataModel = ProfileData.GetAllProfileDataModel.fromJson(
              jsonDecode(response.body));
          checkGender =
              _getAllProfileDataModel!.data!.basicInfo!.gender.toString();
        });
      }

      print("profile All inforamtion ++++++++++++++ ${response.body}");

      print("profile response ::::::: ${response.body}");
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

class MultiSelect extends StatefulWidget {
  final List<String> items;

  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(13)),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        insetPadding: EdgeInsets.all(25),
        elevation: 0,
        contentPadding: EdgeInsets.all(5),
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Text('Select Language'),
            SizedBox(
              height: 20,
            ),
          ],
        ),
        content: Builder(builder: (context) {
          return Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: ListBody(
                children: widget.items
                    .map((item) => CheckboxListTile(
                          activeColor: Colors.white,
                          checkColor: Colors.blue,
                          tileColor: Colors.white,
                          value: _selectedItems.contains(item),
                          title: Text(item),
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (isChecked) =>
                              _itemChange(item, isChecked!),
                        ))
                    .toList(),
              ),
            ),
          );
        }),
        actions: [
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: _cancel,
          ),
          InkWell(
            onTap: () {
              _submit();
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  gradient: AppColors.appColor),
              height: 30,
              width: 80,
              child: Center(
                  child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              )),
            ),
          )
        ],
      ),
    );
  }
}
