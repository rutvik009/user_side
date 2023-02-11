import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/widget/commonappbar_search.dart';
import 'package:matrimonial_app/widget/submit_button.dart';
import 'package:dio/dio.dart';

class Contact_Us extends StatefulWidget {
  const Contact_Us({Key? key}) : super(key: key);

  @override
  State<Contact_Us> createState() => _Contact_UsState();
}

class _Contact_UsState extends State<Contact_Us> {
  Dio dio = Dio();
  final maxLines = 5;
  PickedFile? imageFile;
  PickedFile? imageFile1;
  PickedFile? imageFile2;
  bool isName = false;
  bool isEmailValid = false;
  bool isMobileNo = false;
  bool isValidNo = false;
  bool isAboutText = false;
  final _form = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _msgController = TextEditingController();
  GoogleSignInAccount? user;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonAppbar1(name: "contactus".tr),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 10, bottom: 15),
                    child: Form(
                      key: _form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "contactUsText".tr,
                            style: headerstyle.copyWith(
                              color: Color(0xff67707D),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            "entername".tr,
                            style: headerstyle.copyWith(
                              color: Color(0xff67707D),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 2),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp("[A-Za-z  \s]"),
                              ),
                              LengthLimitingTextInputFormatter(35)
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                /*  setState(() {
                                  isName = true;
                                }); */
                                return 'Please enter a name';
                              }

                              // return null;
                            },
                            onChanged: (value) {
                              if (_form.currentState!.validate()) {
                                /*  if (value.isEmpty) {
                                  setState(() {
                                    isName = true;
                                  });
                                } else {
                                  setState(() {
                                    isName = false;
                                  });
                                } */
                              }
                            },
                            controller: _nameController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 232, 15, 15),
                                    width: 1.5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: BorderSide(
                                    color: Color(0xffd1d1d1), width: 1.5),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 15),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: BorderSide(
                                    color: Color(0xffD1D1D1), width: 1.5),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              labelStyle: fontStyle.copyWith(
                                  color: Color(0xff777777),
                                  fontWeight: FontWeight.w500),
                              hintText: "Alexandra Smith",
                              hintStyle: TextStyle(
                                color: Color(0xff333F52).withOpacity(0.5),
                              ),
                            ),
                          ),
                          /* (isName)
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text(
                                    "Please enter a name",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 13),
                                  ),
                                )
                              : Container(), */
                          SizedBox(height: 25),
                          Text(
                            "enteremail".tr,
                            style: headerstyle.copyWith(
                              color: Color(0xff67707D),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 2),
                          TextFormField(
                            readOnly: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z0-9@\.]")),
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                /* setState(() {
                                  isEmailValid = true;
                                }); */
                                return "Please enter a email address";
                              } else if (!RegExp(r'\S+@\S+\.\S+')
                                  .hasMatch(value)) {
                                return "Please enter valid email address";
                              }
                              // return null;
                            },
                            onTap: () async {
                              user = await GoogleSignAuth.signIn();
                              print("call");
                              if (user == null) return;
                              print("user");
                              setState(() {
                                _emailController.text = user!.email;
                              });
                            },
                            onChanged: ((value) {
                              if (_form.currentState!.validate()) {
                                /* if (value.isEmpty) {
                                  setState(() {
                                    isEmailValid = true;
                                  });
                                } else {
                                  setState(() {
                                    isEmailValid = false;
                                  });
                                } */
                              }
                            }),
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 232, 15, 15),
                                    width: 1.5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 232, 15, 15),
                                    width: 1.5),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 15),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: BorderSide(
                                    color: Color(0xffD1D1D1), width: 1.5),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              labelStyle: fontStyle.copyWith(
                                  color: Color(0xff777777),
                                  fontWeight: FontWeight.w500),
                              hintText: "alexa@gmail.com",
                              hintStyle: TextStyle(
                                  color: Color(0xff333F52).withOpacity(0.5)),
                            ),
                          ),
                          /*  (isEmailValid)
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text(
                                    "Please enter a valid email address",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : Container(), */
                          SizedBox(height: 25),
                          Text(
                            "entermobile".tr,
                            style: headerstyle.copyWith(
                              color: Color(0xff67707D),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 2),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                /*  setState(() {
                                  isMobileNo = true;
                                  isValidNo = false;
                                }); */
                                return 'Enter a Phone Number';
                              } else if (value.length < 10 ||
                                  value.length > 10) {
                                /*   setState(() {
                                  isValidNo = true;
                                  isMobileNo = false;
                                }); */
                                return 'Phone Number Should be 10 Character';
                              }
                            },
                            onChanged: (value) {
                              if (_form.currentState!.validate()) {
                                /* if (value.isEmpty) {
                                  setState(() {
                                    isMobileNo = true;
                                  });
                                } else if (value.length > 10) {
                                  print("less then");
                                  setState(() {
                                    isValidNo = true;
                                  });
                                } else if (value.length != 10) {
                                  print("greater then");
                                  setState(() {
                                    isValidNo = true;
                                  });
                                } else {
                                  setState(() {
                                    isMobileNo = false;
                                    isValidNo = false;
                                  });
                                } */
                              }
                            },
                            controller: _numberController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                            ],
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13),
                                  borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.5),
                                      width: 1.5),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 232, 15, 15),
                                      width: 1.5),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13),
                                  borderSide: BorderSide(
                                      color: Color(0xffD1D1D1), width: 1.5),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                labelStyle: fontStyle.copyWith(
                                    color: Color(0xff777777),
                                    fontWeight: FontWeight.w500),
                                hintText: "9852147856",
                                hintStyle: TextStyle(
                                    color: Color(0xff333F52).withOpacity(0.5))),
                          ),
                          /* (isMobileNo)
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text(
                                    "Enter a Phone Number",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : (isValidNo == true)
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: Text(
                                        "Phone Number Should be 10 Character",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    )
                                  : Container(), */
                          SizedBox(height: 25),
                          Text(
                            "tellusAbout".tr,
                            style: headerstyle.copyWith(
                              color: Color(0xff67707D),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 2),
                          TextFormField(
                            validator: (value) {
                              /* if (value!.isEmpty) {
                                /*  setState(() {
                                  isAboutText = true;
                                }); */
                                return 'Please fill tell us';
                              } */
                              if (value!.length < 50 || value.length > 50) {
                                return 'Please describe the issue in at least 50 character';
                              }
                            },
                            onChanged: ((value) {
                              if (_form.currentState!.validate()) {
                                /* if (value.isEmpty) {
                                  isAboutText = true;
                                } else {
                                  setState(() {
                                    isAboutText = false;
                                  });
                                } */
                              }
                            }),
                            maxLength: 50,
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z ,.  \s]"))
                            ],
                            controller: _msgController,
                            maxLines: maxLines,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: BorderSide(
                                    color: Color(0xffD1D1D1), width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: BorderSide(
                                    color: Color(0xffD1D1D1), width: 1.5),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 232, 15, 15),
                                    width: 1.5),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13)),
                            ),
                          ),
                          SizedBox(height: 8),
                          /*   (isAboutText)
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text(
                                    "Please fill tell us",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : Container(), */
                          Text(
                            "add attachment".tr,
                            style: headerstyle.copyWith(
                              color: Color(0xff67707D),
                              fontSize: 13.7,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              DottedBorder(
                                dashPattern: [8, 4],
                                strokeWidth: 1,
                                strokeCap: StrokeCap.round,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(7),
                                color: Color(0xffD9DADE),
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: Center(
                                                  child:
                                                      const Text('Pick Image')),
                                              actions: <Widget>[
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        _openGallery(context);
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text('Gallery'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        _openCamera(context);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Camera'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: (imageFile == null)
                                            ? Container(
                                                height: 90,
                                                width: 100,
                                                color: Colors.transparent,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      37.0),
                                                  child: Image.asset(
                                                      ImagePath.uploadImage,
                                                      height: 15,
                                                      width: 15),
                                                ),
                                              )
                                            : Container(
                                                height: 90,
                                                width: 90,
                                                child: Image.file(
                                                  File(imageFile!.path),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              //SizedBox(width: 15),
                              DottedBorder(
                                dashPattern: [8, 4],
                                strokeWidth: 1,
                                strokeCap: StrokeCap.round,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(7),
                                color: Color(0xffD9DADE),
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: Center(
                                                  child:
                                                      const Text('Pick Image')),
                                              actions: <Widget>[
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        _openGallery1(context);
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text('Gallery'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        _openCamera1(context);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Camera'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: (imageFile1 == null)
                                            ? Container(
                                                height: 90,
                                                width: 100,
                                                color: Colors.transparent,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      37.0),
                                                  child: Image.asset(
                                                      ImagePath.uploadImage,
                                                      height: 15,
                                                      width: 15),
                                                ),
                                              )
                                            : Container(
                                                height: 90,
                                                width: 90,
                                                child: Image.file(
                                                  File(imageFile1!.path),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              //SizedBox(width: 15),
                              DottedBorder(
                                dashPattern: [8, 4],
                                strokeWidth: 1,
                                strokeCap: StrokeCap.round,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(7),
                                color: Color(0xffD9DADE),
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: Center(
                                                  child:
                                                      const Text('Pick Image')),
                                              actions: <Widget>[
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        _openGallery2(context);
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text('Gallery'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        _openCamera2(context);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Camera'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: (imageFile2 == null)
                                            ? Container(
                                                height: 90,
                                                width: 100,
                                                color: Colors.transparent,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      37.0),
                                                  child: Image.asset(
                                                      ImagePath.uploadImage,
                                                      height: 15,
                                                      width: 15),
                                                ),
                                              )
                                            : Container(
                                                height: 90,
                                                width: 90,
                                                child: Image.file(
                                                  File(imageFile2!.path),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //SizedBox(width: 15),
                            ],
                          ),
                          SizedBox(height: 16),
                          CommonButton(
                            btnName: "sendus".tr,
                            btnOnTap: () {
                              if (_form.currentState!.validate()) {
                                sendMail();
                                print("submit");
                                // setContactUs();
                                /* final Email send_email = Email(
                                  body: 'body of email',
                                  subject: 'subject of email',
                                  recipients: ['example1@ex.com'],
                                  cc: ['example_cc@ex.com'],
                                  bcc: ['example_bcc@ex.com'],
                                  attachmentPaths: [
                                    '/path/to/email_attachment.zip'
                                  ],
                                  isHTML: false,
                                ); */

                              } else {
                                print("not submit");
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _textFormField(
      double height, TextEditingController _controller, String hintext) {
    return Container(
      height: height,
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        controller: _controller,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp("[A-Za-z  \s]"),
          ),
        ],
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: Color(0xffD1D1D1), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: Color(0xffD1D1D1), width: 1.5),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            hintText: hintext,
            hintStyle: TextStyle(color: Color(0xff333F52).withOpacity(0.5))),
      ),
    );
  }

  DottedBorder imagepicker(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DottedBorder(
      dashPattern: [8, 4],
      strokeWidth: 1,
      strokeCap: StrokeCap.round,
      borderType: BorderType.RRect,
      radius: Radius.circular(7),
      color: Color(0xffD9DADE),
      child: Container(
        height: 90,
        width: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Center(child: const Text('Pick Image')),
                    actions: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              _openGallery(context);
                              Navigator.pop(context);
                            },
                            child: const Text('Gallery'),
                          ),
                          TextButton(
                            onPressed: () {
                              _openCamera(context);
                              Navigator.pop(context);
                            },
                            child: Text('Camera'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              child: (imageFile == null)
                  ? Container(
                      child: Image.asset(ImagePath.uploadImage,
                          height: 15, width: 15),
                    )
                  : Container(
                      height: 90,
                      width: 90,
                      color: Colors.red,
                      child: Image.file(
                        File(imageFile!.path),
                        fit: BoxFit.fill,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    final f = File(pickedFile!.path);
    int sizeInBytes = f.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb < 5) {
      setState(() {
        imageFile = pickedFile;
      });
    } else {
      Fluttertoast.showToast(
        msg: "max size 5 mb",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    final f = File(pickedFile!.path);
    int sizeInBytes = f.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb < 5) {
      setState(() {
        imageFile = pickedFile;
      });
    } else {
      Fluttertoast.showToast(
        msg: "max size 5 mb",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    Navigator.pop(context);
  }

  void _openGallery1(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    final f = File(pickedFile!.path);
    int sizeInBytes = f.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb < 5) {
      setState(() {
        imageFile1 = pickedFile;
      });
    } else {
      Fluttertoast.showToast(
        msg: "max size 5 mb",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    Navigator.pop(context);
  }

  void _openCamera1(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    final f = File(pickedFile!.path);
    int sizeInBytes = f.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb < 5) {
      setState(() {
        imageFile1 = pickedFile;
      });
    } else {
      Fluttertoast.showToast(
        msg: "max size 5 mb",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    Navigator.pop(context);
  }

  void _openGallery2(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    final f = File(pickedFile!.path);
    int sizeInBytes = f.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb < 5) {
      setState(() {
        imageFile2 = pickedFile;
      });
    } else {
      Fluttertoast.showToast(
        msg: "max size 5 mb",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    Navigator.pop(context);
  }

  void _openCamera2(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    final f = File(pickedFile!.path);
    int sizeInBytes = f.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb < 5) {
      setState(() {
        imageFile2 = pickedFile;
      });
    } else {
      Fluttertoast.showToast(
        msg: "max size 5 mb",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    Navigator.pop(context);
  }

  void setContactUs() async {
    CommonUtils.showProgressLoading(context);

    FormData formData = FormData.fromMap({
      "full_name": _nameController.text,
      "email": _emailController.text,
      "mobile_no": _numberController.text,
      "message": _msgController.text,
      "image": imageFile != null
          ? await MultipartFile.fromFile(imageFile!.path,
              filename: imageFile!.path.split('/').last)
          : null,
      "image": imageFile1 != null
          ? await MultipartFile.fromFile(imageFile1!.path,
              filename: imageFile1!.path.split('/').last)
          : null,
      "image": imageFile2 != null
          ? await MultipartFile.fromFile(imageFile2!.path,
              filename: imageFile2!.path.split('/').last)
          : null,
    });

    var response = await dio.post(CONTACT_US, data: formData);

    if (response.statusCode == 200) {
      if (mounted) {
        Fluttertoast.showToast(
          msg: "Your Contact Us Submitted successfully",
          toastLength: Toast.LENGTH_SHORT,
        );
        Navigator.pop(context);
      }
      CommonUtils.hideProgressLoading();
    } else if (response.statusCode == 500) {
      CommonUtils.hideProgressLoading();
      Fluttertoast.showToast(
          msg: "Internal Server Error",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xffE16284),
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
        msg: "Somthing went wrong",
        toastLength: Toast.LENGTH_SHORT,
      );
      CommonUtils.hideProgressLoading();
    }
  }

  sendMail() async {
    String username = user!.email;
    final auth = await user!.authentication;
    final token = auth.accessToken;

    final smtpServer = gmailSaslXoauth2(username, token!);
    final message = Message()
      ..from = Address(username, _nameController.text)
      ..recipients.add('contact@mangalkaryam.com')
      // mailto:contact@mangalkaryam.com
      // ..ccRecipients.addAll(['hiCc1@caveman.my', 'hiCc2@caveman.my'])
      // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Contact Us : ${DateTime.now()}'
      ..text = _msgController.text;

    try {
      CommonUtils.showProgressLoading(context);
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      Fluttertoast.showToast(msg: "Message successfully sent");
      _nameController.clear();
      _msgController.clear();
      _emailController.clear();
      CommonUtils.hideProgressLoading();
    } on MailerException catch (e) {
      log(e.toString());
      CommonUtils.hideProgressLoading();
      print('Message not sent. ${e.message}');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    // DONE
  }
}

class GoogleSignAuth {
  static final _googleSignIn =
      GoogleSignIn(scopes: ['https://mail.google.com/']);
  static Future<GoogleSignInAccount?> signIn() async {
    if (await _googleSignIn.isSignedIn()) {
      return _googleSignIn.currentUser;
    } else {
      return await _googleSignIn.signIn();
    }
  }
}
