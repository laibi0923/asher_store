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
      Get.snackbar('退貨提示', '此貨品不能退貨', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    //  此貨品退貨申請中
    if(orderProductModel.refundStatus == '退貨申請中'){
      Get.snackbar('退貨提示', '此貨品退貨申請中，請耐心等候', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    //  此貨品已退貨
    if(orderProductModel.refundStatus == '已退貨'){
      Get.snackbar('退貨提示', '此貨品已退貨', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    //  此貨品尚未出貨
    if(orderProductModel.shippingStatus == ''){
      Get.snackbar('退貨提示', '此貨品出貨進行中', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    //  2. 跳出提示框
    bool dialogResult = await showDialog(
      context: Get.context!, 
      builder: (BuildContext context){
        return const CustomizeDialog(
          title: '退貨申請',
          content: '確定要退此貨品嗎? \n 申請後我們會以電郵形式與您了解。', 
          submitBtnText: '確定',
          cancelBtnText: '取消'
        );
      }
    );

    //  3. 當用戶選擇是
    if(dialogResult == true){

      orderModel.orderProduct![productIndex]['REFUND_STATUS'] = '退貨申請中';
      
      //  通知系統退貨
      FirebaseService().makeRefund(orderModel, orderProductModel.orderProductNo.toString());
  
      Get.back();
      Get.snackbar('退貨提示', '此貨品退貨申請成功，稍後時間會有專人與你聯絡，請耐心等候。', snackPosition: SnackPosition.BOTTOM);

    }

  }


}