import 'package:flutter/material.dart';
import 'package:matrimonial_app/Core/Constant/globle.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/Ui/Login/login_screen.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlertDailog extends StatefulWidget {
  const AlertDailog({Key? key}) : super(key: key);

  @override
  State<AlertDailog> createState() => _AlertDailogState();
}

class _AlertDailogState extends State<AlertDailog> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5),(){
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 5,
                        spreadRadius: 0.9)
                  ],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                height: 200,
                width: MediaQuery.of(context).size.width * 0.9,
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        ImagePath.success,
                        height: 50,
                        width: 50,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "SUCCESSFULLY",
                        style: nextBtnStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Your Profile has been created successfully. \nKindly login again ",
                        style: headingStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async{
                        SharedPreferences _prefs =
                            await SharedPreferences.getInstance();
                        setState(() {
                          _prefs.setBool(SHOWREGISTER, false);
                          _prefs.setBool(SHOWPERSONALDETAILS, false);
                          _prefs.setBool(SHOWUPLOADIMAGE, false);
                          isFirstRegister = true;
                        });

                       
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                            (route) => false);
                      },
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.7,
                          height: 40,
                          decoration: BoxDecoration(
                              gradient: AppColors.appColor,
                              borderRadius: BorderRadius.circular(9)),
                          alignment: Alignment.center,
                          child: Text(
                            "Ok",
                            style: appBtnStyle,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
