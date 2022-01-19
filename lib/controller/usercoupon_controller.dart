import 'package:asher_store/model/usercoupon_model.dart';
import 'package:asher_store/service/firebase_service.dart';
import 'package:get/get.dart';

class UserCouponController extends GetxController{

  final RxList<UserCouponModel> userCouponList = <UserCouponModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    bindUserCouponStream();
  }

  void bindUserCouponStream(){
    userCouponList.bindStream(FirebaseService().getUserCouponRecord());
  }

}