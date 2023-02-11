import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/getAllCandidateDetailModel.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:readmore/readmore.dart';

class Basic_DDetail extends StatefulWidget {
  GetAllCandidateDetailsModel? allCandidateDetailsModel;
  Basic_DDetail({Key? key, this.allCandidateDetailsModel}) : super(key: key);

  @override
  BasicDDetailScreen createState() => BasicDDetailScreen();
}

class BasicDDetailScreen extends State<Basic_DDetail> {
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
                  padding: EdgeInsets.only(bottom: 10, top: 5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: width / 2 - 10,
                              child: Text(
                                "firstname".tr,
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.firstname !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .basicInfo!
                                                    .firstname !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.firstname
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
                                "middlename".tr,
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.middlename !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .basicInfo!
                                                    .middlename !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.middlename
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
                                "lastname".tr,
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.lastname !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .basicInfo!
                                                    .lastname !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.lastname
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
                                "emailaddress".tr,
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
                              child: widget.allCandidateDetailsModel != null &&
                                      widget.allCandidateDetailsModel!.data !=
                                          null &&
                                      widget.allCandidateDetailsModel!.data!
                                              .basicInfo !=
                                          null
                                  ? (widget.allCandidateDetailsModel!.data!
                                              .basicInfo!.email
                                              .toString()
                                              .length <=
                                          17)
                                      ? Text(
                                          (widget.allCandidateDetailsModel!.data!
                                                          .basicInfo!.email !=
                                                      null &&
                                                  widget
                                                          .allCandidateDetailsModel!
                                                          .data!
                                                          .basicInfo!
                                                          .email !=
                                                      '')
                                              ? " " +
                                                  widget
                                                      .allCandidateDetailsModel!
                                                      .data!
                                                      .basicInfo!
                                                      .email
                                                      .toString()
                                              : " N/A",
                                        )
                                      : Text(
                                          widget.allCandidateDetailsModel !=
                                                      null &&
                                                  widget.allCandidateDetailsModel!
                                                          .data !=
                                                      null &&
                                                  widget.allCandidateDetailsModel!
                                                          .data!.basicInfo !=
                                                      null
                                              ? (widget
                                                              .allCandidateDetailsModel!
                                                              .data!
                                                              .basicInfo!
                                                              .email !=
                                                          null &&
                                                      widget
                                                              .allCandidateDetailsModel!
                                                              .data!
                                                              .basicInfo!
                                                              .email !=
                                                          '')
                                                  ? " " +
                                                      widget
                                                          .allCandidateDetailsModel!
                                                          .data!
                                                          .basicInfo!
                                                          .email
                                                          .toString()
                                                          .replaceAll(
                                                              "gmail.com",
                                                              "...")
                                                  : " N/A"
                                              : "",
                                        )
                                  : Container(),
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
                                "mobileno".tr,
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.mobile !=
                                                null &&
                                            widget.allCandidateDetailsModel!
                                                    .data!.basicInfo!.mobile !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.mobile
                                                .toString()
                                        : " N/A"
                                    : "",
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
                                "gender".tr,
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.gender !=
                                                null &&
                                            widget.allCandidateDetailsModel!
                                                    .data!.basicInfo!.gender !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.gender
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
                                "age".tr,
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.age !=
                                                null &&
                                            widget.allCandidateDetailsModel!
                                                    .data!.basicInfo!.age !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.age
                                                .toString() +
                                            " (Years)"
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
                                "height".tr,
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
                              child: Row(
                                children: [
                                  Text(
                                    widget.allCandidateDetailsModel != null &&
                                            widget.allCandidateDetailsModel!
                                                    .data !=
                                                null &&
                                            widget.allCandidateDetailsModel!
                                                    .data!.basicInfo !=
                                                null
                                        ? (widget.allCandidateDetailsModel!.data!
                                                        .basicInfo!.height !=
                                                    null &&
                                                widget
                                                        .allCandidateDetailsModel!
                                                        .data!
                                                        .basicInfo!
                                                        .height !=
                                                    '')
                                            ? " " +
                                                widget.allCandidateDetailsModel!
                                                    .data!.basicInfo!.height
                                                    .toString() +
                                                " (Inches)"
                                            : " N/A"
                                        : "",
                                    style: TextStyle(height: 1.5),
                                  ),
                                ],
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
                                "weight".tr,
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
                              child: Row(
                                children: [
                                  Text(
                                    widget.allCandidateDetailsModel != null &&
                                            widget.allCandidateDetailsModel!
                                                    .data !=
                                                null &&
                                            widget.allCandidateDetailsModel!
                                                    .data!.basicInfo !=
                                                null
                                        ? (widget.allCandidateDetailsModel!.data!
                                                        .basicInfo!.weight !=
                                                    null &&
                                                widget
                                                        .allCandidateDetailsModel!
                                                        .data!
                                                        .basicInfo!
                                                        .weight !=
                                                    '')
                                            ? " " +
                                                widget.allCandidateDetailsModel!
                                                    .data!.basicInfo!.weight
                                                    .toString()
                                            : " N/A"
                                        : "",
                                    style: TextStyle(height: 1.5),
                                  ),
                                ],
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
                                "manglik".tr,
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.manglikType !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .basicInfo!
                                                    .manglikType !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.manglikType
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
                                "skintone".tr,
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.skinTone !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .basicInfo!
                                                    .skinTone !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.skinTone
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.religion !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .basicInfo!
                                                    .religion !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.religion
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
                                "caste".tr,
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.caste !=
                                                null &&
                                            widget.allCandidateDetailsModel!
                                                    .data!.basicInfo!.caste !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.caste
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
                                "gotra".tr,
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.gotra !=
                                                null &&
                                            widget.allCandidateDetailsModel!
                                                    .data!.basicInfo!.gotra !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.gotra
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
                                "bodytype".tr,
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.bodyType !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .basicInfo!
                                                    .bodyType !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.bodyType
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
                                "allergic".tr,
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.allergicType !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .basicInfo!
                                                    .allergicType !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.allergicType
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
                                "appereance".tr,
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.beardType !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .basicInfo!
                                                    .beardType !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.beardType
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
                                "habit".tr,
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.drinkType !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .basicInfo!
                                                    .drinkType !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.drinkType
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
                                "status".tr,
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.maritalStatus !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .basicInfo!
                                                    .maritalStatus !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.maritalStatus
                                                .toString()
                                        : " N/A"
                                    : "",
                                /* "", */
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
                                "dateofbirth".tr,
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.dob !=
                                                null &&
                                            widget.allCandidateDetailsModel!
                                                    .data!.basicInfo!.dob !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.dob
                                                .toString()
                                        : " N/A"
                                    : "",
                                /* "", */
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
                                "addbirthplace".tr,
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.birthPlace !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .basicInfo!
                                                    .birthPlace !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.birthPlace
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
                                "addbirthtime".tr,
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.birthTime !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .basicInfo!
                                                    .birthTime !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.birthTime
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
                                "referby".tr,
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.referedBy !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .basicInfo!
                                                    .referedBy !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.referedBy
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
                                "nationality".tr,
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.nationality !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .basicInfo!
                                                    .nationality !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.nationality
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
                                "profile by".tr,
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
                                                .basicInfo !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .basicInfo!.createdBy !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .basicInfo!
                                                    .createdBy !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.basicInfo!.createdBy
                                                .toString()
                                        : " N/A"
                                    : "",
                                style: TextStyle(height: 1.5),
                              ),
                            )
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
          borderRadius: BorderRadius.circular(13),
          color: Colors.white,
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

  Widget detaileditabout(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Colors.white,
          border: Border.all(
            color: AppColors.borderdetail,
            width: 1,
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 8.0, right: 8.0, top: 12, bottom: 12),
          child: ReadMoreText(
            text,
            trimLines: 5,
            colorClickableText: currentColor,
            style: detaileditname,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Read more',
            trimExpandedText: ' Less',
          ),
        ),
      ),
    );
  }
}
