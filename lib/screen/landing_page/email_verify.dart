import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerify extends StatelessWidget {
  const EmailVerify({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final _authController = Get.put(AuthController());

    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 100),
                child: Icon(
                  Icons.mark_email_read_outlined, 
                  color: Colors.grey,
                  size: 100,
                ),
              ),
              Center(
                child: Text(
                  'email_verify_content'.tr,
                  textAlign: TextAlign.center,
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Text('email_verify_usreceivedemail'.tr),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:  const Color(xMainColor),
                    elevation: 0,
                    shape:  const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                  ),
                  onPressed: () => _authController.sendEmailVerification(),
                  child:  Text(
                    'email_verify_resendemail'.tr,
                  ),
                ),
              )
              
            ],
          ),
          Positioned(
            top: 80,
            right: 20,
            child: IconButton(
              onPressed: () => Get.back(), 
              icon: const Icon(Icons.close)
            )
          )
        ],
      ),
    );
  }
}