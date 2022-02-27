import 'package:asher_store/controller/auth_controller.dart';
import 'package:asher_store/model/user_model.dart';
import 'package:asher_store/service/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoController extends GetxController{

  final TextEditingController userNameEditingController = TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController phoneEditingController = TextEditingController();
  final TextEditingController userRecipientEditingController = TextEditingController();
  final TextEditingController unitEditingController = TextEditingController();
  final TextEditingController estateEditingController = TextEditingController();
  final TextEditingController districtEditingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final _authController = Get.put(AuthController());
    userNameEditingController.text = _authController.userModel.value!.name.toString();
    emailEditingController.text = _authController.userModel.value!.email.toString();
    phoneEditingController.text = _authController.userModel.value!.phone.toString();
    userRecipientEditingController.text = _authController.userModel.value!.recipientName.toString();
    unitEditingController.text = _authController.userModel.value!.unitAndBuilding.toString();
    estateEditingController.text = _authController.userModel.value!.estate.toString();
    districtEditingController.text = _authController.userModel.value!.district.toString();
  }

  @override
  void onClose() {
    super.onClose();
    userNameEditingController.dispose();
    emailEditingController.dispose();
    phoneEditingController.dispose();
    userRecipientEditingController.dispose();
    unitEditingController.dispose();
    estateEditingController.dispose();
    districtEditingController.dispose();
  }


  //  更新用戶資料
  void updateUserInfo(String uid){
    if(userNameEditingController.text.trim().isEmpty){
      Get.snackbar('userinfo_title'.tr, 'userinfo_erro_username'.tr, snackPosition: SnackPosition.BOTTOM);
    } else {
      UserModel userModel = UserModel(
        lastModify: Timestamp.now(),
        name: userNameEditingController.text,
        phone: phoneEditingController.text,
        recipientName: userRecipientEditingController.text,
        unitAndBuilding: unitEditingController.text,
        estate: estateEditingController.text,
        district: districtEditingController.text
      );
      FirebaseService().updateUserInfo(userModel);
    }
  }


}