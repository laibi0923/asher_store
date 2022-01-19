import 'package:asher_store/model/privatepolicy_model.dart';
import 'package:asher_store/model/refundpolicy_model.dart';
import 'package:asher_store/service/firebase_service.dart';
import 'package:get/state_manager.dart';

class PolicyController extends GetxController{

  Rx<PrivatePolicyModel> privatePolicy = PrivatePolicyModel().obs;
  Rx<RefundPolicyModel> refundPolicy = RefundPolicyModel().obs;
  
  @override
  void onInit() {
    super.onInit();
    privatePolicy.bindStream(FirebaseService().getPrivatePolicyContent);
    refundPolicy.bindStream(FirebaseService().getReturnPolicyContent);
  }

}