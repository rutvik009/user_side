import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';

class CommonTextFieldnumber extends StatelessWidget {
  TextEditingController controller;
  FocusNode? focusenode;
  String lableName;
  String hinttext;
  int? inputlength;
  var validator;
  double padding;

  CommonTextFieldnumber(
      {Key? key,
      required this.controller,
      required this.lableName,
      required this.hinttext,
      this.inputlength,
      this.validator,
      this.focusenode,
      required this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: Padding(
        padding: EdgeInsets.only(top: padding),
        child: TextFormField(
          autofocus: false,
          validator: validator,
          focusNode: focusenode,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          controller: controller,
          inputFormatters: [
            LengthLimitingTextInputFormatter(inputlength),
            FilteringTextInputFormatter.allow(RegExp("[0-9]"))
          ],
          decoration: InputDecoration(
            focusColor: Colors.white,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: Color(0xffD1D1D1), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xffD1D1D1), width: 1.5),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            hintText: hinttext,
            hintStyle: TextStyle(
                color: Color(0xff757885),
                fontWeight: FontWeight.w500,
                fontSize: 14),
            label: Text(
              lableName,
              style: headerstyle.copyWith(
                  color: Color(0xff4D4D4D),
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
