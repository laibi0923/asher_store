import 'package:asher_store/screen/root/root.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{

  Future<void> load() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    Get.offAll(() => const RootPage());
  }

}