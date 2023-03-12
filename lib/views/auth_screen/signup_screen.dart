import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:juztelectronics/consts/consts.dart';
import 'package:juztelectronics/widgets_common/applogo_widget.dart';
import 'package:juztelectronics/widgets_common/bg_widget.dart';
import 'package:juztelectronics/widgets_common/custom_textfield.dart';
import 'package:juztelectronics/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:juztelectronics/consts/consts.dart';
import 'package:juztelectronics/consts/lists.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                applogoWidget(),
                10.heightBox,
                "Register to $appname".text.fontFamily(bold).white.size(18).make(),
                15.heightBox,
                Column(
                  children: [
                    customTextField(hint: nameHint,title: name),
                    customTextField(hint: emailHint,title: email),
                    customTextField(hint: passwordHint,title: password),
                    customTextField(hint: passwordHint,title: retypepassword),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(onPressed: (){}, child: forgetPass.text.make())),
                    5.heightBox,
                    //ourButton().box.width(context.screenWidth - 50).make(),
                    ourButton(color: Colors.blueGrey, title: login,textColor: whiteColor, onPress: (){})
                        .box
                        .width(context.screenWidth-50)
                        .make(),

                  ],
                ).box.white.rounded.padding(EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make()

              ],
            ),
          ),
        ));
  }
}
