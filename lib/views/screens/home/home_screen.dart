import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_network/image_network.dart';
import 'package:logan/constant/asset_path.dart';
import 'package:logan/models/categories_models.dart';
import 'package:logan/utils/extensions.dart';
import 'package:logan/views/global_components/k_vendor_brands_list_component.dart';
import 'package:logan/views/screens/services/services_screen.dart';
import 'package:logan/views/styles/b_style.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../controllers/category_controller.dart';
import '../../../controllers/coupon_controller.dart';
import '../../global_components/k_featured_carousel_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController buttonCarouselController = CarouselController();
  bool viewScreens = false;

  CategoryController categoryController=Get.put(CategoryController());
  CouponController couponController=Get.put(CouponController());
  List<Widget>?featuredCarousel=[

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.offWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: KSize.getWidth(context, 23), right: KSize.getWidth(context, 18)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: KSize.getHeight(context, 70)),
              Text(
                "Welcome shopvoo!",
                style: KTextStyle.headline4.copyWith(color: KColor.black),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Image.asset(AssetPath.location, height: 22, width: 18),
                  const SizedBox(width: 18),
                  Text(
                    "Logan, UT, USA",
                    style: KTextStyle.headline2.copyWith(color: KColor.orange, fontSize: 16),
                  )
                ],
              ),
              const SizedBox(height: 25),
              Obx(() => couponController.featuredCouponList.isNotEmpty?SizedBox(
                width: context.screenWidth,
                child: CarouselSlider(
                    carouselController: buttonCarouselController,
                    items:  List.generate(couponController.featuredCouponList.length, (index) {
                      return   KFeaturedCarouselCard(
                        percent: couponController.featuredCouponList.elementAt(index).percentageOff,
                        image: "",
                        vid:couponController.featuredCouponList.elementAt(index).vid ,

                      );
                    }),


                    options: CarouselOptions(
                      height: 157,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    )),
              ):Container(),),

              const SizedBox(height: 25),
              Text(
                "Categories",
                style: KTextStyle.headline4.copyWith(fontSize: 22, color: KColor.black),
              ),
              const SizedBox(height: 25),
              Obx(() =>
                  GridView.builder(
                  clipBehavior: Clip.none,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: viewScreens ? categoriesViewsItem.length : categoryController.allCategory.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 100,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context) => ServicesScreen(catId: categoryController.allCategory.elementAt(index).cid,)));
                        // setState(() {
                        //   if (categoriesItem[index] == categoriesItem[6]) {
                        //     Navigator.push(context, MaterialPageRoute(builder: (context) => const ServicesScreen()));
                        //   }
                        //   if (categoriesItem[index] == categoriesItem[categoriesItem.length - 1]) {
                        //     viewScreens = true;
                        //   }
                        // });
                      },
                      child: viewScreens
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: KColor.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: KColor.cornflowerBlue.withOpacity(0.1),
                              ),
                              boxShadow: [
                                BoxShadow(color: KColor.black.withOpacity(0.16), blurRadius: 4),
                              ],
                            ),


                            child: Image.asset(
                              categoriesViewsItem[index].image!,
                              height: 23,
                              width: 23,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            categoriesViewsItem[index].text!,
                            overflow: TextOverflow.ellipsis,
                            style: KTextStyle.headline2.copyWith(fontSize: 13, color: KColor.black),
                          )
                        ],
                      )
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: KColor.white,
                                shape: BoxShape.circle,
                                boxShadow: [BoxShadow(color: KColor.black.withOpacity(0.16), blurRadius: 6)]),

                            child: ImageNetwork(
                              image: categoryController.allCategory.elementAt(index).categoryLogoPath,
                              imageCache: CachedNetworkImageProvider(categoryController.allCategory.elementAt(index).categoryLogoPath),
                              height: 23,
                              width: 23,
                              duration: 1500,
                              curve: Curves.easeIn,
                              onPointer: true,
                              debugPrint: false,
                              fullScreen: false,
                              fitAndroidIos: BoxFit.cover,
                              fitWeb: BoxFitWeb.cover,
                              borderRadius: BorderRadius.circular(50),
                              onLoading: const CircularProgressIndicator(
                                color: Colors.indigoAccent,
                              ),
                              onError: const Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ServicesScreen(catId: categoryController.allCategory.elementAt(index).cid,)));
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            categoryController.allCategory[index].categoryName,
                            overflow: TextOverflow.ellipsis,
                            style: KTextStyle.headline2.copyWith(fontSize: 13, color: KColor.black),
                          )
                        ],
                      ),
                    );
                  })

              ),


              const SizedBox(height: 25),
              SizedBox(height: KSize.getHeight(context, 20)),
              const KVendorBrandsListComponent(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
