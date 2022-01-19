import 'dart:io';

import 'package:asher_store/service/firebase_service.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SettingController extends GetxController{

  Rx<bool> showLoading = false.obs;

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