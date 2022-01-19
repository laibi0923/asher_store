import 'package:asher_store/controller/product_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPhotoViewController extends GetxController{

  late PageController? photoViewPageController;
  
  final productDetailsController = Get.find<ProductDetailsController>();

  @override
  void onInit() {
    super.onInit();
    photoViewPageController = PageController(initialPage: productDetailsController.pageController.page!.toInt());
  }

  void getBack(){
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      return Get.back(result: photoViewPageController!.page);
    });
  }

}