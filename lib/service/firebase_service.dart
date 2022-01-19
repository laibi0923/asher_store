import 'dart:io';
import 'dart:math';
import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/auth_controller.dart';
import 'package:asher_store/model/banner_model.dart';
import 'package:asher_store/model/category_model.dart';
import 'package:asher_store/model/coupon_model.dart';
import 'package:asher_store/model/mailbox_model.dart';
import 'package:asher_store/model/order_model.dart';
import 'package:asher_store/model/privatepolicy_model.dart';
import 'package:asher_store/model/product_model.dart';
import 'package:asher_store/model/refundpolicy_model.dart';
import 'package:asher_store/model/user_model.dart';
import 'package:asher_store/model/usercoupon_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FirebaseService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final uid = Get.find<AuthController>().auth.currentUser?.uid;
  
  //  新用戶註冊
  Future<void> creatNewUserInfo(UserModel userModel) async {
    try{
      DocumentReference ref = FirebaseFirestore.instance.collection('user').doc(userModel.uid);

      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(ref);
        if (!snapshot.exists) {

          await ref.set({
            'CREATE_DATE': Timestamp.now(),
            'LAST_MODIFY': Timestamp.now(),
            'UID': userModel.uid,
            'NAME': userModel.name,
            'EMAIL': userModel.email,
            'PHOTO': userModel.photo,
            'RECIPIENT_NAME': userModel.recipientName,
            'UNIT_AND_BUILDING': userModel.unitAndBuilding,
            'ESTATE': userModel.estate,
            'DISTRICT': userModel.district,
            'PHONE': userModel.phone
          });

          String mailboxDocid = _firestore.collection('user').doc().id;
          DocumentReference mailboxref = FirebaseFirestore.instance
              .collection('user')
              .doc(userModel.uid)
              .collection('mailbox')
              .doc(mailboxDocid);

          mailboxref.set({
            'CREATE_DATE': Timestamp.now(),
            'TITLE' : welcomeMailboxTitle,
            'CONTENT': welcometMailboxContent,
            'ISREADED': false,
            'DOCID' : mailboxDocid
          });

        }
      });  

    } catch (e){
      // ignore: avoid_print
      print(e);
    }
  }

  //  取得用戶資料
  Stream<UserModel> getUserInfo() {
    print("取得用戶資料 $uid");
    return _firestore.collection('user').doc(uid).snapshots().map((list){
      return UserModel.fromFirestore(list.data());
    });
  }

  //  更新用戶資料
  Future updateUserInfo(UserModel userModel) {
    return _firestore.collection('user').doc(uid).update({
      'NAME': userModel.name,
      'PHONE': userModel.phone,
      'RECIPIENT_NAME': userModel.recipientName,
      'UNIT_AND_BUILDING': userModel.unitAndBuilding,
      'ESTATE': userModel.estate,
      'DISTRICT': userModel.district,
    });
  }

  //  更新用戶頭像連結
  Future<void> setUserPhoto(String url) async {
    return _firestore.collection('user').doc(uid).update({
      'PHOTO' : url
    });
  }

  //  上存圖片
  Future<String> uploadImage(String path, File file) async {
    Reference storageRef = FirebaseStorage.instance.ref().child(path);
    final UploadTask uploadTask = storageRef.putFile(file);
    final TaskSnapshot downloadUrl = (await uploadTask);
    final String url = await downloadUrl.ref.getDownloadURL();
    return url;
  }

   //  取得用戶郵箱
  Stream<List<MailBoxModel>> getUserMailbox() {
    return _firestore
        .collection('user')
        .doc(uid)
        .collection('mailbox')
        .snapshots()
        .map((list) => list.docs
        .map((doc) => MailBoxModel.fromFirestore(doc.data())).toList());
  }

  //  取得用戶郵箱
  Stream<List<MailBoxModel>> getUnReadMailbox() {
    return _firestore
        .collection('user')
        .doc(uid)
        .collection('mailbox').where('ISREADED', isEqualTo: false)
        .snapshots()
        .map((list) => list.docs
        .map((doc) => MailBoxModel.fromFirestore(doc.data())).toList());
  }

  //  移除用戶郵件
  void removeMailboxItem(String docId) {
    _firestore
    .collection('user')
    .doc(uid)
    .collection('mailbox')
    .doc(docId)
    .delete();
  }

  //  標記用戶已讀取郵件
  readedMailBox(String mailboxDocid){
    _firestore.collection('user').doc(uid)
    .collection('mailbox').doc(mailboxDocid).update({'ISREADED': true});
  }


  //  取得用戶已使用優惠券
  Stream<List<UserCouponModel>> getUserCouponRecord(){
    return _firestore
      .collection('user')
      .doc(uid)
      .collection('coupon')
      .snapshots()
      .map((list) => list.docs
      .map((doc) => UserCouponModel.fromFirestore(doc.data())).toList());
  }

  //  加入已使用優惠券到用戶
  addCouponRecord(String couponCode){
    return FirebaseFirestore.instance.collection('user').doc(uid).collection('coupon').doc().set({
      'DATE': Timestamp.now(),
      'CODE' : couponCode
    });
  }


  //  隨機生成英文數字    
  String randomStringGender(int chart, bool isString){
    var _chars = '';
    if(isString){
      _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    } else {
      _chars = '1234567890';
    }
    
    Random _rnd = Random();
    String getRandomString(int length) => String.fromCharCodes(
      Iterable.generate(length, (_) => _chars.codeUnitAt(
        _rnd.nextInt(_chars.length))
      )
    );

    return getRandomString(chart);
  }


  //  取得所有貨品
  Stream<List<ProductModel>> get getProduct {
    return _firestore.collection('product')
      .where('INSTOCK', isEqualTo: true)
      .snapshots()
      .map((list) => list.docs
      .map((doc) => ProductModel.fromFirestore(doc.data()))
      .toList());
  }

  //  取得主頁 Promotion Banner
  Stream<List<BannerModel>> get getBanner {
    return _firestore.collection('banner')
      .snapshots()
      .map((list) => list.docs
      .map((doc) => BannerModel.fromFirestore(doc.data(), doc.id))
      .toList());
  }

  //  取得所有分類
  Stream<List<CategoryModel>> get getCategory {
    return _firestore.collection('category')
      .orderBy('CREATE_DATE' , descending: false)  
      .snapshots()
      .map((list) => list.docs
      .map((doc) => CategoryModel.fromFirestore(doc.data()))
      .toList());
  }

  //  取得折扣代碼
  Stream<List<CouponModel>> get getCouponCode{
    return _firestore.collection('coupon')
      .snapshots()
      .map((list) => 
      list.docs.map((doc) => 
      CouponModel.fromFirestore(doc.data())).toList());
  }


  //  取得用戶過往下單紀錄
  Stream<List<OrderModel>> get orderHistory {
    return _firestore
    .collection('user')
    .doc(uid)
    .collection('order').orderBy('ORDER_DATE', descending: true)
    .snapshots()
    .map((list) => list.docs.map((doc) => OrderModel.fromFirestore(doc.data(), doc.id)).toList());  
  }
  
  //  用戶下單
  Future takeOrder(OrderModel orderModel) async{

    try{
      DocumentReference xRef = FirebaseFirestore.instance.collection('user').doc(uid).collection('order').doc();
      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(xRef);
        if(!snapshot.exists){
          xRef.set({
            'ORDER_DATE' : orderModel.orderDate,
            'ORDER_NUMBER' : orderModel.orderNumber,
            'DISCOUNT_CODE' : orderModel.discountCode,
            'DISCOUNT_AMOUNT' : orderModel.discountAmount,
            'SUB_AMOUNT' : orderModel.subAmount,
            'SHIPPING_FREE' : orderModel.shippingAmount,
            'TOTAL_AMOUNT' : orderModel.totalAmount,
            'RECIPIENT_INFO' : orderModel.receipientInfo,
            'ORDER_PRODUCT' : orderModel.orderProduct,
            'PAYMENT_METHOD' : orderModel.paymentMothed
          });
        }
      });

      DocumentReference zRef = FirebaseFirestore.instance.collection('order').doc();
      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(zRef);
        if(!snapshot.exists){
          zRef.set({
            'ORDER_DATE' : orderModel.orderDate,
            'ORDER_NUMBER' : orderModel.orderNumber,
            'REF' : xRef,
            'AMOUNT' : orderModel.totalAmount,
            'ISCOMPLETE' : false,
          });
        }
      });
      
    }catch(e){
      // ignore: avoid_print
      print(e);
    }
  }

  //  取得用戶政策
  Stream<PrivatePolicyModel> get getPrivatePolicyContent{
    return _firestore
    .collection('policy')
    .doc('private_policy')
    .snapshots()
    .map((list) => PrivatePolicyModel.fromFirestore(list.data()!));
  }

  //  取得退貨政策
  Stream<RefundPolicyModel> get getReturnPolicyContent{
    return _firestore
    .collection('policy')
    .doc('return_policy')
    .snapshots()
    .map((list) => RefundPolicyModel.fromFirestore(list.data()!));
  }

  //  用戶退貨
  Future makeRefund(OrderModel orderModel, String orderProductNo) async{

    try{

      //  於 Order Histoty 修改 RefundStatus
      DocumentReference xRef = FirebaseFirestore.instance.collection('user').doc(uid).collection('order').doc(orderModel.docId);
      FirebaseFirestore.instance.runTransaction((transaction) async {
        xRef.update({
          'ORDER_PRODUCT' : orderModel.orderProduct
        });
      });


      //  通知後台申請退款
      DocumentReference zRef = FirebaseFirestore.instance.collection('refund').doc();
      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(zRef);
        if(!snapshot.exists){
          zRef.set({
            'CREATE_DATE' : Timestamp.now(),
            'REF' : xRef,
            'ISCOMPLETE' : false,
            'ORDER_PRODUCT_NO' : orderProductNo,
            'ORDER_NO' : orderModel.orderNumber
          });
        }
      });
      
    }catch(e){
      // ignore: avoid_print
      print(e);
    }
  }

}