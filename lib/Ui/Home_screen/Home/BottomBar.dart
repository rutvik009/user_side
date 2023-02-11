import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial_app/Ui/DiscoverFeed/discover_feed_screen.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Drawer/ProfileScreen/profile_screenn.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/HomeScreen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Notification/message_screen.dart';
import 'package:matrimonial_app/Ui/Matrimonial%20Like/like_screen.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';

class BottombarScreen extends StatefulWidget {
  int? selectedIndex;
  String? onfun;
  BottombarScreen({Key? key, this.selectedIndex, this.onfun}) : super(key: key);

  @override
  State<BottombarScreen> createState() => _BottombarScreenState();
}

class _BottombarScreenState extends State<BottombarScreen>
    with SingleTickerProviderStateMixin {
  DateTime? currentBackPressTime;

  int _selectedIndex = 0;
   List<Widget> _widgetOptions = [];
  /* _widgetOptions = <Widget>[
    HomeScreen(),
    DiscoverFeed(),
    Like_screen(),
    Message_screen(fromValue: 'Discover feed'),
    Profile(
      fromValue: "Profile",
    )
  ]; */

  void _onItemTapped(int index) {
    setState(
      () {
        widget.selectedIndex = index;
        _selectedIndex = index;
      },
    );
  }

  @override
  void initState() {
    log("init state call ${widget.onfun}");
    print("call init");
    super.initState();

    _onItemTapped((widget.selectedIndex) != null ? widget.selectedIndex! : 0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("call did change function");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("call build method");
    _widgetOptions = <Widget>[
      HomeScreen(),
      DiscoverFeed(),
      Like_screen(),
      Message_screen(fromValue: 'Discover feed'),
      Profile(
        fromValue: "Profile",
      )
    ];
    return WillPopScope(
      onWillPop: () async => _onBackPressed(),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: const Color(0xff2F2F2F).withOpacity(0.1),
                  offset: const Offset(0, 0),
                  blurRadius: 10,
                  spreadRadius: 0)
            ],
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
            ),
          ),
          height: 66,
          width: MediaQuery.of(context).size.width,
          child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: new Material(
                      type: MaterialType.transparency,
                      elevation: 10,
                      animationDuration: Duration(seconds: 1),
                      child: new InkWell(
                        splashColor: Colors.grey.withOpacity(0.5),
                        splashFactory: InkRipple.splashFactory,
                        onTap: () {
                          print("kk");
                          setState(() {
                            _onItemTapped(0);
                          });
                        },
                        child: Container(
                          width: 65,
                          child: Center(
                            child: _selectedIndex == 0
                                ? ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                        currentColor, BlendMode.srcATop),
                                    child: Image.asset(
                                      ImagePath.colorhome,
                                      width: 25,
                                      height: 25,
                                    ))
                                : Image.asset(
                                    ImagePath.bottomhome,
                                    width: 25,
                                    height: 25,
                                  ),
                          ),
                        ),
                      ),
                      color: Colors.transparent,
                    ),
                    color: Colors.white,
                  ),
                  Container(
                    child: new Material(
                      type: MaterialType.transparency,
                      elevation: 10,
                      animationDuration: Duration(seconds: 1),
                      child: new InkWell(
                          splashColor: Colors.grey.withOpacity(0.5),
                          splashFactory: InkRipple.splashFactory,
                          onTap: () {
                            print("kkddd1");
                            setState(() {
                              _onItemTapped(1);
                            });
                          },
                          child: Container(
                            width: 65,
                            child: Center(
                              child: _selectedIndex == 1
                                  ? ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                          currentColor, BlendMode.srcATop),
                                      child: Image.asset(
                                        ImagePath.colorsearch,
                                        width: 25,
                                        height: 25,
                                      ),
                                    )
                                  : Image.asset(
                                      ImagePath.bottomsearch,
                                      width: 25,
                                      height: 25,
                                    ),
                            ),
                          )),
                      color: Colors.transparent,
                    ),
                    color: Colors.white,
                  ),
                  Container(
                    child: new Material(
                      type: MaterialType.transparency,
                      elevation: 10,
                      animationDuration: Duration(seconds: 1),
                      child: new InkWell(
                          splashColor: Colors.grey.withOpacity(0.5),
                          splashFactory: InkRipple.splashFactory,
                          onHover: (value) {
                            log(value.toString());
                          },
                          onTap: () {
                            setState(() {
                              _onItemTapped(2);
                            });
                          },
                          child: Container(
                            width: 65,
                            child: Center(
                              child: _selectedIndex == 2
                                  ? ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                          currentColor, BlendMode.srcATop),
                                      child: Image.asset(ImagePath.colorheart,
                                          height: 25, width: 25))
                                  : Image.asset(
                                      ImagePath.bottomheart,
                                      width: 25,
                                      height: 25,
                                    ),
                            ),
                          )),
                      color: Colors.transparent,
                    ),
                    color: Colors.white,
                  ),
                  Container(
                    child: new Material(
                      type: MaterialType.transparency,
                      elevation: 10,
                      animationDuration: Duration(seconds: 1),
                      child: new InkWell(
                          splashColor: Colors.grey.withOpacity(0.5),
                          splashFactory: InkRipple.splashFactory,
                          onTap: () {
                            setState(() {
                              _onItemTapped(3);
                            });
                          },
                          child: Container(
                            width: 65,
                            child: Center(
                              child: _selectedIndex == 3
                                  ? ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                          currentColor, BlendMode.srcATop),
                                      child: Image.asset(
                                        ImagePath.colormessage,
                                        height: 25,
                                        width: 25,
                                      ),
                                    )
                                  : Image.asset(
                                      ImagePath.bottommessage,
                                      width: 25,
                                      height: 25,
                                    ),
                            ),
                          )),
                      color: Colors.transparent,
                    ),
                    color: Colors.white,
                  ),
                  Container(
                    child: new Material(
                      type: MaterialType.transparency,
                      elevation: 10,
                      animationDuration: Duration(seconds: 1),
                      child: new InkWell(
                          splashColor: Colors.grey.withOpacity(0.5),
                          splashFactory: InkRipple.splashFactory,
                          onTap: () {
                            setState(() {
                              _onItemTapped(4);
                            });
                          },
                          child: Container(
                            width: 65,
                            child: Center(
                              child: _selectedIndex == 4
                                  ? ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                          currentColor, BlendMode.srcATop),
                                      child: Image.asset(ImagePath.colorprofile,
                                          height: 25, width: 25))
                                  : Image.asset(
                                      ImagePath.bottomprofile,
                                      width: 25,
                                      height: 25,
                                    ),
                            ),
                          )),
                      color: Colors.transparent,
                    ),
                    color: Colors.white,
                  ),
                ],
              )),
        ),
        body: Center(
          child: _widgetOptions[_selectedIndex],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: 'Please click BACK again to exit',
          backgroundColor: currentColor,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
      return Future.value(false);
    }
    exit(0);
  }
}
