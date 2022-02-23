import 'dart:io';

import 'package:asher_store/service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingController extends GetxController{

  SharedPreferences? mSharedPreferences;
  Rx<bool> showLoading = false.obs;
  RxInt languageIndex = 0.obs;
  final List locale =[
    {'name':'ENGLISH','locale': const Locale('en','US')},
    {'name':'繁體中文','locale': const Locale('zh','HK')},
  ];

  @override
  void onInit() {
    super.onInit();
    setupSharedPreferences().then((value) => getUserLanguage());
  }

  Future<void> setupSharedPreferences() async {
    mSharedPreferences = await SharedPreferences.getInstance();
  }

  void getUserLanguage(){
    int currentlanguage = mSharedPreferences?.getInt('language') ?? 0;
    languageIndex.value = currentlanguage;
  }

  void setLanguage(){
    if(languageIndex.value == 0){
      mSharedPreferences?.setInt('language', 1);
      languageIndex.value = 1;
    } else {
      mSharedPreferences?.setInt('language', 0);
      languageIndex.value = 0;
    }
    Get.updateLocale(locale[languageIndex.value]['locale']);
  }

  //  用戶設置頭像
  Future<void> userImageSetting(String uid) async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null){
        return;
      } else {

        final File imageFile = File(image.path);
        showLoading.value = true;
        String uploadImagepath = await FirebaseService().uploadImage(
          'user/${FirebaseService().randomStringGender(20, true).toUpperCase()}.jpg',
          imageFile
        );
        FirebaseService().setUserPhoto(uploadImagepath).then((value){
          showLoading.value = false;
        });
        update();
      }
    } on PlatformException catch (e){
      // ignore: avoid_print
      print('Failed to pick image : $e');
    }
  }

}