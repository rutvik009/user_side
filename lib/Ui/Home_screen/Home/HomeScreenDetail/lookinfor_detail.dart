import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/getAllCandidateDetailModel.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';

class Looking_Detail extends StatefulWidget {
  GetAllCandidateDetailsModel? allCandidateDetailsModel;
  Looking_Detail({Key? key, this.allCandidateDetailsModel}) : super(key: key);

  @override
  Looking_DetailScreen createState() => Looking_DetailScreen();
}

class Looking_DetailScreen extends State<Looking_Detail> {
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
                                "hisheight".tr,
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
                                                .lookingFor !=
                                            null
                                    ? widget.allCandidateDetailsModel!.data!
                                                .lookingFor!.heightFrom !=
                                            null
                                        ? " " +
                                            (widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .lookingFor!
                                                    .heightFrom
                                                    .toString() +
                                                " To " +
                                                widget.allCandidateDetailsModel!
                                                    .data!.lookingFor!.heightTo
                                                    .toString() +
                                                ' (Inches)')
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
                                "agerange".tr,
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
                                                .lookingFor !=
                                            null
                                    ? widget.allCandidateDetailsModel!.data!
                                                .lookingFor!.ageFrom !=
                                            null
                                        ? " " +
                                            (widget.allCandidateDetailsModel!
                                                    .data!.lookingFor!.ageFrom
                                                    .toString() +
                                                " To " +
                                                widget.allCandidateDetailsModel!
                                                    .data!.lookingFor!.ageTo
                                                    .toString() +
                                                ' (Years)')
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
                                "worktype".tr,
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
                                                .lookingFor !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .lookingFor!.workType !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .lookingFor!
                                                    .workType !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.lookingFor!.workType
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
                                "earning".tr,
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
                                                .lookingFor !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .lookingFor!.workType !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .lookingFor!
                                                    .annualIncome !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.lookingFor!.annualIncome
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
                                "diettype".tr,
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
                                                .lookingFor !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .lookingFor!.dietType !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .lookingFor!
                                                    .dietType !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.lookingFor!.dietType
                                                .toString()
                                        : " N/A"
                                    : "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
                                "marriatlestatus".tr,
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
                                                .lookingFor !=
                                            null
                                    ? (widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .lookingFor!
                                                    .maritalStatus !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .lookingFor!
                                                    .maritalStatus !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.lookingFor!.maritalStatus
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
                                "qualities".tr,
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
                                                .lookingFor !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .lookingFor!.quality !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .lookingFor!
                                                    .quality !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.lookingFor!.quality
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
                                                .lookingFor !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .lookingFor!.caste !=
                                                null &&
                                            widget.allCandidateDetailsModel!
                                                    .data!.lookingFor!.caste !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.lookingFor!.caste
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
                                                .lookingFor !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .lookingFor!.gotra !=
                                                null &&
                                            widget.allCandidateDetailsModel!
                                                    .data!.lookingFor!.gotra !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.lookingFor!.gotra
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

  Widget detailtext(String text) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
        child: Text(text, style: detailtextname),
      ),
    );
  }

  Widget detailtext1(String text) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
        child: Text(text, style: detaileditname),
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

  Widget detailedittick(String text) {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: detaileditname,
              ),
              Image.asset(
                ImagePath.tick,
                height: 16,
                width: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
