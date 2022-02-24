import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/auth_controller.dart';
import 'package:asher_store/controller/order_history_controller.dart';
import 'package:asher_store/model/order_product_model.dart';
import 'package:asher_store/screen/setting/revieworder.dart';
import 'package:asher_store/widget/currency_textview.dart';
import 'package:asher_store/widget/set_cachednetworkimage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';


class OrderHistory extends GetWidget<AuthController> {

  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _orderHistoryController = Get.find<OrderHistoryController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('order_history'.tr),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => Navigator.pop(context), 
              icon: const Icon(Icons.close)
            ),
          )
        ],
      ),
      body: Obx((){
        return _orderHistoryController.orderHistoryList.isEmpty ? _emptyView() :
        ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: _orderHistoryController.orderHistoryList.length,
          itemBuilder: (context, index){
            return GestureDetector(
              onTap: () => Get.to(() => ReviewOrder(orderModel: _orderHistoryController.orderHistoryList[index])),
              child: _orderItemView(index)
            );
          }
        );
      })
    );
  
  }
}

Widget _emptyView(){
  return Center(
    child: Text(
      'epmty_order_text'.tr,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.grey),
    ),
  );
}

Widget _orderItemView(int index){

  final _orderHistoryController = Get.find<OrderHistoryController>();

  return Container(
    margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
    padding: const EdgeInsets.only(left: 20, right: 20, top:20, bottom: 20),
    decoration: BoxDecoration(
      color: const Color(cGrey),
      borderRadius: BorderRadius.circular(17)
    ),
    child: Row(
      children: [
         //  Order Date & Order Number & Total Price
        Expanded(
          child: SizedBox(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('yyyy/MM/dd  kk:mm').format(DateTime.fromMicrosecondsSinceEpoch(_orderHistoryController.orderHistoryList[index].orderDate!.microsecondsSinceEpoch))
                ),
                Text(_orderHistoryController.orderHistoryList[index].orderNumber!),
                const Spacer(),
                Text(_orderHistoryController.orderHistoryList[index].orderProduct!.length.toString() + ' 件商品'),
                CurrencyTextView(
                  value: _orderHistoryController.orderHistoryList[index].totalAmount!, 
                  textStyle: const TextStyle()
                )
              ],
            ),
          ),
        ),
        // Order Image
        _orderHistoryController.orderHistoryList[index].orderProduct!.length == 1 ?
        _buildSingleImage(
          OrderProductModel.fromFirestore(
            _orderHistoryController.orderHistoryList[index].orderProduct[0],
          ).colorImage!
        ) :
        _buildMutilImage(
          OrderProductModel.fromFirestore(
            _orderHistoryController.orderHistoryList[index].orderProduct[0],
            ).colorImage!,
          OrderProductModel.fromFirestore(
            _orderHistoryController.orderHistoryList[index].orderProduct[1],
          ).colorImage!
        )
      ],
    ),
  );
}

Widget _buildSingleImage(String uri){
  return SizedBox(
    height: 90,
    width: 90,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(17),
      child: SetCachNetImage(
        imageUrl: uri,
        boxFit: BoxFit.fitWidth,
        bgColor: const Color(cGrey),
        loadingWidget: const LoadingIndicator(
          indicatorType: Indicator.lineScalePulseOutRapid,
          colors: [Color(xMainColor)],
        )
      )
    ),
  );
}

Widget _buildMutilImage(String uri1, String uri2){
  return SizedBox(
    height: 90,
    width: 90,
    child: Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: SizedBox(
            height: 80,
            width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: SetCachNetImage(
                imageUrl: uri1,
                boxFit: BoxFit.fitWidth,
                bgColor: const Color(cGrey),
                loadingWidget: const LoadingIndicator(
                  indicatorType: Indicator.lineScalePulseOutRapid,
                  colors: [Color(xMainColor)],
                )
              )
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: SizedBox(
            height: 80,
            width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: SetCachNetImage(
                imageUrl: uri2,
                boxFit: BoxFit.fitWidth,
                bgColor: const Color(cGrey),
                loadingWidget: const LoadingIndicator(
                  indicatorType: Indicator.lineScalePulseOutRapid,
                  colors: [Color(xMainColor)],
                )
              )
            ),
          ),
        ),
      ],
    ),
  );
}