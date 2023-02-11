// ignore_for_file: unused_local_variable

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/Drawer_Screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/User_Detail_Screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/model/user.dart';
import 'package:matrimonial_app/Ui/Home_screen/provider/card_provider.dart';
import 'package:matrimonial_app/Ui/Matrimonial%20Like/like_screen.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/basic_detail.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:provider/provider.dart';

class UserModelIntro {
  UserModelIntro(this.stories);
  final List<StoryModelIntro> stories;
}

class StoryModelIntro {
  StoryModelIntro(this.imageUrl);
  final String imageUrl;
}

class ContentIntro {
  final String text;
  final Color color;

  ContentIntro({required this.text, required this.color});
}

class TinderCardIntro extends StatefulWidget {
  final User user;
  final bool isFront;

  const TinderCardIntro({
    Key? key,
    required this.user,
    required this.isFront,
    required List<User> users,
  }) : super(key: key);

  @override
  State<TinderCardIntro> createState() => _TinderCardIntroState();
}

class _TinderCardIntroState extends State<TinderCardIntro> {
  int changeStoryIndex = 0;
  List<String> imaglist = [
    "Comedy",
    "Coffee",
    "Maggie",
    "Car",
    "Netfix",
    "Shopping",
  ];
  final sampleUsers = [
    UserModelIntro(
      [
        StoryModelIntro(ImagePath.introSwipeLeft),
       
      ],
    ),
  ];
  @override
  void initState() {
    super.initState();
    print(AppConstants.index);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(size);
    },);
  }

  @override
  Widget build(BuildContext context) => widget.isFront
     
      ? buildFrontCard()
      : buildCard();

  Widget buildFrontCard() => GestureDetector(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final provider = Provider.of<CardProvider>(context);
            final position = provider.position;
            final milliseconds = provider.isDragging ? 0 : 400;
            final center = constraints.smallest.center(Offset.zero);
            final angle = provider.angle * pi / 180;
            final rotatedMatrix = Matrix4.identity()
              ..translate(center.dx, center.dy)
              ..rotateZ(angle)
              ..translate(-center.dx, -center.dy);

            return AnimatedContainer(
              curve: Curves.bounceInOut,
              duration: Duration(milliseconds: milliseconds),
              transform: rotatedMatrix..translate(position.dx, position.dy),
              child: Stack(
                children: [
                  buildCard(),
                ],
              ),
            );
          },
        ),
        onPanStart: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);

          provider.startPosition(details);
        },
        onPanUpdate: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);

          provider.updatePosition(details);
        },
        onPanEnd: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);

          provider.endPosition();
        },
      );
  Widget buildCard() => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Center(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                
                child: AppConstants.index == 0
                    ? Image.asset(ImagePath.introSwipeLeft,
                        fit: BoxFit.fitWidth)
                    : Image.asset(
                        ImagePath.introSwipeRight,
                        fit: BoxFit.fitWidth,
                      ),
              ),

            ],
          ),
        ),
      );

Widget buildCard1() => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Visibility(
          visible: true,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.70),
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width / 1.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => Zoom(),
                                    ),
                                    (route) => false);
                              },
                              child: Image.asset(ImagePath.greyCross,
                                  height: 28, width: 28),
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                        SizedBox(height: 13),
                        Image.asset(ImagePath.appLogo, height: 60, width: 60),
                        SizedBox(height: 18),
                        Text(
                          "Complete Your Registartion",
                          style: headingStyle.copyWith(
                            color: Color(0xff333F52),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Text(
                            AppConstants.registerguide,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: headingStyle.copyWith(
                              color: Color(0xffAFAFAF),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  CupertinoPageRoute(
                                    builder: (context) => Zoom(),
                                  ),
                                  (route) => false);
                            },
                            child: Text("Skip Now")),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => Basic_Detail()));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              decoration: BoxDecoration(
                                  gradient: AppColors.appColor,
                                  borderRadius: BorderRadius.circular(9)),
                              alignment: Alignment.center,
                              child: Text(
                                "Complete Now",
                                style: appBtnStyle,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  

  Widget buildStamps() {
    final provider = Provider.of<CardProvider>(context);
    final status = provider.getStatus();
    final opacity = provider.getStatusOpacity();

    switch (status) {
      case CardStatus.like:
        final child = buildStamp(
          angle: -0.5,
          color: Colors.green,
          text: 'LIKE',
          opacity: opacity,
        );
        return Positioned(top: 64, left: 50, child: child);

      case CardStatus.dislike:
        final child = buildStamp(
          angle: 0.5,
          color: Colors.red,
          text: 'NOPE',
          opacity: opacity,
        );

        return Positioned(top: 64, right: 50, child: child);

      default:
        return Container();
    }
  }

  Widget buildStamp({
    double angle = 0,
    required Color color,
    required String text,
    required double opacity,
  }) {
    return Opacity(
      opacity: opacity,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: 4),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  MaterialStateProperty<Color> getColor(
      Color color, Color colorPressed, bool force) {
    final getColor = (Set<MaterialState> states) {
      if (force || states.contains(MaterialState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    };

    return MaterialStateProperty.resolveWith(getColor);
  }

  MaterialStateProperty<BorderSide> getBorder(
      Color color, Color colorPressed, bool force) {
    final getBorder = (Set<MaterialState> states) {
      if (force || states.contains(MaterialState.pressed)) {
        return BorderSide(color: Colors.transparent);
      } else {
        return BorderSide(color: color, width: 2);
      }
    };

    return MaterialStateProperty.resolveWith(getBorder);
  }


  buildcircle(String path) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 8),
      child: Container(
        height: 43,
        width: 43,
        child: CircleAvatar(
          backgroundColor: AppColors.grey.withOpacity(0.90),
          child: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage(path),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildGridPopular(List<String> matches, index) {
    return Container(
      height: 30,
      width: 90,
      child: GestureDetector(
        onTap: () {},
        child: Padding(
          padding:
              EdgeInsets.only(left: 1.0, right: 1.0, top: 1.0, bottom: 1.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.60),
              borderRadius: BorderRadius.circular(30),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              imaglist[index],
              maxLines: 1,
              style: homestyle.copyWith(fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildName() {
    final provider = Provider.of<CardProvider>(context);
    final users = provider.users;
    final status = provider.getStatus();
    final isLike = status == CardStatus.like;
    final isDislike = status == CardStatus.dislike;
    final isSuperLike = status == CardStatus.superLike;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 3, bottom: 5),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => UserDetailScreen(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppConstants.profilename,
                    style: appBtnStyle.copyWith(
                        fontWeight: FontWeight.w700, fontSize: 25),
                  ),
                  Text(
                    AppConstants.hage,
                    style: appBtnStyle.copyWith(
                        fontWeight: FontWeight.w500, fontSize: 25),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    ImagePath.homeuser,
                    height: 22,
                    width: 22,
                  )
                ],
              ),
            ),
          ),
          changeStoryIndex == 1
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const Like_screen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Wrap(
                        children: List.generate(
                          imaglist.length,
                          (index) {
                            return buildGridPopular(imaglist, index);
                          },
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 8),
                child: Container(
                  height: 43,
                  width: 43,
                  child: CircleAvatar(
                    backgroundColor: AppColors.grey.withOpacity(0.90),
                    child: GestureDetector(
                      onTap: () {
                        final provider =
                            Provider.of<CardProvider>(context, listen: false);

                        provider.dislike();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage(ImagePath.close),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              buildcircle(ImagePath.fav),
              Padding(
                padding:
                    const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 8),
                child: Container(
                  height: 63,
                  width: 63,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ImagePath.like),
                          fit: BoxFit.cover)),
                  child: GestureDetector(
                    child: const Padding(
                      padding: EdgeInsets.all(9.0),
                      child: Image(
                        image: AssetImage(ImagePath.like1),
                      ),
                    ),
                  ),
                ),
              ),
              buildcircle(ImagePath.chat),
              Padding(
                padding:
                    const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 8),
                child: Container(
                  height: 43,
                  width: 43,
                  child: CircleAvatar(
                    backgroundColor: AppColors.grey.withOpacity(0.90),
                    child: GestureDetector(
                      onTap: () {
                        final provider =
                            Provider.of<CardProvider>(context, listen: false);

                        provider.like();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage(ImagePath.next),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
