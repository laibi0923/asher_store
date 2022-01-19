import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootController extends GetxController{

  RxInt currentIndex = 0.obs;

  final PageController pageController = PageController(initialPage: 0, keepPage: false);

  Future<void> jumpToPage(int index) async {
    if(currentIndex.value != index){
      currentIndex.value = index;
      pageController.animateToPage(
        index, 
        duration: const Duration(milliseconds: 100), 
        curve: Curves.easeInOut
      );
    }
  }

  void pageViewOnPageChange(int index){
    currentIndex.value = index;
  }

}