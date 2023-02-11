
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/commonappbar.dart';

class Comunity_screen extends StatefulWidget {
  const Comunity_screen({Key? key}) : super(key: key);

  @override
  State<Comunity_screen> createState() => _Comunity_screenState();
}

class _Comunity_screenState extends State<Comunity_screen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonAppbar(
            name: AppConstants.comunity,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 3,
            color: Color(0xffF1F2F6),
          ),
          SizedBox(
            height: 29,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              AppConstants.comunity,
              style: description,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Container(
              height: height * 0.7,
              child: Text(
                AppConstants.comunity1,
                style: securitycontent,
              ),
            ),
          )
        ],
      ),
    );
  }
}