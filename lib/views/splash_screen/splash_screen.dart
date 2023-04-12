import 'package:firebase_auth/firebase_auth.dart';
import 'package:juztelectronics/consts/consts.dart';
import 'package:juztelectronics/views/auth_screen/login_screen.dart';
import 'package:juztelectronics/widgets_common/applogo_widget.dart';
import 'package:get/get.dart';
import '../home_screen/home.dart';

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
     // Get.to(()=>const LoginScreen());
      auth.authStateChanges().listen((User? user) {
        if(user ==null && mounted){
          Get.to(()=>const LoginScreen());
        }else{
          Get.to(()=>const Home());
        }
      });
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
      backgroundColor: white,
      body: Center(
        child: Column(
          children: [
           Align (
            alignment: Alignment.topLeft,
             child: Image.asset(icSplashBg, width: 300)),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).black.make(),
            5.heightBox,
            appversion.text.black.make(),
            const Spacer(),
            credits.text.black.fontFamily(semibold).make(),
            30.heightBox,
            //splash screen done
        ],
        ),
      ),
    );
  }
}
