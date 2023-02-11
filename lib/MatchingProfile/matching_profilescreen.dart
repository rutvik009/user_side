/* import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/MatchingProfile/matchSucess_screen.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/candidate_model.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/get_allInformation_model.dart'
    as exeProfileAllInformation;
import 'package:matrimonial_app/Ui/Home_screen/Match%20Screen/match_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/submit_button.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MatchingProfile_Screen extends StatefulWidget {
  String? name;
  String? img;
  var candidateId;
  MatchingProfile_Screen({Key? key, this.name, this.img, this.candidateId})
      : super(key: key);

  @override
  HomeScreenDetailState1 createState() => HomeScreenDetailState1();
}

class HomeScreenDetailState1 extends State<MatchingProfile_Screen>
    with SingleTickerProviderStateMixin {
  bool _pinned = true;
  bool _snap = true;
  bool _floating = true;
  TabController? _tabController;
  var TabHeightString = "Basic Detail";
  GetCandidateModel? _candidateModel;
  exeProfileAllInformation.AllInformationModel? _allInformationModel;
  late ScrollController _scrollController = ScrollController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  TextEditingController _DOBController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Color _textColor = Colors.white;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 378,
                width: width,
                child: Image.network(
                  widget.img.toString(),
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _allInformationModel != null &&
                                _allInformationModel!.data != null
                            ? _allInformationModel!.data!.basicInfo!.name
                                    .toString() +
                                ', ' +
                                _allInformationModel!.data!.basicInfo!.age
                                    .toString()
                            : AppConstants.headingText,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            ImagePath.locationIcon,
                            height: 25,
                          ),
                          Text(
                            AppConstants.SubtitleText,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 40,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Color(0xff000000).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => Match_screen()));
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 2,
                right: 2,
                top: 4,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 95,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffFC7358), Color(0xffFA2457)],
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Image.asset(
                        ImagePath.detailprofile,
                        height: 60,
                        width: 60,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppConstants.matchMaking,
                          style: appBtnStyle.copyWith(fontSize: 14),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => E_Match_screen()));
                          },
                          child: Text(
                            AppConstants.clickhere,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffFFFFFF)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8),
            child: Text(
              AppConstants.About,
              style: TextStyle(
                  color: Color(0xff4D4D4D),
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border.all(color: Color(0xffC8CACD).withOpacity(0.56)),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 10, right: 10, bottom: 10),
                child: ReadMoreText(
                  _candidateModel != null && _candidateModel!.data != null
                      ? _candidateModel!.data!.aboutMeLong.toString()
                      : "",
                  trimLines: 6,
                  colorClickableText: Colors.pink,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: Color(0xff757885)),
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Read more',
                  trimExpandedText: ' Less',
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6.0, right: 6, top: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Basic Details",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Container(
                              height: 30,
                              width: 30,
                            ))
                      ],
                    ),
                  ),
                ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width / 2 - 10,
                                child: Text(
                                  AppConstants.fullname,
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null
                                      ? ' ' +
                                          _allInformationModel!
                                              .data!.basicInfo!.name
                                              .toString()
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
                                  AppConstants.candidateemail,
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null
                                      ? ' ' +
                                          _allInformationModel!
                                              .data!.basicInfo!.email
                                              .toString()
                                      : ' ',
                                  style: TextStyle(),
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
                                  'Mobile',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null
                                      ? _allInformationModel!
                                                  .data!.basicInfo!.mobile !=
                                              null
                                          ? ' ' +
                                              _allInformationModel!
                                                  .data!.basicInfo!.mobile
                                                  .toString()
                                          : " N/A"
                                      : '',
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
                                  'Gender',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null
                                      ? _allInformationModel!
                                                  .data!.basicInfo!.gender !=
                                              null
                                          ? ' ' +
                                              _allInformationModel!
                                                  .data!.basicInfo!.gender
                                                  .toString()
                                          : " N/A"
                                      : '',
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
                                  'Age',
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
                                      _allInformationModel != null &&
                                              _allInformationModel!.data !=
                                                  null &&
                                              _allInformationModel!
                                                      .data!.basicInfo !=
                                                  null
                                          ? _allInformationModel!
                                                      .data!.basicInfo!.age !=
                                                  ""
                                              ? " " +
                                                  (_allInformationModel!
                                                      .data!.basicInfo!.age
                                                      .toString())
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
                                  'Height',
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
                                      _allInformationModel != null &&
                                              _allInformationModel!.data !=
                                                  null &&
                                              _allInformationModel!
                                                      .data!.basicInfo !=
                                                  null
                                          ? _allInformationModel!.data!
                                                      .basicInfo!.height !=
                                                  ""
                                              ? " " +
                                                  (_allInformationModel!
                                                      .data!.basicInfo!.height
                                                      .toString())
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
                                  'Weight',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.basicInfo !=
                                              null
                                      ? _allInformationModel!
                                                  .data!.basicInfo!.weight !=
                                              ""
                                          ? " " +
                                              (_allInformationModel!
                                                  .data!.basicInfo!.weight
                                                  .toString())
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
                                  AppConstants.status,
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.basicInfo !=
                                              null
                                      ? _allInformationModel!.data!.basicInfo!
                                                  .maritalStatus !=
                                              ""
                                          ? " " +
                                              (_allInformationModel!.data!
                                                  .basicInfo!.maritalStatus
                                                  .toString())
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
                                  'DOB',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null
                                      ? _allInformationModel!
                                                  .data!.basicInfo!.dob !=
                                              ""
                                          ? ' ' +
                                              _allInformationModel!
                                                  .data!.basicInfo!.dob
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
          Container(
            width: width,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 6, right: 6, top: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Preference",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Container(
                            height: 30,
                            width: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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
                                  'His Height',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.lookingFor !=
                                              null
                                      ? _allInformationModel!.data!.lookingFor!
                                                  .heightFrom !=
                                              null
                                          ? " " +
                                              (_allInformationModel!.data!
                                                      .lookingFor!.heightFrom
                                                      .toString() +
                                                  " To " +
                                                  _allInformationModel!.data!
                                                      .lookingFor!.heightTo
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
                                  'Age Range',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.lookingFor !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.lookingFor!.ageFrom !=
                                              null)
                                          ? " " +
                                              (_allInformationModel!
                                                      .data!.lookingFor!.ageFrom
                                                      .toString() +
                                                  " To " +
                                                  _allInformationModel!
                                                      .data!.lookingFor!.ageTo
                                                      .toString() +
                                                  " (year)")
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
                                  'Work Type',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.lookingFor !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.lookingFor!.workType !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
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
                                  'Earning',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.lookingFor !=
                                              null
                                      ? (_allInformationModel!.data!.lookingFor!
                                                  .annualIncome !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .lookingFor!.annualIncome
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
                                  'Diet type',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.lookingFor !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.lookingFor!.diet !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.lookingFor!.diet
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
                                  'Marriatle Status',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.lookingFor !=
                                              null
                                      ? (_allInformationModel!.data!.lookingFor!
                                                  .maritalStatus !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .lookingFor!.maritalStatus
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
                                  'Gotra',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.lookingFor !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.lookingFor!.gotra !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              Container(
                                width: width / 2 - 10,
                                child: Text(
                                  'Cast',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.lookingFor !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.lookingFor!.caste !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6, top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Contact",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                                  'Contact No.',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userContact !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.userContact!.mobile !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.userContact!.mobile
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
                                  'Alternate \nContact No.',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userContact !=
                                              null
                                      ? (_allInformationModel!.data!
                                                  .userContact!.altMobile !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.userContact!.altMobile
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
                                  'Email ID',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userContact !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.userContact!.email !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.userContact!.email
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
                                  'Address',
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
                                    _allInformationModel != null &&
                                            _allInformationModel!.data !=
                                                null &&
                                            _allInformationModel!
                                                    .data!.userContact !=
                                                null
                                        ? (_allInformationModel!.data!
                                                    .userContact!.address !=
                                                null)
                                            ? " " +
                                                _allInformationModel!
                                                    .data!.userContact!.address
                                                    .toString()
                                            : " N/A"
                                        : "",
                                    style: TextStyle(height: 1.5),
                                  ))
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
                                  'State',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userContact !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.userContact!.state !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.userContact!.state
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
                                  'PIN Code',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userContact !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.userContact!.pincode !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.userContact!.pincode
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
                                  'Country',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userContact !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.userContact!.country !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.userContact!.country
                                                  .toString()
                                          : " N/A"
                                      : "",
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
          Container(
            width: width,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 6.0, right: 6, top: 0),
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Career & Education",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                                  'Profession',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userCareer !=
                                              null
                                      ? (_allInformationModel!.data!.userCareer!
                                                  .profession !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.userCareer!.profession
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
                                  'Annual Income',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userCareer !=
                                              null
                                      ? (_allInformationModel!.data!.userCareer!
                                                  .annualIncome !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userCareer!.annualIncome
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
                                  'Highest Qualification',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userCareer !=
                                              null
                                      ? (_allInformationModel!.data!.userCareer!
                                                  .qualification !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userCareer!.qualification
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
                                  'Education Field',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userCareer !=
                                              null
                                      ? (_allInformationModel!.data!.userCareer!
                                                  .educationFields !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userCareer!.educationFields
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
                                  'University name',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userCareer !=
                                              null
                                      ? (_allInformationModel!.data!.userCareer!
                                                  .universityName !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userCareer!.universityName
                                                  .toString()
                                          : " N/A"
                                      : "",
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
          Container(
            width: width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6.0, right: 6, top: 0),
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Family Detail",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                                  'Family Type',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userFamily !=
                                              null
                                      ? (_allInformationModel!.data!.userFamily!
                                                  .familyType !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              Container(
                                width: width / 2 - 10,
                                child: Text(
                                  'Religion',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userFamily !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.userFamily!.religion !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.userFamily!.religion
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
                                  'Mother Tongue',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userFamily !=
                                              null
                                      ? (_allInformationModel!.data!.userFamily!
                                                  .motherTounge !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userFamily!.motherTounge
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
                                  'Father’s Occupation',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userFamily !=
                                              null
                                      ? (_allInformationModel!.data!.userFamily!
                                                  .fatherOccupation !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userFamily!.fatherOccupation
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
                                  'Mother`s Occupation',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userFamily !=
                                              null
                                      ? (_allInformationModel!.data!.userFamily!
                                                  .motherOccupation !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userFamily!.motherOccupation
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
                                  'Family income (yearly in lakhs)',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userFamily !=
                                              null
                                      ? (_allInformationModel!.data!.userFamily!
                                                  .familyIncome !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userFamily!.familyIncome
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
                                  'No of Brother',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userFamily !=
                                              null
                                      ? (_allInformationModel!.data!.userFamily!
                                                  .noBrothers !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
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
                                  'Married',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userFamily !=
                                              null
                                      ? (_allInformationModel!.data!.userFamily!
                                                  .marriedBrothers !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userFamily!.marriedBrothers
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
                                  'No Of Sister',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userFamily !=
                                              null
                                      ? (_allInformationModel!.data!.userFamily!
                                                  .noSisters !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
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
                                  'Married',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userFamily !=
                                              null
                                      ? (_allInformationModel!.data!.userFamily!
                                                  .marriedSisters !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userFamily!.marriedSisters
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
                                  'Family Based Out of',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userFamily !=
                                              null
                                      ? (_allInformationModel!.data!.userFamily!
                                                  .familyBasedOut !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userFamily!.familyBasedOut
                                                  .toString()
                                          : " N/A"
                                      : "",
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
          Container(
            width: width,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 6.0, right: 6, top: 0),
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Location",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                                  'Presently Living',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userLocation !=
                                              null
                                      ? (_allInformationModel!.data!
                                                  .userLocation!.livingPlace !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userLocation!.livingPlace
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
                                  'City',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userLocation !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.userLocation!.city !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
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
                                  'State',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userLocation !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.userLocation!.state !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
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
                                  'Country',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userLocation !=
                                              null
                                      ? (_allInformationModel!.data!
                                                  .userLocation!.country !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
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
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: CommonButton(
                btnName: 'Move to Final Discussion', btnOnTap: () {}),
          ),
          SizedBox(height: 15),
        ],
      ),
    ));
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getAllInformationApi();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getAllInformationApi();
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
        padding: const EdgeInsets.only(top: 8.0, bottom: 0),
        child: Text(text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff4D4D4D))),
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
          borderRadius: BorderRadius.circular(10),
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
          borderRadius: BorderRadius.circular(10),
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

  getCandidateApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var authToken = prefs.getString(EXE_TOKEN);
    var userId = prefs.getString(EXE_ID);
    log(authToken.toString());
    log(userId.toString());
    final queryParameters = {
      "user_id": widget.candidateId.toString(),
      "token": authToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response =
        await http.get(Uri.parse(GET_CANDIDATES_URL + "?" + queryString));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _candidateModel = GetCandidateModel.fromJson(data);
      });
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

  getAllInformationApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CommonUtils.showProgressLoading(context);
    var authToken = prefs.getString(EXE_TOKEN);

    final queryParameters = {
      "user_id": widget.candidateId.toString(),
      "token": authToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response =
        await http.get(Uri.parse(GET_ALL_INFORMATION_URL + "?" + queryString));

    if (response.statusCode == 200) {
      CommonUtils.hideProgressLoading();
      setState(() {
        var data = jsonDecode(response.body);
        log(response.body);

        _allInformationModel =
            exeProfileAllInformation.AllInformationModel.fromJson(data);
      });
    } else if (response.statusCode == 500) {
      log('Server Error :: Exectuvie All information');
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
}
 */
import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/MatchingProfile/matchSucess_screen.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/candidate_model.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/get_allInformation_model.dart'
    as exeProfileAllInformation;
import 'package:matrimonial_app/Ui/Home_screen/Match%20Screen/match_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/submit_button.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MatchingProfile_Screen extends StatefulWidget {
  String? name;
  String? img;
  var candidateId;
  MatchingProfile_Screen({Key? key, this.name, this.img, this.candidateId})
      : super(key: key);

  @override
  HomeScreenDetailState1 createState() => HomeScreenDetailState1();
}

class HomeScreenDetailState1 extends State<MatchingProfile_Screen>
    with SingleTickerProviderStateMixin {
  bool _pinned = true;
  bool _snap = true;
  bool _floating = true;
  TabController? _tabController;
  var TabHeightString = "Basic Detail";
  GetCandidateModel? _candidateModel;
  exeProfileAllInformation.AllInformationModel? _allInformationModel;
  late ScrollController _scrollController = ScrollController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  TextEditingController _DOBController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Color _textColor = Colors.white;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 390,
                width: width,
                child: Image.network(
                  widget.img.toString(),
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        /* _allInformationModel != null &&
                                _allInformationModel!.data != null
                            ? */
                        widget.name.toString() + ", " + "25",
                        // ', ' +
                        // _allInformationModel!.data!.basicInfo!.age
                        // .toString(),
                        // : AppConstants.headingText,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            ImagePath.locationIcon,
                            height: 25,
                          ),
                          Text(
                            AppConstants.SubtitleText,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 40,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Color(0xff000000).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          /* GestureDetector(
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => Match_screen()));
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 2,
                right: 2,
                top: 4,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 95,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffFC7358), Color(0xffFA2457)],
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Image.asset(
                        ImagePath.detailprofile,
                        height: 60,
                        width: 60,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppConstants.matchMaking,
                          style: appBtnStyle.copyWith(fontSize: 14),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => E_Match_screen()));
                          },
                          child: Text(
                            AppConstants.clickhere,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffFFFFFF)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ), */
          SizedBox(
            height: 5,
          ),
          /* Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8),
            child: Text(
              AppConstants.About,
              style: TextStyle(
                  color: Color(0xff4D4D4D),
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border.all(color: Color(0xffC8CACD).withOpacity(0.56)),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 10, right: 10, bottom: 10),
                child: ReadMoreText(
                  _candidateModel != null && _candidateModel!.data != null
                      ? _candidateModel!.data!.aboutMeLong.toString()
                      : "",
                  trimLines: 6,
                  colorClickableText: Colors.pink,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: Color(0xff757885)),
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Read more',
                  trimExpandedText: ' Less',
                ),
              ),
            ),
          ),
          SizedBox(height: 10), */
          Container(
            width: width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6.0, right: 6, top: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Basic Details",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Container(
                              height: 30,
                              width: 30,
                            ))
                      ],
                    ),
                  ),
                ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width / 2 - 10,
                                child: Text(
                                  AppConstants.fullname,
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null
                                      ? ' ' +
                                          _allInformationModel!
                                              .data!.basicInfo!.name
                                              .toString()
                                      : "N/A",
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
                                  AppConstants.candidateemail,
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null
                                      ? ' ' +
                                          _allInformationModel!
                                              .data!.basicInfo!.email
                                              .toString()
                                      : 'N/A',
                                  style: TextStyle(),
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
                                  'Mobile',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null
                                      ? _allInformationModel!
                                                  .data!.basicInfo!.mobile !=
                                              null
                                          ? ' ' +
                                              _allInformationModel!
                                                  .data!.basicInfo!.mobile
                                                  .toString()
                                          : " N/A"
                                      : 'N/A',
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
                                  'Gender',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null
                                      ? _allInformationModel!
                                                  .data!.basicInfo!.gender !=
                                              null
                                          ? ' ' +
                                              _allInformationModel!
                                                  .data!.basicInfo!.gender
                                                  .toString()
                                          : " N/A"
                                      : 'N/A',
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
                                  'Age',
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
                                      _allInformationModel != null &&
                                              _allInformationModel!.data !=
                                                  null &&
                                              _allInformationModel!
                                                      .data!.basicInfo !=
                                                  null
                                          ? _allInformationModel!
                                                      .data!.basicInfo!.age !=
                                                  ""
                                              ? " " +
                                                  (_allInformationModel!
                                                      .data!.basicInfo!.age
                                                      .toString())
                                              : " N/A"
                                          : "N/A",
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
                                  'Height',
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
                                      _allInformationModel != null &&
                                              _allInformationModel!.data !=
                                                  null &&
                                              _allInformationModel!
                                                      .data!.basicInfo !=
                                                  null
                                          ? _allInformationModel!.data!
                                                      .basicInfo!.height !=
                                                  ""
                                              ? " " +
                                                  (_allInformationModel!
                                                      .data!.basicInfo!.height
                                                      .toString())
                                              : " N/A"
                                          : "N/A",
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
                                  'Weight',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.basicInfo !=
                                              null
                                      ? _allInformationModel!
                                                  .data!.basicInfo!.weight !=
                                              ""
                                          ? " " +
                                              (_allInformationModel!
                                                  .data!.basicInfo!.weight
                                                  .toString())
                                          : " N/A"
                                      : "N/A",
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
                                  AppConstants.status,
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.basicInfo !=
                                              null
                                      ? _allInformationModel!.data!.basicInfo!
                                                  .maritalStatus !=
                                              ""
                                          ? " " +
                                              (_allInformationModel!.data!
                                                  .basicInfo!.maritalStatus
                                                  .toString())
                                          : " N/A"
                                      : "N/A",
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
                                  'DOB',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null
                                      ? _allInformationModel!
                                                  .data!.basicInfo!.dob !=
                                              ""
                                          ? ' ' +
                                              _allInformationModel!
                                                  .data!.basicInfo!.dob
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
          Container(
            width: width,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 6, right: 6, top: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Preference",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Container(
                            height: 30,
                            width: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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
                                  'His Height',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.lookingFor !=
                                              null
                                      ? _allInformationModel!.data!.lookingFor!
                                                  .heightFrom !=
                                              null
                                          ? " " +
                                              (_allInformationModel!.data!
                                                      .lookingFor!.heightFrom
                                                      .toString() +
                                                  " To " +
                                                  _allInformationModel!.data!
                                                      .lookingFor!.heightTo
                                                      .toString() +
                                                  ' (Inches)')
                                          : " N/A"
                                      : "N/A",
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
                                  'Age Range',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.lookingFor !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.lookingFor!.ageFrom !=
                                              null)
                                          ? " " +
                                              (_allInformationModel!
                                                      .data!.lookingFor!.ageFrom
                                                      .toString() +
                                                  " To " +
                                                  _allInformationModel!
                                                      .data!.lookingFor!.ageTo
                                                      .toString() +
                                                  " (year)")
                                          : " N/A"
                                      : "N/A",
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
                                  'Work Type',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.lookingFor !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.lookingFor!.workType !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.lookingFor!.workType
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'Earning',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.lookingFor !=
                                              null
                                      ? (_allInformationModel!.data!.lookingFor!
                                                  .annualIncome !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .lookingFor!.annualIncome
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'Diet type',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.lookingFor !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.lookingFor!.diet !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.lookingFor!.diet
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'Marriatle Status',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.lookingFor !=
                                              null
                                      ? (_allInformationModel!.data!.lookingFor!
                                                  .maritalStatus !=
                                              "")
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .lookingFor!.maritalStatus
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'Cast',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.lookingFor !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.lookingFor!.caste !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.lookingFor!.caste
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'Gotra',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.lookingFor !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.lookingFor!.gotra !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.lookingFor!.gotra
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
          Container(
            width: width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6, top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Contact",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                                  'Contact No.',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userContact !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.userContact!.mobile !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.userContact!.mobile
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'Alternate \nContact No.',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userContact !=
                                              null
                                      ? (_allInformationModel!.data!
                                                  .userContact!.altMobile !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.userContact!.altMobile
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'Email ID',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userContact !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.userContact!.email !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.userContact!.email
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'Address',
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
                                    _allInformationModel != null &&
                                            _allInformationModel!.data !=
                                                null &&
                                            _allInformationModel!
                                                    .data!.userContact !=
                                                null
                                        ? (_allInformationModel!.data!
                                                    .userContact!.address !=
                                                null)
                                            ? " " +
                                                _allInformationModel!
                                                    .data!.userContact!.address
                                                    .toString()
                                            : " N/A"
                                        : "N/A",
                                    style: TextStyle(height: 1.5),
                                  ))
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
                                  'State',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userContact !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.userContact!.state !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.userContact!.state
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'PIN Code',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userContact !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.userContact!.pincode !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.userContact!.pincode
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'Country',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userContact !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.userContact!.country !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.userContact!.country
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
          Container(
            width: width,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 6.0, right: 6, top: 0),
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Career & Education",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                                  'Profession',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userCareer !=
                                              null
                                      ? (_allInformationModel!.data!.userCareer!
                                                  .profession !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.userCareer!.profession
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'Annual Income',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userCareer !=
                                              null
                                      ? (_allInformationModel!.data!.userCareer!
                                                  .annualIncome !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userCareer!.annualIncome
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'Highest Qualification',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userCareer !=
                                              null
                                      ? (_allInformationModel!.data!.userCareer!
                                                  .qualification !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userCareer!.qualification
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'Education Field',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userCareer !=
                                              null
                                      ? (_allInformationModel!.data!.userCareer!
                                                  .educationFields !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userCareer!.educationFields
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'University name',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userCareer !=
                                              null
                                      ? (_allInformationModel!.data!.userCareer!
                                                  .universityName !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userCareer!.universityName
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
          Container(
            width: width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6.0, right: 6, top: 0),
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Family Detail",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                                  'Family Type',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userFamily !=
                                              null
                                      ? (_allInformationModel!.data!.userFamily!
                                                  .familyType !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.userFamily!.familyType
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'Religion',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.basicInfo !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.basicInfo!.religion !=
                                              null || _allInformationModel!
                                                  .data!.basicInfo!.religion !=
                                              "")
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.basicInfo!.religion
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'Mother Tongue',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userFamily !=
                                              null
                                      ? (_allInformationModel!.data!.userFamily!
                                                  .motherTounge !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userFamily!.motherTounge
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'Father’s Occupation',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userFamily !=
                                              null
                                      ? (_allInformationModel!.data!.userFamily!
                                                  .fatherOccupation !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userFamily!.fatherOccupation
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'Mother`s Occupation',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userFamily !=
                                              null
                                      ? (_allInformationModel!.data!.userFamily!
                                                  .motherOccupation !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userFamily!.motherOccupation
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'Family income (yearly in lakhs)',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userFamily !=
                                              null
                                      ? (_allInformationModel!.data!.userFamily!
                                                  .familyIncome !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userFamily!.familyIncome
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'No of Brother',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userFamily !=
                                              null
                                      ? (_allInformationModel!.data!.userFamily!
                                                  .noBrothers !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.userFamily!.noBrothers
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'Married',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userFamily !=
                                              null
                                      ? (_allInformationModel!.data!.userFamily!
                                                  .marriedBrothers !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userFamily!.marriedBrothers
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'No Of Sister',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userFamily !=
                                              null
                                      ? (_allInformationModel!.data!.userFamily!
                                                  .noSisters !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.userFamily!.noSisters
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'Married',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userFamily !=
                                              null
                                      ? (_allInformationModel!.data!.userFamily!
                                                  .marriedSisters !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userFamily!.marriedSisters
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'Family Based Out of',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userFamily !=
                                              null
                                      ? (_allInformationModel!.data!.userFamily!
                                                  .familyBasedOut !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userFamily!.familyBasedOut
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
          Container(
            width: width,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 6.0, right: 6, top: 0),
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Location",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                                  'Presently Living',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userLocation !=
                                              null
                                      ? (_allInformationModel!.data!
                                                  .userLocation!.livingPlace !=
                                              null)
                                          ? " " +
                                              _allInformationModel!.data!
                                                  .userLocation!.livingPlace
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'City',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userLocation !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.userLocation!.city !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.userLocation!.city
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'State',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userLocation !=
                                              null
                                      ? (_allInformationModel!
                                                  .data!.userLocation!.state !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.userLocation!.state
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
                                  'Country',
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
                                  _allInformationModel != null &&
                                          _allInformationModel!.data != null &&
                                          _allInformationModel!
                                                  .data!.userLocation !=
                                              null
                                      ? (_allInformationModel!.data!
                                                  .userLocation!.country !=
                                              null)
                                          ? " " +
                                              _allInformationModel!
                                                  .data!.userLocation!.country
                                                  .toString()
                                          : " N/A"
                                      : "N/A",
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
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: CommonButton(
                btnName: 'Move to Final Discussion',
                btnOnTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>));
                }),
          ),
          SizedBox(height: 15),
        ],
      ),
    ));
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getAllInformationApi();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getAllInformationApi();
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
        padding: const EdgeInsets.only(top: 8.0, bottom: 0),
        child: Text(text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff4D4D4D))),
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
          borderRadius: BorderRadius.circular(10),
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
          borderRadius: BorderRadius.circular(10),
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

  getCandidateApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var authToken = prefs.getString(EXE_TOKEN);
    var userId = prefs.getString(EXE_ID);
    log(authToken.toString());
    log(userId.toString());
    final queryParameters = {
      "user_id": widget.candidateId.toString(),
      "token": authToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response =
        await http.get(Uri.parse(GET_CANDIDATES_URL + "?" + queryString));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _candidateModel = GetCandidateModel.fromJson(data);
      });
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

  getAllInformationApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CommonUtils.showProgressLoading(context);
    var authToken = prefs.getString(EXE_TOKEN);

    final queryParameters = {
      "user_id": widget.candidateId.toString(),
      "token": authToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response =
        await http.get(Uri.parse(GET_ALL_INFORMATION_URL + "?" + queryString));

    if (response.statusCode == 200) {
      CommonUtils.hideProgressLoading();
      setState(() {
        var data = jsonDecode(response.body);
        log(response.body);

        _allInformationModel =
            exeProfileAllInformation.AllInformationModel.fromJson(data);
      });
    } else if (response.statusCode == 500) {
      log('Server Error :: Exectuvie All information');
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
}
