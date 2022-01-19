import 'package:asher_store/controller/order_history_controller.dart';
import 'package:asher_store/model/order_product_model.dart';
import 'package:get/get.dart';

class RefundController extends GetxController{

  RxList refundProductList = <OrderProductModel>[].obs;
  final ordeHistoryController = Get.find<OrderHistoryController>();
  
  void findRefundproduct(){
    refundProductList.clear();
    for(int i = 0; i < ordeHistoryController.orderHistoryList.length; i++){
      for(int k = 0; k < ordeHistoryController.orderHistoryList[i].orderProduct!.length; k++){
        OrderProductModel orderProductModel = OrderProductModel.fromFirestore(
          ordeHistoryController.orderHistoryList[i].orderProduct[k],
        );
        if(orderProductModel.refundStatus == '已退貨'){
          refundProductList.add(orderProductModel);
        }
      }
    }
    update();
  }

}