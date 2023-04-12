import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:juztelectronics/consts/consts.dart';
import 'package:juztelectronics/services/firestore_services.dart';
import 'package:juztelectronics/widgets_common/loading_indicator.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlists(),
        builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(child: loadingIndicator(),);
          }else if(snapshot.data!.docs.isEmpty){
            return
              "No Wishlist found !".text.color(darkFontGrey).makeCentered();
          }else{
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index){
                    return ListTile(
                      leading: Image.network("${data[index]['p_imgs'][0]}",
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      title:"${data[index]['p_name']}".text.fontFamily(semibold).size(16).make(),
                      subtitle: "${data[index]['p_price']}".numCurrency.text.blue900.fontFamily(semibold).make(),

                      trailing: Icon(Icons.favorite, color: Colors.redAccent,).onTap(() async{
                        await firestore.collection(productsCollection).doc(data[index].id).set({
                          'p_wishlist':FieldValue.arrayRemove([currentUser!.uid])
                        },SetOptions(merge: true));
                      }),
                    );
                  },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
