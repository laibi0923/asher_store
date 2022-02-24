import 'package:asher_store/controller/auth_controller.dart';
import 'package:asher_store/controller/refund_controller.dart';
import 'package:asher_store/model/order_product_model.dart';
import 'package:asher_store/widget/set_cachednetworkimage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asher_store/constants.dart';
import 'package:asher_store/model/order_model.dart';
import 'package:loading_indicator/loading_indicator.dart';

class RefundHistory extends GetWidget<AuthController> {
  const RefundHistory({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _refundController = Get.find<RefundController>();
    // final _orderHistotyController = Get.find<OrderHistoryController>();

    _refundController.findRefundproduct();
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Obx((){
        
        return _refundController.refundProductList.isEmpty ? 
        Center(
          child: Text('empty_return_text'.tr),
        ) : 
        ListView.builder(
          itemCount: _refundController.refundProductList.length,
          padding: const EdgeInsets.only(left: 15, right: 15),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index){
            return _buildRefundItem(
              _refundController.ordeHistoryController.orderHistoryList[index],
              _refundController.refundProductList[index]
            );
          }
        );
      })
    );
  }

  AppBar _buildAppBar(){
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text('return_history'.tr),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () => Get.back(), 
            icon: const Icon(Icons.close)
          ),
        )
      ],
    );
  }

  Widget _buildRefundItem(OrderModel orderModel, OrderProductModel orderProductModel){
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top:20, bottom: 20),
      decoration: BoxDecoration(
        color: const Color(cGrey),
        borderRadius: BorderRadius.circular(17)
      ),
      child: Row(
        children: [
          Container(
            height: 110,
            width: 110,
            margin: const EdgeInsets.only(right: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SetCachNetImage(
                imageUrl: orderProductModel.colorImage!,
                boxFit: BoxFit.fitWidth,
                bgColor: const Color(cGrey),
                loadingWidget: const LoadingIndicator(
                  indicatorType: Indicator.lineScalePulseOutRapid,
                  colors: [Color(xMainColor)],
                )
              )
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Text('return_order_no'.tr),
                      Expanded(
                        child: Text(
                          orderModel.orderNumber!.toUpperCase(),
                          style: const TextStyle(color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      orderProductModel.productName!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  const Spacer(),
                  
                  Row(
                    children: [

                      // Product Color
                      Text(
                        '${orderProductModel.colorName} / ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      //  Product Size
                      Expanded(
                        child: Text(
                          orderProductModel.size!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      Text(
                        'return_text'.tr,
                        style: const TextStyle(color: Colors.redAccent),
                      ),

                    ],
                  ),
                  
                ],
              )
            )
          ),
        ],
      ),
    );
  }

  // Widget _buildRefundListView(BuildContext context){

  //   final _refundController = Get.find<RefundController>();
  //   final _orderHistotyController = Get.find<OrderHistoryController>();
  //   final _authController = Get.find<AuthController>();

  //   return Obx((){

  //     if(_authController.user.value != null){
  //       _refundController.findRefundproduct();
  //     }

  //     // ignore: unnecessary_null_comparison
  //     // if(_orderHistotyController.orderHistoryList == null){
  //     //   return const Center(
  //     //     child: CircularProgressIndicator()
  //     //   );
  //     // } else {
  //     //   _refundController.findRefundproduct();
  //     // }

  //     if(_refundController.refundProductList.isEmpty){
  //       return const Center(
  //         child: Text('沒有退貨紀錄'),
  //       );
  //     }

  //     return ListView.builder(
  //       itemCount: _refundController.refundProductList.length,
  //       padding: const EdgeInsets.only(left: 15, right: 15),
  //       physics: const BouncingScrollPhysics(),
  //       itemBuilder: (context, index){
  //         return _buildRefundItem(
  //           _orderHistotyController.orderHistoryList[index],
  //           _refundController.refundProductList[index]
  //         );
  //       }
  //     );
  //   });
  
  // }

}