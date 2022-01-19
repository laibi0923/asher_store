import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/auth_controller.dart';
import 'package:asher_store/controller/setting_controller.dart';
import 'package:asher_store/screen/landing_page/landing_page.dart';
import 'package:asher_store/screen/setting/coupon_history.dart';
import 'package:asher_store/screen/setting/order_history.dart';
import 'package:asher_store/screen/setting/private_policy.dart';
import 'package:asher_store/screen/setting/refund_history.dart';
import 'package:asher_store/screen/setting/refund_policy.dart';
import 'package:asher_store/screen/setting/user_information.dart';
import 'package:asher_store/widget/set_cachednetworkimage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SettingPage extends GetWidget<AuthController> {
  const SettingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _settingController = Get.put(SettingController());

    return Obx((){
      return Scaffold(
        body: 
        controller.user.value == null || 
        controller.user.value?.emailVerified == false ?
        const LandingPage(displayCloseButton: false) : 
        ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              height: 460,
              padding: const EdgeInsets.only(top: 80),
              child: Column(
                children: [
                  //  User Photo
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Stack(
                      children: [
                        
                        _settingController.showLoading.isFalse? 
                        const SizedBox(height: 200, width: 200) :
                        const SizedBox(
                          height: 200,
                          width: 200,
                          child: CircularProgressIndicator(color: Color(xMainColor), strokeWidth: 10),
                        ),

                        GestureDetector(
                          onTap: () => _settingController.userImageSetting(controller.auth.currentUser!.uid),
                          child: controller.userModel.value!.photo == '' ? 
                            ClipRRect(
                              borderRadius: BorderRadius.circular(99),
                              child: Container(
                                height: 200,
                                width: 200,
                                margin:  const EdgeInsets.only(bottom: 20),
                                child: ClipRRect(borderRadius: BorderRadius.circular(99),
                                  child: Container(
                                    color: const Color(cGrey),
                                    padding: const EdgeInsets.all(40),
                                    child: Image.asset(
                                      'assets/icon/ic_person.png',
                                      fit: BoxFit.cover,
                                      color: const Color(xMainColor),
                                    ),
                                  ),
                                ),
                              ),
                            ) : 
                            ClipRRect(
                              borderRadius: BorderRadius.circular(99),
                              child: Container(
                                height: 200,
                                width: 200,
                                margin:  const EdgeInsets.only(bottom: 20),
                                child: ClipRRect(borderRadius: BorderRadius.circular(99),
                                child: SetCachNetImage(
                                    imageUrl: controller.userModel.value!.photo.toString(),
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
                        ),
                       
                      ],
                    ),
                  ),

                  //  Change User Info Button
                  controller.userModel.value  == null ? Container() :
                  GestureDetector(
                    onTap: () => Get.to(() => UserInformation()),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            controller.userModel.value!.name == null ? '' :
                            controller.userModel.value!.name.toString(),
                            style: const TextStyle(fontSize: xTextSize26),
                          ),
                          const Text(
                            '編輯你的個人資料',
                            style: TextStyle(fontSize: xTextSize14),
                          )
                        ],
                      ),
                    )
                  ),

                  // Signout Button
                  GestureDetector(
                    onTap: () => controller.signOut(),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 0),
                      child: Text(
                        '登出',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          fontSize: xTextSize16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            _buildSettingMenu(),
          ],
        ),
      );
    });
  }

  Widget _buildSettingMenu(){
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            padding: const EdgeInsets.only(top: 30, bottom: 10),
            child: const Text(
              '訂單',
              style: TextStyle(fontSize: xTextSize18, fontWeight: FontWeight.bold),
            ),
          ),

          //  訂單紀錄
          GestureDetector(
            onTap: () => Get.to(() => const OrderHistory()),
            // onTap: () => _settingviewmodel.orderhistory(),
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: const [
                  Expanded(
                    child: Text('訂單紀錄')
                  ),
                  Icon(Icons.arrow_right_outlined)
                ],
              )
            ),
          ),

          //  出貸紀錄
          // GestureDetector(
          //   onTap: () => Get.to(() => const ShippingHistory()),
          //   child: Container(
          //     padding: const EdgeInsets.only(top: 10, bottom: 10),
          //     child: Row(
          //       children: const [
          //         Expanded(
          //           child: Text('出貨紀錄')
          //         ),
          //         Icon(Icons.arrow_right_outlined)
          //       ],
          //     )
          //   ),
          // ),

          //  退貨紀錄
          GestureDetector(
            onTap: () => Get.to(() => const RefundHistory()),
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: const [
                  Expanded(
                    child: Text('退貨紀錄')
                  ),
                  Icon(Icons.arrow_right_outlined)
                ],
              )
            ),
          ),

          //  已使用優惠代碼
          GestureDetector(
            onTap: () => Get.to(() => const CouponHistory()),
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: const [
                  Expanded(
                    child: Text('優惠代碼紀錄')
                  ),
                  Icon(Icons.arrow_right_outlined)
                ],
              )
            ),
          ),

          Container(
            padding: const EdgeInsets.only(top: 30, bottom: 10),
            child: const Text(
              '一般設定',
              style: TextStyle(fontSize: xTextSize18, fontWeight: FontWeight.bold),
            ),
          ),

          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: const [
                Expanded(
                  child: Text('語言')
                ),
                Text('繁體'),
              ],
            )
          ),

          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: const [
                Expanded(
                  child: Text('貨幣')
                ),
                Text('HKD'),
              ],
            )
          ),

          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: const [
                Expanded(
                  child: Text('暗黑模式')
                ),
                Text('關閉'),
              ],
            )
          ),

          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: const Text(
              '關於我們',
              style: TextStyle(fontSize: xTextSize18, fontWeight: FontWeight.bold),
            ),
          ),

          GestureDetector(
            onTap: () => Get.to(() => const PrivatePolicy()),
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: const Text('私隱政策'),
            ),
          ),

          GestureDetector(
            onTap: () => Get.to(() => const RefundPolicy()),
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: const Text('退貨政策'),
            ),
          ),
            
        ],
      ),
    );
  }

}