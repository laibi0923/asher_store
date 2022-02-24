import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/auth_controller.dart';
import 'package:asher_store/controller/userinfo_controller.dart';
import 'package:asher_store/widget/customize_phonetextfield.dart';
import 'package:asher_store/widget/customize_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInformation extends GetWidget<AuthController> {
  UserInformation({ Key? key }) : super(key: key);

  final _userinfoController = Get.put(UserInfoController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'user_info_titile'.tr,
                            style: const TextStyle(
                              fontSize: xTextSize26,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(Icons.close)
                        )
                      ],
                    ),
                  ),
                  CustomizeTextField(
                    isenabled: false,
                    title: 'user_info_email'.tr,
                    isPassword: false,
                    textEditingController: _userinfoController.emailEditingController,
                  ),
                  CustomizeTextField(
                    title: 'user_info_username'.tr,
                    isPassword: false,
                    textEditingController: _userinfoController.userNameEditingController,
                  ),       
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 20),
                    child: Text(
                      'user_info_shippingaddress'.tr,
                      style: const TextStyle(fontSize: xTextSize26, fontWeight: FontWeight.bold),
                    ),
                  ),
                  CustomizeTextField(
                    title: 'user_info_receipient_name'.tr,
                    isPassword: false,
                    textEditingController: _userinfoController.userRecipientEditingController,
                  ),
                  CustomizePhoneTextField(
                    title: 'user_info_contact_no'.tr,
                    isPassword: false,
                    mTextEditingController: _userinfoController.phoneEditingController,
                  ),
                  CustomizeTextField(
                    title: 'user_info_unit'.tr,
                    isPassword: false,
                    textEditingController: _userinfoController.unitEditingController,
                  ),
                  CustomizeTextField(
                    title: 'user_info_building'.tr,
                    isPassword: false,
                    textEditingController: _userinfoController.estateEditingController,
                  ),
                  CustomizeTextField(
                    title: 'user_info_district'.tr,
                    isPassword: false,
                    textEditingController: _userinfoController.districtEditingController,
                  ),
                  Container(
                    height: 200,
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(xMainColor),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19))
                ),
                child: Text('user_info_save'.tr, style: const TextStyle(fontSize: xTextSize16)),
                onPressed: () {
                  _userinfoController.updateUserInfo(controller.user.value!.uid.toString());
                  Get.back();
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}