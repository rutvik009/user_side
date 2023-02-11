
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/Enter_verification_code.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/commonappbar.dart';
import 'package:matrimonial_app/widget/submit_button.dart';

class Enter_mobileNumber extends StatefulWidget {
  const Enter_mobileNumber({Key? key}) : super(key: key);

  @override
  State<Enter_mobileNumber> createState() => _Enter_mobileNumberState();
}

class _Enter_mobileNumberState extends State<Enter_mobileNumber> {
  String? countryCodeShow = '(+91)';
  bool checkvalue = true;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Column(
            children: [
              HeaderAppBar(name: AppConstants.enterMobileNo),
              
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.0,
                            color: Color(0xff7572E7).withOpacity(0.23)),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 0.9,
                            blurRadius: 4,
                            offset: Offset(
                              .0,
                              3,
                            ),
                            color: Color(0xff000000).withOpacity(.25),
                          ),
                        ],
                      ),
                    
                      child: Row(
                        children: [
                          CountryCodePicker(
                            onChanged: (CountryCode countryCode) {
                              setState(() {
                                countryCodeShow = countryCode.toString();
                              });
                            },
                            initialSelection:
                               
                                "IN",
                            favorite: ['(+91)', 'IN'],
                            showCountryOnly: false,
                            showFlag: true,
                            showFlagDialog: true,
                            textStyle: TextStyle(
                                fontSize: 15,
                                color: Color(0xff646B7B),
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: AppConstants.enteryournumber,
                                  hintStyle: TextStyle(
                                      color: Color(0xff677294),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 22),
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Checkbox(
                            value: checkvalue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3)),
                            activeColor: Color(0xffFB5A57),
                            checkColor: Colors.white,
                            onChanged: (value) {
                              setState(
                                () {
                                  checkvalue = !checkvalue;
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.start,
                           
                            text: TextSpan(
                              text: AppConstants.rich1,
                              style: fontStyle.copyWith(
                                  color: Color(0xff8186A1), fontSize: 11.5),
                              children: [
                                TextSpan(
                                  text: AppConstants.rich2,
                                  style: fontStyle.copyWith(
                                      color: Color(0xffFB5A57), fontSize: 12),
                                ),
                                TextSpan(text: AppConstants.rich3)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CommonButton(
                    btnName: AppConstants.getOtp,
                    btnOnTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => Enter_Varification_Code()));
                    }),
              ),
              SizedBox(
                height: 270,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderAppBar extends StatelessWidget {
  String name;
  HeaderAppBar({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 40,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
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
        name,
        style: headingStyle.copyWith(
            color: Color(0xff440312),
            fontSize: 20,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
