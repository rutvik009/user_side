import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/LoginWithSocialMedia.dart';
import 'package:matrimonial_app/ModelClass/Social_Media_Model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/login_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/user_data_model.dart';
import 'package:matrimonial_app/Ui/AboutScreen/about_screen.dart';
import 'package:matrimonial_app/Ui/DetailsScreen/details_screen.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Home_screen/Home/Drawer_Screen.dart';
import 'package:matrimonial_app/Ui/Login/Model/loginmodel.dart' as users;
import 'package:matrimonial_app/Ui/Login/otp_screen.dart';
import 'package:matrimonial_app/Ui/Register%20Now/register_screen.dart';
import 'package:matrimonial_app/Ui/RegisterScreen/enter_mobilenumber.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/submit_button.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/url_constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var name;
  var email;
  User? user;
  FToast? fToast;
  bool check = false;
  bool dontcheck = false;
  bool ismobileEmptyChek = false;
  bool ismobileValidChek = false;
  String isNotAuthorize = "";
  bool isAuthorize = false;
  String userValidation = "";
  bool loginerror = false;
  final _formKey = GlobalKey<FormState>();
  String? _ratingController;
  String? countryCodeShow = '(+91)';
  TextEditingController _mobile = TextEditingController();
  TextEditingController _email = TextEditingController();
  String selectedCountry = "";
  bool isCheckValue = false;
  String? fromValue;

  @override
  void initState() {
    fToast = FToast();
    fToast!.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    fToast = FToast();
    fToast!.init(context);
    return Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        height: 75,
                        child: Image.asset(ImagePath.appLogo),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 50,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            AppConstants.welcome,
                            style: GoogleFonts.montserrat(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                          "You Can Now Continue With Your Mobile Number To Find Your Life Partner.",
                          textAlign: TextAlign.center,
                          style: fontStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Color(0xff8186A1))),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.0,
                              color: Color(0xff7572E7).withOpacity(0.2)),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(11),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 0.2,
                              blurRadius: 10,
                              offset: Offset(
                                4,
                                6,
                              ),
                              color: Color(0xff000000).withOpacity(.1),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CountryCodePicker(
                              padding: EdgeInsets.only(
                                  left: 8, top: 8, bottom: 10, right: 0),
                              onChanged: (CountryCode countryCode) {
                                setState(() {
                                  countryCodeShow = countryCode.toString();
                                });
                              },
                              initialSelection: "IN",
                              favorite: ['(+91)', 'IN'],
                              showCountryOnly: false,
                              showFlag: true,
                              showFlagDialog: true,
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff646B7B),
                                  fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _mobile,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]")),
                                ],
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    setState(() {
                                      isNotAuthorize = "";
                                      isAuthorize = false;
                                    });
                                  }
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: AppConstants.enteryournumber,
                                    hintStyle: TextStyle(
                                        color:
                                            Color(0xff677294).withOpacity(0.5),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            loginerror == true
                                ? "Phone Number Should be of 10 Digit"
                                : ismobileEmptyChek
                                    ? "Enter a Phone Number!"
                                    : ismobileValidChek
                                        ? 'Please enter valid phone number'
                                        : isAuthorize
                                            ? isNotAuthorize
                                            : "",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 1,
                            width: 130,
                            color: Color.fromARGB(255, 194, 191, 191),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "OR",
                            style: TextStyle(color: AppColors.grey),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 1,
                            width: 130,
                            color: Color.fromARGB(255, 194, 191, 191),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
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
                              spreadRadius: 0.2,
                              blurRadius: 10,
                              offset: Offset(
                                4,
                                6,
                              ),
                              color: Color(0xff000000).withOpacity(.1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
                            controller: _email,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Your Email",
                                hintStyle: TextStyle(
                                    color: Color(0xff677294).withOpacity(0.5),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Material(
                              type: MaterialType.transparency,
                              elevation: 10,
                              animationDuration: Duration(seconds: 1),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    check = !check;
                                    dontcheck = false;
                                    print(check);
                                  });
                                },
                                child: check == false
                                    ? Container(
                                        width: 20,
                                        height: 20,
                                        color: Colors.transparent,
                                        child: Container(
                                          width: 16,
                                          height: 16,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              border: Border.all(
                                                color: Color.fromARGB(
                                                    255, 194, 191, 191),
                                              )),
                                        ),
                                      )
                                    : Image.asset(
                                        ImagePath.logincheck,
                                        width: 20,
                                        height: 20,
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  check = !check;
                                  dontcheck = false;
                                  print(check);
                                });
                              },
                              child: Container(
                                child: RichText(
                                    textAlign: TextAlign.start,
                                    maxLines: 3,
                                    text: TextSpan(
                                        text: "I have read and accept the",
                                        style: fontStyle.copyWith(
                                            color: Color(0xff8186A1),
                                            fontSize: 11.5),
                                        children: [
                                          TextSpan(
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                          builder: (context) =>
                                                              About_Screen()));
                                                },
                                              text: " Privacy Policy ",
                                              style: fontStyle.copyWith(
                                                  color: Color(0xffFB5A57),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500)),
                                          TextSpan(
                                              text:
                                                  'and agree \nthat my personal data will be processed by you')
                                        ])),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      (isCheckValue == true)
                          ? Container(
                              height: 40,
                              width: 280,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                                color: currentColor,
                              ),
                              child: Center(
                                  child: Text(
                                'Please accept privacy policy for login',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )),
                            )
                          : SizedBox(
                              height: 40,
                            ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => Enter_mobileNumber()));
                        },
                        child: Text(
                          'Forgot Your Mobile Number?',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color(0xff677294)),
                        ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      CommonButton(
                          btnName: "Login Now",
                          btnOnTap: () {
                            //  print("message\u1d40\u1d39");
                            if (_formKey.currentState!.validate()) {
                              if (_mobile.text.isEmpty) {
                                if (_mobile.text.isEmpty &&
                                    _email.text.isNotEmpty) {
                                  if (check == false) {
                                    /*    setState(() {
                                    ismobileEmptyChek = false;
                                  }); */
                                    setState(() {
                                      isCheckValue = true;
                                      Future.delayed(Duration(seconds: 2), () {
                                        setState(() {
                                          isCheckValue = false;
                                        });
                                      });
                                    });

                                    print("not check privacy");
                                    // privacyPolicyToast();
                                  } else {
                                    checkConnection();
                                  }
                                } else {
                                  setState(() {
                                    loginerror = false;
                                    ismobileEmptyChek = true;
                                    // loginerror = false;
                                    // isNotAuthorize = "";
                                  });
                                }

                                print("Please enter mobile number");
                              } else if (_mobile.text.length < 10 ||
                                  _email.text.length < 0) {
                                setState(() {
                                  ismobileEmptyChek = false;
                                  loginerror = true;
                                  // ismobileValidChek = true;
                                });
                              } else {
                                setState(() {
                                  ismobileEmptyChek = false;
                                  ismobileEmptyChek = false;
                                  loginerror = false;
                                  isNotAuthorize = "";
                                });
                                if (check == false) {
                                  setState(() {
                                    isCheckValue = true;
                                    Future.delayed(Duration(seconds: 2), () {
                                      setState(() {
                                        isCheckValue = false;
                                      });
                                    });
                                    ismobileEmptyChek = false;
                                  });
                                  print("not check privacy");
                                  // privacyPolicyToast();
                                } else {
                                  checkConnection();
                                }
                              }
                            }
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      /*  RichText(
                        text: TextSpan(
                            text: "Don't have an Account? ",
                            style: fontStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color(0xff8186A1)),
                            children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Register_screen()));
                                    },
                                  text: 'Register Now ',
                                  style: fontStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffE16284)))
                            ]),
                      ),
                      SizedBox(
                        height: 15,
                      ), */
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 1,
                            width: 90,
                            color: Color.fromARGB(255, 194, 191, 191),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Or sign in with",
                            style: TextStyle(color: Color(0xff777777)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 1,
                            width: 90,
                            color: Color.fromARGB(255, 194, 191, 191),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff475993).withOpacity(0.1)),
                            height: 54,
                            width: width * 0.45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ImagePath.fblogo,
                                  height: 24,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'FACEBOOK',
                                  style: fontStyle.copyWith(
                                      color: Color(0xff475993),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              fromValue = "google";
                              signInwithGoogle();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffEB4132).withOpacity(0.1)),
                              height: 54,
                              width: width * 0.45,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ImagePath.googlelogo,
                                    height: 24,
                                    width: 24,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'GOOGLE',
                                    style: fontStyle.copyWith(
                                        color: Color(0xffEB4132),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      /* RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'Not looking for a marriage? ',
                            style: fontStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color(0xff8186A1)),
                            children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Benefits_screen()));
                                    },
                                  text: 'Become a Matchmaker ',
                                  style: fontStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffE16284)))
                            ]),
                      ), */
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  privacyPolicyToast() async {
    fToast!.showToast(
      fadeDuration: 500,
      toastDuration: Duration(seconds: 2),
      positionedToastBuilder: ((context, child) {
        return Positioned(
          child: child,
          left: 0,
          right: 0,
          bottom: 260,
        );
      }),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                20,
              ),
              color: currentColor,
            ),
            child: Center(
                child: Text(
              'Please accept privacy policy for login',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
          ),
        ],
      ),
    );
  }

  toastMessage(String text) async {
    fToast!.showToast(
      fadeDuration: 500,
      toastDuration: Duration(seconds: 2),
      positionedToastBuilder: ((context, child) {
        return Positioned(
          child: child,
          left: 0,
          right: 0,
          bottom: 241,
        );
      }),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                20,
              ),
              color: currentColor,
            ),
            child: Center(
                child: Text(
              '$text',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
          ),
        ],
      ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      loginApi();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      loginApi();
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Alert"),
              content: Text("Check Your Internet Connection"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok")),
              ],
            );
          });
    }
  }

  loginApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CommonUtils.showProgressLoading(context);
    try {
      final msg = {
        "email": _email.text,
        "mobile": _mobile.text.toString(),
        "otp": "123456",
        "type": "3"
      };

      var response = await http.post(
        Uri.parse(LOGIN_URL),
        body: msg,
      );
      print(response.body);
      if (response.statusCode == 200) {
        // CommonUtils.hideProgressLoading();
        ismobileEmptyChek = false;
        ismobileValidChek = false;
        loginerror = false;
        LoginModel _firstlogin = LoginModel.fromJson(
          jsonDecode(response.body),
        );
        prefs.setBool(SHOWLOGIN, true);
        prefs.setString(USER_MOBILE, _mobile.text);
        prefs.setString(
          USER_TOKEN,
          _firstlogin.token.toString(),
        );

        getUserData(_firstlogin.token.toString(), _firstlogin.success);
        print("mobile ${_mobile.text}");
        print("email ${_email.text}");
      } else if (response.statusCode == 404) {
        var data = jsonDecode(response.body);
        if (data['code'] == 0) {
          prefs.setBool(SHOWREGISTER, true);
          prefs.setString(USER_MOBILE, _mobile.text);
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OTPScreen(
                      isSuccess: data['success'],
                      mobile: _mobile.text,
                      email: _email.text,
                      countryCode: countryCodeShow,
                      text: '123456',
                      fromValue: 'Login',
                    )),
          );
        }
      } else if (response.statusCode == 400) {
        CommonUtils.hideProgressLoading();
        setState(() {
          loginerror = true;
        });
      } else if (response.statusCode == 500) {
        var data = jsonDecode(response.body);

        CommonUtils.hideProgressLoading();
        ismobileEmptyChek = false;
        ismobileValidChek = false;
        loginerror = false;
        /*  if (data['success'] == false) {
          prefs.setBool(SHOWREGISTER, true);
          prefs.setString(USER_MOBILE, _mobile.text);
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OTPScreen(
                      isSuccess: data['success'],
                      mobile: _mobile.text,
                      email: _email.text,
                      countryCode: countryCodeShow,
                      text: '123456',
                      fromValue: 'Login',
                    )),
          );
        } */
        setState(() {
          isNotAuthorize = data['message'];
          isAuthorize = true;
        });

        // toastMessage("${data["message"]}");
      }
    } catch (e) {
      log("error $e");
    }
  }

  Future<String?> signInwithGoogle() async {
    try {
      _googleSignIn.signOut();
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        if (credential != null) {
          CommonUtils.showProgressLoading(context);
          UserCredential result = await _auth.signInWithCredential(credential);
          user = result.user;
          if (result != null) {
            setState(() {
              name = user!.displayName;
              email = user!.email;
              print("Goole payload::: $user");
            });
            socialMediaAPI();
          }
        }

        print("sign in successfully");
        print(user);
        print(name);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  socialMediaAPI() async {
    Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("from value :: $fromValue");
    var params = {
      "mobile": user!.phoneNumber,
      "email": user!.email,
      "display_name": user!.displayName,
      "provider": fromValue,
      "uid": user!.uid,
      "type": "3"
    };
    try {
      var response =
          await dio.post(REGISTER_WITH_SOCIAL_MEDIA_URL, data: params);
      if (response.statusCode == 200) {
        var data = response.data;
        if (data['data'] != null) {
          RegisterWithSocialMediaModel socialMediaModel =
              RegisterWithSocialMediaModel.fromJson(response.data);
          prefs.setBool(SHOWREGISTER, true);
          prefs.setBool(SOCIAL_GOOGLE, true);
          prefs.setString(USER_ID, socialMediaModel.data!.userId.toString());
          prefs.setString(
              USER_MOBILE, socialMediaModel.data!.mobile.toString());
          prefs.setString(EMAIL, socialMediaModel.data!.email.toString());
          prefs.setString(
              FIRST_NAME, socialMediaModel.data!.firstname.toString());
          prefs.setString(
              LAST_NAME, socialMediaModel.data!.lastname.toString());

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Detail_screen(
                  userNumber: socialMediaModel.data!.mobile.toString(),
                ),
              ));
        } else {
          LoginWithSocialMediaModel socialMediaModel =
              LoginWithSocialMediaModel.fromJson(response.data);

          prefs.setBool(SHOWLOGIN, true);
          prefs.setBool(SHOWOTPSCREEN, true);
          prefs.setBool(ISGOOGLELOGIN, true);
          prefs.setString(USER_MOBILE, _mobile.text);
          prefs.setString(
            USER_TOKEN,
            socialMediaModel.token.toString(),
          );
          getUserData(
              socialMediaModel.token.toString(), socialMediaModel.success);
          CommonUtils.hideProgressLoading();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Zoom()),
              (route) => false);
        }

        print("object::: ${response.data}");
      }
    } on DioError catch (e) {
      CommonUtils.hideProgressLoading();
      var res = e.response!.data;
      Fluttertoast.showToast(
          msg: res['message'], backgroundColor: currentColor);
      print("catch response ::: $e");
    }
  }

  void getUserData(String token, bool? success) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await http.get(
        Uri.parse("http://13.127.8.138:8080/api/userCheck?token=${token}"),
      );
      print("data data ::::: " + response.body);
      if (response.statusCode == 200) {
        CommonUtils.hideProgressLoading();
        UserDataModel userData = UserDataModel.fromJson(
          jsonDecode(response.body),
        );

        await prefs.setString(USER_ID, userData.data!.userId!);
        await prefs.setString(FULLNAME, userData.data!.userName!);
        await prefs.setString(PROFILEIMAGE, userData.data!.profileImage!);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OTPScreen(
                    isSuccess: success,
                    mobile: _mobile.text,
                    email: _email.text,
                    countryCode: countryCodeShow,
                    text: '123456',
                    fromValue: 'Login',
                  )),
        );

        /* Firebase Auth */

        /*  FirebaseFirestore.instance
            .collection("Users")
            .doc(userData.data!.userId!)
            .set({
          "userId": userData.data!.userId!,
          "userName": userData.data!.userName!,
          "userProfile": userData.data!.profileImage!,
        }); */
        /* Firebase Auth */

      } else if (response.statusCode == 400) {
        CommonUtils.hideProgressLoading();
      } else if (response.statusCode == 500) {
        var data = jsonDecode(response.body);

        CommonUtils.hideProgressLoading();
        ismobileEmptyChek = false;
        ismobileValidChek = false;
        loginerror = false;
        setState(() {
          isNotAuthorize = data['message'];
          isAuthorize = true;
        });

        // toastMessage("${data["message"]}");
      }
    } catch (e) {
      log("error $e");
    }
  }
}

class ErrorResponse {
  String? timestamp;
  int? status;
  String? error;
  String? message;
  String? path;

  ErrorResponse(
      {this.timestamp, this.status, this.error, this.message, this.path});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    error = json['error'];
    message = json['message'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['status'] = status;
    data['error'] = error;
    data['message'] = message;
    data['path'] = path;
    return data;
  }
}
