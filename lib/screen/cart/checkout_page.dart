import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/cart_controller.dart';
import 'package:asher_store/controller/checkout_controller.dart';
import 'package:asher_store/widget/currency_textview.dart';
import 'package:asher_store/widget/customize_phonetextfield.dart';
import 'package:asher_store/widget/customize_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _checkoutController = Get.put(CheckOutController());

    return Scaffold(
      body: Stack(
        children: [

          Column(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
                  children: [
                    
                    Text(
                      'checkout_title1'.tr,
                      style: const TextStyle(fontSize: xTextSize26, fontWeight: FontWeight.bold),
                    ),

                    CustomizeTextField(
                      title: 'user_info_receipient_name'.tr,
                      maxLine: 1,
                      textEditingController: _checkoutController.userRecipientEditingControlle,
                    ),

                    CustomizePhoneTextField(
                      title: 'user_info_contact_no'.tr,
                      isPassword: false,
                      mTextEditingController: _checkoutController.phoneEditingControlle,
                    ),

                    Container(height: 20,),

                    Text(
                      'checkout_title2'.tr,
                      style: const TextStyle(fontSize: xTextSize26, fontWeight: FontWeight.bold),
                    ),

                    Container(height: 20,),

                    _expansionPanelList(),
                    
                  ],
                )
              ),
              _checkoutDetails(),
            ],
          ),

          //  關閉按鈕
          Positioned(
            top: 60,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(99)
              ),
              child: const Icon(Icons.close)),
            )
          ),

          //  Loading Screen
          _showLoadingScreen()
        ],
      ),
    );
  }

  Widget _showLoadingScreen(){
    return  Obx((){
      return Get.find<CheckOutController>().isLoading.isFalse ? Container() :
      Container(
        color: const Color(0x90000000),
        child: const Center(
          child: CircularProgressIndicator(
            color: Color(xMainColor),
          )
        ),
      );
    });
  }

  Widget _expansionPanelList(){

    final _checkoutController = Get.find<CheckOutController>();

    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 0),
      child: Obx((){
        return ExpansionPanelList(
          elevation: 0,
          expandedHeaderPadding: const EdgeInsets.all(0),
          expansionCallback: (i, isOpen) => _checkoutController.expansionPanelListToggler(i, isOpen),
          children: [
            
            ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: _checkoutController.expansionPanelOpenStatus[0],
              headerBuilder: (context, isOpen){
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text('checkout_sflocker'.tr)
                );
              },
              body: Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () => _checkoutController.sfLockerSelecter(),
                  child: _checkoutController.sFLockerLocation().isEmpty ? 
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Text('checkout_select_location'.tr)
                    ),
                  ) : 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _checkoutController.sFLockerLocation()['code'].toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(height: 5,),
                      Text(
                        _checkoutController.sFLockerLocation()['location'].toString()
                      ),
                      Container(height: 10,),
                      Text(
                        _checkoutController.sFLockerLocation()['openingHour'].toString()
                      ),
                    ],
                  ),
                ),
              )
            ),

            ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: _checkoutController.expansionPanelOpenStatus[1],
              headerBuilder: (context, isOpen){
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text('checkout_shippingto'.tr)
                );
              },
              body: _buildAddressFrom()
            ),
            
          ],
        );
      })
    );
  }

  Widget _buildAddressFrom(){

    final _checkoutController = Get.find<CheckOutController>();

    return Column(
      children: [
        CustomizeTextField(
          title: 'user_info_unit'.tr,
          maxLine: 1,
          textEditingController: _checkoutController.unitEditingControlle,
        ),
        CustomizeTextField(
          title: "user_info_building".tr,
          maxLine: 1,
          textEditingController: _checkoutController.estateEditingControlle,
        ),
        CustomizeTextField(
          title:'user_info_district'.tr,
          maxLine: 1,
          textEditingController: _checkoutController.districtEditingControlle,
        ),
        _saveAddressButton(),
        Container(height: 50)
      ],
    );
  }

  Widget _saveAddressButton(){

    final _checkoutController = Get.find<CheckOutController>();
    
    return GestureDetector(
      onTap: () => _checkoutController.saveAddressOnClick(),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Obx(() {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: _checkoutController.saveShippingAddress.isTrue ?
                const Icon(
                  Icons.radio_button_checked,
                  color: Color(xMainColor)
                ) : 
                const Icon(
                  Icons.radio_button_unchecked,
                  color: Color(xMainColor),                  
                ),
              );
            }),
            Text('checkout_saveaddress'.tr)
          ],
        ),
      ),
    );
  }

  Widget _checkoutDetails(){

    final _checkoutController = Get.find<CheckOutController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Center(
            child: Text(
              'checkout_totalpayment'.tr,
              style: const TextStyle(
                fontSize: xTextSize18, 
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Center(
            child: CurrencyTextView(
              value: Get.find<CartController>().totalAmount.value, 
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ),
    
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(xMainColor),
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
            ),
            onPressed: () => _checkoutController.makePayment(),
            child: Text('checkout_cardpayment'.tr)
          ),
        ),

        Container(height: 30)
      ],
    );
  }

}