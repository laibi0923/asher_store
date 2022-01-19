import 'package:asher_store/controller/policy_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:asher_store/constants.dart';


class RefundPolicy extends StatelessWidget {
  const RefundPolicy({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _policyController = Get.find<PolicyController>();

     return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          // ignore: unnecessary_null_comparison
          _policyController.refundPolicy == null ? Container() :
          ListView(
            physics: const BouncingScrollPhysics(),
            children: [

              const Padding(
                padding: EdgeInsets.only(top: 40, bottom: 40),
                child: Center(
                  child: Text(
                    '退貨政策',
                    style: TextStyle(fontSize: xTextSize18, fontWeight: FontWeight.bold),
                  )
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '上次修改時間 : ${DateFormat('yyyy年MM月dd日').format(
                        DateTime.fromMicrosecondsSinceEpoch(_policyController.refundPolicy.value.lastModify!.microsecondsSinceEpoch)
                      )}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        _policyController.refundPolicy.value.content!
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        
          Positioned(
            top:55,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999)
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context), 
                icon: const Icon(Icons.close)
              ),
            ),
          )
        
        ],
      ),
    );
  }
}