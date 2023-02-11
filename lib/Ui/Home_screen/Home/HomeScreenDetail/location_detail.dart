import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/getAllCandidateDetailModel.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';

class Location_DDetail extends StatefulWidget {
  GetAllCandidateDetailsModel? allCandidateDetailsModel;
  Location_DDetail({Key? key, this.allCandidateDetailsModel})
      : super(
          key: key,
        );
  @override
  LocationDDetailScreen createState() => LocationDDetailScreen();
}

class LocationDDetailScreen extends State<Location_DDetail> {
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
                                "presently living".tr,
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
                                                .userLocation !=
                                            null
                                    ? (widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .userLocation!
                                                    .livingPlace !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .userLocation!
                                                    .livingPlace !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.userLocation!.livingPlace
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
                                "city".tr,
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
                                                .userLocation !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .userLocation!.city !=
                                                null &&
                                            widget.allCandidateDetailsModel!
                                                    .data!.userLocation!.city !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.userLocation!.city
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
                                "state".tr,
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
                                                .userLocation !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .userLocation!.state !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .userLocation!
                                                    .state !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.userLocation!.state
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
                                "country".tr,
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
                                                .userLocation !=
                                            null
                                    ? (widget.allCandidateDetailsModel!.data!
                                                    .userLocation!.country !=
                                                null &&
                                            widget
                                                    .allCandidateDetailsModel!
                                                    .data!
                                                    .userLocation!
                                                    .country !=
                                                '')
                                        ? " " +
                                            widget.allCandidateDetailsModel!
                                                .data!.userLocation!.country
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
