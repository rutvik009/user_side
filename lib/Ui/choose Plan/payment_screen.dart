import 'package:flutter/material.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/Utils/value_constant.dart';
import 'package:matrimonial_app/widget/submit_button.dart';

class Payment_screen extends StatefulWidget {
  const Payment_screen({Key? key}) : super(key: key);

  @override
  State<Payment_screen> createState() => _Payment_screenState();
}

class _Payment_screenState extends State<Payment_screen> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> payment = [
    {
      IMAGE: ImagePath.paytmlogo,
      NAME: AppConstants.paytm,
    },
    {
      IMAGE: ImagePath.gpaylogo,
      NAME: AppConstants.googlepay,
    },
    {
      IMAGE: ImagePath.paypallogo,
      NAME: AppConstants.paypal,
    },
    {
      IMAGE: ImagePath.visalogo,
      NAME: AppConstants.visa,
    },
    {
      IMAGE: ImagePath.walletlogo,
      NAME: AppConstants.wallet,
    }
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
        body: Column(
      children: [
        _filterbar(),
        SizedBox(
          height: 0,
        ),
        Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: payment.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _onItemTapped(index);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(
                              0xffF2F2F2,
                            ),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(11)),
                      height: height * 0.1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 21, right: 15, top: 18, bottom: 17),
                        child: Row(
                          children: [
                            Image.asset(
                              payment[index][IMAGE],
                              width: 35,
                              height: 30,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(payment[index][NAME],
                                style: _selectedIndex == index ? gpay : paytm),
                            Spacer(),
                            _selectedIndex == index
                                ? Image.asset(
                                    ImagePath.payselect,
                                    width: 18,
                                    height: 18,
                                  )
                                : Image.asset(
                                    ImagePath.paynotselect,
                                    width: 18,
                                    height: 18,
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 50),
              child: CommonButton(btnName: 'Pay', btnOnTap: () {}),
            )
          ],
        )
      ],
    ));
  }

  _filterbar() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Align(
          alignment: Alignment.center,
          child: Image.asset(
            ImagePath.leftArrow,
            width: 28,
            color: Color(0xff2C3E50),
            height: height * 0.050,
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        AppConstants.payment,
        style: message,
      ),
    );
  }
}
