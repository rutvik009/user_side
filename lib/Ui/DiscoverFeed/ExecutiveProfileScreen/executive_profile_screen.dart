import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Ui/DiscoverFeed/ExecutiveProfileScreen/review_screen.dart';
import 'package:matrimonial_app/Ui/choose%20Plan/choose_plan_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/Utils/value_constant.dart';
import 'package:matrimonial_app/widget/commondivider.dart';

class Executive_Profile extends StatefulWidget {
  String? name;

  String? gender;
  String? image;
  Executive_Profile({Key? key, this.name, this.image, this.gender})
      : super(key: key);

  @override
  State<Executive_Profile> createState() => _Executive_ProfileState();
}

class _Executive_ProfileState extends State<Executive_Profile> {
  List<Map<String, dynamic>> profilevisiter = [
    {
      IMAGE: ImagePath.profilevisitors_1,
      NAME: AppConstants.isaiah,
    },
    {
      IMAGE: ImagePath.profilevisitors_2,
      NAME: AppConstants.ethel,
    },
    {
      IMAGE: ImagePath.profilevisitors_3,
      NAME: AppConstants.hayden,
    },
    {
      IMAGE: ImagePath.profilevisitors_4,
      NAME: AppConstants.hunter,
    },
    {
      IMAGE: ImagePath.profilevisitors_5,
      NAME: AppConstants.hunter,
    },
  ];
  List<String> portfolio = [
    "assets/images/portfolio_1.png",
    "assets/images/portfolio_2.png",
    "assets/images/portfolio_3.png",
    "assets/images/portfolio_1.png",
    "assets/images/portfolio_3.png",
    "assets/images/portfolio_2.png",
  ];

  bool _showPreview = false;
  String _image = "assets/images/portfolio_1.png";

  List<Map<String, dynamic>> reviewdetail = [
    {
      IMAGE: ImagePath.review_1,
      NAME: AppConstants.miaSmith,
      MAIL: AppConstants.reviewEmail,
      RATING: ImagePath.rating_1,
      RAT: AppConstants.rating1,
      DETAIL: AppConstants.reviewDetails,
    },
    {
      IMAGE: ImagePath.review_2,
      NAME: AppConstants.miaSmith,
      MAIL: AppConstants.reviewEmail,
      RATING: ImagePath.rating_2,
      RAT: AppConstants.rating2,
      DETAIL: AppConstants.reviewDetails,
    },
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("object :::${widget.image}");
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 232,
                    width: MediaQuery.of(context).size.width * 4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            ImagePath.executiveBackground,
                          ),
                          fit: BoxFit.fill),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(ImagePath.leftArrow,
                                  height: 28, width: 28)),
                          Spacer(),
                          Text(
                            AppConstants.profile,
                            style: headingStyle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 25),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 200),
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width * 4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(15, 7, 16, 0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xffE6E6E6),
                                      ),
                                    ),
                                    child: Center(
                                        child: Image.asset(ImagePath.share,
                                            height: 25, width: 25)),
                                  ),
                                ),
                                Text(
                                  widget.name.toString(),
                                  style: headingStyle,
                                ),
                                Text(
                                  AppConstants.elonMuskUserName,
                                  style: headingStyle.copyWith(
                                      color: AppColors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 55,
                          child: Container(
                            height: 98,
                            width: 98,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: (widget.image!.isNotEmpty)
                                  ? Image.network(
                                      widget.image.toString(),
                                      height: 72,
                                      width: 72,
                                      fit: BoxFit.fill,
                                    )
                                  : (widget.gender == "Male")
                                      ? Image.asset(
                                          ImagePath.maleProfile,
                                        )
                                      : Image.asset(
                                          ImagePath.femaleProfile,
                                        ),
                            ),
                          )
                          /* Container(
                            height: 98,
                            width: 98,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                borderRadius: BorderRadius.circular(50)),
                            child: Image.network(widget.image.toString())
                            //Image.asset(ImagePath.profileimage),
                            ), */
                          ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(27, 0, 27, 0),
                child: Text(
                  AppConstants.profileBio,
                  textAlign: TextAlign.center,
                  style: headingStyle.copyWith(
                      fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => Chooseplan_screen()));
                },
                child: Center(
                  child: Container(
                    height: 35,
                    width: 152,
                    decoration: BoxDecoration(
                      gradient: AppColors.appColor,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 4,
                          blurRadius: 22,
                          offset: Offset(
                            0,
                            11,
                          ),
                          color: Color(0xffFA4057).withOpacity(.21),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        AppConstants.subscribe,
                        style: headingStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.colorWhite),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          AppConstants.following,
                          style: headingStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          AppConstants.followingtext,
                          style: headingStyle.copyWith(
                              color: AppColors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    VerticalDivider(
                      color: Color(0xffEEEEEE),
                      thickness: 2,
                    ),
                    Column(
                      children: [
                        Text(
                          AppConstants.followers,
                          style: headingStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          AppConstants.followerstext,
                          style: headingStyle.copyWith(
                              color: AppColors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    VerticalDivider(
                      color: Color(0xffEEEEEE),
                      thickness: 2,
                    ),
                    Column(
                      children: [
                        Text(
                          AppConstants.likes,
                          style: headingStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          AppConstants.likestext,
                          style: headingStyle.copyWith(
                              color: AppColors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Common_divider(),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppConstants.profileVisitors,
                      style: headingStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      AppConstants.seeMore,
                      style: headingStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.green,
                      ),
                    ),
                    SizedBox(width: 5),
                    Image.asset(ImagePath.seemoreimage, height: 8, width: 5),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: Container(
                  height: 100,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: profilevisiter.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                          child: Column(
                            children: [
                              Image.asset(profilevisiter[index][IMAGE],
                                  height: 66, width: 66),
                              Text(
                                profilevisiter[index][NAME],
                                style: headingStyle.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        );
                      })),
                ),
              ),
              SizedBox(height: 10),
              Common_divider(),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  AppConstants.aboutHim,
                  style: headingStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  AppConstants.aboutHimDetails,
                  style: headingStyle.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Common_divider(),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppConstants.portFolio,
                      style: headingStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      AppConstants.seeMore,
                      style: headingStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.green,
                      ),
                    ),
                    SizedBox(width: 5),
                    Image.asset(ImagePath.seemoreimage, height: 8, width: 5),
                  ],
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: 115,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5),
                      itemCount: portfolio.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: index == 0
                                ? Radius.circular(10)
                                : Radius.circular(0),
                            topRight: index == 2
                                ? Radius.circular(10)
                                : Radius.circular(0),
                            bottomLeft: index == 3
                                ? Radius.circular(10)
                                : Radius.circular(0),
                            bottomRight: index == 5
                                ? Radius.circular(10)
                                : Radius.circular(0),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => new Dialog(
                                        backgroundColor: Colors.transparent,
                                        child: new Container(
                                            alignment: FractionalOffset.center,
                                            height: height * 0.5,
                                            width: width,
                                            padding: EdgeInsets.all(0.0),
                                            child: Container(
                                              child: Image.asset(
                                                portfolio[index],
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                      ));
                            },
                            child: Image.asset(
                              portfolio[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (_showPreview) ...[
                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5.0,
                        sigmaY: 5.0,
                      ),
                      child: Container(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            _image,
                            height: 300,
                            width: 300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 15),
              Common_divider(),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  AppConstants.languageKnown,
                  style: headingStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Wrap(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Container(
                      height: 35,
                      width: 79,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Color(0xffF5F5F5),
                        border: Border.all(
                          color: Color(0xffE0E0E0),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        AppConstants.gujarati,
                        style: headingStyle.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff4D5767),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                    child: Container(
                      height: 35,
                      width: 67,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Color(0xffF5F5F5),
                        border: Border.all(
                          color: Color(0xffE0E0E0),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        AppConstants.hindi,
                        style: headingStyle.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff4D5767),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                    child: Container(
                      height: 35,
                      width: 86,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Color(0xffF5F5F5),
                        border: Border.all(
                          color: Color(0xffE0E0E0),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        AppConstants.punjabi,
                        style: headingStyle.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff4D5767),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Common_divider(),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppConstants.reviews,
                      style: headingStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Review_screen()));
                      },
                      child: Text(
                        AppConstants.seeMore,
                        style: headingStyle.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.green,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Review_screen()));
                      },
                      child: Image.asset(ImagePath.seemoreimage,
                          height: 8, width: 5),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: reviewdetail.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffE8E8E8),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(width: 15),
                              Image.asset(reviewdetail[index][IMAGE],
                                  height: 43, width: 43),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reviewdetail[index][NAME],
                                    style: headingStyle.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    reviewdetail[index][MAIL],
                                    style: headingStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Container(
                                height: 30,
                                width: 65,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xffFDF1E1),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 8),
                                    Image.asset(reviewdetail[index][RATING],
                                        height: 22, width: 22),
                                    SizedBox(width: 4),
                                    Text(
                                      reviewdetail[index][RAT],
                                      style: headingStyle.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 15),
                            ],
                          ),
                          SizedBox(height: 14),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: Text(
                              reviewdetail[index]['detail'],
                              style: headingStyle.copyWith(
                                height: 1.5,
                                color: Color(0xff67707D),
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
