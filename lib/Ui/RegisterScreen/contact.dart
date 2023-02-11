import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'package:http/http.dart' as http;
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/GetProfile_Details/Get_Contact_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Update_Profile_Details/Update_Contact_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/country_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/state_model.dart'
    as stateModel;
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/Drawer_Screen.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/basic_detail.dart';

import 'package:matrimonial_app/Ui/RegisterScreen/career_education.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/commentextfield.dart';
import 'package:matrimonial_app/widget/submit_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Contact_screen extends StatefulWidget {
  String? fromValue;
  Contact_screen({Key? key, this.fromValue}) : super(key: key);

  @override
  State<Contact_screen> createState() => _Contact_screenState();
}

class _Contact_screenState extends State<Contact_screen> {
  int? inputlength;
  Dio dio = Dio();
  stateModel.StateModel? _stateModel;
  stateModel.Data? _data;
  countryModal? _countryModel;
  CountryData? _countryData;
  final TextEditingController _contactNocontroller = TextEditingController();
  final TextEditingController _alternatecontactNocontroller =
      TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _addresscontroller = TextEditingController();
  final TextEditingController _pinCodecontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool? isGoogleLogin = false;
  getPrefData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isGoogleLogin = pref.getBool(ISGOOGLELOGIN);
  }

  @override
  void initState() {
    super.initState();
    checkConnection();
    getPrefData();
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
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              children: [
                ProfileDataGetAppbar(name: "contact".tr),
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
                              : Image.asset(ImagePath.contact, height: 19),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "privateno".tr,
                            style: headingStyle.copyWith(
                                color: Color(0xff838994),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 45,
                            child: TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              controller: _contactNocontroller,
                              keyboardType: TextInputType.number,
                              readOnly: /* (isGoogleLogin == true) ? false : */ true,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.withOpacity(0.5),
                                  filled: true,
                                  focusColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide.none),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                      color: Color(0xff777777),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 15),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 169, 169, 169)
                                                .withOpacity(1),
                                      )
                                      /* borderSide: BorderSide.none, */
                                      ),
                                  border: OutlineInputBorder(),
                                  labelStyle: fontStyle.copyWith(
                                      color: Color(0xffd1d1d1),
                                      fontWeight: FontWeight.w500),
                                  hintText: "Enter contact number",
                                  hintStyle: TextStyle(
                                    color: Color(0xff777777),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]"))
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter a Phone Number!';
                                }
                                if (value.length < 10 || value.length > 10) {
                                  return 'Phone Number Should be 10 Character';
                                }
                              },
                              controller: _alternatecontactNocontroller,
                              keyboardType: TextInputType.number,
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
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                        color: Color(0xffD1D1D1), width: 1.5),
                                  ),
                                  border: OutlineInputBorder(),
                                  label: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "alternateno".tr,
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
                                  /*   labelText: "alternateno".tr, */
                                  labelStyle: fontStyle.copyWith(
                                      color: Color(0xff777777),
                                      fontWeight: FontWeight.w500),
                                  hintText: "Enter alternate number",
                                  hintStyle: TextStyle(
                                    color: Color(0xff757885),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "emailid".tr,
                            style: headingStyle.copyWith(
                                color: Color(0xff838994),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 45,
                            child: TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              controller: _emailcontroller,
                              keyboardType: TextInputType.emailAddress,
                              readOnly: true,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.withOpacity(0.5),
                                  filled: true,
                                  focusColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide.none),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                      color: Color(0xff777777),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 15),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 169, 169, 169)
                                                .withOpacity(1),
                                      )
                                      /* borderSide: BorderSide.none, */
                                      ),
                                  border: OutlineInputBorder(),
                                  labelStyle: fontStyle.copyWith(
                                      color: Color(0xffd1d1d1),
                                      fontWeight: FontWeight.w500),
                                  hintText: AppConstants.mailId,
                                  hintStyle: TextStyle(
                                    color: Color(0xff777777),
                                  )),
                            ),
                          ),
                          /* CommonTextField(
                              readonly: true,
                              fillColors: Colors.grey.withOpacity(0.5),
                              fill: true,
                              controller: _emailcontroller,
                              hinttext: AppConstants.mailId,
                              textInputType: TextInputType.emailAddress,
                              padding: 0), */
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "address".tr,
                            style: headingStyle.copyWith(
                                color: Color(0xff838994),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 45,
                            child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(35),
                                FilteringTextInputFormatter.allow(
                                  RegExp("[A-Za-z0-9 ,.|\s ]"),
                                ),
                              ],
                              controller: _addresscontroller,
                              keyboardType: TextInputType.name,
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
                                /* labelText: "address".tr,
                                labelStyle: fontStyle.copyWith(
                                    color: Color(0xff777777),
                                    fontWeight: FontWeight.w500), */
                                hintText: "enteraddress".tr,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "pincode".tr,
                                    style: TextStyle(
                                      color: Color(0xff4D4D4D),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
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
                          // SizedBox(height: 15),

                          TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                _countryData != null
                                    ? _countryData!.id == 1
                                        ? 6
                                        : 5
                                    : 6,
                              ),
                              FilteringTextInputFormatter.allow(
                                RegExp("[0-9]"),
                              ),
                            ],
                            controller: _pinCodecontroller,
                            keyboardType: TextInputType.number,
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
                              /* labelText: "pincode".tr,
                              labelStyle: fontStyle.copyWith(
                                  color: Color(0xff777777),
                                  fontWeight: FontWeight.w500), */
                              hintText: "enterpincode".tr,
                            ),
                            validator: (text) {
                              if (text!.length < 6) {
                                return "Please Enter 6 digit pincode";
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "country".tr,
                                    style: TextStyle(
                                      color: Color(0xff4D4D4D),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
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
                          /* Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "country".tr,
                                style: TextStyle(
                                  color: Color(0xff4D4D4D),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ), */
                          Container(
                            // height: 45,
                            width: width,
                            padding: EdgeInsets.all(2),
                            /* decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                color: Color(0xffD1D1D1),
                                width: 1.5,
                              ),
                            ), */
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField2<CountryData>(
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
                                    "selectcountry".tr,
                                    style: fontStyle.copyWith(
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return '    Please select Your Country';
                                  }
                                },
                                dropdownMaxHeight: 200,
                                itemHeight: 20,
                                items: addDividersAfterItems(
                                    (_countryModel != null)
                                        ? _countryModel!.data!
                                        : []),
                                customItemsIndexes: getDividersIndexes(
                                    (_countryModel != null)
                                        ? _countryModel!.data!
                                        : []),
                                value: _countryData,
                                onChanged: (newValue) {
                                  print(
                                      "Country iD ::::::::::::::: ${newValue}");
                                  setState(() {
                                    _countryData = newValue;
                                  });
                                  if (_formkey.currentState!.validate()) ;
                                  getState(_countryData!.id.toString());
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "state".tr,
                                    style: TextStyle(
                                      color: Color(0xff4D4D4D),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
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
                          /* Padding(
                            padding: const EdgeInsets.only(
                              bottom: 5,
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "state".tr,
                                style: TextStyle(
                                  color: Color(0xff4D4D4D),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ), */
                          Container(
                            // height: 45,
                            width: width,
                            padding: EdgeInsets.all(2),
                            /*  decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                color: Color(0xffD1D1D1),
                                width: 1.5,
                              ),
                            ), */
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField2<stateModel.Data>(
                                /* dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                ), */
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
                                    "selectstate".tr,
                                    style: fontStyle.copyWith(
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return '    Please select Your State';
                                  }
                                },
                                dropdownMaxHeight: 200,
                                itemHeight: 20,
                                items: addDividersAfterItemsStateModel(
                                    (_stateModel != null)
                                        ? _stateModel!.data!
                                        : []),
                                customItemsIndexes: getDividersIndexes(
                                    (_stateModel != null)
                                        ? _stateModel!.data!
                                        : []),
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
                                                    Career_Education()));
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
                                      updateContactAPI();
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
                                          updateContactAPI();
                                        }
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
      getCountry();
      getContactData();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getCountry();
      getContactData();
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

  getCountry() async {
    var response = await http.get(
      Uri.parse(GET_COUNTRY_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _countryModel = countryModal.fromJson(jsonDecode(response.body));
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

  getState(String index) async {
    var response = await http.get(
      Uri.parse(GET_STATE_URL + "?country=${index.toString()}"),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _stateModel =
              stateModel.StateModel.fromJson(jsonDecode(response.body));
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

  updateContactAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;

    var params = {
      "mobile": _contactNocontroller.text,
      "alt_mobile": _alternatecontactNocontroller.text,
      "email": _emailcontroller.text,
      "address": _addresscontroller.text,
      "state": (_data != null) ? _data!.id : "",
      "pincode": _pinCodecontroller.text,
      "country": (_countryData != null) ? _countryData!.id : ""
    };
    var response =
        await dio.post(UPDATE_CONTACT_URL + "?" + queryString, data: params);
    if (response.statusCode == 200) {
      var data = response.data;
      if (data['success'] == true) {
        UpdateContactModel _updateContactModel =
            UpdateContactModel.fromJson(data);
        if (widget.fromValue == "Edit") {
          Navigator.pop(context, "UpdateData");
        } else {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => Career_Education()));
        }
      } else {
        if (widget.fromValue == "Edit") {
          Navigator.pop(context, "UpdateData");
        } else {
          Navigator.push(context,
              CupertinoPageRoute(builder: (contetx) => Career_Education()));
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

  getContactData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    CommonUtils.showProgressLoading(context);
    var response =
        await http.get(Uri.parse(GET_CONTACT_URL + "?" + queryString));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['success'] == true) {
        GetContactModel _getContactModel = GetContactModel.fromJson(data);
        setState(() {
          _contactNocontroller.text = (_getContactModel.data!.mobile != null)
              ? _getContactModel.data!.mobile.toString()
              : "";
          _alternatecontactNocontroller.text =
              (_getContactModel.data!.altMobile != null)
                  ? _getContactModel.data!.altMobile.toString()
                  : "";
          _emailcontroller.text = (_getContactModel.data!.email != null)
              ? _getContactModel.data!.email.toString()
              : "";
          _addresscontroller.text = (_getContactModel.data!.address != null)
              ? _getContactModel.data!.address.toString()
              : "";
          _pinCodecontroller.text = (_getContactModel.data!.pincode != null)
              ? _getContactModel.data!.pincode.toString()
              : "";
          if (_countryModel != null && _countryModel!.data != null) {
            for (var i = 0; i < _countryModel!.data!.length; i++) {
              if (_getContactModel.data!.country ==
                  _countryModel!.data![i].id) {
                _countryData = _countryModel!.data![i];
              }
            }
          }
          if (_stateModel != null && _stateModel!.data != null) {
            for (var i = 0; i < _stateModel!.data!.length; i++) {
              if (_getContactModel.data!.state != null) {
                if (int.parse(_getContactModel.data!.state.toString()) ==
                    _stateModel!.data![i].id) {
                  _data = _stateModel!.data![i];
                }
              } else {}
            }
          }
        });
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

      print(response.body);
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

  List<DropdownMenuItem<CountryData>> addDividersAfterItems(
      List<CountryData> items) {
    List<DropdownMenuItem<CountryData>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<CountryData>(
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
            const DropdownMenuItem<CountryData>(
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

  List<DropdownMenuItem<stateModel.Data>> addDividersAfterItemsStateModel(
      List<stateModel.Data> items) {
    List<DropdownMenuItem<stateModel.Data>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<stateModel.Data>(
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
            const DropdownMenuItem<stateModel.Data>(
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
