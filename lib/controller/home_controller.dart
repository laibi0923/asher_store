import 'package:asher_store/model/banner_model.dart';
import 'package:asher_store/service/firebase_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  Rx<List<BannerModel>> bannerList = Rx([]);

  @override
  void onInit() {
    super.onInit();
    bannerList.bindStream(FirebaseService().getBanner);
  }

}