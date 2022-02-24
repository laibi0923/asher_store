import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/usercoupon_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class CouponHistory extends StatelessWidget {
  const CouponHistory({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final _userCouponController = Get.find<UserCouponController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('coupon_history_title'.tr),
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
      body: Center(
        child: _userCouponController.userCouponList.isEmpty ? 
        Text(
          'empty_coupon_text'.tr,
          style: const TextStyle(color: Colors.grey),
        ) :
        ListView.builder(
          itemCount: _userCouponController.userCouponList.length,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 20, right: 20),
          itemBuilder: (context, index){
            return Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: const Color(cGrey),
                borderRadius: BorderRadius.circular(7)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text('coupon_record_date'.tr)
                      ),
                      Text(
                        DateFormat('yyyy/MM/dd  kk:mm').format(DateTime.fromMicrosecondsSinceEpoch(_userCouponController.userCouponList[index].date.microsecondsSinceEpoch))
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text('coupon_code_text'.tr)
                      ),
                      Text(_userCouponController.userCouponList[index].code, style: const TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                ],
              ),
            );
          }
        ),
      )
    );
  }
}