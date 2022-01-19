import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/auth_controller.dart';
import 'package:asher_store/controller/cart_controller.dart';
import 'package:asher_store/controller/mailbox_controller.dart';
import 'package:asher_store/controller/root_controller.dart';
import 'package:asher_store/screen/cart/cart_page.dart';
import 'package:asher_store/screen/home/home_page.dart';
import 'package:asher_store/screen/mailbox/mailbox_page.dart';
import 'package:asher_store/screen/setting/setting_page.dart';
import 'package:asher_store/screen/wishlist/wlish.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootPage extends GetWidget<AuthController> {
  const RootPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _rootController = Get.put(RootController());
    final _cartController = Get.find<CartController>();
    _cartController.refreshCartData();
    final _mailBoxController = Get.find<MailboxContorller>();
    
    List _pages = const [
      HomePage(),
      WishlistPage(),
      CartPage(),
      MailboxPage(),
      SettingPage()
    ];

    return Scaffold(
      body: PageView.builder(
        itemCount: _pages.length,
        controller: _rootController.pageController,
        onPageChanged: (index) => _rootController.pageViewOnPageChange(index),
        itemBuilder: (context, index){
          return _pages[index];
        }
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent
        ),
        child: Obx((){
          return BottomNavigationBar(
            currentIndex: _rootController.currentIndex.value,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(xMainColor),
            unselectedItemColor: Colors.grey,
            onTap: (index) => _rootController.jumpToPage(index),
            items: <BottomNavigationBarItem>[

              const BottomNavigationBarItem(
                label: '',
                icon: Icon(Icons.roofing)
              ),

              const BottomNavigationBarItem(
                label: '',
                icon: ImageIcon(AssetImage('assets/icon/ic_heart.png')),
              ), 

              BottomNavigationBarItem(
                label: '',
                icon: Badge(
                  position: const BadgePosition(bottom: -13),
                  badgeColor: const Color(xMainColor),
                  showBadge: _cartController.cartList.isEmpty ? false : true,
                  badgeContent: Text(((){
                    int cartLenght = _cartController.cartList.length;
                    if(cartLenght > 99) () => '99+';
                    return cartLenght.toString();
                  })(),
                    style: const TextStyle(color: Colors.white, fontSize: 10)
                  ),
                  child: const ImageIcon(AssetImage('assets/icon/ic_shoppingbag.png')),
                )
              ),

              BottomNavigationBarItem(
                label: '',
                icon: Obx((){
                  return Badge(
                    position: const BadgePosition(bottom: -13),
                    badgeColor: const Color(xMainColor),
                    showBadge: 
                    controller.auth.currentUser != null &&
                    _mailBoxController.unReadMailBoxList.isNotEmpty ? true : false,
                    badgeContent:  Text(((){
                      return _mailBoxController.unReadMailBoxList.length.toString();
                    })(),
                      style: const TextStyle(color: Colors.white, fontSize: 10)
                    ),
                    child: const ImageIcon(AssetImage('assets/icon/ic_mail.png')),
                  );
                })
              ),

              const BottomNavigationBarItem(
                label: '',
                icon: ImageIcon(AssetImage('assets/icon/ic_settingmenu.png')),
              ),

            ]
          );
        })        
      )
    );
  }
}