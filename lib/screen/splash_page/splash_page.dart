import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatelessWidget{
  const SplashPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _controller = Get.put(SplashController());
    _controller.load();

    return Scaffold(
      backgroundColor: const Color(xMainColor),
      body: Center(
        child: Text(
          appName, 
          style: GoogleFonts.alice (
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.bold
          )
        ),
      ),
    );
  }
}