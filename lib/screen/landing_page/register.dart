import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/auth_controller.dart';
import 'package:asher_store/controller/landing_controller.dart';
import 'package:asher_store/widget/customize_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Register extends StatelessWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final _landingcontroller = Get.put(LandingController());
    final _authcontroller = Get.put(AuthController());

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        children: [

          CustomizeTextField(
            title: 'register_email'.tr, 
            textEditingController: _landingcontroller.emailEditingController,
            maxLine: 1,
          ),

          CustomizeTextField(
            title: 'register_pw'.tr, 
            isPassword: true,
            textEditingController: _landingcontroller.pwEditingController,
            maxLine: 1,
          ),

          CustomizeTextField(
            title: 'register_pw2'.tr,
            isPassword: true,
            textEditingController: _landingcontroller.firmPwEditingController,
            maxLine: 1,
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child :ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(xMainColor),
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
              ),
              onPressed: () => _authcontroller.registerByEmail(
                _landingcontroller.emailEditingController.text.trim(), 
                _landingcontroller.pwEditingController.text.trim(),
                _landingcontroller.firmPwEditingController.text.trim()
              ),
              child: Text(
                'register_registertext'.tr,
              ),
            )
          )

        ],
      ),
    );
  }
}