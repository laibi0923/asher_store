import 'package:asher_store/model/order_model.dart';
import 'package:asher_store/model/order_product_model.dart';
import 'package:asher_store/service/firebase_service.dart';
import 'package:asher_store/widget/customize_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderHistoryController extends GetxController{

  RxList orderHistoryList = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    bindOrderHistoryStream();
  }

  void bindOrderHistoryStream(){
    orderHistoryList.bindStream(FirebaseService().orderHistory);
  }

  

  Future<void> requestFundProduct(OrderModel orderModel, String docid, int productIndex) async {

    OrderProductModel orderProductModel = OrderProductModel.fromFirestore(orderModel.orderProduct![productIndex]);

    //  1.判斷貨品可否退貨或申請退貨中
    //  此貨品不能退貨
    if(orderProductModel.refundAble == false){
      Get.snackbar('refund_title'.tr, 'refund_cannot_refund'.tr, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    //  此貨品退貨申請中
    if(orderProductModel.refundStatus == '退貨申請中'){
      Get.snackbar('refund_title'.tr, 'refund_cannot_refundprocessing'.tr, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    //  此貨品已退貨
    if(orderProductModel.refundStatus == '已退貨'){
      Get.snackbar('refund_title'.tr, 'refund_cannot_refundaready'.tr, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    //  此貨品尚未出貨
    if(orderProductModel.shippingStatus == ''){
      Get.snackbar('refund_title'.tr, 'refund_cannot_onshipping'.tr, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    //  2. 跳出提示框
    bool dialogResult = await showDialog(
      context: Get.context!, 
      builder: (BuildContext context){
        return CustomizeDialog(
          title: 'refund_apply_title'.tr,
          content: 'refund_apply_content'.tr, 
          submitBtnText: 'submit_text'.tr,
          cancelBtnText: 'cancel_text'.tr
        );
      }
    );

    //  3. 當用戶選擇是
    if(dialogResult == true){

      orderModel.orderProduct![productIndex]['REFUND_STATUS'] = '退貨申請中';
      
      //  通知系統退貨
      FirebaseService().makeRefund(orderModel, orderProductModel.orderProductNo.toString());
  
      Get.back();
      Get.snackbar('refund_title'.tr, 'refund_cannot_refundprocessing1'.tr, snackPosition: SnackPosition.BOTTOM);

    }

  }


}