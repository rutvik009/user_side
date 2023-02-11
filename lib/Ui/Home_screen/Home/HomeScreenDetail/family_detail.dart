import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/getAllCandidateDetailModel.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Family_Detail extends StatefulWidget {
  GetAllCandidateDetailsModel? allCandidateDetailsModel;
  String? fromValue;
  Family_Detail({Key? key, this.fromValue, this.allCandidateDetailsModel})
      : super(key: key);

  @override
  Family_DetailScreen createState() => Family_DetailScreen();
}

class Family_DetailScreen extends State<Family_Detail> {
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
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
             
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8, top: 5),
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
                                widget.allCandidateDetailsModel != null &&
                                        widget.allCandidateDetailsModel!.data !=
                                            null &&
                                        widget.allCandidateDetailsModel!.data!
                                                .userFamily !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .userFamily!.familyType !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .userFamily!
                                                    .familyType !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.userFamily!.familyType
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
                                widget.allCandidateDetailsModel != null &&
                                        widget.allCandidateDetailsModel!.data !=
                                            null &&
                                        widget.allCandidateDetailsModel!.data!
                                                .userFamily !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .userFamily!.religion !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .userFamily!
                                                    .religion !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.userFamily!.religion
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
                                widget.allCandidateDetailsModel != null &&
                                        widget.allCandidateDetailsModel!.data !=
                                            null &&
                                        widget.allCandidateDetailsModel!.data!
                                                .userFamily !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .userFamily!.motherTounge !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .userFamily!
                                                    .motherTounge !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.userFamily!.motherTounge
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
                                widget.allCandidateDetailsModel != null &&
                                        widget.allCandidateDetailsModel!.data !=
                                            null &&
                                        widget.allCandidateDetailsModel!.data!
                                                .userFamily !=
                                            null
                                    ? (widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .userFamily!
                                                    .fatherOccupation !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .userFamily!
                                                    .fatherOccupation !=
                                                '')
                                        ? " " +
                                            widget
                                                .allCandidateDetailsModel!
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
                                widget.allCandidateDetailsModel != null &&
                                        widget.allCandidateDetailsModel!.data !=
                                            null &&
                                        widget.allCandidateDetailsModel!.data!
                                                .userFamily !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .userFamily!.familyIncome !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .userFamily!
                                                    .familyIncome !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.userFamily!.familyIncome
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
                                widget.allCandidateDetailsModel != null &&
                                        widget.allCandidateDetailsModel!.data !=
                                            null &&
                                        widget.allCandidateDetailsModel!.data!
                                                .userFamily !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .userFamily!.noBrothers !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .userFamily!
                                                    .noBrothers !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.userFamily!.noBrothers
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
                                widget.allCandidateDetailsModel != null &&
                                        widget.allCandidateDetailsModel!.data !=
                                            null &&
                                        widget.allCandidateDetailsModel!.data!
                                                .userFamily !=
                                            null
                                    ? (widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .userFamily!
                                                    .marriedBrothers !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .userFamily!
                                                    .marriedBrothers !=
                                                '')
                                        ? " " +
                                            widget
                                                .allCandidateDetailsModel!
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
                                widget.allCandidateDetailsModel != null &&
                                        widget.allCandidateDetailsModel!.data !=
                                            null &&
                                        widget.allCandidateDetailsModel!.data!
                                                .userFamily !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .userFamily!.noSisters !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .userFamily!
                                                    .noSisters !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.userFamily!.noSisters
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
                                widget.allCandidateDetailsModel != null &&
                                        widget.allCandidateDetailsModel!.data !=
                                            null &&
                                        widget.allCandidateDetailsModel!.data!
                                                .userFamily !=
                                            null
                                    ? (widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .userFamily!
                                                    .marriedSisters !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .userFamily!
                                                    .marriedSisters !=
                                                '')
                                        ? " " +
                                            widget
                                                .allCandidateDetailsModel!
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
                                widget.allCandidateDetailsModel != null &&
                                        widget.allCandidateDetailsModel!.data !=
                                            null &&
                                        widget.allCandidateDetailsModel!.data!
                                                .userFamily !=
                                            null
                                    ? (widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .userFamily!
                                                    .familyBasedOut !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .userFamily!
                                                    .familyBasedOut !=
                                                '')
                                        ? " " +
                                            widget
                                                .allCandidateDetailsModel!
                                                .data!
                                                .userFamily!
                                                .familyBasedOut
                                                .toString()
                                        : " N/A"
                                    : "",
                                    maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
     
      ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
   
    } else if (connectivityResult == ConnectivityResult.wifi) {
      
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Alert"),
              content: Text("Check Your Internet Connection"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok")),
              ],
            );
          });
    }
  }

  Widget detailtext(String text) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
        child: Text(text, style: detailtextname),
      ),
    );
  }

  Widget detailedit(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: AppColors.borderdetail,
            width: 1,
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 8.0, right: 8.0, top: 12, bottom: 12),
          child: Text(
            text,
            style: detaileditname,
          ),
        ),
      ),
    );
  }
}
