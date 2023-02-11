import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/getAllCandidateDetailModel.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';

class Hobbies_DDetail extends StatefulWidget {
  GetAllCandidateDetailsModel? allCandidateDetailsModel;
  Hobbies_DDetail({Key? key, this.allCandidateDetailsModel}) : super(key: key);
  @override
  HobbiesDDetailScreen createState() => HobbiesDDetailScreen();
}

class HobbiesDDetailScreen extends State<Hobbies_DDetail> {
  List<String> imaglist = [
    AppConstants.catan,
    AppConstants.ludo,
    AppConstants.rave,
    AppConstants.outdoors,
    AppConstants.cricket,
    AppConstants.sushi,
    AppConstants.mountians,
    AppConstants.broadway,
    AppConstants.pilates
  ];

  var selectedList;

  var selectedevent;
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
      body: Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8, top: 5),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(bottom: 10, top: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width / 2 - 10,
                      child: Text(
                        "hobbies".tr,
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
                        child: Wrap(
                          children: List.generate(
                              widget.allCandidateDetailsModel != null &&
                                      widget.allCandidateDetailsModel!.data !=
                                          null &&
                                      widget.allCandidateDetailsModel!.data!
                                              .userHobbies !=
                                          null &&
                                      widget.allCandidateDetailsModel!.data!
                                              .userHobbies!.hobbies!.length !=
                                          0
                                  ? widget.allCandidateDetailsModel!.data!
                                      .userHobbies!.hobbies!.length
                                  : 0,
                              (index) => Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(widget
                                                      .allCandidateDetailsModel!
                                                      .data !=
                                                  null &&
                                              widget
                                                      .allCandidateDetailsModel!
                                                      .data!
                                                      .userHobbies!
                                                      .hobbies !=
                                                  []
                                          ? widget
                                                  .allCandidateDetailsModel!
                                                  .data!
                                                  .userHobbies!
                                                  .hobbies![index] +
                                              ','
                                          : "N/A"),
                                    ),
                                  )),
                        ))
                  
                  ],
                ),
              ),
            
            ],
          ),
        ),
      ),

    
    );
  }

  Widget _listItem(int i) {
    return Container(
        margin: EdgeInsets.only(left: 6, right: 1, top: 2, bottom: 1),
        child: FilterChip(
          backgroundColor: Colors.white,
          label: Text(
            imaglist[i],
            style: homestyle.copyWith(fontSize: 17, color: Color(0xffFB5257)),
          ),
          selectedColor: Colors.pink,
          shape: const StadiumBorder(
            side: BorderSide(
              width: 1.5,
              color: Color(0xffFB5257),
            ),
          ),
          onSelected: (bool value) {},
        ));
  }

  buildGridPopular(List<String> matches, index) {
    return Container(
      child: GestureDetector(
        onTap: () {},
        child: Padding(
          padding:
              EdgeInsets.only(left: 1.0, right: 1.0, top: 1.0, bottom: 1.0),
          child: Center(
            child: Chip(
              elevation: 20,
              padding: EdgeInsets.all(8),
              backgroundColor: Colors.greenAccent[100],
              shadowColor: Colors.black,
              label: Text(
                imaglist[index],
                style:
                    homestyle.copyWith(fontSize: 17, color: Color(0xffFB5257)),
              ),
            ),
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
}
