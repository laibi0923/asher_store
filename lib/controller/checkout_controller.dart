import 'dart:convert';
import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/auth_controller.dart';
import 'package:asher_store/controller/cart_controller.dart';
import 'package:asher_store/model/order_model.dart';
import 'package:asher_store/model/user_model.dart';
import 'package:asher_store/screen/cart/sf_lockerlocation.dart';
import 'package:asher_store/screen/cart/thankyou_screen.dart';
import 'package:asher_store/service/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CheckOutController extends GetxController{

  final TextEditingController userRecipientEditingControlle = TextEditingController();
  final TextEditingController phoneEditingControlle = TextEditingController();
  final TextEditingController unitEditingControlle = TextEditingController();
  final TextEditingController estateEditingControlle = TextEditingController();
  final TextEditingController districtEditingControlle = TextEditingController();
  List<bool> expansionPanelOpenStatus = [false, false].obs;
  RxBool isLoading = false.obs;
  RxBool saveShippingAddress = false.obs;
  RxMap sFLockerLocation = {}.obs;
  Map<String, dynamic>? paymentIntentData;
  Map<String, dynamic>? _receipientInfo;

  @override
  void onInit() {
    super.onInit();
    final _authController = Get.put(AuthController());
    if(_authController.auth.currentUser != null){
      userRecipientEditingControlle.text = _authController.userModel.value!.recipientName.toString();
      phoneEditingControlle.text = _authController.userModel.value!.phone.toString();
      unitEditingControlle.text = _authController.userModel.value!.unitAndBuilding.toString();
      estateEditingControlle.text = _authController.userModel.value!.estate.toString();
      districtEditingControlle.text = _authController.userModel.value!.district.toString();
    }
  }

  @override
  void onClose() {
    super.onClose();
    userRecipientEditingControlle.dispose();
    phoneEditingControlle.dispose();
    unitEditingControlle.dispose();
    estateEditingControlle.dispose();
    districtEditingControlle.dispose();
  }

  //  運送地址列表切換
  void expansionPanelListToggler(int i, bool isOpen){
    for(int i = 0; i < expansionPanelOpenStatus.length; i ++){
      expansionPanelOpenStatus[i] = false;
    }
    expansionPanelOpenStatus[i] = !isOpen;
  }

  //  
  Future<void> sfLockerSelecter() async {
    var result = await Get.to(() => const SFLockerLocation());
    if(result.isNotEmpty){
      sFLockerLocation.addAll(result);
    }
  }

  //  儲存送貨地址
  void saveAddressOnClick(){
    if(saveShippingAddress.isTrue){
      saveShippingAddress.value = false;
    } else {
      saveShippingAddress.value = true;
    }
  }

  //  Loading Screen
  void setShowLoadingScreen(){
    if(isLoading.isTrue){
      isLoading.value = false;
    } else {
      isLoading.value = true;
    }
  }

  //  建立支付
  Future<void> makePayment() async {

    if(userRecipientEditingControlle.text.trim().isEmpty){
      Get.snackbar('checkout_erro_title'.tr, 'checkout_erro_name'.tr, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if(phoneEditingControlle.text.trim().isEmpty){
      Get.snackbar('checkout_erro_title'.tr, 'checkout_erro_phone'.tr, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if(expansionPanelOpenStatus[0] == false && expansionPanelOpenStatus[1] == false){
      Get.snackbar('checkout_erro_title'.tr, 'checkout_erro_shippingmethod'.tr, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if(expansionPanelOpenStatus[0]){
      if(sFLockerLocation.isEmpty){
        Get.snackbar('checkout_erro_title'.tr, 'checkout_erro_dflockerlocation'.tr, snackPosition: SnackPosition.BOTTOM);
        return;
      }

      //  收件人資料
      _receipientInfo = {
        'RECEIPIENT_NAME': userRecipientEditingControlle.text,
        'CONTACT': phoneEditingControlle.text,
        'UNIT_AND_BUILDING': sFLockerLocation['code'],
        'ESTATE': sFLockerLocation['location'],
        'DISTRICT': sFLockerLocation['openingHour']
      };

    }

    if(expansionPanelOpenStatus[1]){

      if(unitEditingControlle.text.trim().isEmpty){
        Get.snackbar('checkout_erro_title'.tr, 'checkout_erro_unit'.tr, snackPosition: SnackPosition.BOTTOM);
        return;
      }

      if(estateEditingControlle.text.trim().isEmpty){
        Get.snackbar('checkout_erro_title'.tr, 'checkout_erro_building'.tr, snackPosition: SnackPosition.BOTTOM);
        return;
      }

      if(districtEditingControlle.text.trim().isEmpty){
        Get.snackbar('checkout_erro_title'.tr, 'checkout_erro_district'.tr, snackPosition: SnackPosition.BOTTOM);
        return;
      }

      //  收件人資料
      _receipientInfo = {
        'RECEIPIENT_NAME': userRecipientEditingControlle.text,
        'CONTACT': phoneEditingControlle.text,
        'UNIT_AND_BUILDING': unitEditingControlle.text,
        'ESTATE': estateEditingControlle.text,
        'DISTRICT': districtEditingControlle.text
      };
      
    }

    setShowLoadingScreen();

    const url = 'https://us-central1-asher-177a1.cloudfunctions.net/stripePayment';

    String amount = (Get.find<CartController>().totalAmount.value * 100).toInt().toString();

    final http.Response response = await http.post(
      Uri.parse('$url?amount=$amount&currency=HKD'),
    );

    paymentIntentData = json.decode(response.body);
    
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentData!['paymentIntent'],
        applePay: true,
        googlePay: true,
        style: ThemeMode.light,
        merchantCountryCode: 'HK',
        merchantDisplayName: appName,
      )
    );

    try{
      await Stripe.instance.presentPaymentSheet();
      paymentIntentData = null;
      orderInformation();
      setShowLoadingScreen();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      setShowLoadingScreen();
    }

  }

  //  訂單資料
  Future<void> orderInformation() async {

    final _cartController = Get.find<CartController>();
    
    //  結用戶選中保存地址時用
    if(expansionPanelOpenStatus[1] && saveShippingAddress.isTrue){
      FirebaseService().updateUserInfo(
        UserModel(
          phone: phoneEditingControlle.text,
          recipientName: userRecipientEditingControlle.text,
          unitAndBuilding: unitEditingControlle.text,
          estate: estateEditingControlle.text,
          district: districtEditingControlle.text
        )
      );
    }

    //  重新將 Cart 內物品資料整理
    List<Map<String, dynamic>> _tempProductList = [];

    for(int k = 0; k < _cartController.cartList.length; k++){
      _tempProductList.add({
        'ORDER_PRODUCT_NO' : FirebaseService().randomStringGender(30, true),
        'PRODUCT_NO' : _cartController.cartProductList[k].productNo,
        'PRODUCT_NAME' : _cartController.cartProductList[k].productName,
        'PRODUCT_IMAGE' : _cartController.cartProductList[k].imagePatch![0],
        'REFUND_ABLE' : _cartController.cartProductList[k].refundable,
        'PRICE' : _cartController.cartProductList[k].price,
        'DISCOUNT' : _cartController.cartProductList[k].discountPrice,
        'SIZE' : _cartController.cartProductList[k].size?[_cartController.cartList[k].size],
        'COLOR_IMAGE' : _cartController.cartProductList[k].color?[_cartController.cartList[k].color]['COLOR_IMAGE'],
        'COLOR_NAME' : _cartController.cartProductList[k].color?[_cartController.cartList[k].color]['COLOR_NAME'],
        'SHIPPING_STATUS' : '',
        'REFUND_STATUS' : ''
      });
    }

    //  訂單資料
    OrderModel tempOrderModel = OrderModel(
      orderDate: Timestamp.now(),
      orderNumber: 'OD${FirebaseService().randomStringGender(10, false)}', 
      subAmount: _cartController.subAmount.value,
      shippingAmount: _cartController.shippingFree.value,
      totalAmount: _cartController.totalAmount.value,
      discountCode: _cartController.discountCode.value,
      discountAmount: _cartController.discountAmount.value,
      receipientInfo: _receipientInfo,
      orderProduct: _tempProductList,
      paymentMothed: '信用卡'
    );

    //  落單
    FirebaseService().takeOrder(tempOrderModel).then((value){
      _cartController.clearCart();
      Get.back();
      Get.to(() => const ThankYouScreen());
    });

    //  紀錄用戶已使用此優惠
    if (_cartController.discountCode.isNotEmpty) {
      FirebaseService().addCouponRecord(_cartController.discountCode.value);
    }

  }

}