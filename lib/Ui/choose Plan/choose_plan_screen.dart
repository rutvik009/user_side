import 'package:flutter/material.dart';
import 'package:matrimonial_app/Core/Constant/globle.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/choose%20Plan/payment_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/Utils/value_constant.dart';
import 'package:matrimonial_app/widget/submit_button.dart';

class Chooseplan_screen extends StatefulWidget {
  const Chooseplan_screen({Key? key}) : super(key: key);

  @override
  State<Chooseplan_screen> createState() => _ChoosePlan_screenState();
}

class _ChoosePlan_screenState extends State<Chooseplan_screen> {
  int? _selectedIndex;

  List<Map<String, dynamic>> plan = [
    {
      NAME: AppConstants.weekly1,
      SUBNAME: AppConstants.year1,
      SUBNAME1: AppConstants.trail,
      SUBNAME2: AppConstants.anytime1,
    },
    {
      NAME: AppConstants.monthly2,
      SUBNAME: AppConstants.month2,
      SUBNAME1: AppConstants.trail1,
      SUBNAME2: AppConstants.anytime2,
    },
    {
      NAME: AppConstants.annualy3,
      SUBNAME: AppConstants.year3,
      SUBNAME1: AppConstants.trail3,
      SUBNAME2: AppConstants.cancelanytime3,
    },
    {
      NAME: AppConstants.premium4,
      SUBNAME: AppConstants.year4,
      SUBNAME1: AppConstants.trail4,
      SUBNAME2: AppConstants.anytime4,
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 40,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Image.asset(
                ImagePath.leftArrow,
                height: 28,
                width: 28,
                color: Color(0xff2C3E50),
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            'Choose your Plan',
            style: headingStyle.copyWith(
                color: Color(0xff440312),
                fontSize: 21,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: plan.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 10,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _onItemTapped(index);
                              print('_onItemTapped');
                            });
                          },
                          child: Container(
                            height: height * 0.25,
                            decoration: BoxDecoration(
                                border: _selectedIndex == index
                                    ? Border.all(
                                        color: currentColor.withOpacity(0.5),
                                      )
                                    : Border.all(
                                        color: Color(
                                          0xffEDEDED,
                                        ).withOpacity(0.5),
                                        width: 1.5),
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16, top: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 13),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          plan[index][NAME],
                                          style: plane,
                                        ),
                                        _selectedIndex == index
                                            ? Image.asset(
                                                ImagePath.roundplan,
                                                color: currentColor,
                                                height: 22,
                                                width: 22,
                                              )
                                            : Container()
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    plan[index][SUBNAME],
                                    style: subname1,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 26,
                                    width: 126,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xffC8EDDA),
                                    ),
                                    child: Center(
                                      child: Text(
                                        plan[index][SUBNAME1],
                                        style: subname2,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    plan[index][SUBNAME2],
                                    style: subname3,
                                  ),
                                  SizedBox(
                                    height: 14,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 30, left: 60, right: 60),
                    child: CommonButton(
                        btnName: 'Continue To Checkout',
                        btnOnTap: () {
                          setState(() {
                            isPreminum = true;
                          });
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             const Payment_screen()));
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
