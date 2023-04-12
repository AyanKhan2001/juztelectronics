import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juztelectronics/consts/consts.dart';
import 'package:juztelectronics/consts/lists.dart';
import 'package:juztelectronics/controllers/cart_controller.dart';
import 'package:juztelectronics/views/home_screen/home.dart';
import 'package:juztelectronics/widgets_common/loading_indicator.dart';

import '../../widgets_common/our_button.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<CartController>();

    return Obx(()=>
        Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          title: "Choose Payment Method".text.fontFamily(semibold).color(darkFontGrey).make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value ? Center(
            child: loadingIndicator(),
          ) :ourButton(
            onPress: () async{
              controller.placeMyOrder(orderPaymentMethod: paymentMethods[controller.paymentIndex.value],totalAmount: controller.totalP.value);

              await controller.clearCart();
              VxToast.show(context, msg: "Order placed successfully");
              Get.offAll(const Home());
            },
            color: cyan,
            textColor: whiteColor,
            title: "Place Order",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(()=>
              Column(
              children: List.generate(paymentMethodsImg.length,(index){
                return GestureDetector(
                  onTap: (){
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: controller.paymentIndex.value == index ? black : Colors.transparent,width: 4,

                      )
                    ),
                    margin: EdgeInsets.only(bottom: 8),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(paymentMethodsImg[index],width: double.infinity,
                            colorBlendMode: controller.paymentIndex.value == index ?
                            BlendMode.darken : BlendMode.color,color:controller.paymentIndex.value == index ?
                            Colors.black.withOpacity(0.4) : Colors.transparent , height: 120, fit: BoxFit.cover),
                       controller.paymentIndex.value == index ? Transform.scale(scale:1.3,
                            child: Checkbox
                              (
                                activeColor: Colors.lightGreen,
                                shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(50),),
                                value: true, onChanged: (value){}
                            ),
                       ): Container(),

                        Positioned(
                            bottom: 10,
                            right: 10,
                            child: paymentMethods[index].text.white.fontFamily(semibold).size(16).make()),



                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
