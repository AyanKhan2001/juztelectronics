import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:juztelectronics/consts/consts.dart';
import 'package:juztelectronics/consts/lists.dart';
import 'package:juztelectronics/services/firestore_services.dart';
import 'package:juztelectronics/views/category_screen/item_details.dart';
import 'package:juztelectronics/views/home_screen/components/featured_button.dart';
import 'package:juztelectronics/widgets_common/home_buttons.dart';
import 'package:juztelectronics/widgets_common/loading_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            color: lightGrey,
            child: TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search),
                filled: true,
                fillColor: whiteColor,
                hintText: searchanything,
                hintStyle: TextStyle(color: textfieldGrey),
              ),
            ),
          ),
          10.heightBox,
         Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                //swipers brands
                VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    height: 150,
                    itemCount: slidersList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Image
                            .asset(
                          slidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make(),
                      );
                    }),
                10.heightBox,
                //deals button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(2, (index) =>
                      homeButtons(
                          height: context.screenHeight * 0.15,
                          width: context.screenWidth / 2.5,
                          icon: index == 0 ? icTodaysDeal : icFlashDeal,
                          title: index == 0 ? todayDeal : flashsale)),
                ),
                //2nd swiper
                10.heightBox,
                VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    height: 150,
                    itemCount: secondSlidersList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Image
                            .asset(
                          secondSlidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make(),
                      );
                    }),

                //category buttons
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(3, (index) =>
                      homeButtons(
                        height: context.screenHeight * 0.15,
                        width: context.screenWidth / 3.5,
                        icon: index == 0 ? icTopCategories : index == 1
                            ? icBrands
                            : icTopSeller,
                        title: index == 0 ? topCategories : index == 1
                            ? brand
                            : topSellers,
                      )),
                ),
                //featured categories
                20.heightBox,
                Align(
                    alignment: Alignment.centerLeft,
                    child: featuredCategories.text.color(darkFontGrey)
                        .size(18)
                        .fontFamily(semibold)
                        .make()),
                20.heightBox,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                child:Row(children: List.generate(3,
                        (index) => Column(
                  children: [
                    featuredButton(icon: featuredImages1[index],title: featuredTitles1[index]),
                    10.heightBox,
                    featuredButton(icon: featuredImages2[index],title: featuredTitles2[index]),
                  ],
                )).toList(),
                ),
                ),
                
                //featured product
                
                20.heightBox,
                Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: const BoxDecoration(color: cyan),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    featuredProduct.text.white.fontFamily(bold).size(18).make(),
                    10.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FutureBuilder(
                        future: FirestoreServices.getFeaturedProducts(),
                        builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: loadingIndicator(),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            return "No Featured Products".text.white
                                .makeCentered();
                          } else {
                            var featuredData = snapshot.data!.docs;
                            return Row(
                              children: List.generate(featuredData.length, (index) =>
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Image.network(featuredData[index]['p_imgs'][0],
                                        width: 130,
                                        height: 130,
                                        fit: BoxFit.cover,
                                      ),
                                      10.heightBox,
                                      "${featuredData[index]['p_name']}".text.fontFamily(
                                          semibold).color(darkFontGrey).make(),
                                      10.heightBox,
                                      "${featuredData[index]['p_price']}".numCurrency.text.color(redColor)
                                          .fontFamily(bold).size(16)
                                          .make()
                                    ],
                                  ).box.white
                                      .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                      .roundedSM
                                      .padding(const EdgeInsets.all(8))
                                      .make()),
                            );
                          }
                        }
                      ),
                    ),
                  ],
                  ),
                ),
                //Third Swiper
                20.heightBox,
                VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    height: 150,
                    itemCount: thirdSlidersList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Image
                            .asset(
                          thirdSlidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make(),
                      );
                    }),
                //all products section
                20.heightBox,
                StreamBuilder(
                    stream: FirestoreServices.allproducts(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if(!snapshot.hasData){
                        return loadingIndicator();
                      }else{
                        var allproductsdata = snapshot.data!.docs;
                       return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: allproductsdata.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 300 ),
                            itemBuilder: (context,index){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    allproductsdata[index]['p_imgs'][0],
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  const Spacer(),
                                  "${allproductsdata[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                  10.heightBox,
                                  "${allproductsdata[index]['p_price']}".text.color(redColor).fontFamily(bold).size(16).make(),
                                ],
                              ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(12)).make().onTap(() { Get.to(()=>ItemDetails(title: "${allproductsdata[index]['p_name']}",data: allproductsdata[index],
                              ));
                              });
                            });
                      }
                    },
                ),
              ],
            ),
          ),
         ),
           ],
      )),
    );
  }
}
