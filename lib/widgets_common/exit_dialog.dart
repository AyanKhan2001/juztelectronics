import 'package:flutter/services.dart';
import 'package:juztelectronics/consts/consts.dart';
import 'package:juztelectronics/widgets_common/our_button.dart';

Widget exitDialog(context){
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        Divider(),
        10.heightBox,
        "Are you sure you want to exit?".text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(color: cyan,onPress: (){
              SystemNavigator.pop();
            },textColor: black,title: "Yes"),
            ourButton(color: cyan,onPress: (){
              Navigator.pop(context);
            },textColor: black,title: "No"),
          ],
        ),
      ],
    ).box
        .color(lightGrey).padding(EdgeInsets.all(12)).rounded
        .make(),
  );
}

