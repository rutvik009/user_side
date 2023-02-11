import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/personaldetails_model.dart';
import 'package:matrimonial_app/Ui/DetailsScreen/Upload_Images.dart';
import 'package:matrimonial_app/Ui/DetailsScreen/upload_image.dart';
import 'package:matrimonial_app/Ui/Drawer/AccountSettingScreen/account_screen.dart';
import 'package:matrimonial_app/Ui/Login/otp_screen.dart';
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/Utils/value_constant.dart';
import 'package:matrimonial_app/src/DatePicker/date_picker.dart';
import 'package:matrimonial_app/src/DatePicker/i18n/date_picker_i18n.dart';
import 'package:matrimonial_app/widget/submit_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widget/dropdown_const.dart';

class Detail_screen extends StatefulWidget {
  String userNumber;
  Detail_screen({Key? key, required this.userNumber}) : super(key: key);

  @override
  State<Detail_screen> createState() => _Detail_screenState();
}

String? genderSelecter;

class _Detail_screenState extends State<Detail_screen> {
  var regexToRemoveEmoji =
      '   /\uD83C\uDFF4\uDB40\uDC67\uDB40\uDC62(?:\uDB40\uDC77\uDB40\uDC6C\uDB40\uDC73|\uDB40\uDC73\uDB40\uDC63\uDB40\uDC74|\uDB40\uDC65\uDB40\uDC6E\uDB40\uDC67)\uDB40\uDC7F|\uD83D\uDC69\u200D\uD83D\uDC69\u200D(?:\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67]))|\uD83D\uDC68(?:\uD83C\uDFFF\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB-\uDFFE])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFE\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB-\uDFFD\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFD\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB\uDFFC\uDFFE\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFC\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB\uDFFD-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFB\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFC-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\u200D(?:\u2764\uFE0F\u200D(?:\uD83D\uDC8B\u200D)?\uD83D\uDC68|(?:\uD83D[\uDC68\uDC69])\u200D(?:\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67]))|\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67])|(?:\uD83D[\uDC68\uDC69])\u200D(?:\uD83D[\uDC66\uDC67])|[\u2695\u2696\u2708]\uFE0F|\uD83D[\uDC66\uDC67]|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|(?:\uD83C\uDFFF\u200D[\u2695\u2696\u2708]|\uD83C\uDFFE\u200D[\u2695\u2696\u2708]|\uD83C\uDFFD\u200D[\u2695\u2696\u2708]|\uD83C\uDFFC\u200D[\u2695\u2696\u2708]|\uD83C\uDFFB\u200D[\u2695\u2696\u2708])\uFE0F|\uD83C\uDFFF|\uD83C\uDFFE|\uD83C\uDFFD|\uD83C\uDFFC|\uD83C\uDFFB)?|\uD83E\uDDD1(?:(?:\uD83C[\uDFFB-\uDFFF])\u200D(?:\uD83E\uDD1D\u200D\uD83E\uDDD1(?:\uD83C[\uDFFB-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF84\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\u200D(?:\uD83E\uDD1D\u200D\uD83E\uDDD1|\uD83C[\uDF3E\uDF73\uDF7C\uDF84\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD]))|\uD83D\uDC69(?:\u200D(?:\u2764\uFE0F\u200D(?:\uD83D\uDC8B\u200D(?:\uD83D[\uDC68\uDC69])|\uD83D[\uDC68\uDC69])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFF\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFE\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFD\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFC\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFB\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD]))|\uD83D\uDC69\uD83C\uDFFF\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB-\uDFFE])|\uD83D\uDC69\uD83C\uDFFE\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB-\uDFFD\uDFFF])|\uD83D\uDC69\uD83C\uDFFD\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB\uDFFC\uDFFE\uDFFF])|\uD83D\uDC69\uD83C\uDFFC\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB\uDFFD-\uDFFF])|\uD83D\uDC69\uD83C\uDFFB\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFC-\uDFFF])|\uD83D\uDC69\u200D\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC69\u200D\uD83D\uDC69\u200D(?:\uD83D[\uDC66\uDC67])|(?:\uD83D\uDC41\uFE0F\u200D\uD83D\uDDE8|\uD83D\uDC69(?:\uD83C\uDFFF\u200D[\u2695\u2696\u2708]|\uD83C\uDFFE\u200D[\u2695\u2696\u2708]|\uD83C\uDFFD\u200D[\u2695\u2696\u2708]|\uD83C\uDFFC\u200D[\u2695\u2696\u2708]|\uD83C\uDFFB\u200D[\u2695\u2696\u2708]|\u200D[\u2695\u2696\u2708])|\uD83C\uDFF3\uFE0F\u200D\u26A7|\uD83E\uDDD1(?:(?:\uD83C[\uDFFB-\uDFFF])\u200D[\u2695\u2696\u2708]|\u200D[\u2695\u2696\u2708])|\uD83D\uDC3B\u200D\u2744|(?:(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])(?:\uD83C[\uDFFB-\uDFFF])|\uD83D\uDC6F|\uD83E[\uDD3C\uDDDE\uDDDF])\u200D[\u2640\u2642]|(?:\u26F9|\uD83C[\uDFCB\uDFCC]|\uD83D\uDD75)(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])\u200D[\u2640\u2642]|\uD83C\uDFF4\u200D\u2620|(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])\u200D[\u2640\u2642]|[\xA9\xAE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9\u21AA\u2328\u23CF\u23ED-\u23EF\u23F1\u23F2\u23F8-\u23FA\u24C2\u25AA\u25AB\u25B6\u25C0\u25FB\u25FC\u2600-\u2604\u260E\u2611\u2618\u2620\u2622\u2623\u2626\u262A\u262E\u262F\u2638-\u263A\u2640\u2642\u265F\u2660\u2663\u2665\u2666\u2668\u267B\u267E\u2692\u2694-\u2697\u2699\u269B\u269C\u26A0\u26A7\u26B0\u26B1\u26C8\u26CF\u26D1\u26D3\u26E9\u26F0\u26F1\u26F4\u26F7\u26F8\u2702\u2708\u2709\u270F\u2712\u2714\u2716\u271D\u2721\u2733\u2734\u2744\u2747\u2763\u2764\u27A1\u2934\u2935\u2B05-\u2B07\u3030\u303D\u3297\u3299]|\uD83C[\uDD70\uDD71\uDD7E\uDD7F\uDE02\uDE37\uDF21\uDF24-\uDF2C\uDF36\uDF7D\uDF96\uDF97\uDF99-\uDF9B\uDF9E\uDF9F\uDFCD\uDFCE\uDFD4-\uDFDF\uDFF5\uDFF7]|\uD83D[\uDC3F\uDCFD\uDD49\uDD4A\uDD6F\uDD70\uDD73\uDD76-\uDD79\uDD87\uDD8A-\uDD8D\uDDA5\uDDA8\uDDB1\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDE8\uDDEF\uDDF3\uDDFA\uDECB\uDECD-\uDECF\uDEE0-\uDEE5\uDEE9\uDEF0\uDEF3])\uFE0F|\uD83D\uDC69\u200D\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67])|\uD83C\uDFF3\uFE0F\u200D\uD83C\uDF08|\uD83D\uDC69\u200D\uD83D\uDC67|\uD83D\uDC69\u200D\uD83D\uDC66|\uD83D\uDC15\u200D\uD83E\uDDBA|\uD83D\uDC69(?:\uD83C\uDFFF|\uD83C\uDFFE|\uD83C\uDFFD|\uD83C\uDFFC|\uD83C\uDFFB)?|\uD83C\uDDFD\uD83C\uDDF0|\uD83C\uDDF6\uD83C\uDDE6|\uD83C\uDDF4\uD83C\uDDF2|\uD83D\uDC08\u200D\u2B1B|\uD83D\uDC41\uFE0F|\uD83C\uDFF3\uFE0F|\uD83E\uDDD1(?:\uD83C[\uDFFB-\uDFFF])?|\uD83C\uDDFF(?:\uD83C[\uDDE6\uDDF2\uDDFC])|\uD83C\uDDFE(?:\uD83C[\uDDEA\uDDF9])|\uD83C\uDDFC(?:\uD83C[\uDDEB\uDDF8])|\uD83C\uDDFB(?:\uD83C[\uDDE6\uDDE8\uDDEA\uDDEC\uDDEE\uDDF3\uDDFA])|\uD83C\uDDFA(?:\uD83C[\uDDE6\uDDEC\uDDF2\uDDF3\uDDF8\uDDFE\uDDFF])|\uD83C\uDDF9(?:\uD83C[\uDDE6\uDDE8\uDDE9\uDDEB-\uDDED\uDDEF-\uDDF4\uDDF7\uDDF9\uDDFB\uDDFC\uDDFF])|\uD83C\uDDF8(?:\uD83C[\uDDE6-\uDDEA\uDDEC-\uDDF4\uDDF7-\uDDF9\uDDFB\uDDFD-\uDDFF])|\uD83C\uDDF7(?:\uD83C[\uDDEA\uDDF4\uDDF8\uDDFA\uDDFC])|\uD83C\uDDF5(?:\uD83C[\uDDE6\uDDEA-\uDDED\uDDF0-\uDDF3\uDDF7-\uDDF9\uDDFC\uDDFE])|\uD83C\uDDF3(?:\uD83C[\uDDE6\uDDE8\uDDEA-\uDDEC\uDDEE\uDDF1\uDDF4\uDDF5\uDDF7\uDDFA\uDDFF])|\uD83C\uDDF2(?:\uD83C[\uDDE6\uDDE8-\uDDED\uDDF0-\uDDFF])|\uD83C\uDDF1(?:\uD83C[\uDDE6-\uDDE8\uDDEE\uDDF0\uDDF7-\uDDFB\uDDFE])|\uD83C\uDDF0(?:\uD83C[\uDDEA\uDDEC-\uDDEE\uDDF2\uDDF3\uDDF5\uDDF7\uDDFC\uDDFE\uDDFF])|\uD83C\uDDEF(?:\uD83C[\uDDEA\uDDF2\uDDF4\uDDF5])|\uD83C\uDDEE(?:\uD83C[\uDDE8-\uDDEA\uDDF1-\uDDF4\uDDF6-\uDDF9])|\uD83C\uDDED(?:\uD83C[\uDDF0\uDDF2\uDDF3\uDDF7\uDDF9\uDDFA])|\uD83C\uDDEC(?:\uD83C[\uDDE6\uDDE7\uDDE9-\uDDEE\uDDF1-\uDDF3\uDDF5-\uDDFA\uDDFC\uDDFE])|\uD83C\uDDEB(?:\uD83C[\uDDEE-\uDDF0\uDDF2\uDDF4\uDDF7])|\uD83C\uDDEA(?:\uD83C[\uDDE6\uDDE8\uDDEA\uDDEC\uDDED\uDDF7-\uDDFA])|\uD83C\uDDE9(?:\uD83C[\uDDEA\uDDEC\uDDEF\uDDF0\uDDF2\uDDF4\uDDFF])|\uD83C\uDDE8(?:\uD83C[\uDDE6\uDDE8\uDDE9\uDDEB-\uDDEE\uDDF0-\uDDF5\uDDF7\uDDFA-\uDDFF])|\uD83C\uDDE7(?:\uD83C[\uDDE6\uDDE7\uDDE9-\uDDEF\uDDF1-\uDDF4\uDDF6-\uDDF9\uDDFB\uDDFC\uDDFE\uDDFF])|\uD83C\uDDE6(?:\uD83C[\uDDE8-\uDDEC\uDDEE\uDDF1\uDDF2\uDDF4\uDDF6-\uDDFA\uDDFC\uDDFD\uDDFF])|[#\*0-9]\uFE0F\u20E3|(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])(?:\uD83C[\uDFFB-\uDFFF])|(?:\u26F9|\uD83C[\uDFCB\uDFCC]|\uD83D\uDD75)(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])|\uD83C\uDFF4|(?:[\u270A\u270B]|\uD83C[\uDF85\uDFC2\uDFC7]|\uD83D[\uDC42\uDC43\uDC46-\uDC50\uDC66\uDC67\uDC6B-\uDC6D\uDC72\uDC74-\uDC76\uDC78\uDC7C\uDC83\uDC85\uDCAA\uDD7A\uDD95\uDD96\uDE4C\uDE4F\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1C\uDD1E\uDD1F\uDD30-\uDD34\uDD36\uDD77\uDDB5\uDDB6\uDDBB\uDDD2-\uDDD5])(?:\uD83C[\uDFFB-\uDFFF])|(?:[\u261D\u270C\u270D]|\uD83D[\uDD74\uDD90])(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])|[\u270A\u270B]|\uD83C[\uDF85\uDFC2\uDFC7]|\uD83D[\uDC08\uDC15\uDC3B\uDC42\uDC43\uDC46-\uDC50\uDC66\uDC67\uDC6B-\uDC6D\uDC72\uDC74-\uDC76\uDC78\uDC7C\uDC83\uDC85\uDCAA\uDD7A\uDD95\uDD96\uDE4C\uDE4F\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1C\uDD1E\uDD1F\uDD30-\uDD34\uDD36\uDD77\uDDB5\uDDB6\uDDBB\uDDD2-\uDDD5]|\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD]|\uD83D\uDC6F|\uD83E[\uDD3C\uDDDE\uDDDF]|[\u231A\u231B\u23E9-\u23EC\u23F0\u23F3\u25FD\u25FE\u2614\u2615\u2648-\u2653\u267F\u2693\u26A1\u26AA\u26AB\u26BD\u26BE\u26C4\u26C5\u26CE\u26D4\u26EA\u26F2\u26F3\u26F5\u26FA\u26FD\u2705\u2728\u274C\u274E\u2753-\u2755\u2757\u2795-\u2797\u27B0\u27BF\u2B1B\u2B1C\u2B50\u2B55]|\uD83C[\uDC04\uDCCF\uDD8E\uDD91-\uDD9A\uDE01\uDE1A\uDE2F\uDE32-\uDE36\uDE38-\uDE3A\uDE50\uDE51\uDF00-\uDF20\uDF2D-\uDF35\uDF37-\uDF7C\uDF7E-\uDF84\uDF86-\uDF93\uDFA0-\uDFC1\uDFC5\uDFC6\uDFC8\uDFC9\uDFCF-\uDFD3\uDFE0-\uDFF0\uDFF8-\uDFFF]|\uD83D[\uDC00-\uDC07\uDC09-\uDC14\uDC16-\uDC3A\uDC3C-\uDC3E\uDC40\uDC44\uDC45\uDC51-\uDC65\uDC6A\uDC79-\uDC7B\uDC7D-\uDC80\uDC84\uDC88-\uDCA9\uDCAB-\uDCFC\uDCFF-\uDD3D\uDD4B-\uDD4E\uDD50-\uDD67\uDDA4\uDDFB-\uDE44\uDE48-\uDE4A\uDE80-\uDEA2\uDEA4-\uDEB3\uDEB7-\uDEBF\uDEC1-\uDEC5\uDED0-\uDED2\uDED5-\uDED7\uDEEB\uDEEC\uDEF4-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0D\uDD0E\uDD10-\uDD17\uDD1D\uDD20-\uDD25\uDD27-\uDD2F\uDD3A\uDD3F-\uDD45\uDD47-\uDD76\uDD78\uDD7A-\uDDB4\uDDB7\uDDBA\uDDBC-\uDDCB\uDDD0\uDDE0-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6]|(?:[\u231A\u231B\u23E9-\u23EC\u23F0\u23F3\u25FD\u25FE\u2614\u2615\u2648-\u2653\u267F\u2693\u26A1\u26AA\u26AB\u26BD\u26BE\u26C4\u26C5\u26CE\u26D4\u26EA\u26F2\u26F3\u26F5\u26FA\u26FD\u2705\u270A\u270B\u2728\u274C\u274E\u2753-\u2755\u2757\u2795-\u2797\u27B0\u27BF\u2B1B\u2B1C\u2B50\u2B55]|\uD83C[\uDC04\uDCCF\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01\uDE1A\uDE2F\uDE32-\uDE36\uDE38-\uDE3A\uDE50\uDE51\uDF00-\uDF20\uDF2D-\uDF35\uDF37-\uDF7C\uDF7E-\uDF93\uDFA0-\uDFCA\uDFCF-\uDFD3\uDFE0-\uDFF0\uDFF4\uDFF8-\uDFFF]|\uD83D[\uDC00-\uDC3E\uDC40\uDC42-\uDCFC\uDCFF-\uDD3D\uDD4B-\uDD4E\uDD50-\uDD67\uDD7A\uDD95\uDD96\uDDA4\uDDFB-\uDE4F\uDE80-\uDEC5\uDECC\uDED0-\uDED2\uDED5-\uDED7\uDEEB\uDEEC\uDEF4-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0C-\uDD3A\uDD3C-\uDD45\uDD47-\uDD78\uDD7A-\uDDCB\uDDCD-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6])|(?:[#\*0-9\xA9\xAE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9\u21AA\u231A\u231B\u2328\u23CF\u23E9-\u23F3\u23F8-\u23FA\u24C2\u25AA\u25AB\u25B6\u25C0\u25FB-\u25FE\u2600-\u2604\u260E\u2611\u2614\u2615\u2618\u261D\u2620\u2622\u2623\u2626\u262A\u262E\u262F\u2638-\u263A\u2640\u2642\u2648-\u2653\u265F\u2660\u2663\u2665\u2666\u2668\u267B\u267E\u267F\u2692-\u2697\u2699\u269B\u269C\u26A0\u26A1\u26A7\u26AA\u26AB\u26B0\u26B1\u26BD\u26BE\u26C4\u26C5\u26C8\u26CE\u26CF\u26D1\u26D3\u26D4\u26E9\u26EA\u26F0-\u26F5\u26F7-\u26FA\u26FD\u2702\u2705\u2708-\u270D\u270F\u2712\u2714\u2716\u271D\u2721\u2728\u2733\u2734\u2744\u2747\u274C\u274E\u2753-\u2755\u2757\u2763\u2764\u2795-\u2797\u27A1\u27B0\u27BF\u2934\u2935\u2B05-\u2B07\u2B1B\u2B1C\u2B50\u2B55\u3030\u303D\u3297\u3299]|\uD83C[\uDC04\uDCCF\uDD70\uDD71\uDD7E\uDD7F\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01\uDE02\uDE1A\uDE2F\uDE32-\uDE3A\uDE50\uDE51\uDF00-\uDF21\uDF24-\uDF93\uDF96\uDF97\uDF99-\uDF9B\uDF9E-\uDFF0\uDFF3-\uDFF5\uDFF7-\uDFFF]|\uD83D[\uDC00-\uDCFD\uDCFF-\uDD3D\uDD49-\uDD4E\uDD50-\uDD67\uDD6F\uDD70\uDD73-\uDD7A\uDD87\uDD8A-\uDD8D\uDD90\uDD95\uDD96\uDDA4\uDDA5\uDDA8\uDDB1\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDE8\uDDEF\uDDF3\uDDFA-\uDE4F\uDE80-\uDEC5\uDECB-\uDED2\uDED5-\uDED7\uDEE0-\uDEE5\uDEE9\uDEEB\uDEEC\uDEF0\uDEF3-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0C-\uDD3A\uDD3C-\uDD45\uDD47-\uDD78\uDD7A-\uDDCB\uDDCD-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6])\uFE0F|(?:[\u261D\u26F9\u270A-\u270D]|\uD83C[\uDF85\uDFC2-\uDFC4\uDFC7\uDFCA-\uDFCC]|\uD83D[\uDC42\uDC43\uDC46-\uDC50\uDC66-\uDC78\uDC7C\uDC81-\uDC83\uDC85-\uDC87\uDC8F\uDC91\uDCAA\uDD74\uDD75\uDD7A\uDD90\uDD95\uDD96\uDE45-\uDE47\uDE4B-\uDE4F\uDEA3\uDEB4-\uDEB6\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1F\uDD26\uDD30-\uDD39\uDD3C-\uDD3E\uDD77\uDDB5\uDDB6\uDDB8\uDDB9\uDDBB\uDDCD-\uDDCF\uDDD1-\uDDDD])/';

  final _form = GlobalKey<FormState>();
  late String birthDateInString;
  var selectedDate = DateTime.now();
  bool isDateSelected = true;

  String? _ratingprofile;
  String date = "";
  TimeOfDay selectedTime = TimeOfDay.now();
  String? selectedValue;
  List<String> neutre = [
    'Male',
    'Female',
  ];
  bool ganderSelcted = false;
  bool optionSelcted = false;
  bool nextPressed = false;
  bool isShowToast = false;
  bool sentOTPVerify = false;
  String? toastMsg;
  TextEditingController _name = TextEditingController();
  TextEditingController _middlename = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _refer = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  final pinController = TextEditingController();
  bool? isCompleteRegister;
  FocusNode fname = FocusNode();
  FocusNode mname = FocusNode();
  FocusNode lname = FocusNode();
  FocusNode email = FocusNode();
  FocusNode gender = FocusNode();
  FocusNode dob = FocusNode();
  FocusNode profile = FocusNode();
  FocusNode refer = FocusNode();
  bool? isSocialLogin = false;

  getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      isSocialLogin = pref.getBool(SOCIAL_GOOGLE);
      print("social login ::: $isSocialLogin");
      if (isSocialLogin == true) {
        _name.text = pref.getString(FIRST_NAME)!;
        _lastname.text = pref.getString(LAST_NAME)!;
        _email.text = pref.getString(EMAIL)!;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    print("mobile no :::: ${widget.userNumber}");
    print(widget.userNumber);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        isCompleteRegister = _prefs.getBool(SHOWPERSONALDETAILS) ?? null;

        // if (isCompleteRegister == false) {
        Fluttertoast.showToast(
                timeInSecForIosWeb: 60,
                backgroundColor: currentColor,
                msg: "Kindly re open the app to continue where you left")
            .then((value) {
          Future.delayed(Duration(seconds: 2), () {
            SystemNavigator.pop();
          });
        });
        // SystemNavigator.pop();
        /*  } else {
          Navigator.pop(context);
        } */
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        appBar: AppBar(
          backgroundColor: Color(0xffE5E5E5),
          elevation: 0,
          leading: GestureDetector(
            onTap: () async {
              SharedPreferences _prefs = await SharedPreferences.getInstance();
              isCompleteRegister = _prefs.getBool(SHOWPERSONALDETAILS) ?? null;

              // if (isCompleteRegister == false) {
              Fluttertoast.showToast(
                      timeInSecForIosWeb: 60,
                      msg: "Kindly re open the app to continue where you left")
                  .then((value) {
                Future.delayed(Duration(seconds: 2), () {
                  SystemNavigator.pop();
                });
              });

              /* } else {
                Navigator.pop(context);
              } */
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                ImagePath.leftArrow,
                height: 25,
                width: 25,
                color: Color(0xff2C3E50),
              ),
            ),
          ),
          title: Text(
            AppConstants.personal,
            style: fontStyle.copyWith(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      onTap: () {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field can't empty";
                        }
                        return null;
                      },
                      readOnly: (isSocialLogin == true) ? true : false,
                      controller: _name,
                      keyboardType: TextInputType.name,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp("[A-Za-z \s]"),
                        ),
                      ],
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 232, 15, 15),
                              width: 1.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide:
                              BorderSide(color: Color(0xffd1d1d1), width: 1.5),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide:
                              BorderSide(color: Color(0xffD1D1D1), width: 1.5),
                        ),
                        border: OutlineInputBorder(),
                        labelText: "First Name",
                        labelStyle: fontStyle.copyWith(
                            color: Color(0xff777777),
                            fontWeight: FontWeight.w500),
                        hintText: "Enter your first name here",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          ImagePath.optionaL,
                          width: 14,
                          height: 14,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "Optional",
                          style: fontStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff838994),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: _middlename,
                      keyboardType: TextInputType.name,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp("[A-Za-z \s]"),
                        ),
                      ],
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 232, 15, 15),
                              width: 1.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide:
                              BorderSide(color: Color(0xffd1d1d1), width: 1.5),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide:
                              BorderSide(color: Color(0xffD1D1D1), width: 1.5),
                        ),
                        border: OutlineInputBorder(),
                        labelText: "Middle Name",
                        labelStyle: fontStyle.copyWith(
                            color: Color(0xff777777),
                            fontWeight: FontWeight.w500),
                        hintText: "Enter your middle name here",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 29,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This field can't empty";
                        }
                      },
                      readOnly: (isSocialLogin == true) ? true : false,
                      controller: _lastname,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp("[A-Za-z \s]"),
                        ),
                      ],
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 232, 15, 15),
                              width: 1.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide:
                              BorderSide(color: Color(0xffd1d1d1), width: 1.5),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide:
                              BorderSide(color: Color(0xffD1D1D1), width: 1.5),
                        ),
                        border: OutlineInputBorder(),
                        labelText: "Last Name",
                        labelStyle: fontStyle.copyWith(
                            color: Color(0xff777777),
                            fontWeight: FontWeight.w500),
                        hintText: "Enter your last name here",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 29,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[a-zA-Z0-9@\.]")),
                      ],
                      validator: (value) {
                        if (!RegExp(
                                r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                            .hasMatch(value!)) {
                          return "Please enter a valid email address";
                        }

                        return null;
                      },
                      readOnly: (isSocialLogin == true) ? true : false,
                      controller: _email,
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
                          borderSide:
                              BorderSide(color: Color(0xffd1d1d1), width: 1.5),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide:
                              BorderSide(color: Color(0xffD1D1D1), width: 1.5),
                        ),
                        border: OutlineInputBorder(),
                        labelText: "E-Mail",
                        labelStyle: fontStyle.copyWith(
                            color: Color(0xff777777),
                            fontWeight: FontWeight.w500),
                        hintText: "Enter your email here",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 29,
                  ),
                  (isSocialLogin == true)
                      ? Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter a mobile number";
                              }
                              if (value.length < 10) {
                                return "Phone Number Should be of 10 Digit";
                              }

                              return null;
                            },
                            onChanged: (value) {
                              if (_form.currentState!.validate()) ;
                            },
                            controller: _mobile,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              suffixIcon: (sentOTPVerify)
                                  ? InkWell(
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Container(
                                            height: 25,
                                            width: 68,
                                            decoration: BoxDecoration(
                                                color: (sentOTPVerify)
                                                    ? Colors.green
                                                    : currentColor,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            alignment: Alignment.center,
                                            child: Text(
                                              (sentOTPVerify)
                                                  ? "Verified"
                                                  : "Verify",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            )),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        if (_mobile.text.isNotEmpty) {
                                          verifyMobileAPI();
                                        } else {
                                          if (_form.currentState!.validate()) ;
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Container(
                                            height: 25,
                                            width: 68,
                                            decoration: BoxDecoration(
                                                color: currentColor,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Verify",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ),
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
                              focusedErrorBorder: OutlineInputBorder(
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
                              border: OutlineInputBorder(),
                              labelText: "Mobile Number",
                              labelStyle: fontStyle.copyWith(
                                  color: Color(0xff777777),
                                  fontWeight: FontWeight.w500),
                              hintText: "Enter your mobile number here",
                            ),
                          ),
                        )
                      : Container(),
                  (nextPressed && !sentOTPVerify && isSocialLogin == true)
                      ? Padding(
                          padding: const EdgeInsets.only(left: 35, top: 6),
                          child: Text(
                            "please verify your mobile number",
                            style: TextStyle(
                              color: Theme.of(context).errorColor,
                              fontSize: 12,
                            ),
                          ),
                        )
                      : Container(),
                  /* Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Pinput(
                      controller: pinController,
                      length: 6,
                      cursor: Container(
                        height: 19.87,
                        width: 2,
                        color: Color(0xff57606F).withOpacity(0.1),
                      ),
                      showCursor: true,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      submittedPinTheme: PinTheme(
                        width: 52,
                        height: 48,
                        textStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                        decoration: BoxDecoration(
                          color: currentColor,
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 52,
                        height: 48,
                        textStyle: TextStyle(color: Colors.white),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 19,
                                color: Color(0xff051B28).withOpacity(.09),
                                offset: Offset(5.0, 5.0))
                          ],
                          color: Colors.white,
                          border: Border.all(
                            color: Color(0xff79244D).withOpacity(0.23),
                          ),
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                      defaultPinTheme: PinTheme(
                        width: 52,
                        height: 48,
                        textStyle: TextStyle(color: Colors.white),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Color(0xff79244D).withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                    ),
                  ), */
                  (isSocialLogin == true)
                      ? SizedBox(
                          height: 29,
                        )
                      : Container(),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      readOnly: true,
                      controller: _dob,
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            ImagePath.calendar,
                            width: 21,
                            height: 24,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide:
                              BorderSide(color: Color(0xffD1D1D1), width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide:
                              BorderSide(color: Color(0xffD1D1D1), width: 1.5),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: AppConstants.birthdate,
                        hintStyle: TextStyle(
                            color: Color(0xff757885),
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                        label: Text(
                          AppConstants.dateOfBirth,
                          style: headerstyle.copyWith(
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                      onTap: () async {
                        DateTime? date = DateTime.now();
                        FocusScope.of(context).requestFocus(new FocusNode());
                        date = (await DatePicker.showSimpleDatePicker(context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1972),
                            lastDate:
                                DateTime(date.year - 18, date.month, date.day),
                            dateFormat: 'dd-MMM-yyyy',
                            locale: DateTimePickerLocale.en_us,
                            looping: false,
                            itemTextStyle: TextStyle(color: Color(0xff000000)),
                            textColor: Color(0xffFA2457)));

                        _dob.text = DateFormat('dd-MMM-yyyy').format(date!);
                        log(_dob.text);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18),
                    child: Text("Gender",
                        style: fontStyle.copyWith(
                            color: Color(0xff777777),
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: nextPressed && !ganderSelcted
                                  ? Theme.of(context).errorColor
                                  : Color(0xffD1D1D1),
                              width: 1.5),
                          borderRadius: BorderRadius.circular(13)),
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          focusColor: Colors.white,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          icon: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              height: 15,
                              width: 15,
                              child: Center(
                                child: Image.asset(
                                  ImagePath.forward,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                            ),
                          ),
                          hint: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Select your gender',
                              style: fontStyle.copyWith(
                                  color: Color(0xff777777),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          itemHeight: 20,
                          items: getDropdown()
                              .addDividersAfterItems(['Male', 'Female']),
                          customItemsIndexes: getDropdown()
                              .getDividersIndexes(['Male', 'Female']),
                          value: genderSelecter,
                          onChanged: (value) async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();

                            setState(() {
                              ganderSelcted = true;
                              genderSelecter = value as String?;
                            });
                            pref.setString(SELECTGENDER, genderSelecter!);
                          },
                        ),
                      ),
                    ),
                  ),
                  nextPressed && !ganderSelcted
                      ? Container(
                          margin: EdgeInsets.only(left: 35, top: 8),
                          child: Text(
                            "please add your gender",
                            style: TextStyle(
                              color: Theme.of(context).errorColor,
                              fontSize: 12,
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18),
                    child: Text("Profile Created by",
                        style: fontStyle.copyWith(
                            color: Color(0xff777777),
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: nextPressed && !optionSelcted
                                  ? Theme.of(context).errorColor
                                  : Color(0xffD1D1D1),
                              width: 1.5),
                          borderRadius: BorderRadius.circular(13)),
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          focusColor: Colors.white,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          icon: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              height: 15,
                              width: 15,
                              child: Center(
                                child: Image.asset(
                                  ImagePath.forward,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                            ),
                          ),
                          hint: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Select your Option",
                              style: fontStyle.copyWith(
                                  color: Color(0xff777777),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          dropdownMaxHeight: 200,
                          itemHeight: 20,
                          items: getDropdown().addDividersAfterItems([
                            'Myself',
                            'Sister',
                            'Brother',
                            'Relative',
                            'Friend',
                          ]),
                          customItemsIndexes: getDropdown().getDividersIndexes([
                            'Myself',
                            'Sister',
                            'Brother',
                            'Relative',
                            'Friend',
                          ]),
                          customItemsHeight: 4,
                          value: _ratingprofile,
                          onChanged: (value) {
                            setState(() {
                              optionSelcted = true;
                              _ratingprofile = value as String?;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  nextPressed && !optionSelcted
                      ? Container(
                          margin: EdgeInsets.only(left: 35, top: 8),
                          child: Text(
                            "please add your option",
                            style: TextStyle(
                              color: Theme.of(context).errorColor,
                              fontSize: 12,
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          ImagePath.optionaL,
                          width: 14,
                          height: 14,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "Optional",
                          style: fontStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff838994),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        controller: _refer,
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
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(
                                color: Color(0xffD1D1D1), width: 1.5),
                          ),
                          border: OutlineInputBorder(),
                          labelText: "Refer by",
                          labelStyle: fontStyle.copyWith(
                              color: Color(0xff777777),
                              fontWeight: FontWeight.w500),
                          hintText: "Enter your Reference code",
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  (isShowToast)
                      ? Center(
                          child: Container(
                            height: 40,
                            width: width - 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: currentColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              toastMsg.toString(),
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: CommonButton(
                        btnName: "Next",
                        btnOnTap: () {
                          setState(() {
                            nextPressed = true;
                            if (_form.currentState!.validate() &&
                                    ganderSelcted &&
                                    optionSelcted ||
                                sentOTPVerify) {
                              checkConnection();
                            } else {}
                          });
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _textField(
    TextEditingController _controller,
    String hinttext,
    String lableName,
    FocusNode _focusenode,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "This field can't empty";
          }
        },
        controller: _controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide:
                BorderSide(color: Color.fromARGB(255, 232, 15, 15), width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(color: Color(0xffd1d1d1), width: 1.5),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(color: Color(0xffD1D1D1), width: 1.5),
          ),
          border: OutlineInputBorder(),
          labelText: lableName,
          labelStyle: fontStyle.copyWith(
              color: Color(0xff777777), fontWeight: FontWeight.w500),
          hintText: hinttext,
        ),
      ),
    );
  }

  _textformField(
    TextEditingController _controller,
    String hinttext,
    String lableName,
    Widget image,
  ) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: TextFormField(
              controller: _controller,
              validator: (value) {
                if (value!.isEmpty) {
                  return '* Please Fill Details';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(color: Color(0xffd1d1d1), width: 1.5),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(color: Color(0xffD1D1D1), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(color: Color(0xffD1D1D1), width: 1.5),
                ),
                suffixIcon: image,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                border: InputBorder.none,
                hintText: hinttext,
                label: Text(
                  lableName,
                  style: fontStyle.copyWith(
                      color: Color(0xff777777), fontWeight: FontWeight.w500),
                ),
                alignLabelWithHint: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      personaldetailsApi();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      personaldetailsApi();
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

  personaldetailsApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CommonUtils.showProgressLoading(context);
    log("social register ::: $isSocialLogin");

    final msg = {
      "mobile": (isSocialLogin == false || isSocialLogin == null)
          ? widget.userNumber
          : _mobile.text,
      "firstname": _name.text.toString(),
      "middlename": _middlename.text.toString(),
      "lastname": _lastname.text.toString(),
      "dob": _dob.text.toString(),
      "gender": genderSelecter,
      "referBy": _refer.text.toString(),
      "email": _email.text.toString(),
      "createdBy": _ratingprofile,
      "provider":
          (isSocialLogin == false || isSocialLogin == null) ? "" : "google"
    };
    log("Registration Payload :: $msg");
    var response = await http.post(
      Uri.parse(PERSONAL_DETAILS_URL),
      body: msg,
    );
    print("data dta tatagdsddds");
    print(response.body);
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      CommonUtils.hideProgressLoading();
      if (result["success"] == true) {
        PersonalDetails _personaldetailSuccess =
            PersonalDetails.fromJson(result);
        prefs.setBool(SHOWPERSONALDETAILS, true);
        prefs.setString(
            USER_TOKEN, _personaldetailSuccess.data!.token.toString());

        /// ----------- firebase chat module start -----------
        /* prefs.setString(
            FULLNAME, _personaldetailSuccess.data!.firstname.toString());
        String userId = await prefs.getString(USER_ID)!;
        FirebaseFirestore firestore = FirebaseFirestore.instance;

        await firestore
            .collection("Users")
            .doc(result["data"]["user_id"].toString())
            .set({
          "userId": result["data"]["user_id"].toString(),
          "userName": _personaldetailSuccess.data!.firstname,
          "userProfile": "",
        }).then(
          (value) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen2(
                  userNumber: widget.userNumber,
                  docId: result["data"]["user_id"].toString()),
            ),
          ),
        ); */

        /// ----------- firebase chat module end -----------

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => /* DetailScreen2 */ UploadImages(
                  userNumber: widget.userNumber),
            ),
            (route) => false);
      } else {
        print("error part");

        log(result['message']);
      }
    } else if (response.statusCode == 500) {
      CommonUtils.hideProgressLoading();
      Fluttertoast.showToast(
          msg: "Internal Server Error",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: currentColor,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      var data = jsonDecode(response.body);
      setState(() {
        isShowToast = true;
      });
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          isShowToast = false;
        });
      });
      toastMsg = data['message'];
      CommonUtils.hideProgressLoading();
    }
  }

  verifyMobileAPI() async {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(USER_TOKEN);
    var userId = pref.getString(USER_ID);
    final queryParameters = {
      "token": token.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var params = {"user_id": userId, "mobile": _mobile.text};
    var response =
        await dio.post(VERIFY_MOBILE_URL + "?" + queryString, data: params);
    if (response.statusCode == 200) {
      var res = response.data;
      setState(() {
        sentOTPVerify = true;
      });
      log("verify mobile no resposne:::: ${response.data} ");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OTPScreen(
                  text: "123456",
                  mobile: _mobile.text,
                  email: _email.text,
                  fromValue: "isRegister")));
      print("verify mobile no ::::: ${res['message']}");
    }
  }
}
