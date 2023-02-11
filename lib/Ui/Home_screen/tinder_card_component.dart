// ignore_for_file: unnecessary_null_comparison, must_be_immutable, unused_field

import 'dart:developer' as log;
import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/Drawer_Screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/provider/card_provider.dart';
import 'package:matrimonial_app/Ui/Home_screen/story_view.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/basic_detail.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/story_page_view/story_page_view.dart';
import '../../ModelClass/UserPanel_ModelClass/Today_Match_Detail_Model.dart';
import '../../Utils/app_constants.dart';
import '../../Utils/color_constants.dart';
import '../../Utils/image_path_constants.dart';
import '../../Utils/text_styles.dart';
import '../Matrimonial Like/like_screen.dart';
import 'Home/User_Detail_Screen.dart';

class UserModel {
  UserModel(this.stories);

  final List<StoryModel> stories;
}

class StoryModel {
  StoryModel(this.imageUrl);

  final String imageUrl;
}

class Content {
  final String text;
  final Color color;

  Content({required this.text, required this.color});
}

class TinderCardComponent extends StatefulWidget {
  final Data user;
  final bool isFront;
  final List<Data> users;
  Function? swipeValFun;
  Function? onSuccess;

  TinderCardComponent({
    Key? key,
    required this.user,
    required this.isFront,
    required this.users,
    this.swipeValFun,
    this.onSuccess,
  }) : super(key: key);

  @override
  State<TinderCardComponent> createState() => _TinderCardComponentState();
}

class _TinderCardComponentState extends State<TinderCardComponent> {
  UserModel? _userModel;
  int changeStoryIndex = 0;
  int nameIndex = 0;
  bool imageLoad = false;
  int? userId;

  late ConfettiController _controllerCenter;
  List<String> imaglist = [
    "Comedy",
    "Coffee",
    "Maggie",
    "Car",
    "Netfix",
    "Shopping",
  ];
  int swipeValue = 0;
  List<Data> userList = [];
  List<ProfileImage> imageList = [];

  ValueNotifier<IndicatorAnimationCommand>? indicatorAnimationController;
  List mainStoryList = [];
  List subStoryList = [];
  bool isTinderLoaded = false;
  Data? lowerUser;
  String? ifFirstTimeUser;

  String capitalizeWords(String text) {
    List<String> words = text.split(' ');
    for (int i = 0; i < words.length; i++) {
      words[i] = words[i][0].toUpperCase() + words[i].substring(1);
    }
    return words.join(' ');
  }

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 5));
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
        IndicatorAnimationCommand.resume);
    super.initState();
    final provider = Provider.of<CardProvider>(context, listen: false);

    print(AppConstants.index);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;

      if (isTinderLoaded == false) {
        userList = widget.users;
        for (int i = 0; i < userList.length; i++) {
          if (widget.user.userId == userList[i].userId) {
            setState(() {
              lowerUser = userList[i];
            });
          }
        }
        setState(() {
          mainStoryList = provider.todayMatchDetailModel!.data!;
        });
        setState(() {
          isTinderLoaded = true;
        });
      }
      provider.setScreenSize(size);
    });
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  List swipesIntro = [
    {
      "title": "SLIDE RIGHT TO LIKE",
      "icon": "assets/lottie/swiperight.json",
    },
    {
      "title": "SLIDE LEFT TO SKIP",
      "icon": "assets/lottie/swipeleft.json",
    },
  ];
  int card = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CardProvider>(context, listen: false);
    // print("object ======== ${provider.todayMatchDetailModel!.data!.length}");
    // print("index ======== ${AppConstants.index}");
    return widget.isFront
        ? AppConstants.index != provider.todayMatchDetailModel!.data!.length
            ? Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child:
                              /* provider.todayMatchDetailModel!.data!.length == 0
                                  ? Center(
                                      child: Image.asset(
                                      ImagePath.noCardImg,
                                      fit: BoxFit.fill,
                                    ))
                                  : */
                              buildFrontCard()),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                          color: Colors.transparent, child: buildButtons()),
                    ],
                  ),
                ],
              )
            : completeYourRegistartionView()
        /* Center(
                child: Image.asset(
                ImagePath.noCardImg,
                fit: BoxFit.fill,
              )) */
        : backBuildCard();
  }

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
                  buildStamps(),
                ],
              ),
            );
          },
        ),
        onTap: () {
          final provider = Provider.of<CardProvider>(context, listen: false);
          final users = provider.users;

          imageList.clear();
          // users.clear();
          print("users length ::: ${users.length}");
          for (var i = 0; i < users.length; i++) {
            if (widget.user.userId == users[i].userId) {
              for (var j = 0; j < users[i].profileImage!.length; j++) {
                setState(() {
                  imageList.add(users[i].profileImage![j]);
                });
              }
            }
          }
          // print("user stroy length ::: ${imageList.length}");
          List<String> storiesList = List.generate(imageList.length, (index) {
            return imageList.isEmpty
                ? "http://www.goodmorningimagesdownload.com/wp-content/uploads/2019/12/Love-Images-1.jpg"
                : imageList[index].filePath.toString();
          });
          print("image list length story :::: ${storiesList.length}");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StoryView(
                      story: storiesList,
                      aboutMe: widget.user.aboutMe,
                      hobbies: widget.user.hobbies)));
        },
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
          log.log("Show Status :: ${provider.showStaus}");
          switch (provider.showStaus) {
            case CardStatus.like:
              provider.getLikeApi(widget.user.userId!);
              break;
            case CardStatus.dislike:
              provider.getAddArchiveApi(widget.user.userId!);
              break;
            case CardStatus.superLike:

            default:
              print("Not Swipe");
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {});
          widget.swipeValFun!();
        },
      );

  Widget buildCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.64,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              // color: Colors.redAccent,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: currentColor, width: 3)),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: (widget.user.profileImage!.isNotEmpty)
                      ? widget.user.profileImage!.isEmpty
                          ? Image.network(
                              "http://www.goodmorningimagesdownload.com/wp-content/uploads/2019/12/Love-Images-1.jpg",
                              height: MediaQuery.of(context).size.height * 0.64,
                              fit: BoxFit.cover,
                            )
                          : (widget.user.blurImage == 1)
                              ? ImageFiltered(
                                  imageFilter:
                                      ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                  child: CachedNetworkImage(
                                    imageUrl: widget
                                        .user.profileImage![0].filePath
                                        .toString(),
                                    height: MediaQuery.of(context).size.height *
                                        0.64,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : CachedNetworkImage(
                                  imageUrl: widget
                                      .user.profileImage![0].filePath
                                      .toString(),
                                  height:
                                      MediaQuery.of(context).size.height * 0.64,
                                  fit: BoxFit.cover,
                                )
                      : Image.network(
                          "http://www.goodmorningimagesdownload.com/wp-content/uploads/2019/12/Love-Images-1.jpg",
                          height: MediaQuery.of(context).size.height * 0.64,
                          fit: BoxFit.cover,
                        )
                  /* (widget.user.profileImage!.isNotEmpty)
                  ? widget.user.profileImage!.isEmpty
                      ? (widget.user.blurImage == 1)
                          ? ImageFiltered(
                              imageFilter:
                                  ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: CachedNetworkImage(
                                imageUrl: widget
                                    .user.profileImage![0].filePath
                                    .toString(),
                                fit: BoxFit.cover,
                                height: 207,
                                width: MediaQuery.of(context).size.width,
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: widget
                                  .user.profileImage![0].filePath
                                  .toString(),
                              fit: BoxFit.cover,
                              height: 207,
                              width: MediaQuery.of(context).size.width,
                            )
                      : Image.asset(
                          "http://www.goodmorningimagesdownload.com/wp-content/uploads/2019/12/Love-Images-1.jpg",
                        )
                  : Image.asset(
                      "http://www.goodmorningimagesdownload.com/wp-content/uploads/2019/12/Love-Images-1.jpg",
                    ) */
                  ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, right: 8.0, left: 8, bottom: 8),
                    child: Text("ID : " + widget.user.userId.toString()),
                  ),
                  Spacer(),
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(bottom: 0, left: 0, right: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      gradient: LinearGradient(
                        // tileMode: TileMode.mirror,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        // stops: [0, 0.2, 0.8, 0],
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.9),
                        ],
                      ),
                    ),
                    child: buildName(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget backBuildCard() {
    return Center(
        child: CircularProgressIndicator(
      color: AppColors.grey,
    ));
  }

  Widget completeYourRegistartionView() => ClipRRect(
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
                                        builder: (context) => Zoom()),
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

    if (status == CardStatus.like) {
      final child = buildStamp(
        angle: -0.5,
        color: Colors.green,
        text: 'LIKE',
        opacity: opacity,
      );
      return Positioned(top: 64, left: 50, child: child);
    } else if (status == CardStatus.dislike) {
      final child = buildStamp(
        angle: 0.5,
        color: Colors.red,
        text: 'NOPE',
        opacity: opacity,
      );

      return Positioned(top: 64, right: 50, child: child);
    } else {
      return Container();
    }
  }

  setFirstTimeCall(CardProvider _provider) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String isFirst = "isFirst";
    var isSetFirst = await _prefs.getString(isFirst) ?? "null";
    if (isSetFirst == "null") {
      await _provider
          .getLikeApi(widget.user.userId!)
          .then((value) => {_prefs.setString(isFirst, "true")});
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

  Widget buildButtons() {
    final provider = Provider.of<CardProvider>(context);
    final users = provider.users;
    final status = provider.getStatus();
    final isLike = status == CardStatus.like;
    final isDislike = status == CardStatus.dislike;
    final isSuperLike = status == CardStatus.superLike;

    return users.isEmpty
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Restart',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              final provider =
                  Provider.of<CardProvider>(context, listen: false);

              provider.resetUsers();
            },
          )
        : Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.zero),
                      foregroundColor:
                          getColor(Colors.transparent, Colors.grey, isDislike),
                      backgroundColor: getColor(/* Colors.grey */ currentColor,
                          Colors.grey.withOpacity(0.3), isDislike),
                      side: getBorder(
                          Colors.transparent, Colors.white, isDislike),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Image.asset(
                        ImagePath.cross1,
                        color: (isDislike) ? currentColor : Colors.white,
                        height: 25,
                        width: 25,
                      ),
                    ),
                    onPressed: () {
                      final provider =
                          Provider.of<CardProvider>(context, listen: false);
                      provider.getAddArchiveApi(widget.user.userId!);
                      provider.dislike();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0, right: 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.zero),
                      foregroundColor: getColor(
                          Colors.transparent, Colors.grey, isSuperLike),
                      backgroundColor: getColor(/* Colors.grey */ currentColor,
                          Colors.grey.withOpacity(0.3), isSuperLike),
                      side: getBorder(
                          Colors.transparent, Colors.white, isSuperLike),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Image.asset(
                        ImagePath.star1,
                        color: (isSuperLike) ? currentColor : Colors.white,
                        height: 25,
                        width: 25,
                      ),
                    ),
                    onPressed: () {
                      final provider =
                          Provider.of<CardProvider>(context, listen: false);

                      provider.getstarprofile(widget.user.userId!);
                      widget.onSuccess!();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0, right: 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.zero),
                      foregroundColor:
                          getColor(Colors.transparent, currentColor, isLike),
                      backgroundColor: getColor(/* Colors.grey */ currentColor,
                          Colors.grey.withOpacity(0.3), isLike),
                      side: getBorder(Colors.transparent, Colors.white, isLike),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        ImagePath.planheart,
                        color: (isLike) ? currentColor : Colors.white,
                        height: 25,
                        width: 25,
                      ),
                    ),
                    onPressed: () {
                      final provider =
                          Provider.of<CardProvider>(context, listen: false);
                      provider.getLikeApi(widget.user.userId!);
                      provider.like();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0, right: 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.zero),
                      foregroundColor:
                          getColor(Colors.transparent, Colors.grey, false),
                      backgroundColor: getColor(/* Colors.grey */ currentColor,
                          Colors.grey.withOpacity(0.3), false),
                      side: getBorder(Colors.transparent, Colors.white, false),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Image.asset(
                        ImagePath.chat1,
                        color: (false) ? currentColor : Colors.white,
                        height: 25,
                        width: 25,
                      ),
                    ),
                    onPressed: () {
                      final provider =
                          Provider.of<CardProvider>(context, listen: false);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0, right: 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.zero),
                      foregroundColor:
                          getColor(Colors.transparent, Colors.grey, false),
                      backgroundColor: getColor(/* Colors.grey */ currentColor,
                          Colors.grey.withOpacity(0.3), false),
                      side: getBorder(Colors.transparent, Colors.white, false),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Image.asset(
                        ImagePath.next,
                        color: (false) ? currentColor : Colors.white,
                        height: 25,
                        width: 25,
                      ),
                    ),
                    onPressed: () {
                      final provider =
                          Provider.of<CardProvider>(context, listen: false);
                      provider.like();
                    },
                  ),
                ),
              ],
            ),
          );
  }

  Widget buildName() {
    final provider = Provider.of<CardProvider>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 3, bottom: 5),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => UserDetailScreen(
                      userDetailIndex: widget.user.userId.toString()),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.user.firstname != null
                      ? capitalizeWords(widget.user.firstname!) + " "
                      : "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: appBtnStyle.copyWith(
                      fontWeight: FontWeight.w700, fontSize: 25),
                ),
                SizedBox(width: 3),
                Container(
                  child: Flexible(
                    child: Text(
                      widget.user.firstname != null &&
                              provider.userCheckModel != null
                          ? widget.user.isAgent == "1" &&
                                  provider.userCheckModel!.data!
                                          .paymentStatus ==
                                      0
                              ? (widget.user.lastname != "")
                                  ? widget.user.lastname![0]
                                  : ""
                              : widget.user.lastname!
                          : "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: appBtnStyle.copyWith(
                          fontWeight: FontWeight.w700, fontSize: 25),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(" | ",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: appBtnStyle.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 20)),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      widget.user.firstname != null
                          ? widget.user.age.toString()
                          : "20",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: appBtnStyle.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      " | ",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: appBtnStyle.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    widget.user.firstname != null
                        ? widget.user.height.toString()
                        : "5.1",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: appBtnStyle.copyWith(
                        fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 6.0,
                  ),
                  child: provider.userCheckModel != null
                      ? widget.user.isAgent == "1" &&
                              provider.userCheckModel!.data!.paymentStatus == 0
                          ? Image.asset(
                              ImagePath.colorexe,
                              height: 22,
                              width: 22,
                              color: currentColor,
                            )
                          : Container()
                      : Container(),
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
      ],
    );
  }
}
