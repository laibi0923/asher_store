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
                  title: 'review_order_date'.tr, 
                  value: DateFormat('yyyy/MM/dd  kk:mm').format(DateTime.fromMicrosecondsSinceEpoch(orderModel.orderDate!.microsecondsSinceEpoch)), 
                  isbold: false, 
                  showAddBox: false
                ),

                CartSummaryItemView(
                  title: 'review_order_no'.tr, 
                  value: orderModel.orderNumber!, 
                  isbold: false, 
                  showAddBox: false
                ),

                CartSummaryItemView(
                  title: 'review_receipient'.tr, 
                  value: '${orderModel.receipientInfo!['RECEIPIENT_NAME']}',
                  isbold: false, 
                  showAddBox: false
                ),

                CartSummaryItemView(
                  title: 'review_contact_no'.tr, 
                  value: '${orderModel.receipientInfo!['CONTACT']}',
                  isbold: false, 
                  showAddBox: false
                ),

                CartSummaryItemView(
                  title: 'review_shipping_address'.tr, 
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
                  title: 'cart_subamount'.tr, 
                  value: 'HKD\$ ${orderModel.subAmount!.toStringAsFixed(2)}', 
                  isbold: false, 
                  showAddBox: false
                ),

                CartSummaryItemView(
                  title: orderModel.discountCode!.isEmpty ? 'cart_discount'.tr : '?????????${orderModel.discountCode}???', 
                  value: '-HKD\$ ${orderModel.discountAmount!.toStringAsFixed(2)}', 
                  isbold: false, 
                  showAddBox: false
                ),

                CartSummaryItemView(
                  title: 'cart_shipping'.tr, 
                  value: 'HKD\$ ${orderModel.shippingAmount!.toStringAsFixed(2)}', 
                  isbold: false, 
                  showAddBox: false
                ),

                CartSummaryItemView(
                  title: 'cart_totalamount'.tr, 
                  value: 'HKD\$ ${orderModel.totalAmount!.toStringAsFixed(2)}', 
                  isbold: true, 
                  showAddBox: false
                ),

                CartSummaryItemView(
                  title: 'review_payment_method'.tr, 
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
                            
                            // ????????????????????????????????????, ????????????????????? (?????????)
                            orderProductModel.discount == 0 ? Container() :
                            CurrencyTextView(
                              value: orderProductModel.price!, 
                              textStyle: const TextStyle(
                                fontSize: xTextSize11,
                                decoration: TextDecoration.lineThrough
                              ),
                            ),
                            
                            //  ???????????????????????????????????????, ?????????????????????????????????
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