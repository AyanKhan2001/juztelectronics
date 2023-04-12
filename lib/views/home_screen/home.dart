import 'package:flutter/material.dart';
import 'package:juztelectronics/consts/consts.dart';
import 'package:juztelectronics/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:juztelectronics/views/cart_screen/cart_screen.dart';
import 'package:juztelectronics/views/category_screen/category_screen.dart';
import 'package:juztelectronics/views/home_screen/home_screen.dart';
import 'package:juztelectronics/views/profile_screen/profile_screen.dart';
import 'package:juztelectronics/widgets_common/exit_dialog.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //init home controller
    var controller = Get.put(HomeController());
    var navbarItem = [
      BottomNavigationBarItem(icon: Image.asset(icHome, width: 26,),label: home),
      BottomNavigationBarItem(icon: Image.asset(icCategories, width: 26,),label: categories),
      BottomNavigationBarItem(icon: Image.asset(icCart, width: 26,),label: cart),
      BottomNavigationBarItem(icon: Image.asset(icProfile, width: 26,),label: account)
    ];
    var navBody=[
      HomeScreen(),
      CategoryScreen(),
      CartScreen(),
      ProfileScreen()
    ];
    return WillPopScope(
      onWillPop: ()async{
        showDialog(
            barrierDismissible: false,
            context: context, builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body:Column(
          children:[
        Obx(() => Expanded(child: navBody.elementAt(controller.currentNavIndex.value))),
        ],
        ),
        bottomNavigationBar: Obx(()=>
        BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: blue3,
            selectedLabelStyle: TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            items: navbarItem,
          onTap: (value){
              controller.currentNavIndex.value = value;
          },
        ),
      ),
      ),
    );
  }
}
