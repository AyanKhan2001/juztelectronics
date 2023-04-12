import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juztelectronics/consts/consts.dart';
import 'package:juztelectronics/services/firestore_services.dart';
import 'package:juztelectronics/views/chat_screen/chat_screen.dart';
import 'package:juztelectronics/widgets_common/loading_indicator.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),
        builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(child: loadingIndicator(),);
          }else if(snapshot.data!.docs.isEmpty){
            return
              "No Messages Yet !".text.color(darkFontGrey).makeCentered();
          }else{
            var data =snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index){
                        return Card(
                          child: ListTile(
                            onTap: (){
                              Get.to(()=>ChatScreen(),
                                  arguments: [
                                    data[index]['friend_name'].toString(),
                                    data[index]['toId'].toString()
                                  ],
                              );
                            },
                            leading: CircleAvatar(
                              backgroundColor: cyan,
                              child: Icon(Icons.person, color: whiteColor,),
                            ),
                            title: "${data[index]['friend_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                            subtitle: "${data[index]['last_msg']}".text.make(),
                          ),
                        );
                      },
              ),)
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
