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
                        const Expanded(
                          child: Text(
                            '個人資料',
                            style: TextStyle(
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
                    title: '用戶電郵',
                    isPassword: false,
                    textEditingController: _userinfoController.emailEditingController,
                  ),
                  CustomizeTextField(
                    title: '用戶名稱',
                    isPassword: false,
                    textEditingController: _userinfoController.userNameEditingController,
                  ),       
                  const Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 20),
                    child: Text(
                      '送貨地址',
                      style: TextStyle(fontSize: xTextSize26, fontWeight: FontWeight.bold),
                    ),
                  ),
                  CustomizeTextField(
                    title: '收件人名稱',
                    isPassword: false,
                    textEditingController: _userinfoController.userRecipientEditingController,
                  ),
                  CustomizePhoneTextField(
                    title: '聯絡電話',
                    isPassword: false,
                    mTextEditingController: _userinfoController.phoneEditingController,
                  ),
                  CustomizeTextField(
                    title: '室 / 樓層',
                    isPassword: false,
                    textEditingController: _userinfoController.unitEditingController,
                  ),
                  CustomizeTextField(
                    title: '大廈名稱',
                    isPassword: false,
                    textEditingController: _userinfoController.estateEditingController,
                  ),
                  CustomizeTextField(
                    title: '屋苑名稱 / 地區',
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
                child: const Text('保存', style: TextStyle(fontSize: xTextSize16)),
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