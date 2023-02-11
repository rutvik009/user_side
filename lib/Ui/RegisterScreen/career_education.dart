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
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/GetProfile_Details/Get_Career_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/Get_Profession_Model.dart'
    as profession;
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/Get_education_model.dart'
    as eduction;
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/Get_education_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Update_Profile_Details/Update_Career_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/annualincome_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/qualification_model.dart'
    as qaulification;
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/Drawer_Screen.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/basic_detail.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/famliy_detail.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/submit_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Career_Education extends StatefulWidget {
  String? fromValue;
  Career_Education({Key? key, this.fromValue}) : super(key: key);

  @override
  State<Career_Education> createState() => _Career_EducationState();
}

String? ielts;
String? govtjob;

class _Career_EducationState extends State<Career_Education> {
  String? gender;
  GetEducationModel? _getEducationModel;
  eduction.Data? _eductiondata;
  bool ganderSelcted = false;
  bool nextPressed = false;
  Dio dio = Dio();
  qaulification.QualificationModel? _qualificationModel;
  AnnualincomeModel? _annualincomeModel;
  qaulification.Data? _data;
  AnnualData? _annualincomedata;
  profession.GetProfessionModel? _getProfessionModel;
  profession.Data? _professionData;

  final TextEditingController _educationcontroller = TextEditingController();
  final TextEditingController _universitynamecontroller =
      TextEditingController();
  bool changetext = false;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    checkConnection();
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
                ProfileDataGetAppbar(name: "career".tr),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppConstants.seemsYou,
                            style: headingStyle.copyWith(
                                color: Color(0xff838994),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          (widget.fromValue == "Edit")
                              ? Container()
                              : SizedBox(height: 20),
                          (widget.fromValue == "Edit")
                              ? Container()
                              : Image.asset(ImagePath.career, height: 19),
                          SizedBox(
                            height: 20,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "profession".tr,
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
                          Container(
                            // height: 45,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(2),
                            /* decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                color: Color(0xffD1D1D1),
                                width: 1.5,
                              ),
                            ), */
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField2<profession.Data>(
                                focusColor: Colors.white,
                                buttonHeight: 40,
                                decoration: InputDecoration(
                                    focusColor: Colors.white,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(
                                            color: Color(0xffD1D1D1))),
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
                                /* dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                ), */
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
                                    "selectprofession".tr,
                                    style: fontStyle.copyWith(
                                        fontSize: 15,
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                dropdownMaxHeight: 200,
                                itemHeight: 20,
                                validator: (value) {
                                  if (value == null) {
                                    return '    Please select Profession';
                                  }
                                },
                                items: addDividersAfterItems(
                                    (_getProfessionModel != null)
                                        ? _getProfessionModel!.data!
                                        : []),
                                customItemsIndexes: getDividersIndexes(
                                    (_getProfessionModel != null)
                                        ? _getProfessionModel!.data!
                                        : []),
                                value: _professionData,
                                onChanged: (newValue) {
                                  print(newValue);
                                  setState(() {
                                    _professionData = newValue;
                                  });
                                  if (_formkey.currentState!.validate()) ;
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
                          Container(
                            // height: 45,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(2),
                            /* decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                color: Color(0xffD1D1D1),
                                width: 1.5,
                              ),
                            ), */
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField2<AnnualData>(
                                focusColor: Colors.white,
                                buttonHeight: 40,
                                /* dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                ), */
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
                                    "selectannual".tr,
                                    style: fontStyle.copyWith(
                                        fontSize: 15,
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                dropdownMaxHeight: 200,
                                itemHeight: 20,
                                validator: (value) {
                                  if (value == null) {
                                    return '    Please select Annual Income';
                                  }
                                },
                                items: addDividersAfterItemsAnnualData(
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
                                    _annualincomedata = newValue;
                                  });
                                  if (_formkey.currentState!.validate()) ;
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
                                  text: "englisheligiblitytest".tr,
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
                          /* Text(
                            "englisheligiblitytest".tr,
                            style: headerstyle.copyWith(
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ), */
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            // height: 45,
                            /* decoration: BoxDecoration(
                                border: Border.all(
                                    color: nextPressed && !ganderSelcted
                                        ? Theme.of(context).errorColor
                                        : Color(0xffD1D1D1),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(13)), */
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField2<eduction.Data>(
                                buttonHeight: 40,
                                /* dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                ), */
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
                                        height: 22,
                                        width: 22,
                                      ),
                                    ),
                                  ),
                                ),
                                itemHeight: 20,
                                dropdownMaxHeight: 200,
                                validator: (value) {
                                  if (value == null) {
                                    return '    Please select English Eligiblity Test';
                                  }
                                },
                                hint: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "selectenglish".tr,
                                    style: fontStyle.copyWith(
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                items: addDividersAfterItemsEduction(
                                    _getEducationModel != null
                                        ? _getEducationModel!.data!
                                        : []),
                                customItemsIndexes: getDividersIndexes(
                                    _getEducationModel != null
                                        ? _getEducationModel!.data!
                                        : []),
                                value: _eductiondata,
                                onChanged: (value) {
                                  setState(() {
                                    _eductiondata = value;
                                    log(value.toString());
                                  });
                                  if (_formkey.currentState!.validate()) ;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "qualification".tr,
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
                          Container(
                            //height: 45,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(2),
                            /* decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                color: Color(0xffD1D1D1),
                                width: 1.5,
                              ),
                            ), */
                            child: DropdownButtonHideUnderline(
                              child:
                                  DropdownButtonFormField2<qaulification.Data>(
                                focusColor: Colors.white,
                                buttonHeight: 40,
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
                                /* dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                ), */
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
                                    "selectqualification".tr,
                                    style: fontStyle.copyWith(
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                dropdownMaxHeight: 200,
                                itemHeight: 20,
                                validator: (value) {
                                  if (value == null) {
                                    return '    Please select Qualification';
                                  }
                                },
                                items: addDividersAfterItemsQualificationModel(
                                    (_qualificationModel != null)
                                        ? _qualificationModel!.data!
                                        : []),
                                customItemsIndexes: getDividersIndexes(
                                  (_qualificationModel != null)
                                      ? _qualificationModel!.data!
                                      : [],
                                ),
                                value: _data,
                                onChanged: (newValue) {
                                  print(newValue);
                                  setState(() {
                                    _data = newValue;
                                  });
                                  if (_formkey.currentState!.validate()) ;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Education Field",
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
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(25),
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z \s)]"))
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Education';
                              } /* else if (value.length == 25) {
                                return 'You can add maximum 25 characters only';
                              } */
                            },
                            onChanged: (value) {
                              if (_formkey.currentState!.validate()) ;
                            },
                            controller: _educationcontroller,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                focusColor: Colors.white,
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
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 232, 15, 15),
                                      width: 1.5),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13),
                                  borderSide: BorderSide(
                                      color: Color(0xffD1D1D1), width: 1.5),
                                ),
                                border: OutlineInputBorder(),
                                /* label: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "educationfield".tr,
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
                                    fontWeight: FontWeight.w500), */
                                hintText: "entereducation".tr,
                                hintStyle: TextStyle(
                                  color: Color(0xff757885),
                                )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "University Name",
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
                          SizedBox(height: 5),
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30),
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z \s)]"))
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter university name';
                              } /* else if (value.length == 30) {
                                return 'You can add maximum 30 characters only';
                              } */
                            },
                            onChanged: (value) {
                              if (_formkey.currentState!.validate()) ;
                            },
                            controller: _universitynamecontroller,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                focusColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 232, 15, 15),
                                      width: 1.5),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
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
                                /* label: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "universityname".tr,
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
                                    fontWeight: FontWeight.w500), */
                                hintText: "enteruniversity".tr,
                                hintStyle: TextStyle(
                                  color: Color(0xff757885),
                                )),
                          ),
                          SizedBox(height: 30),
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
                                                Family_Detail(),
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
                          SizedBox(
                            height: 10,
                          ),
                          (widget.fromValue == "Edit")
                              ? CommonButton(
                                  btnName: "submit".tr,
                                  btnOnTap: () {
                                    if (_formkey.currentState!.validate()) {
                                      if (_annualincomedata == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please Select Annual Income")));
                                      } else if (_professionData == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please Select Profession")));
                                      } else if (_data == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please Select Qualification")));
                                      } else {
                                        updateCareerAPI();
                                      }
                                    }
                                  })
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
                                          if (_annualincomedata == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Please Select Annual Income")));
                                          } else if (_data == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Please Select Qualification")));
                                          } else if (_professionData == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Please Select Profession")));
                                          } else {
                                            updateCareerAPI();
                                          }
                                        }
                                        /*  updateCareerAPI(); */
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
      getProfession();
      // getCareerDetailAPI();
      // getAnnualincome();
      // getEduction();
      // getQualification();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getProfession();
      // getCareerDetailAPI();
      // getAnnualincome();
      // getEduction();
      // getQualification();
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

  getProfession() async {
    var response = await http.get(Uri.parse(GET_PROFESSION_URL));
    if (response.statusCode == 200) {
      setState(() {
        _getProfessionModel =
            profession.GetProfessionModel.fromJson(jsonDecode(response.body));
      });
      getAnnualincome();
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
        getEduction();
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

  getEduction() async {
    var response = await http.get(
      Uri.parse(GET_EDUCTION_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _getEducationModel =
              eduction.GetEducationModel.fromJson(jsonDecode(response.body));
        });
        getQualification();
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

  getQualification() async {
    var response = await http.get(
      Uri.parse(GET_QUALIFICATION_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _qualificationModel = qaulification.QualificationModel.fromJson(
              jsonDecode(response.body));
        });
        getCareerDetailAPI();
      }
    } else {}
  }

  getCareerDetailAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;

    var response = await dio.get(GET_CAREER_URL + "?" + queryString);
    if (response.statusCode == 200) {
      print(response.data);
      GetCareerModel _getCareerModel = GetCareerModel.fromJson(response.data);
      setState(() {
        _educationcontroller.text =
            (_getCareerModel.data!.educationFields != null)
                ? _getCareerModel.data!.educationFields.toString()
                : "";
        _universitynamecontroller.text =
            (_getCareerModel.data!.universityName != null)
                ? _getCareerModel.data!.universityName.toString()
                : "";

        if (_getProfessionModel != null && _getProfessionModel!.data != null) {
          for (var i = 0; i < _getProfessionModel!.data!.length; i++) {
            if (int.tryParse(_getCareerModel.data!.profession.toString()) ==
                _getProfessionModel!.data![i].id) {
              _professionData = _getProfessionModel!.data![i];
            }
          }
        }
        if (_annualincomeModel != null && _annualincomeModel!.data != null) {
          for (var i = 0; i < _annualincomeModel!.data!.length; i++) {
            if (_getCareerModel.data!.annualIncome ==
                _annualincomeModel!.data![i].id) {
              _annualincomedata = _annualincomeModel!.data![i];
            }
          }
        }
      });
      if (_qualificationModel != null && _qualificationModel!.data != null) {
        for (var i = 0; i < _qualificationModel!.data!.length; i++) {
          if (_getCareerModel.data!.qualification ==
              _qualificationModel!.data![i].id) {
            _data = _qualificationModel!.data![i];
          }
        }
      }
      if (_getEducationModel != null && _getEducationModel!.data != null) {
        for (var i = 0; i < _getEducationModel!.data!.length; i++) {
          if (_getCareerModel.data!.education ==
              _getEducationModel!.data![i].id) {
            _eductiondata = _getEducationModel!.data![i];
          }
        }
      }
      if (_getProfessionModel != null && _getProfessionModel!.data != null) {
        for (var i = 0; i < _getProfessionModel!.data!.length; i++) {
          if (_getCareerModel.data!.qualification ==
              _getProfessionModel!.data![i].id) {
            _professionData = _getProfessionModel!.data![i];
          }
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

  updateCareerAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var params = {
      "profession": (_professionData != null) ? _professionData!.id : "",
      "annual_income": (_annualincomedata != null) ? _annualincomedata!.id : "",
      "education": (_eductiondata != null) ? _eductiondata!.id : "",
      "qualification": (_data != null) ? _data!.id : "",
      "education_fields": _educationcontroller.text,
      "university_name": _universitynamecontroller.text
    };
    var response =
        await dio.post(UPDATE_CAREER_URL + "?" + queryString, data: params);
    if (response.statusCode == 200) {
      var data = response.data;
      log(data.toString());
      if (data['success'] == true) {
        UpdateCareerModel _updateCareerModel = UpdateCareerModel.fromJson(data);
        if (widget.fromValue == "Edit") {
          Navigator.pop(context, "UpdateData");
        } else {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => Family_Detail()));
        }
      } else {
        if (widget.fromValue == "Edit") {
          Navigator.pop(context, "UpdateData");
        } else {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => Family_Detail()));
        }
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

  /*  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      
      getCareerDetailAPI();
      getAnnualincome();
      getEduction();
      getQualification();
      getProfession();
     
    } else if (connectivityResult == ConnectivityResult.wifi) {
     
      getCareerDetailAPI();
      getAnnualincome();
      getEduction();
      getQualification();
      getProfession();
    
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

  getEduction() async {
    var response = await http.get(
      Uri.parse(GET_EDUCTION_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _getEducationModel =
              eduction.GetEducationModel.fromJson(jsonDecode(response.body));
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

  getQualification() async {
    var response = await http.get(
      Uri.parse(GET_QUALIFICATION_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _qualificationModel = qaulification.QualificationModel.fromJson(
              jsonDecode(response.body));
        });
      }
    } else {}
  }

  getProfession() async {
    var response = await http.get(Uri.parse(GET_PROFESSION_URL));
    if (response.statusCode == 200) {
      setState(() {
        _getProfessionModel =
            profession.GetProfessionModel.fromJson(jsonDecode(response.body));
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

  updateCareerAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var params = {
      "profession": (_professionData != null) ? _professionData!.id : "",
      "annual_income": (_annualincomedata != null) ? _annualincomedata!.id : "",
      "education": (_eductiondata != null) ? _eductiondata!.id : "",
      "qualification": (_data != null) ? _data!.id : "",
      "education_fields": _educationcontroller.text,
      "university_name": _universitynamecontroller.text
    };
    var response =
        await dio.post(UPDATE_CAREER_URL + "?" + queryString, data: params);
    if (response.statusCode == 200) {
      var data = response.data;
      log(data.toString());
      if (data['success'] == true) {
        UpdateCareerModel _updateCareerModel = UpdateCareerModel.fromJson(data);
        if (widget.fromValue == "Edit") {
          Navigator.pop(context, "UpdateData");
        } else {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => Family_Detail()));
        }
      } else {
        if (widget.fromValue == "Edit") {
          Navigator.pop(context, "UpdateData");
        } else {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => Family_Detail()));
        }
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

  getCareerDetailAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    CommonUtils.showProgressLoading(context);
    var response = await dio.get(GET_CAREER_URL + "?" + queryString);
    if (response.statusCode == 200) {
      print(response.data);
      GetCareerModel _getCareerModel = GetCareerModel.fromJson(response.data);
      setState(() {
        _educationcontroller.text =
            (_getCareerModel.data!.educationFields != null)
                ? _getCareerModel.data!.educationFields.toString()
                : "";
        _universitynamecontroller.text =
            (_getCareerModel.data!.universityName != null)
                ? _getCareerModel.data!.universityName.toString()
                : "";

        if (_getProfessionModel != null && _getProfessionModel!.data != null) {
          for (var i = 0; i < _getProfessionModel!.data!.length; i++) {
            if (int.tryParse(_getCareerModel.data!.profession.toString()) ==
                _getProfessionModel!.data![i].id) {
              _professionData = _getProfessionModel!.data![i];
            }
          }
        }
        if (_annualincomeModel != null && _annualincomeModel!.data != null) {
          for (var i = 0; i < _annualincomeModel!.data!.length; i++) {
            if (_getCareerModel.data!.annualIncome ==
                _annualincomeModel!.data![i].id) {
              _annualincomedata = _annualincomeModel!.data![i];
            }
          }
        }
      });
      if (_qualificationModel != null && _qualificationModel!.data != null) {
        for (var i = 0; i < _qualificationModel!.data!.length; i++) {
          if (_getCareerModel.data!.qualification ==
              _qualificationModel!.data![i].id) {
            _data = _qualificationModel!.data![i];
          }
        }
      }
      if (_getEducationModel != null && _getEducationModel!.data != null) {
        for (var i = 0; i < _getEducationModel!.data!.length; i++) {
          if (_getCareerModel.data!.education ==
              _getEducationModel!.data![i].id) {
            _eductiondata = _getEducationModel!.data![i];
          }
        }
      }
      if (_getProfessionModel != null && _getProfessionModel!.data != null) {
        for (var i = 0; i < _getProfessionModel!.data!.length; i++) {
          if (_getCareerModel.data!.qualification ==
              _getProfessionModel!.data![i].id) {
            _professionData = _getProfessionModel!.data![i];
          }
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
 */
  List<DropdownMenuItem<profession.Data>> addDividersAfterItems(
      List<profession.Data> items) {
    List<DropdownMenuItem<profession.Data>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<profession.Data>(
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
            const DropdownMenuItem<profession.Data>(
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

  List<DropdownMenuItem<AnnualData>> addDividersAfterItemsAnnualData(
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

  List<DropdownMenuItem<qaulification.Data>>
      addDividersAfterItemsQualificationModel(List<qaulification.Data> items) {
    List<DropdownMenuItem<qaulification.Data>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<qaulification.Data>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 10),
              child: Text(
                item.qualification.toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<qaulification.Data>(
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

  List<DropdownMenuItem<eduction.Data>> addDividersAfterItemsEduction(
      List<eduction.Data> items) {
    List<DropdownMenuItem<eduction.Data>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<eduction.Data>(
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
            const DropdownMenuItem<eduction.Data>(
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

class TextField extends StatelessWidget {
  TextEditingController controller;
  String? lableName;
  String hinttext;
  TextInputType? textInputType;
  FormFieldValidator? validator;
  String? suffixtext;
  bool readonly = false;
  Color? fillColors;
  bool? fill;

  double padding;
  TextField(
      {Key? key,
      required this.controller,
      this.lableName,
      required this.hinttext,
      required this.padding,
      this.validator,
      this.suffixtext,
      this.fillColors,
      this.fill,
      required this.readonly,
      this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: padding),
      child: Container(
        height: 45,
        child: TextFormField(
          textCapitalization: TextCapitalization.words,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z \s)]"))
          ],
          readOnly: readonly,
          textInputAction: TextInputAction.next,
          keyboardType: textInputType,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
              fillColor: fillColors,
              filled: fill,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(color: Color(0xffD1D1D1), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color(0xffD1D1D1), width: 1.5),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: hinttext,
              suffixText: suffixtext,
              hintStyle: TextStyle(
                  color: Color(0xff757885),
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
              label: /* Text(
              lableName.toString(),
              style: headerstyle.copyWith(
                  color: Color(0xff4D4D4D),
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ), */
                  RichText(
                      text: TextSpan(children: [
                TextSpan(
                  text: lableName.toString(),
                  style: TextStyle(
                    color: Color(0xff838994),
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                )
              ]))),
        ),
      ),
    );
  }
}
