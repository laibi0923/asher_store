import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/auth_controller.dart';
import 'package:asher_store/controller/landing_controller.dart';
import 'package:asher_store/screen/landing_page/login.dart';
import 'package:asher_store/screen/landing_page/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  final bool displayCloseButton;
  const LandingPage({ Key? key, required this.displayCloseButton }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _landingcontroller = Get.put(LandingController());
    final _authcontroller = Get.find<AuthController>();
    _landingcontroller.tabController.index = 0;
    
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [

          Container(
            height: 70,
          ),

          Center(
            child: Text(
              appName,
              style: GoogleFonts.alice(
                fontSize: xTextSize26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.transparent,
              indicator: BoxDecoration(
                color: const Color(xMainColor),
                borderRadius: BorderRadius.circular(999)
              ),
              indicatorPadding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              labelStyle: const TextStyle(fontSize: xTextSize16),
              controller: _landingcontroller.tabController,
              tabs: _landingcontroller.tabtitle.map((e) => Tab(text: e)).toList(),
              onTap: (index) => _landingcontroller.tabOnClick(index),
            ),
          ),

          SizedBox(
            height: 350,
            child: PageView(
              controller: _landingcontroller.pageController,
              onPageChanged: (index) => _landingcontroller.onPageChange(index),
              physics: const BouncingScrollPhysics(),
              children: const [ Login(), Register() ]
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: GestureDetector(
                  onTap: () => _authcontroller.googleLogin(),
                  child: Container(
                    height: 42,
                    width: 42,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(xMainColor),
                      borderRadius: BorderRadius.circular(999)
                    ),
                    child: Image.asset('assets/icon/ic_google.png', color: Colors.white,)
                  )
                ),
              ),

              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: GestureDetector(
                  onTap: () => _authcontroller.facebookLogin(),
                  child: Container(
                    height: 42,
                    width: 42,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(xMainColor),
                      borderRadius: BorderRadius.circular(999)
                    ),
                    child: Image.asset('assets/icon/ic_facebook.png', color: Colors.white,)
                  )
                ),
              ),

            ],
          )

        ],
      ),
    );
  }
}