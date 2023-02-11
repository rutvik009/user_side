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
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/GetProfile_Details/Get_Family_Detail_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Update_Profile_Details/Update_Family_Detail_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/annualincome_model.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/Drawer_Screen.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/basic_detail.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/location.dart';
import 'package:matrimonial_app/Utils/DropDownList.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/submit_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widget/commentextfieldnumber.dart';

class Family_Detail extends StatefulWidget {
  String? fromValue;
  Family_Detail({Key? key, this.fromValue}) : super(key: key);

  @override
  State<Family_Detail> createState() => _Family_DetailState();
}

class _Family_DetailState extends State<Family_Detail> {
  final _formKey = GlobalKey<FormState>();
  bool selectBroValue = false;
  bool selectSisValue = false;
  bool familytypeselected = false;
  bool fatherOccupationSelected = false;
  bool motherOccupationSelected = false;
  bool nextPressed = false;
  bool isMotherTongue = false;
  FocusNode _noOfBrotherfocusenode = FocusNode();
  FocusNode _noOfSisterfocusenode = FocusNode();
  FocusNode _Brotherfocusenode = FocusNode();
  FocusNode _Sisterfocusenode = FocusNode();
  Dio dio = Dio();

  AnnualData? _annualincomedata;
  AnnualincomeModel? _annualincomeModel;
  // religionData.Data? _data;
  // religionData.ReligionData? _religionData;
  final TextEditingController _familyTypecontroller = TextEditingController();
  final TextEditingController _motherTonguecontroller = TextEditingController();
  final TextEditingController _fatherOccupationcontroller =
      TextEditingController();
  final TextEditingController _motherOccupationcontroller =
      TextEditingController();
  final TextEditingController _noOfBrothercontroller = TextEditingController();
  final TextEditingController _marriedBrocontroller = TextEditingController();
  final TextEditingController _noOfSistercontroller = TextEditingController();
  final TextEditingController _marriedSiscontroller = TextEditingController();
  final TextEditingController _familyBasecontroller = TextEditingController();
  bool changetext = false;
  var noOfBrother;
  var noOfMarriedBrother;
  var noOfSister;
  var noOfMarriedSister;
  @override
  void initState() {
    checkConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              children: [
                ProfileDataGetAppbar(name: "family detail".tr),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
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
                          SizedBox(height: 15),
                          (widget.fromValue == "Edit")
                              ? Container()
                              : Image.asset(ImagePath.familyDetai, height: 19),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "familytype".tr,
                                    style: TextStyle(
                                      color: Color(0xff838994),
                                      fontWeight: FontWeight.w400,
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
                          SizedBox(
                            height: 5,
                          ),
                          DropdownButtonHideUnderline(
                            child:
                                DropdownButtonFormField2<Map<String, dynamic>>(
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
                                    color: Color(0xffD1D1D1),
                                  ),
                                ),
                              ),
                              icon: Padding(
                                padding: const EdgeInsets.all(15.0),
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
                                  "enterfamilytype".tr,
                                  style: fontStyle.copyWith(
                                      color: Color(0xff777777),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              items: _addDividersAfterItems(familytypeList),
                              customItemsIndexes: _getDividersIndexes(),
                              customItemsHeight: 2,
                              buttonHeight: 45,
                              buttonWidth: 140,
                              itemHeight: 40,
                              validator: (value) {
                                if (value == null) {
                                  return '    Please select family type';
                                }
                              },
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              value: (familytype.isNotEmpty)
                                  ? familytype
                                  : familytype['name'],
                              onChanged: (value) {
                                setState(() {
                                  familytype = value!;
                                  if (_formKey.currentState!.validate()) ;
                                  log(familytype.toString());
                                });
                              },
                            ),
                          ),
                          /* SizedBox(
                            height: 12,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "religion".tr,
                                  style: TextStyle(
                                    color: Color(0xff838994),
                                    fontWeight: FontWeight.w400,
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
                            child: DropdownButtonFormField2<religionData.Data>(
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
                                  height: 12,
                                  width: 12,
                                  child: Center(
                                    child: Image.asset(
                                      ImagePath.forward,
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                ),
                              ),
                              hint: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "selectreligion".tr,
                                  style: fontStyle.copyWith(
                                      color: Color(0xff777777),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              dropdownMaxHeight: 200,
                              itemHeight: 20,
                              items: addDividersAfterItems(
                                  (_religionData != null)
                                      ? _religionData!.data!
                                      : []),
                              customItemsIndexes: getDividersIndexes(
                                  (_religionData != null)
                                      ? _religionData!.data!
                                      : []),
                              value: _data,
                              validator: (value) {
                                if (value == null) {
                                  return '    Please select Religion';
                                }
                              },
                              onChanged: (newValue) {
                                print(newValue);
                                setState(() {
                                  _data = newValue;
                                  if (_formKey.currentState!.validate()) ;
                                });
                              },
                            ),
                          ), */
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            validator: (value) {
                              if (value!.isEmpty) {
                                /*  setState(() {
                                  isMotherTongue = true;
                                }); */
                                return "Please Enter Mother Tongue";
                              }
                            },
                            onChanged: (value) {
                              if (_formKey.currentState!.validate()) {
                                /*  if (value.isEmpty) {
                                  setState(() {
                                    isMotherTongue = true;
                                  });
                                } else {
                                  setState(() {
                                    isMotherTongue = false;
                                  });
                                } */
                              }
                            },
                            controller: _motherTonguecontroller,
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp("[A-Za-z]"),
                              ),
                              LengthLimitingTextInputFormatter(12)
                            ],
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 232, 15, 15),
                                    width: 1.5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: BorderSide(
                                    color: Color(0xffd1d1d1), width: 1.5),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 15),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: BorderSide(
                                    color: Color(0xffD1D1D1), width: 1.5),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13)),
                              label: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "mothertongue".tr,
                                      style: TextStyle(
                                        color: Color(0xff838994),
                                        fontWeight: FontWeight.w400,
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
                              labelStyle: fontStyle.copyWith(
                                  color: Color(0xff777777),
                                  fontWeight: FontWeight.w500),
                              hintText: "enetrmothertongue".tr,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          /* (isMotherTongue)
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text(
                                    "Please Enter Mother Tongue",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : Container(), */
                          SizedBox(
                            height: 12,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "father's occupation".tr,
                                  style: TextStyle(
                                    color: Color(0xff838994),
                                    fontWeight: FontWeight.w400,
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
                            child:
                                DropdownButtonFormField2<Map<String, dynamic>>(
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
                              dropdownMaxHeight: 200,
                              icon: Padding(
                                padding: const EdgeInsets.all(15.0),
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
                                  "enteroccupation".tr,
                                  style: fontStyle.copyWith(
                                      color: Color(0xff777777),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              items: _addDividersAfterItemsfatherOccupation(
                                  fatherOccupationList),
                              customItemsIndexes:
                                  _getDividersIndexesOccupation(),
                              customItemsHeight: 2,
                              buttonHeight: 45,
                              buttonWidth: 140,
                              itemHeight: 40,
                              validator: (value) {
                                if (value == null) {
                                  return "    Please select Father's occupation";
                                }
                              },
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              value: (fatherOccupation.isNotEmpty)
                                  ? fatherOccupation
                                  : fatherOccupation['name'],
                              onChanged: (value) {
                                setState(() {
                                  fatherOccupation = value!;
                                  if (_formKey.currentState!.validate()) ;
                                  log(fatherOccupation.toString());
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "mother's occupation".tr,
                                  style: TextStyle(
                                    color: Color(0xff838994),
                                    fontWeight: FontWeight.w400,
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
                            child:
                                DropdownButtonFormField2<Map<String, dynamic>>(
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              decoration: InputDecoration(
                                errorStyle: TextStyle(),
                                focusColor: Colors.white,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13),
                                  borderSide: BorderSide(
                                    color: Color(0xffD1D1D1),
                                  ),
                                ),
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
                                    color: Color(0xffD1D1D1),
                                  ),
                                ),
                              ),
                              dropdownMaxHeight: 200,
                              icon: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  height: 12,
                                  width: 12,
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
                                  "enteroccupation".tr,
                                  style: fontStyle.copyWith(
                                      color: Color(0xff777777),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              items: _addDividersAfterItemsmotherOccupation(
                                  motherOccupationList),
                              customItemsIndexes:
                                  _getDividersIndexesmotherOccupation(),
                              customItemsHeight: 2,
                              buttonHeight: 45,
                              buttonWidth: 140,
                              itemHeight: 40,
                              validator: (value) {
                                if (value == null) {
                                  return "    Please select Mother's occupation";
                                }
                              },
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              value: (motherOccupation.isNotEmpty)
                                  ? motherOccupation
                                  : motherOccupation['name'],
                              onChanged: (value) {
                                setState(() {
                                  motherOccupation = value!;
                                  if (_formKey.currentState!.validate()) ;
                                  log(motherOccupation.toString());
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "family income".tr,
                            style: headerstyle.copyWith(
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                color: Color(0xffD1D1D1),
                                width: 1.5,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<AnnualData>(
                                focusColor: Colors.white,
                                buttonHeight: 40,
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
                                        height: 24,
                                        width: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                hint: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "selectannualincome".tr,
                                    style: fontStyle.copyWith(
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                dropdownMaxHeight: 200,
                                itemHeight: 20,
                                items: addDividersAfterItemsIncome(
                                    (_annualincomeModel != null)
                                        ? _annualincomeModel!.data!
                                        : []),
                                customItemsIndexes: getDividersIndexes(
                                    (_annualincomeModel != null)
                                        ? _annualincomeModel!.data!
                                        : []),
                                value: _annualincomedata,
                                onChanged: (newValue) {
                                  print(newValue);
                                  setState(() {
                                    _annualincomedata = newValue as AnnualData?;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: CommonTextFieldnumber(
                                      focusenode: _noOfBrotherfocusenode,
                                      controller: _noOfBrothercontroller,
                                      lableName: "noofbrother".tr,
                                      hinttext: !_noOfBrotherfocusenode.hasFocus
                                          ? AppConstants.noBrother
                                          : "",
                                      inputlength: 2,
                                      padding: 0),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: CommonTextFieldnumber(
                                      focusenode: _Brotherfocusenode,
                                      controller: _marriedBrocontroller,
                                      lableName: "noofmarried".tr,
                                      hinttext: !_Brotherfocusenode.hasFocus
                                          ? AppConstants.marriedNo
                                          : " ",
                                      inputlength: 2,
                                      padding: 0),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: CommonTextFieldnumber(
                                      focusenode: _Sisterfocusenode,
                                      controller: _noOfSistercontroller,
                                      lableName: "noofsister".tr,
                                      hinttext: !_Sisterfocusenode.hasFocus
                                          ? AppConstants.noSister
                                          : "",
                                      inputlength: 2,
                                      padding: 0),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: CommonTextFieldnumber(
                                      focusenode: _noOfSisterfocusenode,
                                      controller: _marriedSiscontroller,
                                      lableName: "noofmarried".tr,
                                      hinttext: !_noOfSisterfocusenode.hasFocus
                                          ? AppConstants.marriedNo
                                          : "",
                                      inputlength: 2,
                                      padding: 0),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            onTap: () {},
                            controller: _familyBasecontroller,
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(25),
                              FilteringTextInputFormatter.allow(
                                RegExp("[A-Za-z |\s]"),
                              ),
                            ],
                            validator: (value) {
                               if (value!.length == 18) {
                                return 'You can add maximum 18 characters only';
                              }
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 232, 15, 15),
                                    width: 1.5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: BorderSide(
                                    color: Color(0xffd1d1d1), width: 1.5),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 15),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: BorderSide(
                                    color: Color(0xffD1D1D1), width: 1.5),
                              ),
                              border: OutlineInputBorder(),
                              labelText: "familybasedoutof".tr,
                              labelStyle: fontStyle.copyWith(
                                  color: Color(0xff777777),
                                  fontWeight: FontWeight.w500),
                              hintText: "enterfamilybasedoutof".tr,
                            ),
                          ),
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
                                                Location_screen(),
                                          ),
                                        );
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
                          (selectBroValue)
                              ? Center(
                                  child: Container(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    decoration: BoxDecoration(
                                        color: currentColor,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Invalid Value of Married",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: 10,
                          ),
                          (widget.fromValue == "Edit")
                              ? CommonButton(
                                  btnName: "submit".tr,
                                  btnOnTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      /* if (_religionData == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please Select Religion")));
                                      } else if (familytype == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please Select Family Type")));
                                      } else if (fatherOccupation == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please Select Father Occupation")));
                                      } */
                                      noOfBrother =
                                          _noOfBrothercontroller.text.isEmpty
                                              ? "0"
                                              : _noOfBrothercontroller.text;
                                      noOfMarriedBrother =
                                          _marriedBrocontroller.text.isEmpty
                                              ? "0"
                                              : _marriedBrocontroller.text;
                                      noOfSister =
                                          _noOfSistercontroller.text.isEmpty
                                              ? "0"
                                              : _noOfSistercontroller.text;
                                      noOfMarriedSister =
                                          _marriedSiscontroller.text.isEmpty
                                              ? "0"
                                              : _marriedSiscontroller.text;
                                      log(noOfBrother);
                                      if (int.parse(noOfBrother) <
                                              int.parse(noOfMarriedBrother) ||
                                          int.parse(noOfSister) <
                                              int.parse(noOfMarriedSister)) {
                                        setState(() {
                                          selectBroValue = true;
                                          selectSisValue = true;
                                        });
                                        Future.delayed(Duration(seconds: 2),
                                            () {
                                          setState(() {
                                            selectBroValue = false;
                                          });
                                        });

                                        /* Fluttertoast.showToast(
                                            msg: "Invalid Value of Married",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Color(0xffE16284),
                                            textColor: Colors.white,
                                            fontSize: 16.0); */
                                      } else {
                                        UpdateFamilyDetailAPI();
                                      }
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
                                            gradient: AppColors.appColor,
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
                                        if (_formKey.currentState!.validate()) {
                                          /* if (_religionData == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Please Select Religion")));
                                          } else if (familytype == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Please Select Family Type")));
                                          } else if (fatherOccupation == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Please Select Father Occupation")));
                                          } */
                                          noOfBrother = _noOfBrothercontroller
                                                  .text.isEmpty
                                              ? "0"
                                              : _noOfBrothercontroller.text;
                                          noOfMarriedBrother =
                                              _marriedBrocontroller.text.isEmpty
                                                  ? "0"
                                                  : _marriedBrocontroller.text;
                                          noOfSister =
                                              _noOfSistercontroller.text.isEmpty
                                                  ? "0"
                                                  : _noOfSistercontroller.text;
                                          noOfMarriedSister =
                                              _marriedSiscontroller.text.isEmpty
                                                  ? "0"
                                                  : _marriedSiscontroller.text;
                                          log(noOfBrother);
                                          if (int.parse(noOfBrother) <
                                                  int.parse(
                                                      noOfMarriedBrother) ||
                                              int.parse(noOfSister) <
                                                  int.parse(
                                                      noOfMarriedSister)) {
                                            setState(
                                              () {
                                                selectBroValue = true;
                                                selectSisValue = true;
                                              },
                                            );

                                            Fluttertoast.showToast(
                                                msg: "Invalid Value of Married",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor:
                                                    Color(0xffE16284),
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          } else {
                                            UpdateFamilyDetailAPI();
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: 54,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                20,
                                        decoration: BoxDecoration(
                                            gradient: AppColors.appColor,
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
      // getFamilyDetailAPI();
      getAnnualincome();
      // getReion();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // getFamilyDetailAPI();
      getAnnualincome();
      // getReion();
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

  getAnnualincome() async {
    CommonUtils.showProgressLoading(context);
    var response = await http.get(
      Uri.parse(GET_ANNUALINCOME_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _annualincomeModel =
              AnnualincomeModel.fromJson(jsonDecode(response.body));
        });
        getFamilyDetailAPI();
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

  /*  getReion() async {
    var response = await http.get(
      Uri.parse(GET_RILIGION),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _religionData =
              religionData.ReligionData.fromJson(jsonDecode(response.body));
        });
        getFamilyDetailAPI();
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
  } */

  getFamilyDetailAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;

    var response = await dio.get(GET_FAMILY_URL + "?" + queryString);
    if (response.statusCode == 200) {
      print(response.data);
      GetFamilyDetailModel _getFamilyDetailModel =
          GetFamilyDetailModel.fromJson(response.data);
      setState(() {
        _familyTypecontroller.text =
            (_getFamilyDetailModel.data!.familyType != null)
                ? _getFamilyDetailModel.data!.familyType.toString()
                : "";
        _motherTonguecontroller.text =
            (_getFamilyDetailModel.data!.familyType != null)
                ? _getFamilyDetailModel.data!.motherTounge.toString()
                : "";

        _noOfBrothercontroller.text =
            (_getFamilyDetailModel.data!.familyType != null)
                ? _getFamilyDetailModel.data!.noBrothers != "0"
                    ? _getFamilyDetailModel.data!.noBrothers.toString()
                    : ""
                : "";
        _marriedBrocontroller.text =
            (_getFamilyDetailModel.data!.familyType != null)
                ? _getFamilyDetailModel.data!.marriedBrothers != "0"
                    ? _getFamilyDetailModel.data!.marriedBrothers.toString()
                    : ""
                : "";
        _marriedSiscontroller.text =
            (_getFamilyDetailModel.data!.familyType != null)
                ? _getFamilyDetailModel.data!.marriedSisters != "0"
                    ? _getFamilyDetailModel.data!.marriedSisters.toString()
                    : ""
                : "";
        _noOfSistercontroller.text =
            (_getFamilyDetailModel.data!.familyType != null)
                ? _getFamilyDetailModel.data!.noSisters != "0"
                    ? _getFamilyDetailModel.data!.noSisters.toString()
                    : ""
                : "";
        _familyBasecontroller.text =
            (_getFamilyDetailModel.data!.familyType != null)
                ? _getFamilyDetailModel.data!.familyBasedOut.toString()
                : "";
        /* if (_religionData != null && _religionData!.data != null) {
          for (var i = 0; i < _religionData!.data!.length; i++) {
            if (_getFamilyDetailModel.data!.religion ==
                _religionData!.data![i].id) {
              _data = _religionData!.data![i];
            }
          }
        } */
        for (var i = 0; i < familytypeList.length; i++) {
          if (int.tryParse(_getFamilyDetailModel.data!.familyType.toString()) ==
              familytypeList[i]['id']) {
            familytype = familytypeList[i];
          }
        }

        for (var i = 0; i < fatherOccupationList.length; i++) {
          if (int.tryParse(
                  _getFamilyDetailModel.data!.fatherOccupation.toString()) ==
              fatherOccupationList[i]['id']) {
            fatherOccupation = fatherOccupationList[i];
          }
        }
        for (var i = 0; i < motherOccupationList.length; i++) {
          if (int.tryParse(
                  _getFamilyDetailModel.data!.motherOccupation.toString()) ==
              motherOccupationList[i]['id']) {
            motherOccupation = motherOccupationList[i];
          }
        }

        if (_annualincomeModel != null && _annualincomeModel!.data != null) {
          for (var i = 0; i < _annualincomeModel!.data!.length; i++) {
            if (_getFamilyDetailModel.data!.familyIncome != null) {
              if (int.parse(_getFamilyDetailModel.data!.familyIncome!) ==
                  _annualincomeModel!.data![i].id) {
                _annualincomedata = _annualincomeModel!.data![i];
              }
            }
          }
        }
      });
      CommonUtils.hideProgressLoading();
    } else if (response.statusCode == 429) {
      getFamilyDetailAPI();
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

  UpdateFamilyDetailAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var params = {
      "family_type": (familytype.isNotEmpty) ? familytype['id'] : "",
      // "religion": (_data != null) ? _data!.id : "",
      "mother_tounge": _motherTonguecontroller.text,
      "father_occupation":
          (fatherOccupation.isNotEmpty) ? fatherOccupation['id'] : "",
      "mother_occupation":
          (motherOccupation.isNotEmpty) ? motherOccupation['id'] : "",
      "family_income": (_annualincomedata != null) ? _annualincomedata!.id : "",
      "no_brothers": noOfBrother,
      "married_brothers": noOfMarriedBrother,
      "no_sisters": noOfSister,
      "married_sisters": noOfMarriedSister,
      "family_based_out": _familyBasecontroller.text,
    };
    var response = await dio.post(UPDATE_FAMILY_DETAIL_URL + "?" + queryString,
        data: params);
    if (response.statusCode == 200) {
      var data = response.data;
      if (data['success'] == true) {
        UpdateFamilyDetailModel _updateFamilyDetailModel =
            UpdateFamilyDetailModel.fromJson(data);
        if (widget.fromValue == "Edit") {
          Navigator.pop(context, "UpdateData");
        } else {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => Location_screen(),
            ),
          );
        }
      } else {
        if (widget.fromValue == "Edit") {
          Navigator.pop(context, "UpdateData");
        } else {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => Location_screen(),
            ),
          );
        }
      }
    } else if (response.statusCode == 429) {
      UpdateFamilyDetailAPI();
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

  /* void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getFamilyDetailAPI();
      getAnnualincome();
      getReion();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getFamilyDetailAPI();
      getAnnualincome();
      getReion();
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

  getReion() async {
    var response = await http.get(
      Uri.parse(GET_RILIGION),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _religionData =
              religionData.ReligionData.fromJson(jsonDecode(response.body));
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

  UpdateFamilyDetailAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var params = {
      "family_type": (familytype.isNotEmpty) ? familytype['id'] : "",
      "religion": (_data != null) ? _data!.id : "",
      "mother_tounge": _motherTonguecontroller.text,
      "father_occupation":
          (fatherOccupation.isNotEmpty) ? fatherOccupation['id'] : "",
      "mother_occupation":
          (motherOccupation.isNotEmpty) ? motherOccupation['id'] : "",
      "family_income": (_annualincomedata != null) ? _annualincomedata!.id : "",
      "no_brothers": _noOfBrothercontroller.text,
      "married_brothers": _marriedBrocontroller.text,
      "no_sisters": _noOfSistercontroller.text,
      "married_sisters": _marriedSiscontroller.text,
      "family_based_out": _familyBasecontroller.text,
    };
    var response = await dio.post(UPDATE_FAMILY_DETAIL_URL + "?" + queryString,
        data: params);
    if (response.statusCode == 200) {
      var data = response.data;
      if (data['success'] == true) {
        UpdateFamilyDetailModel _updateFamilyDetailModel =
            UpdateFamilyDetailModel.fromJson(data);
        if (widget.fromValue == "Edit") {
          Navigator.pop(context, "UpdateData");
        } else {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => Location_screen(),
            ),
          );
        }
      } else {
        if (widget.fromValue == "Edit") {
          Navigator.pop(context, "UpdateData");
        } else {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => Location_screen(),
            ),
          );
        }
      }
    } else if (response.statusCode == 429) {
      UpdateFamilyDetailAPI();
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

  getFamilyDetailAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    CommonUtils.showProgressLoading(context);
    var response = await dio.get(GET_FAMILY_URL + "?" + queryString);
    if (response.statusCode == 200) {
      print(response.data);
      GetFamilyDetailModel _getFamilyDetailModel =
          GetFamilyDetailModel.fromJson(response.data);
      setState(() {
        _familyTypecontroller.text =
            (_getFamilyDetailModel.data!.familyType != null)
                ? _getFamilyDetailModel.data!.familyType.toString()
                : "";
        _motherTonguecontroller.text =
            (_getFamilyDetailModel.data!.familyType != null)
                ? _getFamilyDetailModel.data!.motherTounge.toString()
                : "";

        _noOfBrothercontroller.text =
            (_getFamilyDetailModel.data!.familyType != null)
                ? _getFamilyDetailModel.data!.noBrothers.toString()
                : "";
        _marriedBrocontroller.text =
            (_getFamilyDetailModel.data!.familyType != null)
                ? _getFamilyDetailModel.data!.marriedBrothers.toString()
                : "";
        _marriedSiscontroller.text =
            (_getFamilyDetailModel.data!.familyType != null)
                ? _getFamilyDetailModel.data!.marriedSisters.toString()
                : "";
        _noOfSistercontroller.text =
            (_getFamilyDetailModel.data!.familyType != null)
                ? _getFamilyDetailModel.data!.noSisters.toString()
                : "";
        _familyBasecontroller.text =
            (_getFamilyDetailModel.data!.familyType != null)
                ? _getFamilyDetailModel.data!.familyBasedOut.toString()
                : "";
        if (_religionData != null && _religionData!.data != null) {
          for (var i = 0; i < _religionData!.data!.length; i++) {
            if (_getFamilyDetailModel.data!.religion ==
                _religionData!.data![i].id) {
              _data = _religionData!.data![i];
            }
          }
        }
        for (var i = 0; i < familytypeList.length; i++) {
          if (int.tryParse(_getFamilyDetailModel.data!.familyType.toString()) ==
              familytypeList[i]['id']) {
            familytype = familytypeList[i];
          }
        }

        for (var i = 0; i < fatherOccupationList.length; i++) {
          if (int.tryParse(
                  _getFamilyDetailModel.data!.fatherOccupation.toString()) ==
              fatherOccupationList[i]['id']) {
            fatherOccupation = fatherOccupationList[i];
          }
        }
        for (var i = 0; i < motherOccupationList.length; i++) {
          if (int.tryParse(
                  _getFamilyDetailModel.data!.motherOccupation.toString()) ==
              motherOccupationList[i]['id']) {
            motherOccupation = motherOccupationList[i];
          }
        }

        if (_annualincomeModel != null && _annualincomeModel!.data != null) {
          for (var i = 0; i < _annualincomeModel!.data!.length; i++) {
            if (_getFamilyDetailModel.data!.familyIncome != null) {
              if (int.parse(_getFamilyDetailModel.data!.familyIncome!) ==
                  _annualincomeModel!.data![i].id) {
                _annualincomedata = _annualincomeModel!.data![i];
              }
            }
          }
        }
      });
      CommonUtils.hideProgressLoading();
    } else if (response.statusCode == 429) {
      getFamilyDetailAPI();
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
 */
  /* List<DropdownMenuItem<religionData.Data>> addDividersAfterItems(
      List<religionData.Data> items) {
    List<DropdownMenuItem<religionData.Data>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<religionData.Data>(
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
            const DropdownMenuItem<religionData.Data>(
              enabled: false,
              child: Divider(
                height: 0,
              ),
            ),
        ],
      );
    }
    return _menuItems;
  } */

  List<DropdownMenuItem<AnnualData>> addDividersAfterItemsIncome(
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

  Map<String, dynamic> familytype = {};
  List<DropdownMenuItem<Map<String, dynamic>>> _addDividersAfterItems(
      List<Map<String, dynamic>> familytype) {
    List<DropdownMenuItem<Map<String, dynamic>>> _menuItems = [];
    for (var item in familytypeList) {
      _menuItems.addAll(
        [
          DropdownMenuItem<Map<String, dynamic>>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item['name'],
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != familytypeList.last)
            const DropdownMenuItem<Map<String, dynamic>>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<int> _getDividersIndexes() {
    List<int> _dividersIndexes = [];
    for (var i = 0; i < (familytypeList.length * 2) - 1; i++) {
      if (i.isOdd) {
        _dividersIndexes.add(i);
      }
    }
    return _dividersIndexes;
  }

  Map<String, dynamic> fatherOccupation = {};
  List<DropdownMenuItem<Map<String, dynamic>>>
      _addDividersAfterItemsfatherOccupation(
          List<Map<String, dynamic>> fatherOccupation) {
    List<DropdownMenuItem<Map<String, dynamic>>> _menuItems = [];
    for (var item in fatherOccupationList) {
      _menuItems.addAll(
        [
          DropdownMenuItem<Map<String, dynamic>>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item['name'],
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != fatherOccupationList.last)
            const DropdownMenuItem<Map<String, dynamic>>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<int> _getDividersIndexesOccupation() {
    List<int> _dividersIndexes = [];
    for (var i = 0; i < (fatherOccupationList.length * 2) - 1; i++) {
      if (i.isOdd) {
        _dividersIndexes.add(i);
      }
    }
    return _dividersIndexes;
  }

  Map<String, dynamic> motherOccupation = {};
  List<DropdownMenuItem<Map<String, dynamic>>>
      _addDividersAfterItemsmotherOccupation(
          List<Map<String, dynamic>> fatherOccupation) {
    List<DropdownMenuItem<Map<String, dynamic>>> _menuItems = [];
    for (var item in motherOccupationList) {
      _menuItems.addAll(
        [
          DropdownMenuItem<Map<String, dynamic>>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item['name'],
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != motherOccupationList.last)
            const DropdownMenuItem<Map<String, dynamic>>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<int> _getDividersIndexesmotherOccupation() {
    List<int> _dividersIndexes = [];
    for (var i = 0; i < (motherOccupationList.length * 2) - 1; i++) {
      if (i.isOdd) {
        _dividersIndexes.add(i);
      }
    }
    return _dividersIndexes;
  }
}
