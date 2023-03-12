import 'package:juztelectronics/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:juztelectronics/consts/consts.dart';
import 'package:juztelectronics/views/auth_screen/login_screen.dart';
import 'package:juztelectronics/widgets_common/applogo_widget.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //creating method to go to login page
  changeScreen(){
    Future.delayed(const Duration(seconds: 3),(){
      //using getx
      Get.to(()=>const LoginScreen());
    });
  }
  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          children: [
           Align (
            alignment: Alignment.topLeft,
             child: Image.asset(icSplashBg, width: 300)),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            const Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox,
            //splash screen done
        ],
        ),
      ),
    );
  }
}
