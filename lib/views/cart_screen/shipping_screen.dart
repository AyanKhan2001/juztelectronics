import 'package:get/get.dart';
import 'package:juztelectronics/consts/consts.dart';
import 'package:juztelectronics/controllers/cart_controller.dart';
import 'package:juztelectronics/views/cart_screen/payment_method.dart';
import 'package:juztelectronics/widgets_common/custom_textfield.dart';
import 'package:juztelectronics/widgets_common/our_button.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          onPress: (){
            if(controller.addressController.text.length > 10){
               Get.to(()=>PaymentMethods());
            }else{
              VxToast.show(context, msg: "Please fill the details");
            }
          },
          color: cyan,
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(hint: "Address",isPass: false,title: "Address",controller: controller.addressController),
            customTextField(hint: "City",isPass: false,title: "City", controller: controller.cityController),
            customTextField(hint: "State",isPass: false,title: "State", controller: controller.stateController),
            customTextField(hint: "Pin Code",isPass: false,title: "Postal Code", controller: controller.postalcodeController),
            customTextField(hint: "Phone",isPass: false,title: "Phone",controller: controller.phoneController),
          ],
        ),
      ),

    );
  }
}
