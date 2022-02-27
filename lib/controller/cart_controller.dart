import 'package:asher_store/controller/auth_controller.dart';
import 'package:asher_store/controller/usercoupon_controller.dart';
import 'package:asher_store/controller/product_controller.dart';
import 'package:asher_store/controller/root_controller.dart';
import 'package:asher_store/model/cart_model.dart';
import 'package:asher_store/model/coupon_model.dart';
import 'package:asher_store/model/order_model.dart';
import 'package:asher_store/model/product_model.dart';
import 'package:asher_store/screen/cart/checkout_page.dart';
import 'package:asher_store/service/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController{

  SharedPreferences? mSharedPreferences;
  RxList<CartModel> cartList = <CartModel>[].obs;
  RxList<ProductModel> cartProductList = <ProductModel>[].obs;
  RxList<CouponModel> couponList = <CouponModel>[].obs;
  RxDouble subAmount = 0.0.obs;
  RxString discountCode = ''.obs;
  RxDouble discountAmount = 0.0.obs;
  RxDouble shippingFree = 0.0.obs;
  RxDouble totalAmount = 0.0.obs;
  TextEditingController couponEditingController = TextEditingController();
  OrderModel? orderModel;

  @override
  void onInit() {
    super.onInit();
    setupSharedPreferences();
    couponList.bindStream(FirebaseService().getCouponCode);
  }

  @override
  void onClose() {
    super.onClose();
    couponEditingController.dispose();
  }

  Future<void> setupSharedPreferences() async {
    mSharedPreferences = await SharedPreferences.getInstance();
  }

  //  取得購物車內貨品資料
  void refreshCartData(){
    final List<ProductModel> productlist = Get.find<ProductController>().productList;
    
    cartProductList.clear();
    subAmount.value = 0.0;
    discountCode.value = '';
    discountAmount.value = 0.0;
    shippingFree.value = 0.0;
    totalAmount.value = 0.0;

    _getSharedPreferences();

    for (int i = 0; i < cartList.length; i++) {
      for(int k = 0; k < productlist.length; k++){
        if(productlist[k].productNo == cartList[i].productNo){
          cartProductList.add(productlist[k]);
        }
      }    
    }
    sumAmount();
    update();
  }

  void _setSharedPreferences() {
    mSharedPreferences?.setString('cartInfo', CartModel.encode(cartList));
  }

  void _getSharedPreferences(){
    String cartString = mSharedPreferences?.getString('cartInfo') ?? '';
    cartList.value = CartModel.decode(cartString);
  }

  //  取得 SharedPerferences 購物車
  List<CartModel> get getSharedPerferencesCartList{
    _getSharedPreferences();
    return cartList;
  }

  //  加入購物車 (Product Details)
  void addCart(CartModel cartModel) {
    cartList.add(cartModel);
    _setSharedPreferences();
    refreshCartData();
  }

  //  移除單一購物車貨品
  void removeCartItem(int index){
    cartList.removeAt(index);
    cartProductList.removeAt(index);
    _setSharedPreferences();
    refreshCartData();
    sumAmount();
  }

  //  清空購物車
  void clearCart() {
    cartList.clear();
    cartProductList.clear();
    _setSharedPreferences();
    refreshCartData();
  }

  //  清空優惠券
  void clearCoupon(){
    discountCode.value = '';
    discountAmount.value = 0.0;
    refreshCartData();
  }

  //  計算銀碼
  void sumAmount(){
    subAmount.value = 0.0;
    if(cartList.length < 3){
      shippingFree.value = 60.0;
    } else {
      shippingFree.value = 0.0;
    }
    
    totalAmount.value = 0.0;

    for(int i = 0; i < cartProductList.length; i++){
      if(cartProductList[i].discountPrice != 0){
        subAmount.value = subAmount.value + cartProductList[i].discountPrice!;
      } else {
        subAmount.value = subAmount.value + cartProductList[i].price!;
      }
    }

    totalAmount.value = subAmount.value - discountAmount.value + shippingFree.value;
  }

  //  輸入優惠碼底部組件
  void showCouponBottomSheet(Widget child){
    if(Get.find<AuthController>().auth.currentUser != null){
      showModalBottomSheet(
        isScrollControlled: true,
        context: Get.context!,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return SingleChildScrollView(
            child: child
          );
        }
      );
    } else {
      Get.find<RootController>().jumpToPage(4);
    } 
  }

  //  驗證優惠碼
  void verifyCouponCode(){
    
    if(couponEditingController.text.trim().isEmpty){
      Get.back();
      Get.snackbar('coupon_verify_title'.tr, 'coupon_code_empty'.tr, snackPosition: SnackPosition.BOTTOM);
    } 

    //  檢查用戶有冇用過此代碼
    for(int i = 0; i < Get.find<UserCouponController>().userCouponList.length; i++){
      if(Get.find<UserCouponController>().userCouponList[i].code.toUpperCase() == couponEditingController.text.trim().toUpperCase()){
        Get.snackbar('coupon_verify_title'.tr, 'coupon_code_used'.tr, snackPosition: SnackPosition.BOTTOM);
        return;
      }
    }
    
    //  檢查優惠代碼
    for(int i = 0; i < couponList.length; i++){
      if(couponEditingController.text.trim() == couponList[i].couponCode){

        // 判斷優惠代碼過期
        if(couponList[i].unLimited == false && couponList[i].validDate.millisecondsSinceEpoch < Timestamp.now().millisecondsSinceEpoch){
          Get.snackbar('coupon_verify_title'.tr, 'coupon_code_exprie'.tr, snackPosition: SnackPosition.BOTTOM);
          return;
        } else {

          //  判斷直接扣減銀碼
          if(couponList[i].percentage == 0){
            discountAmount.value = couponList[i].discountAmount;
            discountCode.value = couponList[i].couponCode;
            sumAmount();
          }

          //  全單百分比折扣
          else {
            discountAmount.value = subAmount * couponList[i].percentage / 100;
            discountCode.value = couponList[i].couponCode;
            sumAmount();
          }
          couponEditingController.clear();
          Get.back();
        }

      }
    }

  }

  //  結帳
  void checkbill(){

    if(Get.find<AuthController>().auth.currentUser == null){
      Get.find<RootController>().jumpToPage(4);
    } else {
      Get.to(() => const CheckOutPage());
    }   
  }

}