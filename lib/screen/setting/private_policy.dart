import 'package:asher_store/controller/policy_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:asher_store/constants.dart';

class PrivatePolicy extends StatelessWidget {
  const PrivatePolicy({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _policyController = Get.find<PolicyController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          // ignore: unnecessary_null_comparison
          _policyController.privatePolicy == null ? Container() :
          ListView(
            physics: const BouncingScrollPhysics(),
            children: [

              const Padding(
                padding: EdgeInsets.only(top: 40, bottom: 40),
                child: Center(
                  child: Text(
                    '隱私政策',
                    style: TextStyle(fontSize: xTextSize18, fontWeight: FontWeight.bold),
                  )
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '上次修改時間 : ${DateFormat('yyyy年MM月dd日').format(
                        DateTime.fromMicrosecondsSinceEpoch(_policyController.privatePolicy.value.lastModify!.microsecondsSinceEpoch)
                      )}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        _policyController.privatePolicy.value.content!
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