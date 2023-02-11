import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Ui/Home_screen/Notification/chat_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';

class E_Match_screen extends StatefulWidget {
  const E_Match_screen({Key? key}) : super(key: key);

  @override
  State<E_Match_screen> createState() => _E_Match_screenState();
}

class _E_Match_screenState extends State<E_Match_screen> {
  @override
  Widget build(BuildContext context) {
    double angle = -5.0 * pi / 180.0;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      height: height * 10,
      width: width * 10,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              ImagePath.background,
            ),
            fit: BoxFit.cover),
      ),
      child: Column(
        children: [
         
          _matchappbar(),
          Text(
            AppConstants.congratulation,
            style: congrates.copyWith(fontWeight: FontWeight.bold),
          ),
        
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppConstants.matchtext,
                style: match,
              ),
              Transform.rotate(
                angle: angle,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Container(
                    width: 114,
                    color: Colors.white,
                    child: Transform.rotate(
                      angle: -angle,
                      child: Text(
                        AppConstants.match1,
                        style: match1,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.026,
          ),
          Container(
            height: 138,
            child: Image.asset(ImagePath.matchimage),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImagePath.note,
                    height: 20,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppConstants.kundli,
                        style: congrates.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        AppConstants.kundlimatch,
                        style: congrates.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.008,
          ),
          Divider(
            height: 1,
            color: Colors.white.withOpacity(0.5),
          ),
          SizedBox(
            height: height * 0.005,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImagePath.bag,
                    height: 20,
                  ),
                  SizedBox(
                    width: width * 0.040,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppConstants.food,
                        style: congrates.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        width: width * 0.73,
                        child: Text(
                          AppConstants.foodhabits,
                          style: congrates.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.005,
          ),
          Divider(
            height: 1,
            color: Colors.white.withOpacity(0.5),
          ),
          SizedBox(
            height: height * 0.005,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImagePath.bag,
                    height: 20,
                  ),
                  SizedBox(
                    width: width * 0.040,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppConstants.occupation,
                        style: congrates.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        width: width * 0.73,
                        child: Text(
                          AppConstants.occupationlist,
                          style: congrates.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.005,
          ),
          Divider(
            height: 1,
            color: Colors.white.withOpacity(0.5),
          ),
          SizedBox(
            height: height * 0.005,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImagePath.people,
                    height: 20,
                  ),
                  SizedBox(
                    width: width * 0.040,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppConstants.castmatch,
                        style: congrates.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        width: width * 0.73,
                        child: Text(
                          AppConstants.castmatchlist,
                          style: congrates.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.005,
          ),
          Divider(
            height: 1,
            color: Colors.white.withOpacity(0.5),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => Chat_screen()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    color: AppColors.colorWhite,
                    borderRadius: BorderRadius.circular(9)),
                alignment: Alignment.center,
                child: Text(
                  'Say "Hi!"',
                  style: btnname,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                AppConstants.skip,
                style: appBtnStyle.copyWith(fontSize: 18),
              ),
            ),
          ),

          
        ],
      ),
    ));
  }

  _matchappbar() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 120,
      child: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset(
              ImagePath.shareframe,
              height: height * 0.020,
              width: width * 0.070,
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
       
        leading: Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              ImagePath.backArrow,
              color: Colors.white,
              width: width * 0.070,
              height: height * 0.04,
            ),
          ),
        ),
      ),
    );
  }
}
