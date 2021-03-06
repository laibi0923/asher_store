
import 'package:asher_store/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            const Icon(null),
            const Expanded(
              child: Text('')
            ),
            IconButton(
              onPressed: () => Navigator.pop(context), 
              icon: const Icon(Icons.close)
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [

            const Text(
              'THANK YOU',
              style: TextStyle(fontSize: xTextSize26, color: Colors.grey, fontWeight: FontWeight.bold),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Icon(Icons.done, size: 80, color: Color(xMainColor),),
            ),

            Text(
              'thankyou_content'.tr,
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            )

          ],
        ),
      ),
    );
  }
}