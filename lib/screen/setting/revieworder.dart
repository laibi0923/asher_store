import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/order_history_controller.dart';
import 'package:asher_store/model/order_model.dart';
import 'package:asher_store/model/order_product_model.dart';
import 'package:asher_store/screen/cart/cart_summary_itemview.dart';
import 'package:asher_store/widget/currency_textview.dart';
import 'package:asher_store/widget/set_cachednetworkimage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ReviewOrder extends StatelessWidget {
  final OrderModel orderModel;
  const ReviewOrder({ Key? key, required this.orderModel }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [

                Container(height: 80,),

                CartSummaryItemView(
                  title: '訂單日期', 
                  value: DateFormat('yyyy/MM/dd  kk:mm').format(DateTime.fromMicrosecondsSinceEpoch(orderModel.orderDate!.microsecondsSinceEpoch)), 
                  isbold: false, 
                  showAddBox: false
                ),

                CartSummaryItemView(
                  title: '訂單編號', 
                  value: orderModel.orderNumber!, 
                  isbold: false, 
                  showAddBox: false
                ),

                CartSummaryItemView(
                  title: '收件人', 
                  value: '${orderModel.receipientInfo!['RECEIPIENT_NAME']}',
                  isbold: false, 
                  showAddBox: false
                ),

                CartSummaryItemView(
                  title: '聯絡電話', 
                  value: '${orderModel.receipientInfo!['CONTACT']}',
                  isbold: false, 
                  showAddBox: false
                ),

                CartSummaryItemView(
                  title: '運送地址', 
                  value: '${orderModel.receipientInfo!['UNIT_AND_BUILDING']}\n${orderModel.receipientInfo!['ESTATE']}\n${orderModel.receipientInfo!['DISTRICT']}', 
                  isbold: false, 
                  showAddBox: false
                ),

                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: orderModel.orderProduct!.length,
                  itemBuilder: (context, index){
                    return orderedProductView(
                      orderModel.orderProduct![index], 
                      orderModel.docId.toString(),
                      index
                    );
                  }
                ),

                CartSummaryItemView(
                  title: '小計', 
                  value: 'HKD\$ ${orderModel.subAmount!.toStringAsFixed(2)}', 
                  isbold: false, 
                  showAddBox: false
                ),

                CartSummaryItemView(
                  title: orderModel.discountCode!.isEmpty ? '折扣' : '折扣【${orderModel.discountCode}】', 
                  value: '-HKD\$ ${orderModel.discountAmount!.toStringAsFixed(2)}', 
                  isbold: false, 
                  showAddBox: false
                ),

                CartSummaryItemView(
                  title: '運費', 
                  value: 'HKD\$ ${orderModel.shippingAmount!.toStringAsFixed(2)}', 
                  isbold: false, 
                  showAddBox: false
                ),

                CartSummaryItemView(
                  title: '總計', 
                  value: 'HKD\$ ${orderModel.totalAmount!.toStringAsFixed(2)}', 
                  isbold: true, 
                  showAddBox: false
                ),

                CartSummaryItemView(
                  title: '支付方式', 
                  value: orderModel.paymentMothed!, 
                  isbold: false, 
                  showAddBox: false
                ),

                Container(height: 80,),

              ],
            )
          ),

          Positioned(
            top: 40,
            right: 10,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.close),
            )
          )

        ],
      ),
    );
  }

  Widget orderedProductView(Map<String, dynamic> orderProductData, String docId, int index){
  
  final _orderHistoryController = Get.find<OrderHistoryController>();
  OrderProductModel orderProductModel = OrderProductModel.fromFirestore(orderProductData);

    return InkWell(
      splashColor: Colors.transparent,
      onTap: () => _orderHistoryController.requestFundProduct(orderModel, docId, index),
      child: Container(
        height: 150,
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        decoration: const BoxDecoration(
          color: Color(cGrey),
          borderRadius: BorderRadius.all(Radius.circular(7))
        ),
        child: Row(
          children: [

            //  Product Image
            Container(
              height: 110,
              width: 110,
              margin: const EdgeInsets.only(right: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SetCachNetImage(
                  imageUrl: orderProductModel.productImage!,
                  boxFit: BoxFit.fitWidth,
                  bgColor: const Color(cGrey),
                  loadingWidget: const LoadingIndicator(
                    indicatorType: Indicator.lineScalePulseOutRapid,
                    colors: [Color(xMainColor)],
                  )
                )
              ),
            ),
            
            //  Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //  Product Name
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      orderProductModel.productName!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  const Spacer(),

                  Row(
                    children: [
                      //  Shipping Status
                      orderProductModel.shippingStatus == '' ? Container() :
                      Container(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: const Color(xMainColor),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Text(
                          orderProductModel.shippingStatus.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const Spacer(),
                      //  Refundable
                      orderProductModel.refundAble == true ? Container():
                      const Text(
                        refundableText,
                        style: TextStyle(color: Color(cPink)),
                      ),
                      //  Refund status
                      orderProductModel.refundStatus == '' ? Container() :
                      Text(
                        orderProductModel.refundStatus.toString(),
                        style: const TextStyle(color: Color(cPink)),
                      ),
                    ],
                  ),

                  const Spacer(),

                  Row(
                    children: [
                      
                      //  Product Color
                      Text(
                        '${orderProductModel.colorName} / ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      //  Product Size
                      Text(
                        orderProductModel.size!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      // Prouct Price
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children:  [
                            
                            // 判斷如商品冇特價時不顯示, 相反則顥示正價 (刪除線)
                            orderProductModel.discount == 0 ? Container() :
                            CurrencyTextView(
                              value: orderProductModel.price!, 
                              textStyle: const TextStyle(
                                fontSize: xTextSize11,
                                decoration: TextDecoration.lineThrough
                              ),
                            ),
                            
                            //  判斷如商品冇特價時顯示正價, 相反以紅色顯示特價銀碼
                            orderProductModel.discount != 0 ?
                            CurrencyTextView(
                              value: orderProductModel.discount!, 
                              textStyle: const TextStyle(
                                fontSize: xTextSize14,
                                color: Color(cPink)
                              ),
                            ) :
                            CurrencyTextView(
                              value: orderProductModel.price!, 
                              textStyle: const TextStyle()
                            )
                    
                          ],
                        ),
                      ),

                    ],
                  ),
                  
                ],
              )
            ),

          ],
        ),
      ),
    );
  }

}