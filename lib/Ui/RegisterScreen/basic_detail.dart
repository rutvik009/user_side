import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'package:intl/intl.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/weight_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Update_Profile_Details/Update_Basic_Detail_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/Get_BeardType_Model.dart'
    as beardType;
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/Get_DrinkType_Model.dart'
    as drinkType;
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/GetProfile_Details/Get_Basic_Detail_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/Get_Bodytpe_Model.dart'
    as bodytype;
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/Get_Bodytpe_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/Get_MaritalStatus_Model.dart'
    as maritalStatus;
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/Get_Nationality_model.dart'
    as nationality;
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/Get_Nationality_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/age_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/gotra_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/height_model.dart'
    as height;
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Drawer/ProfileScreen/profile_screenn.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/Drawer_Screen.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/looking_for.dart';
import 'package:matrimonial_app/Utils/DropDownList.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/submit_button.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/Religion_model.dart'
    as religionData;
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/cast_model.dart'
    as castData;

class Basic_Detail extends StatefulWidget {
  String? fromValue;
  Basic_Detail({Key? key, this.fromValue}) : super(key: key);

  @override
  State<Basic_Detail> createState() => _Basic_DetailState();
}

String? drinker;
String? allergic;
// String? bodytype;
String? manglik;
String? shaved;
String? skintone;
// String? nationality;
String? cast;
String? Gotra;

class _Basic_DetailState extends State<Basic_Detail> {
  final _formKey = GlobalKey<FormState>();
  castData.castData? _castdata;
  castData.castModel? _castModel;
  GotraData? _gotraData;
  gotraModel? _gotraModel;
  WeightModel? _weightModel;
  WeightData? _weightData;
  GetNationalityModel? _getNationalityModel;
  Dio dio = Dio();
  AgeModel? _ageModel;
  religionData.Data? _data;
  religionData.ReligionData? _religionData;
  bool isHeight = false;
  bool isWeight = false;
  bool isSelectTime = false;
  bool isAge = false;
  AgeData? _ageData;
  height.HeightData? _heightData;
  height.HeightModel? _heightModel;
  GetBodytypeModel? _getBodytypeModel;
  AgeData? age;
  maritalStatus.GetmaritalStatusModel? _getmaritalStatusModel;
  maritalStatus.Data? _maritalData;
  bodytype.Data? _bodytypeData;
  beardType.Data? _beardData;
  drinkType.Data? _drinkData;
  nationality.Data? _nationalitydata;
  drinkType.GetDrinkTypeModel? _getDrinkTypeModel;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobileno = TextEditingController();
  final TextEditingController _weightcontroller = TextEditingController();
  final TextEditingController _datecontroller = TextEditingController();
  final TextEditingController _placecontroller = TextEditingController();
  final TextEditingController _timecontroller = TextEditingController();
  TextEditingController _refer = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _otherGotraController = TextEditingController();

  // String? gender;
  bool isSelectOther = false;
  bool ganderSelcted = false;
  bool optionSelcted = false;
  String? createdBy;
  bool nextPressed = false;
  String date = "";
  var selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final _formkey = GlobalKey<FormState>();
  bool isBirthDate = false;
  bool isBirthTime = false;

  Map<String, dynamic> appearanceName = {};

  Map<String, dynamic> allergicName = {};

  Map<String, dynamic> manglikName = {};

  Map<String, dynamic> skinToneName = {};

  @override
  void initState() {
    super.initState();
    print("fromValue :: ${widget.fromValue}");
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
                ProfileDataGetAppbar(name: "basicdetail".tr),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /* (widget.fromValue == "Edit")
                              ? Container()
                              : */
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
                              : Image.asset(
                                  ImagePath.basicDetail,
                                  height: 19,
                                ),
                          (widget.fromValue == "Edit")
                              ? SizedBox(
                                  height: 15,
                                )
                              : SizedBox(),
                          (widget.fromValue == "Edit")
                              ? TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  onTap: () {},
                                  validator: (text) {
                                    if (text!.isEmpty) {
                                      return "Please Enter Your Name";
                                    } /* else if (text.length == 18) {
                                      return 'You can add maximum 18 characters only';
                                    } */
                                  },
                                  controller: _firstNameController,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(25),
                                    FilteringTextInputFormatter.allow(
                                      RegExp("[A-Za-z  |\s]"),
                                    ),
                                  ],
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 232, 15, 15),
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
                                    // focusColor: Colors.amber,
                                    border: OutlineInputBorder(),
                                    label: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "firstname".tr,
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
                                    hintText: "yourfirstname".tr,
                                  ),
                                )
                              : Container(),
                          (widget.fromValue == "Edit")
                              ? SizedBox(
                                  height: 15,
                                )
                              : SizedBox(),
                          (widget.fromValue == "Edit")
                              ? TextFormField(
                                  onTap: () {},
                                  validator: (value) {
                                    if (value!.length == 18) {
                                      return 'You can add maximum 18 characters only';
                                    }
                                  },
                                  textCapitalization: TextCapitalization.words,
                                  controller: _middleNameController,
                                  keyboardType: TextInputType.name,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(25),
                                    FilteringTextInputFormatter.allow(
                                      RegExp("[A-Za-z  |\s]"),
                                    ),
                                  ],
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 232, 15, 15),
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
                                    // focusColor: Colors.amber,
                                    border: OutlineInputBorder(),
                                    label: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "middlename".tr,
                                            style: TextStyle(
                                              color: Color(0xff838994),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                            ),
                                          ),
                                          /*  TextSpan(
                                            text: ' *',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                            ),
                                          ) */
                                        ],
                                      ),
                                    ),
                                    labelStyle: fontStyle.copyWith(
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.w500),
                                    hintText: "yourmiddlename".tr,
                                  ),
                                )
                              : Container(),
                          (widget.fromValue == "Edit")
                              ? SizedBox(height: 15)
                              : SizedBox(),
                          (widget.fromValue == "Edit")
                              ? TextFormField(
                                  onTap: () {},
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field can't empty";
                                    } /* else if (value.length == 18) {
                                      return 'You can add maximum 18 characters only';
                                    } */
                                  },
                                  textCapitalization: TextCapitalization.words,
                                  controller: _lastNameController,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(25),
                                    FilteringTextInputFormatter.allow(
                                      RegExp("[A-Za-z |\s]"),
                                    ),
                                  ],
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 232, 15, 15),
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
                                    // focusColor: Colors.amber,
                                    border: OutlineInputBorder(),
                                    /* "lastname".tr */ label: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "lastname".tr,
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
                                    hintText: "yourlastname".tr,
                                  ),
                                )
                              : Container(),
                          (widget.fromValue == "Edit")
                              ? SizedBox(
                                  height: 15,
                                )
                              : SizedBox(),
                          (widget.fromValue == "Edit")
                              ? Text(
                                  "emailaddress".tr,
                                  style: headingStyle.copyWith(
                                      color: Color(0xff838994),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )
                              : Container(),
                          (widget.fromValue == "Edit")
                              ? Container(
                                  height: 45,
                                  child: TextFormField(
                                    controller: _email,
                                    readOnly: true,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey.withOpacity(0.5),
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          borderSide: BorderSide.none),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 15),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide.none,
                                      ),
                                      // focusColor: Colors.amber,
                                      // border: OutlineInputBorder(),
                                      // labelText: "Email Address",
                                      labelStyle: fontStyle.copyWith(
                                          color: Color(0xff777777),
                                          fontWeight: FontWeight.w500),
                                      hintText: "enteremailaddress".tr,
                                    ),
                                  ),
                                )
                              : Container(),
                          (widget.fromValue == "Edit")
                              ? SizedBox(
                                  height: 15,
                                )
                              : SizedBox(),
                          (widget.fromValue == "Edit")
                              ? Text(
                                  "mobileno".tr,
                                  style: headingStyle.copyWith(
                                      color: Color(0xff838994),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )
                              : Container(),
                          (widget.fromValue == "Edit")
                              ? Container(
                                  height: 45,
                                  child: TextFormField(
                                    controller: _mobileno,
                                    readOnly: true,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey.withOpacity(0.5),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide.none,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 15),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide.none,
                                      ),
                                      border: OutlineInputBorder(),
                                      // labelText: "Mobile No",
                                      labelStyle: fontStyle.copyWith(
                                          color: Color(0xff777777),
                                          fontWeight: FontWeight.w500),
                                      hintText: "Enter your Mobile No",
                                    ),
                                  ),
                                )
                              : Container(),
                          (widget.fromValue == "Edit")
                              ? SizedBox(
                                  height: 15,
                                )
                              : SizedBox(),
                          (widget.fromValue == "Edit")
                              ? Text("gender".tr,
                                  style: fontStyle.copyWith(
                                      color: Color(0xff777777),
                                      fontWeight: FontWeight.w500))
                              : Container(),
                          SizedBox(
                            height: 2,
                          ),
                          (widget.fromValue == "Edit")
                              ? Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: nextPressed && !ganderSelcted
                                              ? Theme.of(context).errorColor
                                              : Color(0xffD1D1D1),
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(13)),
                                  width: MediaQuery.of(context).size.width,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
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
                                          "selectgender".tr,
                                          style: fontStyle.copyWith(
                                              color: Color(0xff777777),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      items: _addDividersAfterItems(genderList),
                                      customItemsIndexes: _getDividersIndexes(),
                                      customItemsHeight: 2,
                                      buttonHeight: 40,
                                      buttonWidth: 140,
                                      itemHeight: 40,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      value: gender,
                                      onChanged: (value) {
                                        setState(() {
                                          // ganderSelcted = true;
                                          gender = value as String;
                                          log(gender.toString());
                                        });
                                      },
                                    ),
                                  ),
                                )
                              : Container(),
                          nextPressed && !ganderSelcted
                              ? Container(
                                  margin: EdgeInsets.only(left: 35, top: 8),
                                  child: Text(
                                    "gendererror".tr,
                                    style: TextStyle(
                                      color: Theme.of(context).errorColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              : Container(),
                          (widget.fromValue == "Edit")
                              ? SizedBox(
                                  height: 15,
                                )
                              : SizedBox(),
                          (widget.fromValue == "Edit")
                              ? Text("profile by".tr,
                                  style: fontStyle.copyWith(
                                      color: Color(0xff777777),
                                      fontWeight: FontWeight.w500))
                              : Container(),
                          SizedBox(
                            height: 2,
                          ),
                          (widget.fromValue == "Edit")
                              ? Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: nextPressed && !optionSelcted
                                              ? Theme.of(context).errorColor
                                              : Color(0xffD1D1D1),
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(13)),
                                  width: MediaQuery.of(context).size.width,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      icon: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Container(
                                          // color: Colors.amber,
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
                                          "selectoption".tr,
                                          style: fontStyle.copyWith(
                                              color: Color(0xff777777),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      dropdownMaxHeight: 200,
                                      items: _addDividersAfterItemscreated(
                                          createdby),
                                      customItemsIndexes:
                                          _getDividersIndexescreated(),
                                      customItemsHeight: 2,
                                      buttonHeight: 40,
                                      buttonWidth: 140,
                                      itemHeight: 40,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      /*   ['male', 'female']
                                          .map(
                                              (label) => DropdownMenuItem<String>(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                        label.toString(),
                                                        style: TextStyle(),
                                                      ),
                                                    ),
                                                    value: label,
                                                  ))
                                          .toList(), */
                                      value: createdBy,
                                      onChanged: (value) {
                                        setState(() {
                                          // ganderSelcted = true;
                                          createdBy = value as String;
                                          log(createdBy.toString());
                                        });
                                      },
                                    ),
                                  ),
                                )
                              : Container(),
                          nextPressed && !optionSelcted
                              ? Container(
                                  margin: EdgeInsets.only(left: 35, top: 8),
                                  child: Text(
                                    "optionerror".tr,
                                    style: TextStyle(
                                      color: Theme.of(context).errorColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "age".tr,
                                      style: headerstyle.copyWith(
                                          color: Color(0xff4D4D4D),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14)),
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
                            child: DropdownButtonFormField2<AgeData>(
                              dropdownMaxHeight: 200,
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
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide(
                                          color: Color(0xffD1D1D1)))),
                              offset: Offset(0, 0),
                              isExpanded: true,
                              hint: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "selectage".tr,
                                  style: fontStyle.copyWith(
                                      color: Color(0xff777777),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              icon: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    isAge
                                        ? Text(
                                            "years".tr,
                                            /*   style:
                                                  TextStyle(color: Colors.black), */
                                          )
                                        : Container(),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
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
                                  ],
                                ),
                              ),
                              iconSize: 30,
                              buttonHeight: 45,
                              buttonPadding:
                                  const EdgeInsets.only(left: 0, right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              itemHeight: 20,
                              items: addDividersAfterItemsAge(
                                  (_ageModel != null) ? _ageModel!.data! : []),
                              customItemsIndexes: getDividersIndexes(
                                  (_ageModel != null) ? _ageModel!.data! : []),
                              validator: (value) {
                                if (value == null) {
                                  return '    Please select age';
                                }
                              },
                              value: _ageData,
                              onChanged: (value) {
                                setState(() {
                                  isAge = true;
                                  _ageData = value;
                                });
                                if (_formKey.currentState!.validate()) ;
                                //Do something when changing the item if you want.
                              },
                              onSaved: (value) {
                                // selectedValue = value.toString();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 7),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "height".tr,
                                      style: headerstyle.copyWith(
                                          color: Color(0xff4D4D4D),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15)),
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
                            child: DropdownButtonFormField2<height.HeightData>(
                              dropdownMaxHeight: 200,
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
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide(
                                          color: Color(0xffD1D1D1)))),
                              offset: Offset(0, 0),
                              isExpanded: true,
                              hint: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "heighterror".tr,
                                  style: fontStyle.copyWith(
                                      color: Color(0xff777777),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              icon: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    isAge
                                        ? Text(
                                            "inches".tr,
                                            /*   style:
                                                  TextStyle(color: Colors.black), */
                                          )
                                        : Container(),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
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
                                  ],
                                ),
                              ),
                              iconSize: 30,
                              buttonHeight: 45,
                              buttonPadding:
                                  const EdgeInsets.only(left: 0, right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              itemHeight: 20,
                              items: addDividersAfterItemsHeight(
                                  (_heightModel != null)
                                      ? _heightModel!.data!
                                      : []),
                              customItemsIndexes: getDividersIndexes(
                                  (_heightModel != null)
                                      ? _heightModel!.data!
                                      : []),
                              validator: (value) {
                                if (value == null) {
                                  return '    Please select height';
                                }
                              },
                              value: _heightData,
                              onChanged: (value) {
                                setState(() {
                                  isHeight = true;
                                  _heightData = value;
                                });
                                if (_formKey.currentState!.validate()) ;
                                //Do something when changing the item if you want.
                              },
                              onSaved: (value) {
                                // selectedValue = value.toString();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "weight".tr,
                            style: headerstyle.copyWith(
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: nextPressed && !ganderSelcted
                                        ? Theme.of(context).errorColor
                                        : Color(0xffD1D1D1),
                                    width: 1),
                                borderRadius: BorderRadius.circular(13)),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<WeightData>(
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
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
                                dropdownMaxHeight: 200,
                                itemHeight: 20,
                                hint: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "enterweight".tr,
                                    style: fontStyle.copyWith(
                                        fontSize: 15,
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                items: addDividersAfterItemsWeight(
                                    (_weightModel != null)
                                        ? _weightModel!.data!
                                        : []),
                                customItemsIndexes: getDividersIndexes(
                                    (_weightModel != null)
                                        ? _weightModel!.data!
                                        : []),
                                value: _weightData,
                                onChanged: (value) {
                                  print(value);
                                  setState(() {
                                    _weightData = value;

                                    log(value.toString());
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "bodytype".tr,
                            style: headerstyle.copyWith(
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: nextPressed && !ganderSelcted
                                        ? Theme.of(context).errorColor
                                        : Color(0xffD1D1D1),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(13)),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<bodytype.Data>(
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                icon: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    // color: Colors.amber,
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
                                dropdownMaxHeight: 200,
                                itemHeight: 20,
                                hint: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "selectbodytype".tr,
                                    style: fontStyle.copyWith(
                                        fontSize: 15,
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                items: addDividersAfterItemsBodytype(
                                    (_getBodytypeModel != null)
                                        ? _getBodytypeModel!.data!
                                        : []),
                                customItemsIndexes: getDividersIndexes(
                                    (_getBodytypeModel != null)
                                        ? _getBodytypeModel!.data!
                                        : []),
                                value: _bodytypeData,
                                onChanged: (value) {
                                  print(value);
                                  setState(() {
                                    _bodytypeData = value;
                                    // isHeight = true;
                                    log(value.toString());
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "skintone".tr,
                            style: headerstyle.copyWith(
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: nextPressed && !ganderSelcted
                                        ? Theme.of(context).errorColor
                                        : Color(0xffD1D1D1),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(13)),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<Map<String, dynamic>>(
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                icon: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    // color: Colors.amber,
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
                                dropdownMaxHeight: 200,
                                itemHeight: 20,
                                hint: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "selectskintone".tr,
                                    style: fontStyle.copyWith(
                                        fontSize: 15,
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                items: addDividersAfterItemsSkinTone(
                                    skinToneList
                                    /* _getSkinToneModel != null
                                        ? _getSkinToneModel!.data!
                                        : [] */
                                    ),
                                customItemsIndexes: getDividersIndexes(
                                    skinToneList
                                    /* _getSkinToneModel != null
                                        ? _getSkinToneModel!.data!
                                        : [] */
                                    ),
                                value: (skinToneName.isNotEmpty)
                                    ? skinToneName
                                    : skinToneName['name'],
                                onChanged: (value) {
                                  setState(() {
                                    // ganderSelcted = true;
                                    skinToneName = value!;
                                    log(skinToneName['name'].toString());
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
                              items: addDividersAfterItemsReligion(
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
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "caste".tr,
                                    style: headerstyle.copyWith(
                                        color: Color(0xff4D4D4D),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
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
                              dropdownMaxHeight: 200,
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide:
                                          BorderSide(color: Color(0xffD1D1D1))),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13))),
                              offset: Offset(0, 0),
                              isExpanded: true,
                              hint: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "selectcaste".tr,
                                  style: fontStyle.copyWith(
                                      color: Color(0xff777777),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              icon: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Container(
                                  // color: Colors.amber,
                                  height: 12.5,
                                  width: 12.5,
                                  child: Center(
                                    child: Image.asset(
                                      ImagePath.forward,
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                ),
                              ),
                              iconSize: 30,
                              buttonHeight: 45,
                              buttonPadding:
                                  const EdgeInsets.only(left: 0, right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              itemHeight: 20,
                              items: addDividersAfterItems((_castModel != null)
                                  ? _castModel!.data!
                                  : []),
                              customItemsIndexes: getDividersIndexes(
                                  (_castModel != null)
                                      ? _castModel!.data!
                                      : []),
                              validator: (value) {
                                if (value == null) {
                                  return '    Please select caste';
                                }
                              },
                              value: _castdata,
                              onChanged: (value) {
                                setState(() {
                                  _castdata = value;
                                });
                                if (_formKey.currentState!.validate()) ;
                              },
                              onSaved: (value) {
                                setState(() {
                                  _castdata = value;
                                });
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
                                    style: headerstyle.copyWith(
                                        color: Color(0xff4D4D4D),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
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
                              dropdownMaxHeight: 200,
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide:
                                          BorderSide(color: Color(0xffD1D1D1))),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13))),
                              offset: Offset(0, 0),
                              isExpanded: true,
                              hint: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "selectgotra".tr,
                                  style: fontStyle.copyWith(
                                      color: Color(0xff777777),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              icon: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Container(
                                  height: 12.5,
                                  width: 12.5,
                                  child: Center(
                                    child: Image.asset(
                                      ImagePath.forward,
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                ),
                              ),
                              iconSize: 30,
                              buttonHeight: 45,
                              buttonPadding:
                                  const EdgeInsets.only(left: 0, right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              itemHeight: 20,
                              items: addDividersAfterItemsGotra(
                                  (_gotraModel != null)
                                      ? _gotraModel!.data!
                                      : []),
                              customItemsIndexes: getDividersIndexes(
                                  (_gotraModel != null)
                                      ? _gotraModel!.data!
                                      : []),
                              validator: (value) {
                                if (value == null) {
                                  return '    Please select gotra';
                                }
                              },
                              value: _gotraData,
                              onChanged: (value) {
                                setState(() {
                                  _gotraData = value;
                                });
                                if (_formKey.currentState!.validate()) ;
                                if (_gotraData!.id == 222) {
                                  setState(() {
                                    isSelectOther = true;
                                  });
                                } else {
                                  setState(() {
                                    isSelectOther = false;
                                  });
                                }
                              },
                              onSaved: (value) {
                                setState(() {
                                  _gotraData = value;
                                });
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
                          checkGender == "Male"
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "appereance".tr,
                                      style: headerstyle.copyWith(
                                          color: Color(0xff4D4D4D),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: nextPressed &&
                                                      !ganderSelcted
                                                  ? Theme.of(context).errorColor
                                                  : Color(0xffD1D1D1),
                                              width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      width: MediaQuery.of(context).size.width,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2<
                                            Map<String, dynamic>>(
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(13),
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
                                          itemHeight: 20,
                                          dropdownMaxHeight: 200,
                                          hint: Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "selectappereance".tr,
                                              style: fontStyle.copyWith(
                                                  fontSize: 15,
                                                  color: Color(0xff777777),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          items: addDividersAfterItemsBeardType(
                                              appearanceList
                                              /* _getBeardTypeModel != null
                                        ? _getBeardTypeModel!.data!
                                        : [] */
                                              ),
                                          customItemsIndexes: getDividersIndexes(
                                              appearanceList
                                              /* _getBeardTypeModel != null
                                        ? _getBeardTypeModel!.data!
                                        : [] */
                                              ),
                                          value: (appearanceName.isNotEmpty)
                                              ? appearanceName
                                              : appearanceName['name'],
                                          onChanged: (value) {
                                            setState(() {
                                              // ganderSelcted = true;
                                              appearanceName = value!;
                                              log(appearanceName['id']
                                                  .toString());
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "allergictoanything".tr,
                            style: headerstyle.copyWith(
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: nextPressed && !ganderSelcted
                                        ? Theme.of(context).errorColor
                                        : Color(0xffD1D1D1),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(13)),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<Map<String, dynamic>>(
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                icon: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    // color: Colors.amber,
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
                                itemHeight: 20,
                                dropdownMaxHeight: 200,
                                hint: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "selectanyone".tr,
                                    style: fontStyle.copyWith(
                                        fontSize: 15,
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                items: addDividersAfterItemsAllergicType(
                                    allergicList
                                    /* _getAllergicToneModel != null
                                        ? _getAllergicToneModel!.data!
                                        : [] */
                                    ),
                                customItemsIndexes: getDividersIndexes(
                                    allergicList
                                    /* _getAllergicToneModel != null
                                        ? _getAllergicToneModel!.data!
                                        : [] */
                                    ),
                                value: (allergicName.isNotEmpty)
                                    ? allergicName
                                    : allergicName['name'],
                                onChanged: (value) {
                                  setState(() {
                                    // ganderSelcted = true;
                                    allergicName = value!;
                                    log(allergicName['name'].toString());
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "habit".tr,
                            style: headerstyle.copyWith(
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: nextPressed && !ganderSelcted
                                        ? Theme.of(context).errorColor
                                        : Color(0xffD1D1D1),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(13)),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<drinkType.Data>(
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                icon: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    // color: Colors.amber,
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
                                itemHeight: 20,
                                dropdownMaxHeight: 200,
                                hint: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "selecthabit".tr,
                                    style: fontStyle.copyWith(
                                        fontSize: 15,
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                items: addDividersAfterItemsDrinkType(
                                    _getDrinkTypeModel != null
                                        ? _getDrinkTypeModel!.data!
                                        : []),
                                customItemsIndexes: getDividersIndexes(
                                    _getDrinkTypeModel != null
                                        ? _getDrinkTypeModel!.data!
                                        : []),
                                value: _drinkData,
                                onChanged: (value) {
                                  setState(() {
                                    // ganderSelcted = true;
                                    _drinkData = value;
                                    log(value.toString());
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 7),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "marriatlestatus".tr,
                                      style: headerstyle.copyWith(
                                          color: Color(0xff4D4D4D),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15)),
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
                              "marriatlestatus".tr,
                              style: TextStyle(
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ), */
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2<maritalStatus.Data>(
                              dropdownMaxHeight: 200,
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
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide(
                                          color: Color(0xffD1D1D1)))),
                              offset: Offset(0, 0),
                              isExpanded: true,
                              hint: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "selectmarriatlestatus".tr,
                                  style: fontStyle.copyWith(
                                      color: Color(0xff777777),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              icon: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Container(
                                  // color: Colors.amber,
                                  height: 12.5,
                                  width: 12.5,
                                  child: Center(
                                    child: Image.asset(
                                      ImagePath.forward,
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                ),
                              ),
                              iconSize: 30,
                              buttonHeight: 45,
                              buttonPadding:
                                  const EdgeInsets.only(left: 0, right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              itemHeight: 20,
                              items: addDividersAfterItemsMeritial(
                                  (_getmaritalStatusModel != "" &&
                                          _getmaritalStatusModel != null)
                                      ? _getmaritalStatusModel!.data!
                                      : []),
                              customItemsIndexes: getDividersIndexes(
                                  (_getmaritalStatusModel != "" &&
                                          _getmaritalStatusModel != null)
                                      ? _getmaritalStatusModel!.data!
                                      : []),
                              validator: (value) {
                                if (value == null) {
                                  return '    Please select Marital Status';
                                }
                              },
                              value: _maritalData,
                              onChanged: (value) {
                                setState(() {
                                  _maritalData = value;
                                });
                                if (_formKey.currentState!.validate()) ;
                              },
                              onSaved: (value) {
                                setState(() {
                                  _maritalData = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "manglik".tr,
                            style: headerstyle.copyWith(
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: nextPressed && !ganderSelcted
                                        ? Theme.of(context).errorColor
                                        : Color(0xffD1D1D1),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(13)),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<Map<String, dynamic>>(
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                icon: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    // color: Colors.amber,
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
                                itemHeight: 20,
                                dropdownMaxHeight: 200,
                                hint: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "selectanyone".tr,
                                    style: fontStyle.copyWith(
                                        fontSize: 15,
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                items: addDividersAfterItemsManglikType(
                                    manglikList
                                    /* _getManglikTypeModel != null
                                        ? _getManglikTypeModel!.data!
                                        : [] */
                                    ),
                                customItemsIndexes: getDividersIndexes(
                                    manglikList
                                    /* _getManglikTypeModel != null
                                        ? _getManglikTypeModel!.data!
                                        : [] */
                                    ),
                                value: (manglikName.isNotEmpty)
                                    ? manglikName
                                    : manglikName['name'],
                                onChanged: (value) {
                                  setState(() {
                                    // ganderSelcted = true;
                                    manglikName = value!;
                                    log(manglikName.toString());
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            // height: 45,
                            child: Padding(
                              padding: EdgeInsets.only(top: 0.0),
                              child: TextFormField(
                                /*  validator: (text) {
                                  if (text!.isEmpty) {
                                    return "    Please Enter Birth date";
                                  }
                                }, */
                                onChanged: (value) {
                                  if (_formKey.currentState!.validate()) ;
                                },
                                textInputAction: TextInputAction.done,
                                // keyboardType: TextInputType.text,
                                readOnly: false,
                                keyboardType: TextInputType.number,

                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'\d+|-|/')),
                                  DateInputFormatter(),
                                ],
                                controller: _datecontroller,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                        color: Color(0xffD1D1D1), width: 1.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                        color: Color(0xffD1D1D1), width: 1.5),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  hintText: "selectbirthdate".tr,
                                  hintStyle: TextStyle(
                                      color: Color(0xff757885),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                  label: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "dateofbirth".tr,
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
                                  /*  label: Text(
                                    "dateofbirth".tr,
                                    style: headerstyle.copyWith(
                                        color: Color(0xff4D4D4D),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ), */
                                  /* suffixIcon: GestureDetector(
                                        child: Icon(Icons.calendar_month)) */
                                ),

                                /* onTap: () async {
                                  DateTime? date = DateTime.now();
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime(2000),
                                    firstDate: DateTime(1972),
                                    lastDate: DateTime(
                                        date.year - 18, date.month, date.day),
                                  );

                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                    log(_datecontroller
                                        .text); //formatted date output using intl package =>  2021-03-16
                                    setState(() {
                                      _datecontroller.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {}
                                },
 */

                                /* () async {
                                  DateTime? date = DateTime.now();
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  /* date = await DatePicker.showSimpleDatePicker(
                                      context,
                                      initialDate: DateTime(2000),
                                      firstDate: DateTime(1972),
                                      lastDate: DateTime(
                                          date.year - 18, date.month, date.day),
                                      dateFormat: "dd-MMMM-yyyy",
                                      locale: DateTimePickerLocale.en_us,
                                      looping: false,
                                      itemTextStyle:
                                          TextStyle(color: Colors.black),
                                      textColor: Color(0xffFA2457)); */
                                  date = (await DatePicker.showSimpleDatePicker( 
                                      context,
                                      initialDate: DateTime(2000),
                                      firstDate: DateTime(1972),
                                      lastDate: DateTime(
                                          date.year - 18, date.month, date.day),
                                      dateFormat: 'dd-MMM-yyyy',
                                      locale: DateTimePickerLocale.en_us,
                                      looping: false,
                                      itemTextStyle:
                                          TextStyle(color: Colors.black),
                                      textColor: Color(0xffFA2457)));

                                  _datecontroller.text =
                                      DateFormat('dd-MMM-yyyy').format(date!);

                                  setState(() {
                                    isBirthDate == false;
                                  });

                                  log(_datecontroller.text);
                                }, */
                              ),
                            ),
                          ),
                          (isBirthDate == true)
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    "    Please Enter Birth date",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 11),
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 45,
                            child: TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp("[A-Za-z/ ]"),
                                ),
                              ],
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              controller: _placecontroller,
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
                                labelText: "birthplace".tr,
                                labelStyle: fontStyle.copyWith(
                                    color: Color(0xff777777),
                                    fontWeight: FontWeight.w500),
                                hintText: "enterbirthplace".tr,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            // height: 45,
                            child: Padding(
                              padding: EdgeInsets.only(top: 0.0),
                              child: TextFormField(
                                /* validator: (text) {
                                  if (text!.isEmpty) {
                                    setState(() {
                                      isSelectTime = true;
                                    });
                                    return "Please Enter Birth time";
                                  }
                                }, */
                                onChanged: (value) {
                                  print("time ::: $value");
                                  if (_timecontroller.text.isNotEmpty) {
                                    if (_formKey.currentState!.validate()) ;
                                  }
                                  /*  if (value.isNotEmpty) {
                                    if (_formKey.currentState!.validate()) ;
                                  } */
                                },
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.datetime,
                                readOnly: true,
                                onTap: () {
                                  _selectTime(context);
                                },
                                controller: _timecontroller,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                        color: Color(0xffD1D1D1), width: 1.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                        color: Color(0xffD1D1D1), width: 1.5),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 15),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "birthtime".tr,
                                  hintStyle: TextStyle(
                                      color: Color(0xff757885),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                  label: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "addbirthtime".tr,
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
                                  /*  label: Text(
                                   /*  "addbirthtime".tr */,
                                    style: headerstyle.copyWith(
                                        color: Color(0xff4D4D4D),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ), */
                                ),
                              ),
                            ),
                          ),
                          (isBirthTime == true)
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    "    Please Enter Birth time",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 11),
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "nationality".tr,
                            style: headerstyle.copyWith(
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: nextPressed && !ganderSelcted
                                        ? Theme.of(context).errorColor
                                        : Color(0xffD1D1D1),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(13)),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<nationality.Data>(
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                icon: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    // color: Colors.amber,
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
                                dropdownMaxHeight: 200,
                                itemHeight: 20,
                                hint: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "selectnationality".tr,
                                    style: fontStyle.copyWith(
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                items: addDividersAfterItemsnationality(
                                    _getNationalityModel != null
                                        ? _getNationalityModel!.data!
                                        : []),
                                customItemsIndexes: getDividersIndexes(
                                    _getNationalityModel != null
                                        ? _getNationalityModel!.data!
                                        : []),
                                value: _nationalitydata,
                                onChanged: (value) {
                                  setState(() {
                                    // ganderSelcted = true;
                                    _nationalitydata = value;
                                    log(value.toString());
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          (widget.fromValue == "Edit")
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
                                    controller: _refer,
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
                                      labelText: "referby".tr,
                                      labelStyle: fontStyle.copyWith(
                                          color: Color(0xff777777),
                                          fontWeight: FontWeight.w500),
                                      hintText: "referencecode".tr,
                                    ),
                                  ),
                                )
                              : Container(),
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
                                                    Looking_for()));
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
                                                        )
                                                    // Profile(),
                                                    ),
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
                                    if (_formKey.currentState!.validate()) {
                                      if (_ageData == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text("Please Select Age")));
                                      } else if (_heightData == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please Select Height")));
                                      } /* else if (_castdata == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please Select Caste")));
                                      } */
                                      else if (_gotraData == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please Select Gotra")));
                                      } else if (_maritalData == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please Select MaritalStatus")));
                                      } else {
                                        if (_datecontroller.text.isEmpty) {
                                          setState(() {
                                            isBirthDate = true;
                                            // isBirthTime = true;
                                          });
                                        } else if (_timecontroller
                                            .text.isEmpty) {
                                          setState(() {
                                            // isBirthDate = true;
                                            isBirthTime = true;
                                          });
                                        } else {
                                          addBasicDetailAPI();
                                        }
                                      }
                                      /*  setState(() {
                                        addBasicDetailAPI();
                                      } */

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
                                        if (_formKey.currentState!.validate()) {
                                          if (_ageData == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Please Select Age")));
                                          } else if (_heightData == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Please Select Height")));
                                          } /* else if (_castdata == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Please Select Caste")));
                                          } */
                                          else if (_gotraData == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Please Select Gotra")));
                                          } else if (_maritalData == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Please Select MaritalStatus")));
                                          } else {
                                            if (_datecontroller.text.isEmpty) {
                                              setState(() {
                                                isBirthDate = true;
                                                // isBirthTime = true;
                                              });
                                            } else if (_timecontroller
                                                .text.isEmpty) {
                                              setState(() {
                                                // isBirthDate = true;
                                                isBirthTime = true;
                                              });
                                            } else {
                                              setState(() {
                                                addBasicDetailAPI();
                                              });
                                            }
                                          }
                                          /*  setState(() {
                                        addBasicDetailAPI();
                                      } */

                                        }
                                        /*  if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            addBasicDetailAPI();
                                          });
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

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (timeOfDay != null) {
      setState(() {
        selectedTime = timeOfDay;
        _timecontroller.text = '${selectedTime.format(context)}';
        isBirthTime = false;
        log(_timecontroller.text);
      });
    }
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getAge();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getAge();
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

  getAge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(USER_TOKEN);
    print(authToken);
    CommonUtils.showProgressLoading(context);
    var response = await http.get(
      Uri.parse(GET_AGE_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _ageModel = AgeModel.fromJson(jsonDecode(response.body));
        });
        getHeight();
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

  getHeight() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(USER_TOKEN);

    print(authToken);

    var response = await http.get(
      Uri.parse(GET_HEIGHT_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          // log("Height Api Call");
          // log(response.body);
          _heightModel = height.HeightModel.fromJson(jsonDecode(response.body));
          log("Height Model ${_heightModel!.data![0].height}");
        });
        getWeight();
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

  getWeight() async {
    var response = await http.get(Uri.parse(GET_WEIGHT_URL));
    if (response.statusCode == 200) {
      setState(() {
        _weightModel = WeightModel.fromJson(jsonDecode(response.body));
        // log(response.body);
      });
      getBodytypeAPI();
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

  getBodytypeAPI() async {
    var response = await http.get(Uri.parse(GET_BODYTYPE_URL));
    if (response.statusCode == 200) {
      _getBodytypeModel =
          bodytype.GetBodytypeModel.fromJson(jsonDecode(response.body));
      getReion();
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
          getCast();
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

  getCast() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(USER_TOKEN);
    print(authToken);

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
    } else {}
  }

  getGotra() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(USER_TOKEN);

    var response = await http.get(
      Uri.parse(GET_GOTRA_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _gotraModel = gotraModel.fromJson(jsonDecode(response.body));
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
      // CommonUtils.hideProgressLoading();
    }
  }

  getMaritalStatus() async {
    var response = await http.get(Uri.parse(GET_MARITAL_STATUS_URL));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['success'] == true) {
        // setState(() {
        _getmaritalStatusModel =
            maritalStatus.GetmaritalStatusModel.fromJson(data);
        // });
        getnationality();
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

  getnationality() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(USER_TOKEN);

    var response = await http.get(
      Uri.parse(GET_NATIONALITY_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _getNationalityModel =
              GetNationalityModel.fromJson(jsonDecode(response.body));
        });
        getDrinkTypeAPI();
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
      // CommonUtils.hideProgressLoading();
    }
  }

  getDrinkTypeAPI() async {
    var response = await http.get(Uri.parse(GET_DRINKTYPE_URL));
    if (response.statusCode == 200) {
      _getDrinkTypeModel =
          drinkType.GetDrinkTypeModel.fromJson(jsonDecode(response.body));
      getBasicDetail();
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

  /* getSkinToneAPI() async {
    var response = await http.get(Uri.parse(GET_SKINTONE_URL));
    if (response.statusCode == 200) {
      _getSkinToneModel =
          skinTone.GetSkinToneModel.fromJson(jsonDecode(response.body));
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
      // CommonUtils.hideProgressLoading();
    }
  }

  getBeardTypeAPI() async {
    var response = await http.get(Uri.parse(GET_BEARDTYPE_URL));
    if (response.statusCode == 200) {
      _getBeardTypeModel =
          beardType.GetBeardTypeModel.fromJson(jsonDecode(response.body));
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
      // CommonUtils.hideProgressLoading();
    }
  }

  getAllergicTypeAPI() async {
    var response = await http.get(Uri.parse(GET_ALLERGICTYPE_URL));
    if (response.statusCode == 200) {
      _getAllergicToneModel =
          allergicTone.GetAllergicToneModel.fromJson(jsonDecode(response.body));
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
      // CommonUtils.hideProgressLoading();
    }
  }

  

  getManglikTypeAPI() async {
    var response = await http.get(Uri.parse(GET_MANGLIKTYPE_URL));
    if (response.statusCode == 200) {
      _getManglikTypeModel =
          manglikType.GetManglikTypeModel.fromJson(jsonDecode(response.body));
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
  addBasicDetailAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var params;

    params = {
      "firstname": _firstNameController.text,
      "middlename": _middleNameController.text,
      "lastname": _lastNameController.text,
      "body_type": (_bodytypeData != null) ? _bodytypeData!.id : "",
      "created_by": (createdBy != null) ? createdBy : "",
      "refer_by": _refer.text,
      "dob": _datecontroller.text,
      "weight": (_weightData != null) ? _weightData!.id : "",
      "age": (_ageData != null) ? _ageData!.id : "",
      "nationality": (_nationalitydata != null) ? _nationalitydata!.id : "",
      "marital_status": (_maritalData != null) ? _maritalData!.id : "",
      "height": (_heightData != null) ? _heightData!.id : "",
      "gender": (gender != null) ? gender : "",
      "religion": (_data != null) ? _data!.id : "",
      "gotra": (_gotraData != null)
          ? (isSelectOther)
              ? _otherGotraController.text
              : _gotraData!.id
          : "",
      "caste": (_castdata != null) ? _castdata!.id : "",
      "skin_tone": (skinToneName['id'] != null)
          ? skinToneName['id']
          : "" /* (_skinToneData != null) ? _skinToneData!.id : "" */,
      "allergic_type": (allergicName['id'] != null)
          ? allergicName['id']
          : "" /* (_allergicData != null) ? _allergicData!.id : "" */,
      "drink_type": (_drinkData != null) ? _drinkData!.id : "",
      "beard_type": checkGender == "Male"
          ? (appearanceName['id'] != null)
              ? appearanceName['id']
              : ""
          : "",
      "manglik_type": (manglikName['id'] != null)
          ? manglikName['id']
          : "" /* (_manglikData != null) ? _manglikData!.id : "" */,
      "about_me_long": 'test',
      "birth_place": _placecontroller.text,
      "birth_time": _timecontroller.text
    };
    log(params.toString());
    /*  params = {
      "email": _email.text,
      "mobile": _mobileno.text,
      "createdBy": createdBy,
      "middlename": _middleNameController.text,
      "firstname": _firstNameController.text,
      "lastname": _lastNameController.text,
      "gender": (gender != null) ? gender : "",
      "cast": (_castdata != null) ? _castdata!.id : "",
      "gotra": (_gotraData != null) ? _gotraData!.id : "",
      "skin_tone": (_skinToneData != null) ? _skinToneData!.id : "",
      "allergic_type": (_allergicData != null) ? _allergicData!.id : "",
      "nationality": (nationality != null) ? nationality : "",
      "drink_type": (_drinkData != null) ? _drinkData!.id : "",
      "age": (_ageData != null) ? _ageData!.id : "",
      "marital_status": (_maritalData != null) ? _maritalData!.id : "",
      "height": (_heightData != null) ? _heightData!.id : "",
      "weight": _weightcontroller.text,
      "dob": _datecontroller.text,
      "refer_by": _refer.text,
      "birth_place": _placecontroller.text,
      "birth_time": _timecontroller.text,
    }; */

    print("Update basic :: ${params}");

    try {
      var response = await dio.post(UPDATE_BASIC_DETAIL_URL + "?" + queryString,
          data: params);
      if (response.statusCode == 200) {
        var data = response.data;
        if (data['success'] == true) {
          UpdateBasicDetailModel _updateBasicDetailModel =
              UpdateBasicDetailModel.fromJson(response.data);
          print(response.data);
          if (widget.fromValue == "Edit") {
            Navigator.pop(context, "UpdateData");
          } else {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => Looking_for()));
          }
        } else {
          if (widget.fromValue == "Edit") {
            Navigator.pop(context, "UpdateData");
          } else {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => Looking_for()));
          }
        }

        print("add basic detail response :::::: ${response.data}");
      } else if (response.statusCode == 429) {
        addBasicDetailAPI();
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
        var data = response.data;
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  getBasicDetail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {"token": token.toString()};
    String queryString = Uri(queryParameters: queryParameters).query;
    var response =
        await http.get(Uri.parse(GET_BASIC_DETAIL_URL + "?" + queryString));
    if (response.statusCode == 200) {
      CommonUtils.hideProgressLoading();
      GetBasicDetailModel _getBasicDetailModel =
          GetBasicDetailModel.fromJson(jsonDecode(response.body));
      checkGender = _getBasicDetailModel.data!.gender.toString();
      log(response.body);
      setState(() {
        _firstNameController.text = (_getBasicDetailModel.data != null &&
                _getBasicDetailModel.data!.firstname != null)
            ? _getBasicDetailModel.data!.firstname.toString()
            : "";
        _lastNameController.text = (_getBasicDetailModel.data!.lastname != null)
            ? _getBasicDetailModel.data!.lastname.toString()
            : "";
        _middleNameController.text =
            (_getBasicDetailModel.data!.middlename != null)
                ? _getBasicDetailModel.data!.middlename.toString()
                : "";
        _email.text = _getBasicDetailModel.data!.email.toString();
        _mobileno.text = _getBasicDetailModel.data!.mobile.toString();
        gender = (_getBasicDetailModel.data!.gender != null)
            ? _getBasicDetailModel.data!.gender.toString()
            : null;
        createdBy = (_getBasicDetailModel.data!.createdBy != null)
            ? _getBasicDetailModel.data!.createdBy.toString()
            : null;
        _placecontroller.text = (_getBasicDetailModel.data!.birthPlace != null)
            ? _getBasicDetailModel.data!.birthPlace.toString()
            : "";
        _timecontroller.text = (_getBasicDetailModel.data!.birthTime != null)
            ? _getBasicDetailModel.data!.birthTime.toString()
            : "";
        _datecontroller.text = (_getBasicDetailModel.data!.dob != null)
            ? _getBasicDetailModel.data!.dob.toString()
            : "";
        _weightcontroller.text = (_getBasicDetailModel.data!.weight != null)
            ? _getBasicDetailModel.data!.weight.toString()
            : "";
      });
      if (_religionData != null && _religionData!.data != null) {
        for (var i = 0; i < _religionData!.data!.length; i++) {
          if (_getBasicDetailModel.data!.religion ==
              _religionData!.data![i].id) {
            _data = _religionData!.data![i];
          }
        }
      }

      if (_ageModel != null) {
        for (var i = 0; i < _ageModel!.data!.length; i++) {
          if (_getBasicDetailModel.data!.age == _ageModel!.data![i].id) {
            setState(() {
              _ageData = _ageModel!.data![i];
              // log("age data ${_ageData!.id}");
            });
          }
        }
      }
      if (_weightModel != null) {
        for (var i = 0; i < _weightModel!.data!.length; i++) {
          if (_getBasicDetailModel.data!.weight == _weightModel!.data![i].id) {
            setState(() {
              _weightData = _weightModel!.data![i];
              // log("weight data ${_weightData!.id}");
            });
          }
        }
      }

      if (_heightModel != null) {
        for (var i = 0; i < _heightModel!.data!.length; i++) {
          if (_getBasicDetailModel.data!.height == _heightModel!.data![i].id) {
            setState(() {
              _heightData = _heightModel!.data![i];
              // log("height data ${_heightData!.id}");
            });
          }
        }
      }
      /* if (_getSkinToneModel != null) { */
      for (var i = 0; i < skinToneList.length; i++) {
        if (_getBasicDetailModel.data!.skinTone ==
            skinToneList[i]['id'] /* _getSkinToneModel!.data![i].id */) {
          setState(() {
            skinToneName = skinToneList[i];
            // log("skinTone data ${skinToneName}");
            /* _getSkinToneModel!.data![i] */;
          });
        }
        //}
      }

      if (_castModel != null) {
        for (var i = 0; i < _castModel!.data!.length; i++) {
          if (_getBasicDetailModel.data!.caste == _castModel!.data![i].id) {
            setState(() {
              _castdata = _castModel!.data![i];
              // log("cast data ${_castdata!.id}");
            });
          }
        }
      }
      if (_getmaritalStatusModel != null) {
        for (var i = 0; i < _getmaritalStatusModel!.data!.length; i++) {
          if (_getBasicDetailModel.data!.maritalStatus ==
              _getmaritalStatusModel!.data![i].id) {
            setState(() {
              _maritalData = _getmaritalStatusModel!.data![i];
              // log("marital data ${_maritalData!.id}");
              // print(_maritalData!.name);
            });
          }
        }
      }
      if (_gotraModel != null) {
        for (var i = 0; i < _gotraModel!.data!.length; i++) {
          if (_getBasicDetailModel.data!.gotra == _gotraModel!.data![i].id) {
            setState(() {
              _gotraData = _gotraModel!.data![i];
              // log("Gotra data ${_gotraData!.id}");
            });
          }
        }
      }
      // if (_getBeardTypeModel != null) {
      for (var i = 0; i < appearanceList.length; i++) {
        if (_getBasicDetailModel.data!.beardType ==
            /* _getBeardTypeModel!.data![i].id */ appearanceList[i]['id']) {
          setState(() {
            appearanceName =
                appearanceList[i] /* _getBeardTypeModel!.data![i] */;
            // log("Beard data ${appearanceName}");
          });
        }
        //}
      }
      // if (_getAllergicToneModel != null) {
      for (var i = 0; i < allergicList.length; i++) {
        if (_getBasicDetailModel.data!.allergicType ==
            allergicList[i]['id'] /*  _getAllergicToneModel!.data![i].id */) {
          setState(() {
            allergicName =
                allergicList[i] /* _getAllergicToneModel!.data![i] */;
            // log("Allergic data ${allergicName}");
          });
        }
        // }
      }
      if (_getDrinkTypeModel != null) {
        for (var i = 0; i < _getDrinkTypeModel!.data!.length; i++) {
          if (_getBasicDetailModel.data!.drinkType ==
              _getDrinkTypeModel!.data![i].id) {
            setState(() {
              _drinkData = _getDrinkTypeModel!.data![i];
              // log("Drink data ${_drinkData!.id}");
            });
          }
        }
      }
      // if (_getManglikTypeModel != null) {
      for (var i = 0; i < manglikList.length; i++) {
        if (_getBasicDetailModel.data!.manglikType ==
            manglikList[i]['id'] /* _getManglikTypeModel!.data![i].id */) {
          setState(() {
            manglikName = manglikList[i] /* _getManglikTypeModel!.data![i] */;
            // log("Manglik data ${manglikName}");
          });
        }
        //}
      }
      if (_getBodytypeModel != null) {
        for (var i = 0; i < _getBodytypeModel!.data!.length; i++) {
          // print("body type :::: ${_getBasicDetailModel.data!.bodytype}");
          if (_getBasicDetailModel.data!.bodytype ==
              _getBodytypeModel!.data![i].id) {
            setState(() {
              _bodytypeData = _getBodytypeModel!.data![i];
              // log("BodyType data ${_bodytypeData!.id}");
            });
          }
        }
      }
      if (_getNationalityModel != null) {
        for (var i = 0; i < _getNationalityModel!.data!.length; i++) {
          if (_getBasicDetailModel.data!.nationality ==
              int.parse(_getNationalityModel!.data![i].id.toString())) {
            setState(() {
              _nationalitydata = _getNationalityModel!.data![i];
              // log("Nationality data ${_nationalitydata!.id}");
            });
          }
        }
      }
    } else if (response.statusCode == 429) {
      CommonUtils.hideProgressLoading();
      getBasicDetail();
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
      // CommonUtils.hideProgressLoading();
    }
  }

  List<DropdownMenuItem<height.HeightData>> addDividersAfterItemsHeight(
      List<height.HeightData> items) {
    List<DropdownMenuItem<height.HeightData>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<height.HeightData>(
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
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<height.HeightData>(
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

  List<DropdownMenuItem<bodytype.Data>> addDividersAfterItemsBodytype(
      List<bodytype.Data> items) {
    List<DropdownMenuItem<bodytype.Data>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<bodytype.Data>(
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
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<bodytype.Data>(
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
          //If it's last item, we will not add Divider after it.
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

  List<DropdownMenuItem<WeightData>> addDividersAfterItemsWeight(
      List<WeightData> items) {
    List<DropdownMenuItem<WeightData>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<WeightData>(
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
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<WeightData>(
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

  List<DropdownMenuItem<maritalStatus.Data>> addDividersAfterItemsMeritial(
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
          //If it's last item, we will not add Divider after it.
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

  List<DropdownMenuItem<Map<String, dynamic>>> addDividersAfterItemsSkinTone(
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
                item['name'].toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
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

  List<DropdownMenuItem<Map<String, dynamic>>> addDividersAfterItemsBeardType(
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
          //If it's last item, we will not add Divider after it.
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

  List<DropdownMenuItem<Map<String, dynamic>>>
      addDividersAfterItemsAllergicType(List<Map<String, dynamic>> items) {
    List<DropdownMenuItem<Map<String, dynamic>>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<Map<String, dynamic>>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 10),
              child: Text(
                item['name'].toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
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

  List<DropdownMenuItem<drinkType.Data>> addDividersAfterItemsDrinkType(
      List<drinkType.Data> items) {
    List<DropdownMenuItem<drinkType.Data>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<drinkType.Data>(
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
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<drinkType.Data>(
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

  List<DropdownMenuItem<Map<String, dynamic>>> addDividersAfterItemsManglikType(
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
                item['name'].toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
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

  List<DropdownMenuItem<nationality.Data>> addDividersAfterItemsnationality(
      List<nationality.Data> items) {
    List<DropdownMenuItem<nationality.Data>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<nationality.Data>(
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
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<nationality.Data>(
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

  // final List<String> Gender = ['Male', 'Female'];
  // final List<String> Gender = ['male', 'female'];
  String? gender;

  List<DropdownMenuItem<String>> _addDividersAfterItems(
      List<Map<String, dynamic>> gender) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in genderList) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item['name'],
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
          //If it's last item, we will not add Divider after it.
          if (item != genderList.last)
            const DropdownMenuItem<String>(
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
    for (var i = 0; i < (genderList.length * 2) - 1; i++) {
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _dividersIndexes.add(i);
      }
    }
    return _dividersIndexes;
  }

  final List<String> createdby = [
    'Myself',
    'Brother',
    'Sister',
    'Father',
    'Mother',
    'Relative',
    // 'Executive'
  ];
  String? Createdby;

  List<DropdownMenuItem<String>> _addDividersAfterItemscreated(
      List<String> createdBy) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in createdBy) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != createdby.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<DropdownMenuItem<religionData.Data>> addDividersAfterItemsReligion(
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
  }

  List<int> _getDividersIndexescreated() {
    List<int> _dividersIndexes = [];
    for (var i = 0; i < (createdby.length * 2) - 1; i++) {
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _dividersIndexes.add(i);
      }
    }
    return _dividersIndexes;
  }
}

class ProfileDataGetAppbar extends StatelessWidget {
  String name;

  ProfileDataGetAppbar({Key? key, required this.name}) : super(key: key);

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
              Navigator.pop(context, "BasicDetail");
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
