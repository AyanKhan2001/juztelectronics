import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:juztelectronics/consts/consts.dart';

Widget customTextField({String? title,String? hint,controller}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(Colors.blue).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(

        decoration: InputDecoration(
          hintStyle: TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
          ),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue
            )
          )
        ),
      ),
      7.heightBox,
    ],
  );
}