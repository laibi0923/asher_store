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
              const Center(
                child: Text(
                  '我們已發送確認電郵到閣下郵箱，\n請登入你的電郵點擊生效你的帳戶。',
                  textAlign: TextAlign.center,
                ),
              ),


              const Padding(
                padding: EdgeInsets.only(top: 100),
                child: Text('還沒有收到電郵嗎?'),
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
                  child:  const Text(
                    '重新發送確認電郵',
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