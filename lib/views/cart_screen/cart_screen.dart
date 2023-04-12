import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:juztelectronics/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:juztelectronics/controllers/cart_controller.dart';
import 'package:juztelectronics/services/firestore_services.dart';
import 'package:juztelectronics/views/cart_screen/shipping_screen.dart';
import 'package:juztelectronics/widgets_common/loading_indicator.dart';
import 'package:juztelectronics/widgets_common/our_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());

    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          color: cyan,
          onPress: (){
            Get.to(()=>const ShippingDetails());
          },
          textColor: whiteColor,
          title: "Proceed To Shipping",
        ),
      ),
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping Cart".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),

        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
          } else if(snapshot.data!.docs.isEmpty){
            return Center(
              child: "Cart is Empty".text.color(darkFontGrey).make(),
            );
          }else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot = data;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                     
                      child: ListView.builder(itemCount: data.length, itemBuilder:(BuildContext context, int index){
                 return ListTile(
                   leading: Image.network("${data[index]['img']}",
                     width: 50,
                     fit: BoxFit.cover,
                   ),
                 title:"${data[index]['title']} (x${data[index]['qty']})".text.fontFamily(semibold).size(16).make(),
                   subtitle: "${data[index]['tprice']}".numCurrency.text.blue900.fontFamily(semibold).make(),
                   
                   trailing: Icon(Icons.delete, color: Colors.redAccent,).onTap(() {
                              FirestoreServices.deleteDocument(data[index].id);
                   }),
                 );
              },
              ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total Price".text.fontFamily(semibold).color(darkFontGrey).make(),
                      Obx(()=>"${controller.totalP.value}"
                          .numCurrency.text.size(19).fontFamily(bold).color(Colors.deepPurple).make()),

                    ],
                  ).box.padding(EdgeInsets.all(12)).width(context.screenWidth - 30).color(Color.fromRGBO(0, 230, 253, 0.25882352941176473)).roundedSM.make(),
                  10.heightBox,
                  //SizedBox(
                    //width: context.screenWidth - 60,
                    //child: ourButton(
                      //color: cyan,
                      //onPress: (){},
                      //textColor: whiteColor,
                      //title: "Proceed To Shipping",
                    //),
                  //),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
