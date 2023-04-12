import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:juztelectronics/consts/consts.dart';
import 'package:juztelectronics/controllers/auth_controller.dart';
import 'package:juztelectronics/controllers/profile_controller.dart';
import 'package:juztelectronics/services/firestore_services.dart';
import 'package:juztelectronics/views/chat_screen/messaging_screen.dart';
import 'package:juztelectronics/views/wishlist_screen/wishlist_screen.dart';
import 'package:juztelectronics/widgets_common/bg_widget.dart';
import 'package:juztelectronics/views/profile_screen/edit_profile_screen.dart';
import 'package:juztelectronics/widgets_common/loading_indicator.dart';
import '../../consts/lists.dart';
import '../auth_screen/login_screen.dart';
import '../orders_screen/orders_screen.dart';
import 'components/details_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  get data => null;

  @override
  Widget build(BuildContext context) {


    // ignore: unused_local_variable
    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
      body: StreamBuilder(
        stream: FirestoreServices.getUser(currentUser!.uid),

        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation(redColor),
            ),
            );
          }
          else {
                var data = snapshot.data!.docs[0];
              return SafeArea(
                  child: Column(
                    children: [

                      //editprofile button
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Align(
                            alignment: Alignment.topRight,
                            child: Icon(Icons.edit, color: whiteColor)).onTap(() {
                             controller.nameController.text = data['name'];
                             //controller.passController.text = data['password'];
                              Get.to(()=> EditProfileScreen(data: data));
                        }),
                      ),
                      //user details section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            data['imageUrl']==''?


                            Image.asset(imgProfile2,width: 76,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make()
                            :
                            Image.network(data['imageUrl'],width: 76,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make(),
                            10.widthBox,
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data['name']}".text.fontFamily(semibold).white.make(),
                                "${data['email']}".text.white.make(),
                              ],
                            )),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: whiteColor,

                                  )
                              ),
                              onPressed: () async{
                                await Get.put(AuthController()).signoutMethod(context);
                                Get.offAll(() => const LoginScreen());
                              },
                              child: logout.text.fontFamily(semibold).white.make(),
                            )
                          ],
                        ),
                      ),
                      20.heightBox,

                     FutureBuilder(
                          future: FirestoreServices.getCounts(),
                         builder: (BuildContext context, AsyncSnapshot snapshot){
                           if(!snapshot.hasData){
                             return Center(child: loadingIndicator());
                           }else {
                             var countData = snapshot.data;
                             return Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 detailsCard(count: countData[0].toString(),
                                     title: "in your cart",
                                     width: context.screenWidth / 3.4),
                                 detailsCard(count: countData[1].toString(),
                                     title: "in your wishlist",
                                     width: context.screenWidth / 3.4),
                                 detailsCard(count: countData[2].toString(),
                                     title: "Orders",
                                     width: context.screenWidth / 3.4),
                               ],
                             );
                           }
                         },
                     ),

                     // Row(
                       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //children: [
                          //detailsCard(count: data['cart_count'],title: "in your cart",width: context.screenWidth/3.4),
                          //detailsCard(count: data['wishlist_count'],title: "in your wishlist",width: context.screenWidth/3.4),
                          //detailsCard(count: data['order_count'],title: "Orders",width: context.screenWidth/3.4),
                        //],
                      //),
                      //buttons section

                      ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context,index){
                          return const Divider(
                            color: lightGrey,
                          );
                        },
                        itemCount: profileButtonsList.length,
                        itemBuilder: (BuildContext context, int index){
                          return ListTile(
                            onTap: (){
                              switch(index){
                                case 0:
                                  Get.to(()=>OrdersScreen());
                                 break;
                                case 1: Get.to(()=>WishlistScreen());
                                break;
                                case 2: Get.to(()=>MessagesScreen());
                                break;
                              }
                            },
                            leading: Image.asset(profileButtonsIcon[index],width: 22,
                            ),
                            title: profileButtonsList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                          );
                        },
                      ).box.white.rounded.margin(const EdgeInsets.all(12)).padding(const EdgeInsets.symmetric(horizontal:16)).shadowSm.make().box.white.make(),
                    ],
                  ));
          }

        },
      ),
      ),
    );
  }
}
