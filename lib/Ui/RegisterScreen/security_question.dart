import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:http/http.dart' as http;
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/securityQuestion_model.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/Drawer_Screen.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/enter_mobilenumber.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/submit_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Security_Questions extends StatefulWidget {
  const Security_Questions({Key? key}) : super(key: key);

  @override
  State<Security_Questions> createState() => _Security_QuestionsState();
}

class _Security_QuestionsState extends State<Security_Questions> {
  SecurityQuestionModel? _securityQuestion1Model;
  SecurityQuestionModel? _securityQuestion3Model;
  final _form = GlobalKey<FormState>();
  List<Data> _securityQuestionMainList = [];
  Data? _securityQuestion1;
  Data? _securityQuestion2;
  Data? _securityQuestion3;
  List<Data> q2 = [];
  List<Data> q3 = [];
  List<Data> q1 = [];
  List<SecurityQuestionModel> questions = [];
  String? securitydropdown;

  TextEditingController firstQuestion = TextEditingController();
  TextEditingController secondQuestion = TextEditingController();
  TextEditingController thirdQuestion = TextEditingController();

  bool isQues1 = false;
  bool isQues2 = false;
  bool isQues3 = false;
  Data? ques1;
  Data? ques2;
  Data? ques3;

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
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Column(
            children: [
              HeaderAppBar(name: "securityquestion".tr),
              SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isQues1 = !isQues1;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ques1 != null
                                            ? ques1!.question.toString()
                                            : "Q1. Please Select First Question",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16),
                                      ),
                                      Icon(Icons.keyboard_arrow_down)
                                    ],
                                  )),
                              isQues1
                                  ? Container(
                                      height: 250,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade300,
                                            blurRadius: 30.0,
                                            spreadRadius: 1.0),
                                      ]),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: ListView.builder(
                                            itemCount: _securityQuestionMainList
                                                .length,
                                            shrinkWrap: true,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            // shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (ques1 != null) {
                                                          _securityQuestionMainList
                                                              .add(ques1!);
                                                        }
                                                        ques1 =
                                                            _securityQuestionMainList[
                                                                index];
                                                        _securityQuestionMainList
                                                            .removeAt(index);
                                                        isQues1 = false;
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5.0),
                                                      child: Text(
                                                        _securityQuestionMainList[
                                                                index]
                                                            .question
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                  Divider()
                                                ],
                                              );
                                            }),
                                      ),
                                    )
                                  : Container(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  controller: firstQuestion,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field can't empty";
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppConstants.ans1,
                                    hintStyle: headerstyle.copyWith(
                                      color: Color(0xff333F52),
                                      fontSize: 14.3,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isQues2 = !isQues2;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ques2 != null
                                            ? ques2!.question.toString()
                                            : "Q2. Please Select Second Question",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16),
                                      ),
                                      Icon(Icons.keyboard_arrow_down)
                                    ],
                                  )),
                              isQues2
                                  ? Container(
                                      height: 250,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade300,
                                            blurRadius: 30.0,
                                            spreadRadius: 1.0),
                                      ]),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: ListView.builder(
                                            itemCount: _securityQuestionMainList
                                                .length,
                                            shrinkWrap: true,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            // shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (ques2 != null) {
                                                          _securityQuestionMainList
                                                              .add(ques2!);
                                                        }
                                                        ques2 =
                                                            _securityQuestionMainList[
                                                                index];
                                                        _securityQuestionMainList
                                                            .removeAt(index);
                                                        isQues2 = false;
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5.0),
                                                      child: Text(
                                                        _securityQuestionMainList[
                                                                index]
                                                            .question
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                  Divider()
                                                ],
                                              );
                                            }),
                                      ),
                                    )
                                  : Container(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  controller: secondQuestion,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field can't empty";
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppConstants.ans2,
                                    hintStyle: headerstyle.copyWith(
                                      color: Color(0xff333F52),
                                      fontSize: 14.3,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              // 1st Question
                              /*  Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<Data>(
                                      isExpanded: true,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      icon: Image.asset(
                                        ImagePath.downarrow,
                                        height: 24,
                                        width: 24,
                                      ),
                                      hint: Text(AppConstants.que1),
                                      itemHeight: 20,
                                      dropdownMaxHeight: 200,
                                      items:
                                          addDividersAfterItems((q1 != null) ? q1 : []),
                                      customItemsIndexes:
                                          getDividersIndexes((q1 != null) ? q1 : []),
                                      value: _securityQuestion1,
                                      onChanged: (value) {
                                        setState(() {
                                          _securityQuestion1 = value;
                                          getsecurityquestion2();
                                        });

                                        for (int i = 0;
                                            i < _securityQuestionMainList.length;
                                            i++) {
                                          setState(() {
                                            q2.clear();
                                            q3.clear();
                                          });
                                          if (_securityQuestion1!.id !=
                                              _securityQuestionMainList[i].id) {
                                            log("00000000");
                                            */ /*  setState(() {
                                              q2.add(_securityQuestionMainList[i]);
                                              q3.add(_securityQuestionMainList[i]);
                                            });*/ /*
                                          } else if (_securityQuestion2!.id !=
                                              _securityQuestionMainList[i].id) {
                                            log("111111111");
                                            */ /* setState(() {
                                              q1.add(_securityQuestionMainList[i]);
                                              q3.add(_securityQuestionMainList[i]);
                                            });*/ /*
                                          } else if (_securityQuestion3!.id !=
                                              _securityQuestionMainList[i].id) {
                                            log("22222");
                                            */ /* setState(() {
                                              q1.add(_securityQuestionMainList[i]);
                                              q3.add(_securityQuestionMainList[i]);
                                            });*/ /*
                                          } else if (_securityQuestion2!.id !=
                                              _securityQuestionMainList[i].id) {
                                            log("111111111");
                                            */ /* setState(() {
                                              q1.add(_securityQuestionMainList[i]);
                                              q3.add(_securityQuestionMainList[i]);
                                            });*/ /*
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  controller: firstQuestion,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field can't empty";
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppConstants.ans1,
                                    hintStyle: headerstyle.copyWith(
                                      color: Color(0xff333F52),
                                      fontSize: 14.3,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),*/
                              /*     SizedBox(height: 30),

                              // 2nd Question
                              Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<Data>(
                                      isExpanded: true,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      icon: Image.asset(
                                        ImagePath.downarrow,
                                        height: 24,
                                        width: 24,
                                      ),
                                      hint: Text(AppConstants.que2),
                                      dropdownMaxHeight: 200,
                                      itemHeight: 20,
                                      items: addDividersAfterItems(
                                          (_securityQuestion2Model != null)
                                              ? _securityQuestion2Model!.data!
                                              : []),
                                      customItemsIndexes: getDividersIndexes(
                                          (_securityQuestion2Model != null)
                                              ? _securityQuestion2Model!.data!
                                              : []),
                                      value: _securityQuestion2,
                                      onChanged: (value) {
                                        setState(() {
                                          _securityQuestion2 = value;
                                          getsecurityquestion3();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  controller: secondQuestion,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field can't empty";
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppConstants.ans2,
                                    hintStyle: headerstyle.copyWith(
                                      color: Color(0xff333F52),
                                      fontSize: 14.3,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),*/
                              // 3rd Question
                              /*   Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<Data>(
                                      isExpanded: true,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      icon: Image.asset(
                                        ImagePath.downarrow,
                                        height: 24,
                                        width: 24,
                                      ),
                                      hint: Text(AppConstants.que3),
                                      itemHeight: 20,
                                      dropdownMaxHeight: 200,
                                      items: addDividersAfterItems(
                                          (_securityQuestion3Model != null)
                                              ? _securityQuestion3Model!.data!
                                              : []),
                                      customItemsIndexes: getDividersIndexes(
                                          (_securityQuestion3Model != null)
                                              ? _securityQuestion3Model!.data!
                                              : []),
                                      value: _securityQuestion3,
                                      onChanged: (value) {
                                        setState(() {
                                          _securityQuestion3 = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  controller: thirdQuestion,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field can't empty";
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppConstants.ans1,
                                    hintStyle: headerstyle.copyWith(
                                      color: Color(0xff333F52),
                                      fontSize: 14.3,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),*/
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isQues3 = !isQues3;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ques3 != null
                                            ? ques3!.question.toString()
                                            : "Q3. Please Select Third Question",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16),
                                      ),
                                      Icon(Icons.keyboard_arrow_down)
                                    ],
                                  )),
                              isQues3
                                  ? Container(
                                      height: 250,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade300,
                                            blurRadius: 30.0,
                                            spreadRadius: 1.0),
                                      ]),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: ListView.builder(
                                            itemCount: _securityQuestionMainList
                                                .length,
                                            shrinkWrap: true,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            // shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (ques3 != null) {
                                                          _securityQuestionMainList
                                                              .add(ques3!);
                                                        }
                                                        ques3 =
                                                            _securityQuestionMainList[
                                                                index];
                                                        _securityQuestionMainList
                                                            .removeAt(index);
                                                        isQues3 = false;
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5.0),
                                                      child: Text(
                                                        _securityQuestionMainList[
                                                                index]
                                                            .question
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                  Divider()
                                                ],
                                              );
                                            }),
                                      ),
                                    )
                                  : Container(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  controller: thirdQuestion,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "This field can't empty";
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppConstants.ans1,
                                    hintStyle: headerstyle.copyWith(
                                      color: Color(0xff333F52),
                                      fontSize: 14.3,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CommonButton(
                btnName: "post".tr,
                btnOnTap: () {
                  setState(() {
                    if (_form.currentState!.validate()) {
                      _greateDialogBox();
                    }
                    ;
                  });
                }),
          ),
        ),
      ),
    );
  }

  _greateDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 16),
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: Container(
              height: 290,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(ImagePath.greyCross,
                            height: 28, width: 28),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                  Image.asset(ImagePath.greaticon, height: 69, width: 69),
                  SizedBox(height: 20),
                  Text(
                    AppConstants.great,
                    style: headingStyle.copyWith(
                      color: Color(0xff333F52),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 13),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      AppConstants.successText,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: headingStyle.copyWith(
                        color: Color(0xffAFAFAF),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: CommonButton(
                      btnName: AppConstants.done,
                      btnOnTap: () {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) => Zoom()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getSecurityQuestion1();
      // getSecurityQuestion2();
      // getSecurityQuestion3();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getSecurityQuestion1();
      // getSecurityQuestion2();
      // getSecurityQuestion3();
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

  getSecurityQuestion1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(USER_TOKEN);
    CommonUtils.showProgressLoading(context);
    print(authToken);

    var response = await http.get(
      Uri.parse(GET_SECURITYQUESTION_URL),
    );

    if (response.statusCode == 200) {
      CommonUtils.hideProgressLoading();
      if (mounted) {
        setState(() {
          _securityQuestion1Model =
              SecurityQuestionModel.fromJson(jsonDecode(response.body));
          _securityQuestionMainList = _securityQuestion1Model!.data!;
          log("Question ${_securityQuestionMainList.length}");
        });
      }

      setState(() {
        q1 = _securityQuestionMainList;
        q2 = _securityQuestionMainList;
        q3 = _securityQuestionMainList;
      });
      log("here is data ${q1[0].question}");
      /*for (var i = 0; i < _securityQuestionMainList!.length; i++) {
        setState(() {
          q2.add(_securityQuestionMainList![i]);
        });
        // q3.add(_securityQuestion1Model!.data![i]);
        // q1.add(_securityQuestion1Model!.data![i]);
      }*/
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

  getsecurityquestion2() async {
    var response = await http.get(Uri.parse(GET_SECURITYQUESTION_URL +
        "?select_question=${_securityQuestion1!.id}"));

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
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

  getsecurityquestion3() async {
    var response = await http.get(Uri.parse(GET_SECURITYQUESTION_URL +
        "?select_question=${_securityQuestion1!.id},${_securityQuestion2!.id}"));

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _securityQuestion3Model =
              SecurityQuestionModel.fromJson(jsonDecode(response.body));
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

  // 1st qestion
  List<DropdownMenuItem<Data>> addDividersAfterItems(List<Data> items) {
    List<DropdownMenuItem<Data>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<Data>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0),
              child: Text(
                item.question!,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<Data>(
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
        //Dividers indexes will be the odd indexes
        if (i.isOdd) {
          _dividersIndexes.add(i);
        }
      }
      return _dividersIndexes;
    }
  }
}




/* 

import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:http/http.dart' as http;
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/securityQuestion_model.dart';

import 'package:matrimonial_app/Ui/Home_screen/Home/Drawer_Screen.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/enter_mobilenumber.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/submit_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Security_Questions extends StatefulWidget {
  const Security_Questions({Key? key}) : super(key: key);

  @override
  State<Security_Questions> createState() => _Security_QuestionsState();
}

class _Security_QuestionsState extends State<Security_Questions> {
  SecurityQuestionModel? _securityQuestion1Model;
  SecurityQuestionModel? _securityQuestion2Model;
  SecurityQuestionModel? _securityQuestion3Model;
  final _form = GlobalKey<FormState>();


  Data? _securityQuestion1;
  Data? _securityQuestion2;
  Data? _securityQuestion3;
  
  List<Data> q2 = [];
  List<Data> q3 = [];
  List<Data> q1 = [];

  String? securitydropdown;

  TextEditingController firstQuestion = TextEditingController();
  TextEditingController secondQuestion = TextEditingController();
  TextEditingController thirdQuestion = TextEditingController();

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
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderAppBar(name: "securityquestion".tr),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Container(
                        
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<Data>(
                            isExpanded: true,
                            
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            icon: Image.asset(
                              ImagePath.downarrow,
                              height: 24,
                              width: 24,
                            ),
                            hint: Text(AppConstants.que1),
                            itemHeight: 20,
                            dropdownMaxHeight: 200,
                            items: addDividersAfterItems(
                                (_securityQuestion1Model != null)
                                    ? _securityQuestion1Model!.data!
                                    
                                    : []),
                            customItemsIndexes: getDividersIndexes(
                                (_securityQuestion1Model != null)
                                    ? _securityQuestion1Model!.data!
                                    
                                    : []),
                            value: _securityQuestion1,
                            onChanged: (value) {
                              setState(() {
                                
                                _securityQuestion1 = value;
                                getsecurityquestion2();
                              });
                           
                           },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: firstQuestion,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field can't empty";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: AppConstants.ans1,
                          hintStyle: headerstyle.copyWith(
                            color: Color(0xff333F52),
                            fontSize: 14.3,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                   
                   
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Container(
                        
                        
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<Data>(
                            isExpanded: true,
                            
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            icon: Image.asset(
                              ImagePath.downarrow,
                              height: 24,
                              width: 24,
                            ),
                            hint: Text(AppConstants.que2),
                            dropdownMaxHeight: 200,
                            itemHeight: 20,
                            items: addDividersAfterItems(
                                (_securityQuestion2Model != null)
                                    ? _securityQuestion2Model!.data!
                                    : []),
                            customItemsIndexes: getDividersIndexes(
                                (_securityQuestion2Model != null)
                                    ? _securityQuestion2Model!.data!
                                    : []),
                            value: _securityQuestion2,
                            onChanged: (value) {
                              setState(() {
                              
                                _securityQuestion2 = value;
                                getsecurityquestion3();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: secondQuestion,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field can't empty";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: AppConstants.ans2,
                          hintStyle: headerstyle.copyWith(
                            color: Color(0xff333F52),
                            fontSize: 14.3,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                   
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Container(
                      
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<Data>(
                            isExpanded: true,
                         
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            icon: Image.asset(
                              ImagePath.downarrow,
                              height: 24,
                              width: 24,
                            ),
                            hint: Text(AppConstants.que3),
                          
                            itemHeight: 20,
                            dropdownMaxHeight: 200,
                            items: addDividersAfterItems(
                                (_securityQuestion3Model != null)
                                    ? _securityQuestion3Model!.data!
                                    : []),
                            customItemsIndexes: getDividersIndexes(
                                (_securityQuestion3Model != null)
                                    ? _securityQuestion3Model!.data!
                                    : []),
                            value: _securityQuestion3,
                            onChanged: (value) {
                              setState(() {
                                _securityQuestion3 = value;
                              });
                            },
                            
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: thirdQuestion,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field can't empty";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: AppConstants.ans1,
                          hintStyle: headerstyle.copyWith(
                            color: Color(0xff333F52),
                            fontSize: 14.3,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CommonButton(
                      btnName: "post".tr,
                      btnOnTap: () {
                        setState(() {
                          if (_form.currentState!.validate()) {
                            _greateDialogBox();
                          }
                          ;
                        });

                       
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _greateDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 16),
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: Container(
              height: 290,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(ImagePath.greyCross,
                            height: 28, width: 28),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                  Image.asset(ImagePath.greaticon, height: 69, width: 69),
                  SizedBox(height: 20),
                  Text(
                    AppConstants.great,
                    style: headingStyle.copyWith(
                      color: Color(0xff333F52),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 13),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      AppConstants.successText,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: headingStyle.copyWith(
                        color: Color(0xffAFAFAF),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: CommonButton(
                      btnName: AppConstants.done,
                      btnOnTap: () {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) => Zoom()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getSecurityQuestion1();
      
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getSecurityQuestion1();
      
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
getSecurityQuestion1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(USER_TOKEN);
    CommonUtils.showProgressLoading(context);
    print(authToken);

    var response = await http.get(
      Uri.parse(GET_SECURITYQUESTION_URL),
    );

    if (response.statusCode == 200) {
      CommonUtils.hideProgressLoading();
      if (mounted) {
        setState(() {
          _securityQuestion1Model =
              SecurityQuestionModel.fromJson(jsonDecode(response.body));
        });
      }
      for (var i = 0; i < _securityQuestion1Model!.data!.length; i++) {
        q2.add(_securityQuestion1Model!.data![i]);
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

  getsecurityquestion2() async {
    var response = await http.get(Uri.parse(GET_SECURITYQUESTION_URL +
        "?select_question=${_securityQuestion1!.id}"));

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _securityQuestion2Model =
              SecurityQuestionModel.fromJson(jsonDecode(response.body));
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

  getsecurityquestion3() async {
    var response = await http.get(Uri.parse(GET_SECURITYQUESTION_URL +
        "?select_question=${_securityQuestion1!.id},${_securityQuestion2!.id}"));

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _securityQuestion3Model =
              SecurityQuestionModel.fromJson(jsonDecode(response.body));
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

  List<DropdownMenuItem<Data>> addDividersAfterItems(List<Data> items) {
    List<DropdownMenuItem<Data>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<Data>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0),
              child: Text(
                item.question!,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
         
          if (item != items.last)
            const DropdownMenuItem<Data>(
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



 */