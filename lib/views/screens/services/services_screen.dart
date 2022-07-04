import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_network/image_network.dart';
import 'package:logan/models/services_man_model.dart';
import 'package:logan/models/services_model.dart';
import 'package:logan/views/global_components/k_back_button.dart';
import 'package:logan/views/global_components/k_services_man_card.dart';
import 'package:logan/views/global_components/k_text_field.dart';
import 'package:logan/views/screens/services/service_details_screen.dart';
import 'package:logan/views/styles/b_style.dart';

import '../../../controllers/category_controller.dart';

class ServicesScreen extends StatefulWidget {
  final int catId;
  const ServicesScreen({Key? key,required this.catId}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  TextEditingController searchController = TextEditingController();
  int _currentIndex = 0;
  var categoryController=Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
    categoryController.getSubCategory(widget.catId);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.offWhite,
      appBar: AppBar(
        backgroundColor: KColor.offWhite,
        elevation: 0,
        leading: Padding(padding: const EdgeInsets.all(10), child: KBackButton(bgColor: KColor.black.withOpacity(0.1), iconColor: KColor.black)),
        centerTitle: true,
        title: Text(
          "Services",
          style: KTextStyle.headline2.copyWith(fontSize: 22, color: KColor.blueSapphire),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  KTextField(
                    prefixIcon: const Icon(Icons.search, color: KColor.black),
                    hintText: "Search",
                    controller: searchController,
                  ),
                  const SizedBox(height: 25),
                Obx(()=>  SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: List.generate(categoryController.subCategory.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: KColor.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: KColor.orange.withOpacity(0.1)),
                                  boxShadow: [BoxShadow(color: KColor.black.withOpacity(0.16), blurRadius: 6)],
                                ),
                                // child: Image.asset(
                                //   servicesCategory[index].image!,
                                //   color: _currentIndex == index ? KColor.orange : KColor.primary,
                                //   height: 23,
                                //   width: 23,
                                // ),

                                child: ImageNetwork(
                                  image: categoryController.subCategory.elementAt(index).subCategoryLogoPath,
                                  imageCache: CachedNetworkImageProvider(categoryController.subCategory.elementAt(index).subCategoryLogoPath),
                                  height: 23,
                                  width: 23,
                                  duration: 1500,
                                  curve: Curves.easeIn,
                                  onPointer: true,
                                  debugPrint: false,
                                  fullScreen: false,
                                  fitAndroidIos: BoxFit.cover,
                                  fitWeb: BoxFitWeb.cover,
                                  borderRadius: BorderRadius.circular(70),
                                  onLoading: const CircularProgressIndicator(
                                    color: Colors.indigoAccent,
                                  ),
                                  onError: const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                  onTap: () {

                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                categoryController.subCategory.elementAt(index).subCategoryName,
                                style: KTextStyle.headline2.copyWith(fontSize: 13, color: _currentIndex == index ? KColor.orange : KColor.primary),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),),

                ],
              ),
            ),
            const SizedBox(height: 10),


                ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: servicesMan.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return KServicesManCard(
                    name: servicesMan[index].name,
                    image: servicesMan[index].image,
                    color: servicesMan[index].color,
                    percent: servicesMan[index].percent,
                    date: servicesMan[index].date,
                    buttonText: "Details",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ServiceDetailsScreen(
                              name: servicesMan[index].name,
                              image: servicesMan[index].image,
                              color: servicesMan[index].color,
                              percent: servicesMan[index].percent,
                              date: servicesMan[index].date,
                              category: _currentIndex == 0
                                  ? "Plumber"
                                  : _currentIndex == 1
                                  ? "Roofers"
                                  : "Builders",
                            )),
                      );
                    },
                  );
                }),



            const SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}
