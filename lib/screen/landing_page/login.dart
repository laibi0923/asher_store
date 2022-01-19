import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/auth_controller.dart';
import 'package:asher_store/controller/landing_controller.dart';
import 'package:asher_store/widget/customize_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _landingcontroller = Get.put(LandingController());
    final _authcontroller = Get.put(AuthController());
    
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        children: [

          CustomizeTextField(
            title: '電子郵件', 
            textEditingController: _landingcontroller.emailEditingController,
            maxLine: 1,
          ),

          CustomizeTextField(
            title: '密碼', 
            textEditingController: _landingcontroller.pwEditingController,
            maxLine: 1,
            isPassword: true,
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () => _authcontroller.passwordReset(_landingcontroller.emailEditingController.text.trim()),
                  child: const Text('忘記密碼')
                )
              ],
            ),
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
              onPressed: () {
                _authcontroller.signIn(
                  _landingcontroller.emailEditingController.text.trim(), 
                  _landingcontroller.pwEditingController.text.trim()
                ).then((value){
                  _landingcontroller.pwEditingController.clear();
                });
              }, 
              child: const Text(
                '登入',
              ),
            )
          )
          
        ],
      ),
    );
  }
}