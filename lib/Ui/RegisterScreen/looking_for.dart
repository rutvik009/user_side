import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:http/http.dart' as http;
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/Get_Quality_Model.dart'
    as quality;
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/GetProfile_Details/Get_Looking_for_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/Get_MaritalStatus_Model.dart'
    as maritalStatus;
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Update_Profile_Details/Update_LookingFor_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/age_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/annualincome_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/cast_model.dart'
    as castData;
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/diet_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/gotra_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/height_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/worktype_model.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Drawer/ProfileScreen/profile_screenn.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/Drawer_Screen.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/basic_detail.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/contact.dart';
import 'package:matrimonial_app/Utils/DropDownList.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/commonappbar_search.dart';
import 'package:matrimonial_app/widget/submit_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/color_constants.dart';

class Looking_for extends StatefulWidget {
  String? fromValue;
  String? gender;

  Looking_for({Key? key, this.fromValue, this.gender}) : super(key: key);

  @override
  State<Looking_for> createState() => _Looking_forState();
}

class _Looking_forState extends State<Looking_for> {
  bool nextPressed = false;
  bool qualitiesSelcted = false;
  Dio dio = Dio();

  workTypeModel? _worktypeModel;

  DietModel? _dietModel;
  HeightModel? _heightModelFrom;
  HeightModel? _heightModelTo;
  bool isHeight = false;
  bool isHeighTo = false;
  bool isAge = false;
  bool isAgeTo = false;
  bool isSelectOther = false;
  AgeModel? _ageModelFrom;
  AgeModel? _ageModelTo;
  castData.castData? _data;
  castData.castModel? _castModel;
  GotraData? _gotraData;
  gotraModel? _gotraModel;
  DietData? _dietData;
  HeightData? _heightDataFrom;
  AgeData? _ageDataFrom;
  AgeData? _ageDataTo;
  WorktypeData? _worktypeData;
  HeightData? _heightDataTo;
  maritalStatus.GetmaritalStatusModel? _getmaritalStatusModel;
  maritalStatus.Data? _maritalData;
  AnnualincomeModel? _annualincomeModel;
  AnnualData? _annualincomedata;
  quality.GetQualityModel? _getQualityModel;
  quality.Data? qualityData;

  Map<String, dynamic> dietName = {};
  final TextEditingController _otherGotraController = TextEditingController();

  String dropdown = AppConstants.h1;
  String dropdown1 = AppConstants.hh1;
  String dropdown2 = AppConstants.a18;
  String dropdown3 = AppConstants.aa31;

  final _formkey = GlobalKey<FormState>();
  bool isErrorToHeight = false;
  bool isFromHeightError = false;
  bool isToAge = false;
  bool isToAgeError = false;
  bool isErroFromAge = false;
  bool isErrorToAge = false;

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              children: [
                ProfileDataGetAppbar(name: "lookingfor".tr),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "continuewithus".tr,
                            style: headingStyle.copyWith(
                                color: Color(0xff838994),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          (widget.fromValue == "Edit")
                              ? Container()
                              : SizedBox(height: 15),
                          (widget.fromValue == "Edit")
                              ? Container()
                              : Image.asset(ImagePath.lookingFor, height: 19),
                          SizedBox(height: 15),
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: (widget.gender == "Male")
                                            ? "Her height"
                                            : "hisheight".tr,
                                        style: TextStyle(
                                          color: Color(0xff4D4D4D),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' *',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 5.0),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButtonFormField2<
                                                    HeightData>(
                                                  focusColor: Colors.white,
                                                  buttonHeight: 43,
                                                  dropdownDecoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            13),
                                                  ),
                                                  decoration: InputDecoration(
                                                      focusColor: Colors.white,
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(13),
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xffD1D1D1))),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xffD1D1D1)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13),
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xffd1d1d1),
                                                            width: 1.5),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(13),
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xffD1D1D1)))),
                                                  icon: Row(
                                                    children: [
                                                      isHeight
                                                          ? Container(
                                                              child: Text(
                                                                "inches".tr,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            )
                                                          : Container(),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 8.0),
                                                        child: Container(
                                                          height: 15,
                                                          width: 15,
                                                          child: Center(
                                                            child: Image.asset(
                                                              ImagePath.forward,
                                                              height: 24,
                                                              width: 24,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  hint: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 7),
                                                    child: Text(
                                                      "heighterror".tr,
                                                      style: fontStyle.copyWith(
                                                          color:
                                                              Color(0xff777777),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  dropdownMaxHeight: 200,
                                                  itemHeight: 20,
                                                  items:
                                                      addDividersAfterItemsHeight(
                                                    (_heightModelFrom != null)
                                                        ? _heightModelFrom!
                                                            .data!
                                                        : [],
                                                  ),
                                                  customItemsIndexes:
                                                      getDividersIndexes(
                                                    (_heightModelFrom != null)
                                                        ? _heightModelFrom!
                                                            .data!
                                                        : [],
                                                  ),
                                                  value: _heightDataFrom,
                                                  onChanged: (newValue) {
                                                    print(newValue);
                                                    setState(() {
                                                      _heightDataTo = null;
                                                      isHeighTo = false;
                                                      isHeight = true;
                                                      _heightDataFrom =
                                                          newValue;
                                                      if (_formkey.currentState!
                                                          .validate()) {
                                                        setState(() {
                                                          isFromHeightError =
                                                              false;
                                                        });
                                                      }

                                                      if (_heightDataFrom !=
                                                          null) {
                                                        getHeightTo();
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    AppConstants.to,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField2<
                                            HeightData>(
                                          focusColor: Colors.white,
                                          buttonHeight: 43,
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          decoration: InputDecoration(
                                              focusColor: Colors.white,
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(13),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Color(0xffD1D1D1))),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xffD1D1D1)),
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                borderSide: BorderSide(
                                                    color: Color(0xffd1d1d1),
                                                    width: 1.5),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(13),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Color(0xffD1D1D1)))),
                                          icon: Row(
                                            children: [
                                              isHeighTo
                                                  ? Container(
                                                      child: Text(
                                                        "inches".tr,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    )
                                                  : Container(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Container(
                                                  height: 15,
                                                  width: 15,
                                                  child: Center(
                                                    child: Image.asset(
                                                      ImagePath.forward,
                                                      height: 24,
                                                      width: 24,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          hint: Padding(
                                            padding: EdgeInsets.only(left: 7),
                                            child: Text(
                                              "heighterror".tr,
                                              style: fontStyle.copyWith(
                                                  color: Color(0xff777777),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          dropdownMaxHeight: 200,
                                          itemHeight: 20,
                                          items: addDividersAfterItemsHeight(
                                              (_heightModelTo != null)
                                                  ? _heightModelTo!.data!
                                                  : []),
                                          customItemsIndexes:
                                              getDividersIndexes(
                                                  (_heightModelTo != null)
                                                      ? _heightModelTo!.data!
                                                      : []),
                                          value: _heightDataTo,
                                          onChanged: (newValue) {
                                            print(newValue);
                                            setState(() {
                                              isHeighTo = true;
                                              if (!_formkey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  isErrorToHeight = false;
                                                  isFromHeightError = false;
                                                });
                                              }
                                              ;
                                              _heightDataTo = newValue;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  // height: 30,
                                  width: width,
                                  //  color: Colors.yellow,
                                  // alignment: Alignment.centerRight,
                                  child: Padding(
                                      padding: const EdgeInsets.only(right: 32),
                                      child: (isFromHeightError)
                                          ? Text(
                                              "    Please select height ",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12),
                                            )
                                          : Container()),
                                ),
                              ),
                              /* Flexible(
                                flex: 1,
                                child: Container(
                                  // height: 30,
                                  width: width,
                                  //  color: Colors.blue,
                                  // alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: (isErrorToHeight)
                                        ? Text(
                                            "    Please select height to",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12),
                                          )
                                        : Container(),
                                  ),
                                ),
                              ), */
                            ],
                          ),
                          /* Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  width: 150,
                                  color: Colors.red,
                                  child: (isFromHeightError)
                                      ? Text(
                                          "    Please select height...",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 12),
                                        )
                                      : Container(),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  width: 150,
                                  color: Colors.yellow,
                                  child: (isErrorToHeight)
                                      ? Text(
                                          "    Please select height to",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 12),
                                        )
                                      : Container(),
                                ),
                              ),
                            ],
                          ), */
                          SizedBox(height: 10),
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "agerange".tr,
                                        style: TextStyle(
                                          color: Color(0xff4D4D4D),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' *',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                // color: Colors.yellow,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 0),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 5.0),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButtonFormField2<
                                                          AgeData>(
                                                    focusColor: Colors.white,
                                                    buttonHeight: 40,
                                                    dropdownDecoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              13),
                                                    ),
                                                    decoration: InputDecoration(
                                                        focusColor: Colors
                                                            .white,
                                                        isDense: true,
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        focusedBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        13),
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xffD1D1D1))),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xffD1D1D1)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(13),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(13),
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xffd1d1d1),
                                                              width: 1.5),
                                                        ),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        13),
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xffD1D1D1)))),
                                                    icon: Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: Row(
                                                        children: [
                                                          isAge
                                                              ? Text("years".tr,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13))
                                                              : Container(),
                                                          Container(
                                                            height: 15,
                                                            width: 15,
                                                            child: Center(
                                                              child:
                                                                  Image.asset(
                                                                ImagePath
                                                                    .forward,
                                                                height: 24,
                                                                width: 24,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    hint: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 7),
                                                      child: Text(
                                                        "selectage".tr,
                                                        style:
                                                            fontStyle.copyWith(
                                                                color: Color(
                                                                    0xff777777),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12),
                                                      ),
                                                    ),
                                                    dropdownMaxHeight: 200,
                                                    itemHeight: 20,
                                                    items:
                                                        addDividersAfterItemsAge(
                                                            (_ageModelFrom !=
                                                                    null)
                                                                ? _ageModelFrom!
                                                                    .data!
                                                                : []),
                                                    customItemsIndexes:
                                                        getDividersIndexes(
                                                            (_ageModelFrom !=
                                                                    null)
                                                                ? _ageModelFrom!
                                                                    .data!
                                                                : []),
                                                    value: _ageDataFrom,
                                                    onChanged: (newValue) {
                                                      print(newValue);
                                                      setState(() {
                                                        _ageDataTo = null;
                                                        isAgeTo = false;
                                                        isAge = true;
                                                        _ageDataFrom = newValue;
                                                        if (_ageDataFrom !=
                                                            null) {
                                                          getAgeTo();
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: /* isToAge == true ||
                                                  isToAgeError == true
                                              ? 14
                                              : */
                                              0),
                                      child: Text(AppConstants.to),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        child: DropdownButtonHideUnderline(
                                          child:
                                              DropdownButtonFormField2<AgeData>(
                                            focusColor: Colors.white,
                                            buttonHeight: 43,
                                            dropdownDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            decoration: InputDecoration(
                                                focusColor: Colors.white,
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            13),
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xffD1D1D1))),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xffD1D1D1)),
                                                  borderRadius:
                                                      BorderRadius.circular(13),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(13),
                                                  borderSide: BorderSide(
                                                      color: Color(0xffd1d1d1),
                                                      width: 1.5),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13),
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xffD1D1D1)))),
                                            icon: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Row(
                                                children: [
                                                  isAgeTo
                                                      ? Text(
                                                          "years".tr,
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        )
                                                      : Container(),
                                                  Container(
                                                    height: 15,
                                                    width: 15,
                                                    child: Center(
                                                      child: Image.asset(
                                                        ImagePath.forward,
                                                        height: 24,
                                                        width: 24,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            hint: Padding(
                                              padding: EdgeInsets.only(left: 6),
                                              child: Text(
                                                "selectage".tr,
                                                style: fontStyle.copyWith(
                                                    color: Color(0xff777777),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            dropdownMaxHeight: 200,
                                            itemHeight: 20,
                                            items: addDividersAfterItemsAge(
                                                (_ageModelTo != null)
                                                    ? _ageModelTo!.data!
                                                    : []),
                                            customItemsIndexes:
                                                getDividersIndexes(
                                                    (_ageModelTo != null)
                                                        ? _ageModelTo!.data!
                                                        : []),
                                            value: _ageDataTo,
                                            onChanged: (newValue) {
                                              print(newValue);
                                              setState(() {
                                                isAgeTo = true;
                                                _ageDataTo = newValue;
                                                if (!_formkey.currentState!
                                                    .validate()) {
                                                  isErroFromAge = false;
                                                  isErrorToAge = false;
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  // height: 30,
                                  width: width,
                                  //  color: Colors.yellow,
                                  // alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 32),
                                    child: (isErroFromAge)
                                        ? Text(
                                            "    Please select age ",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12),
                                          )
                                        : Container(),
                                  ),
                                ),
                              ),
                              /* Flexible(
                                flex: 1,
                                child: Container(
                                  // height: 30,
                                  width: width,
                                  //  color: Colors.blue,
                                  // alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 23),
                                    child: (isErrorToAge)
                                        ? Text(
                                            "Please select age to",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12),
                                          )
                                        : Container(),
                                  ),
                                ),
                              ), */
                            ],
                          ),
                          /* Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              (isErroFromAge)
                                  ? Text(
                                      "    Please select age from",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    )
                                  : Container(),
                              (isErrorToAge)
                                  ? Text(
                                      "Please select age to",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    )
                                  : Container()
                            ],
                          ), */
                          SizedBox(height: 10),
                          Text(
                            "worktype".tr,
                            style: TextStyle(
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 45,
                            width: width,
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                color: Color(0xffD1D1D1),
                                width: 1.5,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<WorktypeData>(
                                focusColor: Colors.white,
                                buttonHeight: 43,
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                icon: Padding(
                                  padding: EdgeInsets.all(13.0),
                                  child: Container(
                                    height: 15,
                                    width: 15,
                                    child: Center(
                                      child: Image.asset(
                                        ImagePath.forward,
                                        height: 24,
                                        width: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                hint: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "selectworktype".tr,
                                    style: fontStyle.copyWith(
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                dropdownMaxHeight: 200,
                                itemHeight: 20,
                                items: addDividersAfterItemsWorkType(
                                    (_worktypeModel != null)
                                        ? _worktypeModel!.data!
                                        : []),
                                customItemsIndexes: getDividersIndexes(
                                    (_worktypeModel != null)
                                        ? _worktypeModel!.data!
                                        : []),
                                value: _worktypeData,
                                onChanged: (newValue) {
                                  print(newValue);
                                  setState(() {
                                    _worktypeData = newValue;
                                    // isToHeight = false;
                                    // isToHeightError = false;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "annualincome".tr,
                                  style: TextStyle(
                                    color: Color(0xff4D4D4D),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2<AnnualData>(
                              focusColor: Colors.white,
                              buttonHeight: 45,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              decoration: InputDecoration(
                                  focusColor: Colors.white,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide:
                                          BorderSide(color: Color(0xffD1D1D1))),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffD1D1D1)),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                        color: Color(0xffd1d1d1), width: 1.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide(
                                          color: Color(0xffD1D1D1)))),
                              icon: Padding(
                                padding: EdgeInsets.all(13.0),
                                child: Container(
                                  height: 15,
                                  width: 15,
                                  child: Center(
                                    child: Image.asset(
                                      ImagePath.forward,
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                ),
                              ),
                              hint: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "selectannual".tr,
                                  style: fontStyle.copyWith(
                                      fontSize: 15,
                                      color: Color(0xff777777),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              dropdownMaxHeight: 200,
                              itemHeight: 20,
                              items: addDividersAfterItemsAnnualIncome(
                                  (_annualincomeModel != null)
                                      ? _annualincomeModel!.data!
                                      : []),
                              customItemsIndexes: getDividersIndexes(
                                  (_annualincomeModel != null)
                                      ? _annualincomeModel!.data!
                                      : []),
                              value: _annualincomedata,
                              validator: (value) {
                                if (value == null) {
                                  return '    Please select Annual Income';
                                }
                              },
                              onChanged: (newValue) {
                                print(newValue);
                                setState(() {
                                  _annualincomedata = newValue;
                                  if (_formkey.currentState!.validate()) ;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "diettype".tr,
                            style: TextStyle(
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 45,
                            width: width,
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                color: Color(0xffD1D1D1),
                                width: 1.5,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<Map<String, dynamic>>(
                                focusColor: Colors.white,
                                buttonHeight: 45,
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                icon: Padding(
                                  padding: EdgeInsets.all(13.0),
                                  child: Container(
                                    height: 15,
                                    width: 15,
                                    child: Center(
                                      child: Image.asset(
                                        ImagePath.forward,
                                        height: 24,
                                        width: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                hint: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "selectdiet".tr,
                                    style: fontStyle.copyWith(
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                dropdownMaxHeight: 200,
                                itemHeight: 20,
                                items: addDividersAfterItemsDiet(dietList
                                    /* (_dietModel != null)
                                        ? _dietModel!.data!
                                        : [] */
                                    ),
                                customItemsIndexes: getDividersIndexes(dietList
                                    /* (_dietModel != null)
                                        ? _dietModel!.data!
                                        : [] */
                                    ),
                                value: (dietName.isNotEmpty)
                                    ? dietName
                                    : dietName['name'],
                                onChanged: (newValue) {
                                  print(newValue);
                                  setState(() {
                                    dietName = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 2),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "marriatlestatus".tr,
                                    style: TextStyle(
                                      color: Color(0xff4D4D4D),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2<maritalStatus.Data>(
                              focusColor: Colors.white,
                              buttonHeight: 45,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              decoration: InputDecoration(
                                  focusColor: Colors.white,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide:
                                          BorderSide(color: Color(0xffD1D1D1))),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffD1D1D1)),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                        color: Color(0xffd1d1d1), width: 1.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide(
                                          color: Color(0xffD1D1D1)))),
                              icon: Padding(
                                padding: EdgeInsets.all(13.0),
                                child: Container(
                                  height: 13,
                                  width: 13,
                                  child: Center(
                                    child: Image.asset(
                                      ImagePath.forward,
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                ),
                              ),
                              hint: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "selectmarriatlestatus".tr,
                                  style: fontStyle.copyWith(
                                      color: Color(0xff777777),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                              ),
                              dropdownMaxHeight: 200,
                              itemHeight: 20,
                              items: addDividersAfterItemsMaritalStatus(
                                  (_getmaritalStatusModel != null)
                                      ? _getmaritalStatusModel!.data!
                                      : []),
                              customItemsIndexes: getDividersIndexes(
                                  (_getmaritalStatusModel != null)
                                      ? _getmaritalStatusModel!.data!
                                      : []),
                              value: _maritalData,
                              validator: (value) {
                                if (value == null) {
                                  return "    Please select Marital status";
                                }
                              },
                              onChanged: (newValue) {
                                print(newValue);
                                setState(() {
                                  // _formkey.currentState!.validate();
                                  _maritalData = newValue;
                                });
                                if (_formkey.currentState!.validate()) ;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, bottom: 2),
                            child: Text(
                              "qualities".tr,
                              style: TextStyle(
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: nextPressed && !qualitiesSelcted
                                        ? Theme.of(context).errorColor
                                        : Color(0xffD1D1D1),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(13)),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<quality.Data>(
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                icon: Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Container(
                                    height: 15,
                                    width: 15,
                                    child: Center(
                                      child: Image.asset(
                                        ImagePath.forward,
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                buttonHeight: 43,
                                itemHeight: 20,
                                dropdownMaxHeight: 200,
                                hint: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "selectqualities".tr,
                                    style: fontStyle.copyWith(
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                items: addDividersAfterItemsQuality(
                                    (_getQualityModel != null)
                                        ? _getQualityModel!.data!
                                        : []),
                                customItemsIndexes: getDividersIndexes(
                                    (_getQualityModel != null)
                                        ? _getQualityModel!.data!
                                        : []),
                                value: qualityData,
                                onChanged: (value) {
                                  setState(() {
                                    qualityData = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "caste".tr,
                                  style: TextStyle(
                                    color: Color(0xff4D4D4D),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2<castData.castData>(
                              offset: Offset(0, 0),
                              focusColor: Colors.white,
                              buttonHeight: 45,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              decoration: InputDecoration(
                                  focusColor: Colors.white,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide:
                                          BorderSide(color: Color(0xffD1D1D1))),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffD1D1D1)),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                        color: Color(0xffd1d1d1), width: 1.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide(
                                          color: Color(0xffD1D1D1)))),
                              icon: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Container(
                                  height: 15,
                                  width: 15,
                                  child: Center(
                                    child: Image.asset(
                                      ImagePath.forward,
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                ),
                              ),
                              hint: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "selectcaste".tr,
                                  style: fontStyle.copyWith(
                                      color: Color(0xff777777),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              dropdownMaxHeight: 200,
                              itemHeight: 20,
                              validator: (value) {
                                if (value == null) {
                                  return "    Please select caste";
                                }
                              },
                              items: addDividersAfterItems((_castModel != null)
                                  ? _castModel!.data!
                                  : []),
                              customItemsIndexes: getDividersIndexes(
                                  (_castModel != null)
                                      ? _castModel!.data!
                                      : []),
                              value: _data,
                              onChanged: (newValue) {
                                print(newValue);
                                setState(() {
                                  _data = newValue;
                                  // if (_formkey.currentState!.validate()) ;
                                });
                                if (_formkey.currentState!.validate()) ;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "gotra".tr,
                                  style: TextStyle(
                                    color: Color(0xff4D4D4D),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2<GotraData>(
                              isExpanded: true,
                              offset: Offset(0, 0),
                              focusColor: Colors.white,
                              buttonHeight: 45,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              decoration: InputDecoration(
                                  focusColor: Colors.white,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide:
                                          BorderSide(color: Color(0xffD1D1D1))),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffD1D1D1)),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                        color: Color(0xffd1d1d1), width: 1.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide(
                                          color: Color(0xffD1D1D1)))),
                              icon: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Container(
                                  height: 15,
                                  width: 15,
                                  child: Center(
                                    child: Image.asset(
                                      ImagePath.forward,
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                ),
                              ),
                              hint: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "selectgotra".tr,
                                  style: fontStyle.copyWith(
                                      color: Color(0xff777777),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              dropdownMaxHeight: 200,
                              itemHeight: 20,
                              validator: (value) {
                                if (value == null) {
                                  return "    Please select caste";
                                }
                              },
                              items: addDividersAfterItemsGotra(
                                  (_gotraModel != null)
                                      ? _gotraModel!.data!
                                      : []),
                              customItemsIndexes: getDividersIndexes(
                                  (_gotraModel != null)
                                      ? _gotraModel!.data!
                                      : []),
                              value: _gotraData,
                              onChanged: (newValue) {
                                print(newValue);
                                setState(() {
                                  _gotraData = newValue;
                                  // if (_formkey.currentState!.validate()) ;
                                });
                                if (_gotraData!.id == 222) {
                                  setState(() {
                                    isSelectOther = true;
                                  });
                                } else {
                                  setState(() {
                                    isSelectOther = false;
                                  });
                                }
                                if (_formkey.currentState!.validate()) ;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          (isSelectOther)
                              ? Container(
                                  height: 45,
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[a-zA-Z+ |\s]"))
                                    ],
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.text,
                                    controller: _otherGotraController,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 232, 15, 15),
                                            width: 1.5),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(
                                            color: Color(0xffd1d1d1),
                                            width: 1.5),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 15),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(
                                            color: Color(0xffD1D1D1),
                                            width: 1.5),
                                      ),
                                      border: OutlineInputBorder(),
                                      labelText: "gotra".tr,
                                      labelStyle: fontStyle.copyWith(
                                          color: Color(0xff777777),
                                          fontWeight: FontWeight.w500),
                                      hintText: "selectgotra".tr,
                                    ),
                                  ),
                                )
                              : Container(),
                          /* DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2<GotraData>(
                              offset: Offset(0, 0),
                              focusColor: Colors.white,
                              buttonHeight: 45,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              decoration: InputDecoration(
                                  focusColor: Colors.white,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide:
                                          BorderSide(color: Color(0xffD1D1D1))),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xffD1D1D1)),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                        color: Color(0xffd1d1d1), width: 1.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide(
                                          color: Color(0xffD1D1D1)))),
                            /*   icon: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Container(
                                  height: 15,
                                  width: 15,
                                  child: Center(
                                    child: Image.asset(
                                      ImagePath.forward,
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                ),
                              ), */
                              hint: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "selectgotra".tr,
                                  style: fontStyle.copyWith(
                                      color: Color(0xff777777),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              dropdownMaxHeight: 200,
                              itemHeight: 20,
                              items: addDividersAfterItemsGotra(
                                  (_gotraModel != null)
                                      ? _gotraModel!.data!
                                      : []),
                              customItemsIndexes: getDividersIndexes(
                                  (_gotraModel != null)
                                      ? _gotraModel!.data!
                                      : []),
                              value: _gotraData,
                              validator: (value) {
                                if (value == null) {
                                  return "    Please select Gotra";
                                }
                              },
                              onChanged: (newValue) {
                                print(newValue);
                                setState(() {
                                  _gotraData = newValue;
                                  // _formkey.currentState!.validate();
                                });
                              },
                            ),
                          ), */
                          SizedBox(height: 15),
                          (widget.fromValue == "Edit")
                              ? Container()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    Contact_screen()));
                                      },
                                      child: Text(
                                        "skipthispage".tr,
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: currentColor),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                CupertinoPageRoute(
                                                    builder: (context) => Zoom(
                                                          selectedIndex: 4,
                                                        )),
                                                (route) => false);
                                      },
                                      child: Text(
                                        "skipallpage".tr,
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: currentColor),
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          (widget.fromValue == "Edit")
                              ? CommonButton(
                                  btnName: "submit".tr,
                                  btnOnTap: () {
                                    if (_formkey.currentState!.validate()) {
                                      /* if (_ageDataFrom == null) {
                                      } else if (_ageDataTo == null) {
                                      } else if (_heightDataFrom == null) {
                                        setState(() {
                                          isFromHeightError = true;
                                        });
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(SnackBar(
                                        //         content: Text(
                                        //             "Please Select HeightFrom")));
                                      } else if (_heightDataTo == null) {
                                        setState(() {
                                          isErrorToHeight = true;
                                        });
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(SnackBar(
                                        //         content: Text(
                                        //             "Please Select HeightTo")));

                                      } else { */
                                      updateLookingForAPI();
                                      // }
                                    } else {
                                      if (_heightDataFrom == null) {
                                        setState(() {
                                          isFromHeightError = true;
                                        });
                                      }
                                      if (_heightDataTo == null) {
                                        setState(() {
                                          isErrorToHeight = true;
                                        });
                                      }
                                      if (_ageDataFrom == null) {
                                        setState(() {
                                          isErroFromAge = true;
                                        });
                                      }
                                      if (_ageDataTo == null) {
                                        setState(() {
                                          isErrorToAge = true;
                                        });
                                      }
                                      print("not submit");
                                    }
                                  },
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 54,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                20,
                                        decoration: BoxDecoration(
                                            color: currentColor,
                                            borderRadius:
                                                BorderRadius.circular(9)),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "back".tr,
                                          style: appBtnStyle,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (_formkey.currentState!.validate()) {
                                          /* if (_ageDataFrom == null) {
                                      } else if (_ageDataTo == null) {
                                      } else if (_heightDataFrom == null) {
                                        setState(() {
                                          isFromHeightError = true;
                                        });
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(SnackBar(
                                        //         content: Text(
                                        //             "Please Select HeightFrom")));
                                      } else if (_heightDataTo == null) {
                                        setState(() {
                                          isErrorToHeight = true;
                                        });
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(SnackBar(
                                        //         content: Text(
                                        //             "Please Select HeightTo")));

                                      } else { */
                                          updateLookingForAPI();
                                          // }
                                        } else {
                                          if (_heightDataFrom == null) {
                                            setState(() {
                                              isFromHeightError = true;
                                            });
                                          }
                                          if (_heightDataTo == null) {
                                            setState(() {
                                              isErrorToHeight = true;
                                            });
                                          }
                                          if (_ageDataFrom == null) {
                                            setState(() {
                                              isErroFromAge = true;
                                            });
                                          }
                                          if (_ageDataTo == null) {
                                            setState(() {
                                              isErrorToAge = true;
                                            });
                                          }
                                          print("not submit");
                                        }
                                        /* if (_ageDataFrom == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Please Select AgeFrom")));
                                        } else if (_ageDataTo == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Please Select AgeTo")));
                                        } else if (_heightDataFrom == null) {
                                          setState(() {
                                            isFromHeightError = true;
                                          });
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(SnackBar(
                                          //         content: Text(
                                          //             "Please Select HeightFrom")));
                                        } else if (_heightDataTo == null) {
                                          setState(() {
                                            isErrorToHeight = true;
                                          });
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(SnackBar(
                                          //         content: Text(
                                          //             "Please Select HeightTo")));
                                        } else if (_annualincomedata == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Please Select Annual Income")));
                                        } else if (_maritalData == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Please Select MaritalStatus")));
                                        } else if (_gotraData == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Please Select GOtra")));
                                        } else if (_data == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Please Select Caste")));
                                        } else {
                                          updateLookingForAPI();
                                        } */
                                      },
                                      child: Container(
                                        height: 54,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                20,
                                        decoration: BoxDecoration(
                                            color: currentColor,
                                            borderRadius:
                                                BorderRadius.circular(9)),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "next".tr,
                                          style: appBtnStyle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getHeightFrom();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getHeightFrom();
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

  getHeightFrom() async {
    CommonUtils.showProgressLoading(context);
    var response = await http.get(
      Uri.parse(GET_HEIGHT_URL),
    );
    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _heightModelFrom = HeightModel.fromJson(jsonDecode(response.body));
        });
        getAgeFrom();
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
    } else {
      CommonUtils.hideProgressLoading();
    }
  }

  getAgeFrom() async {
    var response = await http.get(
      Uri.parse(GET_AGE_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _ageModelFrom = AgeModel.fromJson(jsonDecode(response.body));
        });
        getWorktype();
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
    } else {
      CommonUtils.hideProgressLoading();
    }
  }

  getWorktype() async {
    var response = await http.get(
      Uri.parse(GET_WORKTYPE_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _worktypeModel = workTypeModel.fromJson(jsonDecode(response.body));
          log("work type:::: ${response.body}");
        });
        getAnnualincome();
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
    } else {
      CommonUtils.hideProgressLoading();
    }
  }

  getAnnualincome() async {
    var response = await http.get(
      Uri.parse(GET_ANNUALINCOME_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _annualincomeModel =
              AnnualincomeModel.fromJson(jsonDecode(response.body));
        });
        getMaritalStatus();
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
    } else {
      CommonUtils.hideProgressLoading();
    }
  }

  getMaritalStatus() async {
    var response = await http.get(Uri.parse(GET_MARITAL_STATUS_URL));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['success'] == true) {
        setState(() {
          _getmaritalStatusModel =
              maritalStatus.GetmaritalStatusModel.fromJson(data);
        });
        getQualityAPI();
      } else {}
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

  getQualityAPI() async {
    var response = await http.get(Uri.parse(GET_QUALITY_URL));
    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _getQualityModel =
              quality.GetQualityModel.fromJson(jsonDecode(response.body));
        });
        getCast();
      }
    }
  }

  getCast() async {
    var response = await http.get(
      Uri.parse(GET_CAST_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _castModel = castData.castModel.fromJson(jsonDecode(response.body));
        });
        getGotra();
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
    } else {
      CommonUtils.hideProgressLoading();
    }
  }

  getGotra() async {
    var response = await http.get(
      Uri.parse(GET_GOTRA_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _gotraModel = gotraModel.fromJson(jsonDecode(response.body));
        });
        getLookingForData();
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
    } else {
      CommonUtils.hideProgressLoading();
    }
  }

  Future getHeightTo() async {
    var response = await http.get(Uri.parse(GET_HEIGHT_URL +
        "?select_height=${(_heightDataFrom != null) ? _heightDataFrom!.id : ""}"));

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _heightModelTo = HeightModel.fromJson(jsonDecode(response.body));
        });
        log("Height Data::::${response.body}");
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
    } else {
      CommonUtils.hideProgressLoading();
    }
  }

  Future getAgeTo() async {
    var response = await http.get(
      Uri.parse(GET_AGE_URL +
          "?select_age=${(_ageDataFrom != null) ? _ageDataFrom!.id : ""}"),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _ageModelTo = AgeModel.fromJson(jsonDecode(response.body));
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
    } else {
      CommonUtils.hideProgressLoading();
    }
  }

  getDiet() async {
    var response = await http.get(
      Uri.parse(GET_DIET_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _dietModel = DietModel.fromJson(jsonDecode(response.body));
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
    } else {
      CommonUtils.hideProgressLoading();
    }
  }

  updateLookingForAPI() async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var params = {
      "height_from": (_heightDataFrom != null) ? _heightDataFrom!.id : "",
      "height_to": (_heightDataTo != null) ? _heightDataTo!.id : "",
      "age_from": (_ageDataFrom != null) ? _ageDataFrom!.id : "",
      "age_to": (_ageDataTo != null) ? _ageDataTo!.id : "",
      "work_type": (_worktypeData != null) ? _worktypeData!.id : "",
      "annual_income": (_annualincomedata != null) ? _annualincomedata!.id : "",
      "diet": (dietName['id'] != null)
          ? dietName['id']
          : "" /* (_dietData != null) ? _dietData!.id : "" */,
      "marital_status": (_maritalData != null) ? _maritalData!.id : "",
      "gotra": (_gotraData != null)
          ? (isSelectOther)
              ? _otherGotraController.text
              : _gotraData!.id
          : "",
      "caste": (_data != null) ? _data!.id : "",
      "quality": (qualityData != null) ? qualityData!.id : "",
    };
    var response = await dio.post(UPDATE_LOOKING_FOR_URL + "?" + queryString,
        data: params);
    if (response.statusCode == 200) {
      print(response.data);
      var data = response.data;
      if (data['success'] == true) {
        UpdateLookingForModel _UpdateLookingForModel =
            UpdateLookingForModel.fromJson(data);
        if (widget.fromValue == "Edit") {
          Navigator.pop(context, "UpdateData");
        } else {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => Contact_screen()));
        }
      } else {
        if (widget.fromValue == "Edit") {
          Navigator.pop(context, "UpdateData");
        } else {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => Contact_screen()));
        }
      }
    } else if (response.statusCode == 429) {
      updateLookingForAPI();
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
      var result = response.data;
      CommonUtils.hideProgressLoading();
    }
  }

  getLookingForData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;

    var response =
        await http.get(Uri.parse(GET_LOOKING_FOR_URL + "?" + queryString));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['success'] == true) {
        GetLookingForModel _getLookingForModel =
            GetLookingForModel.fromJson(data);
        if (_heightModelFrom != null && _heightModelFrom!.data != null) {
          for (var i = 0; i < _heightModelFrom!.data!.length; i++) {
            if (_getLookingForModel.data!.heightFrom == null) {
            } else {
              if (int.parse(_getLookingForModel.data!.heightFrom.toString()) ==
                  _heightModelFrom!.data![i].id) {
                setState(() {
                  _heightDataFrom = _heightModelFrom!.data![i];
                  getHeightTo().then((value) {
                    if (_heightModelTo != null &&
                        _heightModelTo!.data != null &&
                        _heightModelFrom != null) {
                      for (var i = 0; i < _heightModelTo!.data!.length; i++) {
                        if (int.parse(_getLookingForModel.data!.heightTo
                                .toString()) ==
                            _heightModelTo!.data![i].id) {
                          setState(() {
                            _heightDataTo = _heightModelTo!.data![i];
                            isHeighTo = true;
                            log("height data as  ::: $_heightDataTo");
                          });
                        }
                      }
                    }
                  });
                });
              }
            }
          }
        }
        if (_ageModelFrom != null && _ageModelFrom!.data != null) {
          for (var i = 0; i < _ageModelFrom!.data!.length; i++) {
            if (_getLookingForModel.data!.ageFrom == null) {
            } else {
              if (int.parse(_getLookingForModel.data!.ageFrom.toString()) ==
                  _ageModelFrom!.data![i].id) {
                setState(() {
                  _ageDataFrom = _ageModelFrom!.data![i];
                  _ageDataFrom!.id = _ageModelFrom!.data![i].id;
                  getAgeTo().then((value) {
                    if (_ageModelTo != null && _ageModelTo!.data != null) {
                      for (var i = 0; i < _ageModelTo!.data!.length; i++) {
                        if (_getLookingForModel.data!.ageTo == null) {
                          print("object");
                        } else {
                          if (int.parse(
                                  _getLookingForModel.data!.ageTo.toString()) ==
                              _ageModelTo!.data![i].id) {
                            setState(() {
                              _ageDataTo = _ageModelTo!.data![i];
                              isAgeTo = true;
                              log("age data as :::: $_ageDataTo");
                            });
                          }
                        }
                      }
                    }
                  });
                });
              }
            }
          }
        }

        if (_worktypeModel != null && _worktypeModel!.data != null) {
          for (var i = 0; i < _worktypeModel!.data!.length; i++) {
            if (int.tryParse(_getLookingForModel.data!.workType.toString()) ==
                _worktypeModel!.data![i].id) {
              setState(() {
                _worktypeData = _worktypeModel!.data![i];
              });
            }
          }
        }
        if (_annualincomeModel != null && _annualincomeModel!.data != null) {
          for (var i = 0; i < _annualincomeModel!.data!.length; i++) {
            if (_getLookingForModel.data!.annualIncome ==
                _annualincomeModel!.data![i].id) {
              setState(() {
                _annualincomedata = _annualincomeModel!.data![i];
              });
            }
          }
        }

        // if (_dietModel != null && _dietModel!.data != null) {
        for (var i = 0; i < dietList.length; i++) {
          if (_getLookingForModel.data!.diet == dietList[i]['id']) {
            setState(() {
              dietName = dietList[i];
            });
          }
        }
        // }
        if (_getmaritalStatusModel != null &&
            _getmaritalStatusModel!.data != null) {
          for (var i = 0; i < _getmaritalStatusModel!.data!.length; i++) {
            if (_getLookingForModel.data!.maritalStatus == null) {
            } else {
              if (int.parse(
                      _getLookingForModel.data!.maritalStatus.toString()) ==
                  _getmaritalStatusModel!.data![i].id) {
                setState(() {
                  _maritalData = _getmaritalStatusModel!.data![i];
                });
              }
            }
          }
        }
        if (_gotraModel != null && _gotraModel!.data != null) {
          for (var i = 0; i < _gotraModel!.data!.length; i++) {
            if (_getLookingForModel.data!.gotra == _gotraModel!.data![i].id) {
              setState(() {
                _gotraData = _gotraModel!.data![i];
              });
            }
          }
        }
        if (_castModel != null && _castModel!.data != null) {
          for (var i = 0; i < _castModel!.data!.length; i++) {
            if (_getLookingForModel.data!.caste == _castModel!.data![i].id) {
              setState(() {
                _data = _castModel!.data![i];
              });
            }
          }
        }
        if (_getQualityModel != null && _getQualityModel!.data != null) {
          for (var i = 0; i < _getQualityModel!.data!.length; i++) {
            if (_getLookingForModel.data!.quality ==
                _getQualityModel!.data![i].id) {
              setState(() {
                qualityData = _getQualityModel!.data![i];
              });
            }
          }
        }
        CommonUtils.hideProgressLoading();

        log(response.body);
      } else {
        CommonUtils.hideProgressLoading();
      }
    } else if (response.statusCode == 429) {
      getLookingForData();
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

  List<DropdownMenuItem<castData.castData>> addDividersAfterItems(
      List<castData.castData> items) {
    List<DropdownMenuItem<castData.castData>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<castData.castData>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 10),
              child: Text(
                item.name.toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<castData.castData>(
              enabled: false,
              child: Divider(
                height: 0,
              ),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<DropdownMenuItem<quality.Data>> addDividersAfterItemsQuality(
      List<quality.Data> items) {
    List<DropdownMenuItem<quality.Data>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<quality.Data>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 10),
              child: Text(
                item.name.toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<quality.Data>(
              enabled: false,
              child: Divider(
                height: 0,
              ),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<DropdownMenuItem<HeightData>> addDividersAfterItemsHeight(
      List<HeightData> items) {
    List<DropdownMenuItem<HeightData>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<HeightData>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 10),
              child: Text(
                item.height.toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<HeightData>(
              enabled: false,
              child: Divider(
                height: 0,
              ),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<DropdownMenuItem<AgeData>> addDividersAfterItemsAge(
      List<AgeData> items) {
    List<DropdownMenuItem<AgeData>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<AgeData>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 10),
              child: Text(
                item.name.toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<AgeData>(
              enabled: false,
              child: Divider(
                height: 0,
              ),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<DropdownMenuItem<WorktypeData>> addDividersAfterItemsWorkType(
      List<WorktypeData> items) {
    List<DropdownMenuItem<WorktypeData>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<WorktypeData>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 10),
              child: Text(
                item.name.toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<WorktypeData>(
              enabled: false,
              child: Divider(
                height: 0,
              ),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<DropdownMenuItem<AnnualData>> addDividersAfterItemsAnnualIncome(
      List<AnnualData> items) {
    List<DropdownMenuItem<AnnualData>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<AnnualData>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 10),
              child: Text(
                item.incomes.toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<AnnualData>(
              enabled: false,
              child: Divider(
                height: 0,
              ),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<DropdownMenuItem<Map<String, dynamic>>> addDividersAfterItemsDiet(
      List<Map<String, dynamic>> items) {
    List<DropdownMenuItem<Map<String, dynamic>>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<Map<String, dynamic>>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 10),
              child: Text(
                item['name'],
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<Map<String, dynamic>>(
              enabled: false,
              child: Divider(
                height: 0,
              ),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<DropdownMenuItem<maritalStatus.Data>> addDividersAfterItemsMaritalStatus(
      List<maritalStatus.Data> items) {
    List<DropdownMenuItem<maritalStatus.Data>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<maritalStatus.Data>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 10),
              child: Text(
                item.name.toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<maritalStatus.Data>(
              enabled: false,
              child: Divider(
                height: 0,
              ),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<DropdownMenuItem<GotraData>> addDividersAfterItemsGotra(
      List<GotraData> items) {
    List<DropdownMenuItem<GotraData>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<GotraData>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 10),
              child: Text(
                item.name.toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<GotraData>(
              enabled: false,
              child: Divider(
                height: 0,
              ),
            ),
        ],
      );
    }
    return _menuItems;
  }

  getDividersIndexes(items) {
    List<int> _getDividersIndexes() {
      List<int> _dividersIndexes = [];
      for (var i = 0; i < (items.length * 2) - 1; i++) {
        if (i.isOdd) {
          _dividersIndexes.add(i);
        }
      }
      return _dividersIndexes;
    }
  }
}
