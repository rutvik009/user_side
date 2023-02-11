

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/Ui/Login/login_screen.dart';
import 'package:matrimonial_app/Ui/OnBoardingScreen/widget/next_button.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final imagelist = [
    ImagePath.onBoarding1,
    ImagePath.onBoarding2,
    ImagePath.onBoarding3,
  ];

  final PageController pagecontroller = PageController(initialPage: 0);

  int currentindex = 0;
  TextEditingController _name = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
     
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CarouselSlider(
              items: imagelist.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return 

                        Image.asset(
                      i,
                      fit: BoxFit.cover,
                      width: width * 2,
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: height * 2,
                aspectRatio: 2.0,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentindex = index;
                  });
                },
                scrollDirection: Axis.horizontal,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 13, bottom: 30),
            child: BlurryContainer(
              bgColor: AppColors.blurry,
              width: width,
              height: height * 0.43,
              child: Column(
                children: [
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    AppConstants.getStarted,
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, right: 9),
                    child: Text(
                      AppConstants.loremParagraph,
                      style: GoogleFonts.montserrat(
                          color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  DotsIndicator(
                    dotsCount: imagelist.length,
                    position: currentindex.toDouble(),
                    decorator: DotsDecorator(
                      activeColor: AppColors.colorWhite,
                      size: const Size.square(5.0),
                      activeSize: const Size(27.0, 5.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                  SizedBox(
                    height: 27,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22, right: 18),
                    child: NextButton(
                        btnName: "Next",
                        btnOnTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          setState(() {
                            prefs.setBool(SHOWONBOARDING, true);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                                (route) => false);
                          });
                        }),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  

}
