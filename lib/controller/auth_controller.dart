import 'dart:convert';

import 'package:asher_store/controller/mailbox_controller.dart';
import 'package:asher_store/controller/order_history_controller.dart';
import 'package:asher_store/controller/usercoupon_controller.dart';
import 'package:asher_store/model/user_model.dart';
import 'package:asher_store/screen/landing_page/email_verify.dart';
import 'package:asher_store/service/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';

class AuthController extends GetxController{

  static AuthController instance = Get.find();

  FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<User?> user;
  late Rx<UserModel?> userModel = Rx(UserModel());
  final googleSignIn = GoogleSignIn();

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(auth.currentUser);
    user.bindStream(auth.userChanges());
    if(user.value != null){
      bindUserData();
    }
  }

  //  以電郵註冊
  Future<void> registerByEmail(String email, String password, String confirmPw) async {

    if(email.isEmpty){
      Get.snackbar('註冊失敗', '請輸入電郵', snackPosition: SnackPosition.BOTTOM);
    } else if(password.isEmpty){
      Get.snackbar('註冊失敗', '請輸入密碼', snackPosition: SnackPosition.BOTTOM);
    } else if(confirmPw.isEmpty){
      Get.snackbar('註冊失敗', '請再次輸入密碼', snackPosition: SnackPosition.BOTTOM);
    } else if(password != confirmPw){
      Get.snackbar('註冊失敗', '確認密碼不一致, 請重新輸入', snackPosition: SnackPosition.BOTTOM);
    } else {

      try{
        await auth.createUserWithEmailAndPassword(email: email, password: password).then((value) {   

          createUserInfo(
            email, 
            email.split('@')[0].toUpperCase(), 
          );
      
          sendEmailVerification();
          signOut();
          Get.to(() => const EmailVerify());

        });
      } on FirebaseAuthException catch (e){
        switch(e.code){
          case 'weak-password':
            Get.snackbar('註冊失敗', '請檢查你的密碼強度', snackPosition: SnackPosition.BOTTOM);
            break;

          case 'email-already-in-use':
            Get.snackbar('註冊失敗', '此電郵已註冊', snackPosition: SnackPosition.BOTTOM);
            break;

          case 'invalid-email':
            Get.snackbar('註冊失敗', '輸入電郵不正確', snackPosition: SnackPosition.BOTTOM);
            break;

          default:
            Get.snackbar('註冊失敗', '請與管理員聮絡', snackPosition: SnackPosition.BOTTOM);
            break;
        }
      }
    }    
  }

  //  登出
  Future<void> signOut() async {
    await auth.signOut();
    await googleSignIn.signOut();
    Get.find<MailboxContorller>().unReadMailBoxList.clear();
  }

  //  發送重置密碼電郵
  Future<void> passwordReset(String email) async {
    if(email.isEmpty){
      Get.snackbar('重置密碼失敗', '請輸入電郵', snackPosition: SnackPosition.BOTTOM);
    } else {
      try {
        await auth.sendPasswordResetEmail(email: email);
        Get.snackbar('重置密碼成功', '請檢查你的電子郵箱', snackPosition: SnackPosition.BOTTOM);
      } on FirebaseAuthException catch (e) {
        switch (e.code){
          case 'invalid-email':
          Get.snackbar('重置密碼失敗', '請輸入正確電郵', snackPosition: SnackPosition.BOTTOM);
          break;
        }
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }
  }

  //  發送驗証電郵
  Future<void> sendEmailVerification() async {
    auth.currentUser?.sendEmailVerification();
  }

  //  以電郵登入
  Future<void> signIn(String email, String password) async {
    if(email.isEmpty){
      Get.snackbar('登入失敗', '請輸入電郵', snackPosition: SnackPosition.BOTTOM);
    } else if (password.isEmpty){
      Get.snackbar('登入失敗', '請輸入密碼', snackPosition: SnackPosition.BOTTOM);
    } else {
      try{
        await auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
          if(user.value?.emailVerified == false){
            Get.to(() => const EmailVerify());
          }else{
            bindUserData();
          }
        });
      } on FirebaseAuthException catch (e) {

        switch (e.code) {
          case 'invalid-email':
            Get.snackbar('登入失敗', '你所輸入的電郵或密碼不正確。', snackPosition: SnackPosition.BOTTOM);
            break;
          case 'wrong-password':
            Get.snackbar('登入失敗', '你所輸入的電郵或密碼不正確。', snackPosition: SnackPosition.BOTTOM);
            break;
          case 'too-many-requests':
            Get.snackbar('登入失敗', '由於多次登入失敗，請稍後嘗試。', snackPosition: SnackPosition.BOTTOM);
            break;
          default:
            Get.snackbar('登入失敗', '請稍後嘗試', snackPosition: SnackPosition.BOTTOM);
            break;
        }
        
      }
    }
    
  }

  //  以 Google 登入
  Future<void> googleLogin() async {

    // final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if(googleSignInAccount != null){

      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken
      );

      try{

        final UserCredential userCredential = await auth.signInWithCredential(authCredential).then((value) {
          createUserInfo(googleSignInAccount.email, googleSignInAccount.displayName!);
          return value;
        });        

        user.value = userCredential.user;

      } on FirebaseAuthException catch (e){

        Get.snackbar('FirebaseAuthException Error', e.toString());

      } catch (e){

        Get.snackbar('Error', e.toString());

      }

    }
    
    // try {

    //   GoogleSignInAccount? _googleUser;
    //   // GoogleSignInAccount get guser => _user!; 

    //   final googleUser = await googleSignIn.signIn();
    //   if(googleUser == null) return;
    //   _googleUser = googleUser;

    //   final googleAuth = await googleUser.authentication;

    //   final credential = GoogleAuthProvider.credential(
    //     accessToken: googleAuth.accessToken,
    //     idToken: googleAuth.idToken
    //   );

    //   await auth.signInWithCredential(credential).then((value) {
    //     createUserInfo(
    //       _googleUser!.email,
    //       _googleUser.displayName!, 
    //     );
    //   }).then((value) => Get.snackbar('註冊失敗', 'xxxxxxxx', snackPosition: SnackPosition.BOTTOM));

    // } on FirebaseAuthException catch (e){
    //   Get.snackbar('註冊失敗', e.toString(), snackPosition: SnackPosition.BOTTOM);
    //   // ignore: avoid_print
    //   print(e.toString());
    // }

  }

  //  以 Apple ID 登入 (需付費成為 Apple developer program 會員)
  Future<void> appleLogin() async {

    final rawNonce = generateNonce();
    final bytes = utf8.encode(rawNonce);
    final digest = sha256.convert(bytes);
    final nonce = digest.toString();

    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName
      ],
      nonce: nonce,
    );

    final oAuthCredential = OAuthProvider('apple.com').credential(
      idToken: credential.identityToken,
      rawNonce: rawNonce,
    );

    await auth.signInWithCredential(oAuthCredential).then((value) {
      createUserInfo(
        credential.email!,
        "${credential.givenName!} ${credential.familyName!}", 
      );
    });

  }

  //  以 Facebook 登入
  //  TODO Facebook lgoin
  void facebookLogin(){}

  //  綁定會員資料
  void bindUserData(){
    userModel.bindStream(FirebaseService().getUserInfo());
    Get.find<OrderHistoryController>().bindOrderHistoryStream();
    Get.find<UserCouponController>().bindUserCouponStream();
    Get.find<MailboxContorller>().bindMailboxStream();
  }

  //  新建用戶資料 (Firebase)
  void createUserInfo(String email, String displayName){
    UserModel userModel = UserModel(
      uid: auth.currentUser?.uid,
      createDate: Timestamp.now(),
      lastModify: Timestamp.now(),
      email: email,
      name: displayName,
      phone: '',
      recipientName: '',
      photo: '',
      estate: '',
      unitAndBuilding: '',
      district: '',
    );

    FirebaseService().creatNewUserInfo(userModel).then((value) => bindUserData());

  }

}