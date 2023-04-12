import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:juztelectronics/consts/consts.dart';
import 'package:juztelectronics/controllers/product_controller.dart';
import 'package:juztelectronics/services/firestore_services.dart';
import 'package:juztelectronics/views/category_screen/item_details.dart';
import 'package:juztelectronics/widgets_common/bg_widget.dart';
import 'package:get/get.dart';
import '../../widgets_common/loading_indicator.dart';


class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProductController>();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title:title!.text.fontFamily(bold).white.make() ,
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getProducts(title),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
         if(!snapshot.hasData){
           return Center(
             child: loadingIndicator(),
           );
         }else if(snapshot.data!.docs.isEmpty){
           return Center(
             child: "No Products Found !".text.color(darkFontGrey).make(),
           );
         }else{
           var data = snapshot.data!.docs;

           return Container(
             padding: EdgeInsets.all(12),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 SingleChildScrollView(
                   physics: BouncingScrollPhysics(),
                   scrollDirection: Axis.horizontal,
                   child: Row(
                     children: List.generate(controller.subcat.length, (index) => "${controller.subcat[index]}".text.size(12).fontFamily(semibold).color(darkFontGrey).makeCentered().box.white.rounded.size(120, 60).margin(EdgeInsets.symmetric(horizontal: 4)).make()),
                   ),
                 ),
                 //items container

                 20.heightBox,
                 Expanded(child: GridView.builder(
                     physics: BouncingScrollPhysics(),
                     shrinkWrap: true,
                     itemCount: data.length,
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 250,mainAxisSpacing: 8,crossAxisSpacing: 8),
                     itemBuilder: (context,index){
                       return Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Image.network(
                             data[index]['p_imgs'][0],
                             height: 150,
                             width: 200,
                             fit: BoxFit.cover,
                           ),

                           "${data[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                           10.heightBox,
                           "${data[index]['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(16).make(),
                         ],
                       ).box.white.margin(EdgeInsets.symmetric(horizontal: 4)).roundedSM.outerShadowMd.padding(EdgeInsets.all(12)).make().onTap(() {
                         controller.checkIffav(data[index]);
                         Get.to(()=>ItemDetails(title: "${data[index]['p_name']}",data: data[index], ));
                       });
                     }))

               ],
             ),
           );
         }
          },
        ),
      ));
  }
}
