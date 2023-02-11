import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/Get_Filter_Model.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Search/Filter_Data_Screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/submit_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Filter_screen extends StatefulWidget {
  const Filter_screen({Key? key}) : super(key: key);

  @override
  State<Filter_screen> createState() => _Filter_screenState();
}

class _Filter_screenState extends State<Filter_screen> {
  int val = -1;

  bool onlineOffline = false;
  bool online = false;
  bool offline = false;
  String dropdownValue = 'English';
  SfRangeValues _values = SfRangeValues(5.0, 10.0);
  double _value = 0;
  int? gender;
  String? genderValue;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: [
        _filterbar(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    AppConstants.gender,
                    style: name.copyWith(fontSize: 18),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Radio<int>(
                            activeColor: currentColor,
                            value: 1,
                            groupValue: gender,
                            onChanged: (int? value) {
                              setState(() {
                                gender = value;
                                genderValue = 'Male';
                              });
                            },
                          ),
                          Text(
                            AppConstants.male,
                            style: TextStyle(
                              color: gender == 1
                                  ? currentColor
                                  : Color(0xff7E7E7E),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Radio<int>(
                              activeColor: currentColor,
                              value: 2,
                              groupValue: gender,
                              onChanged: (int? value) {
                                setState(() {
                                  gender = value;
                                  genderValue = 'Female';
                                });
                              }),
                          Text(
                            AppConstants.female,
                            style: TextStyle(
                              color: gender == 2
                                  ? currentColor
                                  : Color(0xff7E7E7E),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Divider(),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            AppConstants.agerange,
                            style: name.copyWith(fontSize: 18),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Container(
                              width: width * 0.14,
                              child: Text(
                                _values.start.toInt().toString() +
                                    '-' +
                                    _values.end.toInt().toString(),
                                style: TextStyle(color: AppColors.female),
                              )),
                        )
                      ],
                    ),
                    Container(
                      width: width,
                      child: SfRangeSliderTheme(
                        data: SfRangeSelectorThemeData(
                          activeTrackColor: currentColor,
                          inactiveTrackColor:
                              Color(0xff7E7E7E).withOpacity(0.1),
                          thumbColor: Colors.white,
                        ),
                        child: SfRangeSlider(
                          max: 100,
                          onChanged: (SfRangeValues newvalue) {
                            setState(() {
                              _values = newvalue;
                              print('${_values.start.toString()}');
                            });
                          },
                          values: _values,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            AppConstants.maximumdistance,
                            style: name.copyWith(fontSize: 18),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            _value.toInt().toString() + ' Km',
                            style: TextStyle(color: AppColors.female),
                          ),
                        )
                      ],
                    ),
                    SfSliderTheme(
                      data: SfSliderThemeData(
                        thumbColor: Colors.white,
                        activeTrackColor: currentColor,
                        inactiveTrackColor: Color(0xff7E7E7E).withOpacity(0.1),
                      ),
                      child: SfSlider(
                        min: 1,
                        max: 200,
                        value: _value,
                        onChanged: (newValue) {
                          setState(() {
                            _value = newValue;
                            print('${_value.toString()}');
                          });
                        },
                      ),
                    )
                  ],
                ),
                Divider(),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            AppConstants.otherStates,
                            style: name.copyWith(
                              fontSize: 18,
                            ),
                          ),
                          Spacer(),
                          FlutterSwitch(
                            width: 39.0,
                            height: 25.0,
                            toggleSize: 16.0,
                            value: onlineOffline,
                            borderRadius: 30.0,
                            activeColor: currentColor,
                            onToggle: (val) {
                              setState(() {
                                onlineOffline = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.020,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 25),
                      child: Container(
                        child:
                            Text(AppConstants.otherStatessub, style: subtitle),
                      ),
                    )
                  ],
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 10, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: width * 0.5,
                            child: Text(
                              AppConstants.profilepicture,
                              style: name.copyWith(fontSize: 18),
                            ),
                          ),
                          Spacer(),
                          FlutterSwitch(
                            width: 39.0,
                            height: 25.0,
                            toggleSize: 16.0,
                            value: offline,
                            borderRadius: 30.0,
                            activeColor: currentColor,
                            onToggle: (val) {
                              setState(() {
                                offline = val;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                          width: width * 0.9,
                          child: Text(AppConstants.profilepicturesub,
                              style: subtitle))
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: CommonButton(
                      btnName: 'Search Now',
                      btnOnTap: () {
                        getFilterAPI();
                      }),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        )
      ],
    ));
  }

  getFilterAPI() async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userToken = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": userToken.toString(),
      "gender": genderValue,
      "age_from": _values.start.toInt().toString(),
      "age_to": _values.end.toInt().toString(),
      "distance_from": '1',
      "distance_to": _value.toInt().toString(),
      "lang": 'en'
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_FILTER_URL + "?" + queryString);
    if (response.statusCode == 200) {
      log("filter response :::::::::::::::::${response.data}");
      GetFilterModel _getFilterModel = GetFilterModel.fromJson(response.data);
      /* Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  FilterDataScreen(filterData: _getFilterModel.data))); */
    }
  }

  _filterbar() {
    var height = MediaQuery.of(context).size.height;
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Align(
          alignment: Alignment.center,
          child: Image.asset(
            ImagePath.backArrow,
            color: Colors.black,
            height: height * 0.050,
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        AppConstants.filter,
        style: message,
      ),
    );
  }
}
