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
        title: const Text('已使用優惠代碼'),
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
        const Text(
          '尚未有任何紀錄',
          style: TextStyle(color: Colors.grey),
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
                      const Expanded(
                        child: Text('使用日期 : ')
                      ),
                      Text(
                        DateFormat('yyyy/MM/dd  kk:mm').format(DateTime.fromMicrosecondsSinceEpoch(_userCouponController.userCouponList[index].date.microsecondsSinceEpoch))
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text('優惠碼 : ')
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