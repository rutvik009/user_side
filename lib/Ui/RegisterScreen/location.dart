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
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/GetProfile_Details/Get_Location_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Update_Profile_Details/Update_Location_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/city_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/country_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/state_model.dart'
    as stateData;
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Drawer/ProfileScreen/profile_screenn.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/Drawer_Screen.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/basic_detail.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/commentextfield.dart';
import 'package:matrimonial_app/widget/commonappbar_search.dart';
import 'package:matrimonial_app/widget/submit_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'hobbies_detail.dart';

class Location_screen extends StatefulWidget {
  String? fromValue;
  Location_screen({Key? key, this.fromValue}) : super(key: key);

  @override
  State<Location_screen> createState() => _Location_screenState();
}

String? international;

class _Location_screenState extends State<Location_screen> {
  final _formKey = GlobalKey<FormState>();
  Dio dio = Dio();
  stateData.StateModel? _stateModel;
  countryModal? _countryModel;
  bool ganderSelcted = false;
  bool nextPressed = false;
  stateData.Data? _data;
  CityModel? _cityModel;
  bool isLiving = false;

  CityData? _citydata;
  CountryData? _countryData;
  final TextEditingController _livingcontroller = TextEditingController();
  final TextEditingController _citycontroller = TextEditingController();
  final TextEditingController _stateCodecontroller = TextEditingController();
  final TextEditingController _countrycontroller = TextEditingController();

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
                ProfileDataGetAppbar(name: "location".tr),
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
                          (widget.fromValue == "Edit")
                              ? Container()
                              : SizedBox(height: 15),
                          (widget.fromValue == "Edit")
                              ? Container()
                              : Image.asset(ImagePath.loaction, height: 19),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            validator: (text) {
                              if (text!.isEmpty) {
                                /*  setState(() {
                                  isLiving = true;
                                }); */
                                return "Please Enter present living";
                              } /* else if (text.length == 18) {
                                return 'You can add maximum 18 characters only';
                              } */
                            },
                            controller: _livingcontroller,
                            keyboardType: TextInputType.text,
                            // maxLength: 50,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(25),
                              FilteringTextInputFormatter.allow(
                                RegExp("[A-Za-z  |\s]"),
                              ),
                              LengthLimitingTextInputFormatter(50)
                            ],
                            onChanged: (value) {
                              if (_formKey.currentState!.validate()) {
                                /*  if (value.isEmpty) {
                                  setState(() {
                                    isLiving = true;
                                  });
                                } else {
                                  setState(() {
                                    isLiving = false;
                                  });
                                } */
                              }
                              ;
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
                              label: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "presently living".tr,
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
                              hintText: "entercurrentliving".tr,
                            ),
                          ),
                          /* (isLiving)
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text(
                                    "Please Enter present living",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : Container(), */
                          /* CommonTextField(
                            controller: _livingcontroller,
                            lableName: "presently living".tr,
                            hinttext: "entercurrentliving".tr,
                            textInputType: TextInputType.text,
                            padding: 0,
                            readonly: false,
                          ), */
                          Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 4),
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
                              child: DropdownButton2<CountryData>(
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
                                    "selectcountry".tr,
                                    style: fontStyle.copyWith(
                                        fontSize: 15,
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
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
                                  print(newValue);
                                  setState(() {
                                    _countryData = newValue;
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 4),
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
                              child: DropdownButton2<stateData.Data>(
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
                                    "selectstate".tr,
                                    style: fontStyle.copyWith(
                                        fontSize: 15,
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                dropdownMaxHeight: 200,
                                itemHeight: 20,
                                items: addDividersAfterItemsState(
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
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 5),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "city".tr,
                                style: TextStyle(
                                  color: Color(0xff4D4D4D),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
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
                              child: DropdownButton2<CityData>(
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
                                    "selectcity".tr,
                                    style: fontStyle.copyWith(
                                        fontSize: 15,
                                        color: Color(0xff777777),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                dropdownMaxHeight: 200,
                                itemHeight: 20,
                                items: addDividersAfterItemsCity(
                                    (_cityModel != null)
                                        ? _cityModel!.data!
                                        : []),
                                customItemsIndexes: getDividersIndexes(
                                    (_cityModel != null)
                                        ? _cityModel!.data!
                                        : []),
                                value: _citydata,
                                onChanged: (newValue) {
                                  print(newValue);
                                  setState(() {
                                    _citydata = newValue;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
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
                                                    Hobbies_Detail()));
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
                          (widget.fromValue == "Edit")
                              ? CommonButton(
                                  btnName: "submit".tr,
                                  btnOnTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        updateLocationAPI();
                                      });
                                    }
                                  },
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: 54,
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              updateLocationAPI();
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: 54,
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
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
      // getLocationDetailAPI();
      // getState();
      getCountry();
      // getCity();

    } else if (connectivityResult == ConnectivityResult.wifi) {
      // getLocationDetailAPI();
      // getState();
      getCountry();
      // getCity();

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
    CommonUtils.showProgressLoading(context);
    var response = await http.get(
      Uri.parse(GET_COUNTRY_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _countryModel = countryModal.fromJson(jsonDecode(response.body));
        });
      }
      getState();
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

  getState() async {
    var response = await http.get(
      Uri.parse(GET_STATE_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _stateModel =
              stateData.StateModel.fromJson(jsonDecode(response.body));
        });
      }
      getCity();
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

  getCity() async {
    var response = await http.get(
      Uri.parse(GET_CITY_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _cityModel = CityModel.fromJson(jsonDecode(response.body));
        });
      }
      getLocationDetailAPI();
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

  updateLocationAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var params = {
      "living_place": _livingcontroller.text,
      "city": (_citydata != null) ? _citydata!.id : "",
      "state": (_data != null) ? _data!.id : "",
      "country": (_countryData != null) ? _countryData!.id : ""
    };
    var response = await dio
        .post(UPDATE_CURRENT_LOCATION_URL + "?" + queryString, data: params);
    if (response.statusCode == 200) {
      var data = response.data;
      if (data['success'] == true) {
        UpdateCurrentLocationModel _updateCurrentLocationModel =
            UpdateCurrentLocationModel.fromJson(data);
        if (widget.fromValue == "Edit") {
          Navigator.pop(context, "UpdateData");
        } else {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => Hobbies_Detail()));
        }
      } else {
        if (widget.fromValue == "Edit") {
          Navigator.pop(context, "UpdateData");
        } else {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => Hobbies_Detail()));
        }
      }
    } else if (response.statusCode == 429) {
      updateLocationAPI();
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

  getLocationDetailAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;

    // CommonUtils.showProgressLoading(context);
    var response = await dio.get(GET_LOCATION_URL + "?" + queryString);
    if (response.statusCode == 200) {
      var data = response.data;
      print(response.data);
      GetLocationModel _getLocationModel =
          GetLocationModel.fromJson(response.data);
      if (data['success'] == true) {
        setState(() {
          _livingcontroller.text = (_getLocationModel.data!.livingPlace != null)
              ? _getLocationModel.data!.livingPlace.toString()
              : "";
          if (_countryModel != null && _countryModel!.data != null) {
            for (var i = 0; i < _countryModel!.data!.length; i++) {
              if (_getLocationModel.data!.country ==
                  _countryModel!.data![i].id) {
                _countryData = _countryModel!.data![i];
              }
            }
          }
          if (_stateModel != null && _stateModel!.data != null) {
            for (var i = 0; i < _stateModel!.data!.length; i++) {
              if (_getLocationModel.data!.state == _stateModel!.data![i].id) {
                _data = _stateModel!.data![i];
              }
            }
          }
          if (_cityModel != null && _cityModel!.data != null) {
            for (var i = 0; i < _cityModel!.data!.length; i++) {
              if (_getLocationModel.data!.city == null) {
              } else {
                if (int.parse(_getLocationModel.data!.city.toString()) ==
                    _cityModel!.data![i].id) {
                  _citydata = _cityModel!.data![i];
                }
              }
            }
          }
        });
        CommonUtils.hideProgressLoading();
      } else {
        CommonUtils.hideProgressLoading();
      }
    } else if (response.statusCode == 429) {
      getLocationDetailAPI();
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

  List<DropdownMenuItem<stateData.Data>> addDividersAfterItemsState(
      List<stateData.Data> items) {
    List<DropdownMenuItem<stateData.Data>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<stateData.Data>(
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
            const DropdownMenuItem<stateData.Data>(
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

  List<DropdownMenuItem<CityData>> addDividersAfterItemsCity(
      List<CityData> items) {
    List<DropdownMenuItem<CityData>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<CityData>(
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
            const DropdownMenuItem<CityData>(
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
