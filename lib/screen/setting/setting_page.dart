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
                          Text(
                            'edit_profile'.tr,
                            style: const TextStyle(fontSize: xTextSize14),
                          )
                        ],
                      ),
                    )
                  ),

                  // Signout Button
                  GestureDetector(
                    onTap: () => controller.signOut(),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 0),
                      child: Text(
                        'logout_btn'.tr,
                        style: const TextStyle(
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

    final _settingController = Get.put(SettingController());

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            padding: const EdgeInsets.only(top: 30, bottom: 10),
            child: Text(
              'order_title'.tr,
              style: const TextStyle(fontSize: xTextSize18, fontWeight: FontWeight.bold),
            ),
          ),

          //  ????????????
          GestureDetector(
            onTap: () => Get.to(() => const OrderHistory()),
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text('order_history'.tr)
                  ),
                  const Icon(Icons.arrow_right_outlined)
                ],
              )
            ),
          ),

          //  ????????????
          // GestureDetector(
          //   onTap: () => Get.to(() => const ShippingHistory()),
          //   child: Container(
          //     padding: const EdgeInsets.only(top: 10, bottom: 10),
          //     child: Row(
          //       children: const [
          //         Expanded(
          //           child: Text('????????????')
          //         ),
          //         Icon(Icons.arrow_right_outlined)
          //       ],
          //     )
          //   ),
          // ),

          //  ????????????
          GestureDetector(
            onTap: () => Get.to(() => const RefundHistory()),
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text('return_history'.tr)
                  ),
                  const Icon(Icons.arrow_right_outlined)
                ],
              )
            ),
          ),

          //  ?????????????????????
          GestureDetector(
            onTap: () => Get.to(() => const CouponHistory()),
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text('coupon_history'.tr)
                  ),
                  const Icon(Icons.arrow_right_outlined)
                ],
              )
            ),
          ),

          Container(
            padding: const EdgeInsets.only(top: 30, bottom: 10),
            child: Text(
              'general_setting'.tr,
              style: const TextStyle(fontSize: xTextSize18, fontWeight: FontWeight.bold),
            ),
          ),

          GestureDetector(
            onTap: () => _settingController.setLanguage(),
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text('language_setting'.tr)
                  ),
                  Text(_settingController.locale[_settingController.languageIndex.value]['name']),
                ],
              )
            ),
          ),

          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text('currency_setting'.tr)
                ),
                const Text('HKD'),
              ],
            )
          ),

          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text('theme_setting'.tr)
                ),
                Text('close_text'.tr),
              ],
            )
          ),

          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              'contact_us'.tr,
              style: const TextStyle(fontSize: xTextSize18, fontWeight: FontWeight.bold),
            ),
          ),

          GestureDetector(
            onTap: () => Get.to(() => const PrivatePolicy()),
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text('private_policy'.tr),
            ),
          ),

          GestureDetector(
            onTap: () => Get.to(() => const RefundPolicy()),
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text('return_policy'.tr),
            ),
          ),
            
        ],
      ),
    );
  }

}