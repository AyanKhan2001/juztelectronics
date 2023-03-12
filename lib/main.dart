import 'package:juztelectronics/views/splash_screen/splash_screen.dart';
import 'package:juztelectronics/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    //we are using getx so we have to change this material app into getnmaterialapp
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
        fontFamily: regular,

      ),
      home: SplashScreen(),
    );
  }
}