import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/GetProfile_Details/Get_Hobbies_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/HobbiesModel.dart'
    as hobbiesData;
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/Update_Profile_Details/Update_Hobbies_Model.dart';
// import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Drawer/ProfileScreen/profile_screenn.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/Drawer_Screen.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/basic_detail.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widget/submit_button.dart';

class Hobbies_Detail extends StatefulWidget {
  String? fromValue;
  Hobbies_Detail({Key? key, this.fromValue}) : super(key: key);
  @override
  HobbiesDetailScreen createState() => HobbiesDetailScreen();
}

class HobbiesDetailScreen extends State<Hobbies_Detail> {
  Dio dio = Dio();
  bool isSelect = false;
  TextEditingController hobbieSearch = TextEditingController();

  List<String> dataList = [];
  List<bool> selected = [];
  List<bool> searchSelect = [];
  //  hobbiesData.HobbiesModel? _hobbiesModel;

  void selectItem(int i) {
    setState(() {
      selected[i] = !selected[i];
      if (selected[i] == true) {
        print("selected items --------> $dataList");
        dataList.add(hobbieList[i].name.toString());
        print("new selection items +++++++ $dataList");
      } else if (searchSelect[i] == true) {
        for (var i = 0; i < hobbieList.length; i++) {
          for (var k = 0; k < dataList.length; k++) {
            if (hobbieList[i].name == dataList[k]) {
              selected[i] = true;
            }
          }
        }
      } else {
        if (selected[i] == false) {
          log("tap id ${hobbieList[i].name}");

          print("data list length ::: ${dataList.length}");
          for (var k = 0; k < dataList.length; k++) {
            if (hobbieList[i].name == dataList[k]) {
              log(dataList[k]);
              dataList.removeAt(k);
            }
            print("object items ======== $dataList");
          }
        }
      }
    });
  }

  /*  void searchSelectItem(int i) {
    setState(() {
      searchList[i].isSelected = !searchList[i].isSelected;
      if (searchList[i].isSelected == true) {
        print("selected items --------> $dataList");
        dataList.add(hobbieList[i]);
        print("new selection items +++++++ $dataList");
      } else {
        if (searchList[i].isSelected == false) {
          log("tap id ${searchList[i].label}");

          print("data list length ::: ${dataList.length}");
          for (var k = 0; k < dataList.length; k++) {
            if (searchList[i].label == dataList[k]) {
              log(dataList[k].label);
              dataList.removeAt(k);
            }
            print("object items ======== $dataList");
          }
        }
      }
    });
  } */

  List<hobbiesData.Data> hobbieList = [
    /*  Tech(AppConstants.catan, false),
    Tech(/* "ludo".tr */ AppConstants.ludo, false),
    Tech(/* "rave ".tr */ AppConstants.rave, false),
    Tech(/* "outdoors".tr */ AppConstants.outdoors, false),
    Tech(/* "cricket".tr */ AppConstants.cricket, false),
    Tech(/* "sushi".tr */ AppConstants.sushi, false),
    Tech(/* "mountians".tr */ AppConstants.mountians, false),
    Tech(/* "broadway".tr */ AppConstants.broadway, false),
    Tech(/* "pilates".tr */ AppConstants.pilates, false),
    Tech(/* "art".tr */ AppConstants.art, false),
    Tech(/* "movie".tr */ AppConstants.movie, false),
    Tech(/* "90s Kid".tr */ AppConstants.d, false),
    Tech(/* "kID".tr */ AppConstants.kid, false),
    Tech(/* "tikTok".tr */ AppConstants.tiktok, false),
    Tech(/* "baseBall".tr */ AppConstants.baseball, false),
    Tech(/* "bloging".tr */ AppConstants.bloging, false),
    Tech(/* "cooking".tr */ AppConstants.cooking, false),
    Tech(/* "dancing".tr */ AppConstants.dancing, false),
    Tech(/* "yoga".tr */ AppConstants.yoga, false),
    Tech(/* "working out".tr */ AppConstants.workingout, false),
    Tech(/* "vinyasa".tr */ AppConstants.vinyasa, false),
    Tech(/* "astrology".tr */ AppConstants.astrology, false), */
  ];

  @override
  void initState() {
    // foundimaglist = hobbieList;
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
                ProfileDataGetAppbar(name: "hobbies".tr),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
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
                        Padding(
                          padding: EdgeInsets.only(top: 20.0, bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xff000000).withOpacity(0.1),
                                    offset: Offset(0.5, 0.5),
                                    blurRadius: 10)
                              ],
                              border: Border.all(
                                  color: Color(0xffC5D0DE), width: 0.5),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: TextFormField(
                                controller: hobbieSearch,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  searchHobbiesAPI(value);
                                },
                                decoration: InputDecoration(
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
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 187, 187, 187),
                                        width: 1.5),
                                  ),
                                  hintText: AppConstants.search,
                                  hintStyle: TextStyle(
                                      color: Color(0xff757885),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                  label: Text(
                                    "what are looking for".tr,
                                    style: headerstyle.copyWith(
                                        color: Color(0xff4D4D4D),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Image.asset(
                                      ImagePath.search,
                                      width: 20,
                                      height: 20,
                                      color: Color(0xff576170),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: hobbies(),
                        ),
                        SizedBox(height: 30),
                        CommonButton(
                          btnName: AppConstants.done,
                          btnOnTap: () {
                            updateHobbiesAPI();
                          },
                        ),
                        SizedBox(height: 30),
                      ],
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
      getAllHobbiesAPI();
      getHobbiesAPI();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getAllHobbiesAPI();
      getHobbiesAPI();
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

  updateHobbiesAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    List hobbiesList = [];
    /* for (var i = 0; i < dataList.length; i++) {
      hobbiesList.add(dataList[i]);
    } */
    var params = {"hobbies": selectedHobby};
    print("hobbies params ::: $params");
    var response =
        await dio.post(UPDATE_HOBBIES_URL + "?" + queryString, data: params);
    if (response.statusCode == 200) {
      print(response.data);
      var data = response.data;
      if (data['success'] == true) {
        UpdateHobbiesModel updateHobbiesModel =
            UpdateHobbiesModel.fromJson(data);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => Zoom(
                      selectedIndex: 4,
                    )),
            (route) => false);
      } else {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => Profile()));
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

  getHobbiesAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_HOBBIES_URL + "?" + queryString);
    if (response.statusCode == 200) {
      print(response.data);
      var data = response.data;
      if (data['success'] == true) {
        GetHobbiesModel _getHobbiesModel =
            GetHobbiesModel.fromJson(response.data);
     
          log("Get Hobbiles Length :: ${_getHobbiesModel.data!.userHobbies!.hobbies!.length}");
          _getHobbiesModel.data!.userHobbies!.hobbies!.forEach((element) {
              selectedHobby.add(element);
            if (selectedHobby.contains(element)) {
            setState(() {
              print("is selected ::: ");
            
              isSelected = true;
            });
          }
        
         /*  for (var i = 0;
              i < _getHobbiesModel.data!.userHobbies!.hobbies!.length;
              i++) {
            log("Get ImageList Length :: ${hobbieList.length}");
            for (var j = 0; j < hobbieList.length; j++) {
              if (_getHobbiesModel.data!.userHobbies!.hobbies![i] ==
                  hobbieList[j].name) {
                selected[j] = true;
                dataList.add(_getHobbiesModel.data!.userHobbies!.hobbies![i]);
                log("Selected Hobbies  : : ${dataList}");
              }
            }
          } */
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

  getAllHobbiesAPI() async {
    var response = await dio.get(GET_ALL_HOBBIES_URL);
    if (response.statusCode == 200) {
      print(response.data);
      var data = response.data;
      if (data['success'] == true) {
        hobbiesData.HobbiesModel _hobbiesModel =
            hobbiesData.HobbiesModel.fromJson(response.data);
        for (var i = 0; i < _hobbiesModel.data!.length; i++) {
          hobbieList.add(_hobbiesModel.data![i]);
          selected.add(false);
          setState(() {});
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

  searchHobbiesAPI(String hobby) async {
    var response = await dio.get(GET_ALL_HOBBIES_URL + "?search=$hobby");
    if (response.statusCode == 200) {
      print(response.data);
      var data = response.data;
      if (data['success'] == true) {
        hobbiesData.HobbiesModel _hobbiesModel =
            hobbiesData.HobbiesModel.fromJson(response.data);
        hobbieList.clear();
        for (var i = 0; i < _hobbiesModel.data!.length; i++) {
          hobbieList.add(_hobbiesModel.data![i]);
          // searchSelect.add(false);
          setState(() {});
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

  List<String> selectedHobby = [];
   bool isSelected = false;

  List<Widget> hobbies() {
    List<Widget> chips = [];

    Widget items = Wrap(
      runSpacing: 10,
      spacing: 10,
      children: hobbieList.map(
        (hobby) {
          bool isSelected = false;
          if (selectedHobby.contains(hobby.name)) {
            setState(() {
              print("is selected ::: ");
              isSelected = true;
            });
          }
          return GestureDetector(
            onTap: () {
              if (!selectedHobby.contains(hobby) && isSelected == false) {
                if (selectedHobby.length < 5) {
                  selectedHobby.add(hobby.name.toString());
                  setState(() {});
                  print(selectedHobby);
                  log("message ::: $isSelected");
                } else {
                  Fluttertoast.showToast(msg: "Maximum 5 hobbies selected");
                }
              } else {
                selectedHobby.removeWhere((element) => element == hobby.name);
                setState(() {});
                print(selectedHobby);
              }
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: isSelected ? Color(0xffFB5257) : Colors.black38),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 8, bottom: 10),
                child: Text(
                  hobby.name.toString(),
                  textAlign: TextAlign.center,
                  style: homestyle.copyWith(
                      fontSize: 17,
                      color:
                          isSelected ? Color(0xffFB5257) : Color(0xff8B8B8B)),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );

    /* Widget items = Wrap(
      runSpacing: 10,
      spacing: 10,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: List.generate(
          hobbieList.length,
          (index) => InkWell(
                onTap: () {
                  if (dataList.length <= 4) {
                    if (selected[index] == false) {
                      selectItem(index);
                    } else {
                      for (var i = 0; i < dataList.length; i++) {
                        if (hobbieList[index].name == dataList[i]) {
                          selected[index] = false;
                          dataList.removeAt(i);
                          setState(() {});
                        }
                      }
                      log("selection else part");
                    }
                  } else if (dataList.length == 5 && selected[index] == false) {
                    Fluttertoast.showToast(msg: "Maximum 5 hobbies selected");
                  } else {
                    log("selection else part");
                    for (var i = 0; i < dataList.length; i++) {
                      if (hobbieList[index].name == dataList[i]) {
                        selected[index] = false;
                        dataList.removeAt(i);
                        setState(() {});
                      }
                    }
                  }
                  
                },
                child: Container(
                  height: 40,
                  // width:
                  // MediaQuery.of(context).size.width / 4,
                  // imaglist[index].label.characters.length.toDouble() /
                  //     0.056,
                  // padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: selected[index]
                              ? Color(0xffFB5257)
                              : Colors.black38),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 8, bottom: 10),
                    child: Text(
                      hobbieList[index].name.toString(),
                      textAlign: TextAlign.center,
                      style: homestyle.copyWith(
                          fontSize: 17,
                          color: selected[index]
                              ? Color(0xffFB5257)
                              : Color(0xff8B8B8B)),
                    ),
                  ),
                ),
              )),
    ); */
    chips.add(items);

    return chips;
  }
}

class Tech {
  String label;
  bool isSelected;
  Tech(this.label, this.isSelected);
}
