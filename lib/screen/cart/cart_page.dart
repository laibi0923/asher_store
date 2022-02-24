import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/auth_controller.dart';
import 'package:asher_store/controller/cart_controller.dart';
import 'package:asher_store/screen/cart/cart_itemview.dart';
import 'package:asher_store/screen/cart/cart_summary_itemview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _cartController = Get.find<CartController>();
    
    return Obx((){
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Center(
            child: Text('cart_title'.tr)
          ),
        ),
        body: _cartController.cartList.isEmpty ? _emptyCartScreen() :
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              _buildCouponButton(),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _cartController.cartList.length + 1,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index){
                    if(index == _cartController.cartList.length){
                      return _buildSummary();
                    } else {
                      return _buildItemView(index);
                    }
                  },
                ),
              ),
              _cartController.cartProductList.isEmpty ? Container() : _buildCheckbillButton()
            ],
          ),
        ),
      ); 
    });
  }

  Widget _buildCouponButton(){
    return InkWell(
      splashColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(cGrey),
          borderRadius: BorderRadius.circular(7)
        ),
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom:10),
        child: Row(
          children: [
            Text('cart_coupon'.tr),
            const Spacer(),
            const Icon(Icons.arrow_right)
          ],
        ),
      ),
      onTap: () => _couponInputDialogView()
    );
  }

  void _couponInputDialogView(){

    final _cartController = Get.find<CartController>();

    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      backgroundColor: Colors.transparent,
      builder: (context) => SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(17), 
              topRight: Radius.circular(17)
            )
          ),
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [

              Center(
                child: Container(
                  height: 8,
                  width: 60,
                  margin:  const EdgeInsets.only(top: 15, bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(99)
                  ),
                ),
              ),

              Center(
                child: Text(
                  'cart_coupon'.tr,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                )
              ),

              Container(height: 30,),

              Container(
                padding: const EdgeInsets.only(top: 10, bottom:20),
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  autofocus: true,
                  textAlign: TextAlign.center,
                  controller: _cartController.couponEditingController,
                  decoration: const InputDecoration(
                    enabledBorder:  OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10, bottom: 5, top: 5, right: 10),
                    // hintText: hints,
                    hintStyle: TextStyle(color: Colors.grey, fontSize: xTextSize14)
                  ),
                ),
              ),

              Container(height: 30,),
      
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(xMainColor),
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                  ),
                  child: Text('submit_text'.tr),
                  onPressed: () => _cartController.verifyCouponCode(),
                )
              )
              
            ],
          ),
        )
      ))
    );
  }

  Widget _buildItemView(int index){
    final _cartController = Get.find<CartController>();
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Slidable(
        key: Key(_cartController.cartProductList[index].productNo!),
        endActionPane: ActionPane(
          openThreshold: 0.15,
          closeThreshold: 0.15,
          extentRatio: 0.3,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => _cartController.removeCartItem(index),
              autoClose: true,
              backgroundColor: const Color(cPink),
              foregroundColor: const Color(cGrey),
              icon: Icons.delete,
              label: 'delete_text'.tr,
            )
          ],
        ),
        child: Builder(builder: (context){
          return GestureDetector(
            onTap: () {
              //  TODO Slidable Open & Close Toggle
              Slidable.of(context)!.close();
            } ,
            child: cartItemView(
              _cartController.cartList[index],
              _cartController.cartProductList[index]
            ),
          );
        })
      ),
    );
  }

  Widget _buildSummary(){
    final _cartController = Get.find<CartController>();
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 100),
      child: Obx((){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CartSummaryItemView(
              title: 'cart_subamount'.tr, 
              value: 'HKD\$ ' + _cartController.subAmount.toStringAsFixed(2),
              isbold: false,
              showAddBox: false,
            ),

            CartSummaryItemView(
              title: 'cart_discount'.tr, 
              value: '-HKD\$ ' + _cartController.discountAmount.toStringAsFixed(2),
              isbold: false,
              showAddBox: false,
            ),

            _cartController.discountCode.isEmpty ? Container() :
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () => _cartController.clearCoupon(),
                child: Row(
                  children: [
                    Text(
                      'cart_couponcode'.tr + '【${_cartController.discountCode}】', 
                      style: const TextStyle(color: Colors.grey)
                    ),
                    Text(
                      'clear_text'.tr, 
                      style: const TextStyle(color: Colors.redAccent)
                    ),
                  ],
                ),
              ),
            ),

            CartSummaryItemView(
              title: 'cart_shipping'.tr, 
              value: 'HKD\$ ' + _cartController.shippingFree.toStringAsFixed(2),
              isbold: false,
              showAddBox: false,
            ),

            CartSummaryItemView(
              title: 'cart_totalamount'.tr, 
              value: 'HKD\$ ' + _cartController.totalAmount.toStringAsFixed(2),
              isbold: true,
              showAddBox: false,
            ),

          ],
        );
      })
    ); 
  }

  Widget _buildCheckbillButton(){
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 10),
      child : ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: const Color(xMainColor),
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
        ),
        onPressed: () => Get.find<CartController>().checkbill(),
        child: Get.find<AuthController>().auth.currentUser == null ?
          Text('shipping_details_btn1'.tr) :
          Text('shipping_details_btn2'.tr) 
      )
    );
  }
  
  Widget _emptyCartScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Image.asset(
            'assets/icon/ic_shoppingbag.png',
            color: Colors.grey,
          ),
          
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'empty_cart_string'.tr, 
              style : const TextStyle(color: Colors.grey)
            ),
          )

        ],
      ),
    );
  }

}