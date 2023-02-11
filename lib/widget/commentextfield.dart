import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatelessWidget {
  TextEditingController controller;
  String? label;
  String hinttext;
  TextInputType? textInputType;
  FormFieldValidator? validator;
  String? suffixtext;
  bool readonly = false;
  Color? fillColors;
  bool? fill;

  double padding;
  CommonTextField(
      {Key? key,
      required this.controller,
      this.label,
      required this.hinttext,
      required this.padding,
      this.validator,
      this.suffixtext,
      this.fillColors,
      this.fill,
      required this.readonly,
      this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: padding),
      child: Container(
        height: 45,
        child: TextFormField(
          textCapitalization: TextCapitalization.words,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z , . + |\s]"))
          ],
          readOnly: readonly,
          textInputAction: TextInputAction.next,
          keyboardType: textInputType,
          controller: controller,
          validator: validator,
          onTap: () {},
          decoration: InputDecoration(
            fillColor: fillColors,
            filled: fill,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: Color(0xffD1D1D1), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xffD1D1D1), width: 1.5),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: hinttext,
            suffixText: suffixtext,
            hintStyle: TextStyle(
                color: Color(0xff757885),
                fontWeight: FontWeight.w500,
                fontSize: 14),
            /*   label: Text(
              label.toString(),
              style: headerstyle.copyWith(
                  color: Color(0xff4D4D4D),
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ), */
          ),
        ),
      ),
    );
  }
}
