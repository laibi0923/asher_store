import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/cart_controller.dart';
import 'package:asher_store/controller/category_controller.dart';
import 'package:asher_store/controller/policy_controller.dart';
import 'package:asher_store/controller/refund_controller.dart';
import 'package:asher_store/controller/setting_controller.dart';
import 'package:asher_store/controller/usercoupon_controller.dart';
import 'package:asher_store/controller/home_controller.dart';
import 'package:asher_store/controller/mailbox_controller.dart';
import 'package:asher_store/controller/order_history_controller.dart';
import 'package:asher_store/controller/product_controller.dart';
import 'package:asher_store/controller/wishlist_controller.dart';
import 'package:asher_store/localeString.dart';
import 'package:asher_store/screen/splash_page/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'controller/auth_controller.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  Stripe.merchantIdentifier = stripeMerchantIdentifier;
  await Stripe.instance.applySettings();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
    Get.put(ProductController());
    Get.put(HomeController());
    Get.put(CategoryController());
    Get.put(WishListController());
    Get.put(CartController());
    Get.put(MailboxContorller());
    Get.put(OrderHistoryController());
    Get.put(UserCouponController());
    Get.put(RefundController());
    Get.put(PolicyController());
    Get.put(SettingController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //  強制直屏
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    //  Status Bar 透明化
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));
    return GetMaterialApp(
      title: appName,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      translations: LocaleString(),
      // locale: const Locale('en', 'US'),
      locale: Get.find<SettingController>().getUserLanguageLocale(),
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        //  Appbar Style
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: xTextSize18,
              fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        //  文字浮標顏色
        textSelectionTheme: const TextSelectionThemeData(cursorColor: Color(xMainColor)),
      ),
      home: const SplashPage()
    );
  }
}