import 'package:asher_store/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingController extends GetxController with GetSingleTickerProviderStateMixin{

  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController pwEditingController = TextEditingController();
  final TextEditingController firmPwEditingController = TextEditingController();
  final List<String> tabtitle = ['login_tag'.tr, 'register_tag'.tr];
  late  TabController tabController = TabController(length: tabtitle.length, vsync: this, initialIndex: 0);
  final PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    final _authController = Get.find<AuthController>();
    if(_authController.auth.currentUser != null){
      String? email = _authController.auth.currentUser?.email;
      emailEditingController.text = email.toString();
    }
  }

  @override
  void onClose() {
    super.onClose();
    emailEditingController.dispose();
    pwEditingController.dispose();
    firmPwEditingController.dispose();
    tabController.dispose();
    pageController.dispose();
  }

  void tabOnClick(int index){
    pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void onPageChange(int index){
    tabController.animateTo(index, duration: const Duration(milliseconds: 300));
  }

  

}