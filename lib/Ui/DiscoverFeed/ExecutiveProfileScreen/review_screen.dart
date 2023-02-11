
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/Utils/value_constant.dart';

class Review_screen extends StatefulWidget {
  const Review_screen({Key? key}) : super(key: key);

  @override
  State<Review_screen> createState() => _Review_screenState();
}

class _Review_screenState extends State<Review_screen> {
  TextEditingController commentController = TextEditingController();
  List<bool> isOpen = [];
  List<Map<String, dynamic>> reviewlist = [
    {
      IMAGE: ImagePath.review1,
      NAME: AppConstants.rakeshPande,
      DATE: AppConstants.date,
      RATING: ImagePath.rating_1,
      RAT: AppConstants.rating1,
      DETAIL: AppConstants.reviewtext,
    },
    {
      IMAGE: ImagePath.review2,
      NAME: AppConstants.rakeshPande,
      DATE: AppConstants.date,
      RATING: ImagePath.rating_1,
      RAT: AppConstants.rating1,
      DETAIL: AppConstants.reviewtext,
    },
    {
      IMAGE: ImagePath.review3,
      NAME: AppConstants.rakeshPande,
      DATE: AppConstants.date,
      RATING: ImagePath.rating_1,
      RAT: AppConstants.rating1,
      DETAIL: AppConstants.reviewtext,
    },
    {
      IMAGE: ImagePath.review4,
      NAME: AppConstants.rakeshPande,
      DATE: AppConstants.date,
      RATING: ImagePath.rating_1,
      RAT: AppConstants.rating1,
      DETAIL: AppConstants.reviewtext,
    },
  ];
  void showHide(int i) {
    setState(() {
      isOpen[i] = !isOpen[i];
    });
  }

  @override
  void initState() {
  
    super.initState();
    for (int i = 0; i < reviewlist.length; i++) {
      isOpen.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                 
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(ImagePath.leftArrow,
                            height: 28, width: 28, color: Color(0xff2C3E50)),
                      ),
                      Spacer(),
                      Text(
                        AppConstants.reviews,
                        style: headingStyle.copyWith(
                            fontSize: 21,
                            color: Color(0xff440312),
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 25),
                      Spacer(),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: reviewlist.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
                      child: Container(
                      
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppColors.colorWhite,
                          border: Border.all(
                            color: Color(0xffE8E8E8),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(
                                0,
                                4,
                              ),
                              color: Color(0xff3E3E42).withOpacity(.12),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(width: 15),
                                Image.asset(reviewlist[index][IMAGE],
                                    height: 43, width: 43),
                                SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      reviewlist[index][NAME],
                                      style: headingStyle.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      reviewlist[index][DATE],
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
                                      Image.asset(reviewlist[index][RATING],
                                          height: 22, width: 22),
                                      SizedBox(width: 4),
                                      Text(
                                        reviewlist[index][RAT],
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
                                reviewlist[index][DETAIL],
                                style: headingStyle.copyWith(
                                  height: 1.7,
                                  color: Color(0xff67707D),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            isOpen[index]
                                ? Container(
                                    height: 2,
                                    width: MediaQuery.of(context).size.width,
                                    color: Color(0xff708A8E).withOpacity(.07),
                                  )
                                : Container(),
                            SizedBox(height: 8),
                            Padding(
                              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showHide(index);
                                    },
                                    child: isOpen[index]
                                        ? Row(
                                            children: [
                                              Image.asset(ImagePath.leftArrow,
                                                  color: Color(0xff1A535C),
                                                  height: 16,
                                                  width: 16),
                                              SizedBox(width: 2),
                                              Text(
                                                AppConstants.replayText,
                                                style: headingStyle.copyWith(
                                                  color: Color(0xff1A535C),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(
                                            width: 75,
                                            height: 25,
                                          
                                            child: Row(
                                              children: [
                                                Text(
                                                  AppConstants.replay,
                                                  style: headingStyle.copyWith(
                                                    color: Color(0xff1A535C),
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(width: 2),
                                                Image.asset(
                                                    ImagePath.rightarrow,
                                                    height: 16,
                                                    width: 16),
                                              ],
                                            ),
                                          ),
                                  ),
                                  Spacer(),
                                  isOpen[index]
                                      ? Container()
                                      : Row(
                                          children: [
                                            Image.asset(ImagePath.report,
                                                height: 16, width: 16),
                                            SizedBox(width: 2),
                                            Text(
                                              AppConstants.report,
                                              style: headingStyle.copyWith(
                                                color: Color(0xff1A535C),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                            isOpen[index]
                                ? Padding(
                                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 250,
                                        
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    itemCount: 5,
                                                    itemBuilder:
                                                        ((context, index) {
                                                      return Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Image.asset(
                                                                  ImagePath
                                                                      .review1,
                                                                  height: 27,
                                                                  width: 27),
                                                              SizedBox(
                                                                  width: 6),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    AppConstants
                                                                        .rakeshPande,
                                                                    style: headingStyle
                                                                        .copyWith(
                                                                      color: Color(
                                                                          0xff1A535C),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          5),
                                                                  Text(
                                                                    AppConstants
                                                                        .date,
                                                                    style: headingStyle
                                                                        .copyWith(
                                                                      color: Color(
                                                                          0xff708A8E),
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 5),
                                                          Text(
                                                            AppConstants
                                                                .reviewReplayText,
                                                            style: headingStyle
                                                                .copyWith(
                                                              color: Color(
                                                                  0xff708A8E),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          SizedBox(height: 15),
                                                        ],
                                                      );
                                                    })),

                                              
                                              ],
                                            ),
                                          ),
                                        ),
                                        _textFormField(commentController,
                                            AppConstants.hintText)
                                      ],
                                    ),
                                  )
                                : Container()
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
      ),
    );
  }

  _textFormField(TextEditingController _controller, String hintText) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 14),
        hintText: hintText,
        filled: true,
        fillColor: Color(0xffEDF0EF),
        prefixIcon: Container(
          height: 20,
          width: 20,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(ImagePath.textfieldemoji, height: 20, width: 20),
          ),
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 7, 5),
          child: Container(
            height: 30,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                AppConstants.send,
                style: headingStyle.copyWith(
                  color: Color(0xff1A535C),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      style: TextStyle(
          fontSize: 12, color: Color(0xff708A8E), fontWeight: FontWeight.w400),
    );
  }
}
