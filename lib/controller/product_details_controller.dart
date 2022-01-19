import 'package:asher_store/controller/cart_controller.dart';
import 'package:asher_store/controller/wishlist_controller.dart';
import 'package:asher_store/model/cart_model.dart';
import 'package:asher_store/model/product_model.dart';
import 'package:asher_store/model/wishlist_model.dart';
import 'package:asher_store/screen/product/product_photoview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController{

  PageController pageController = PageController(initialPage: 0);
  RxBool onWishList = false.obs;
  RxInt wishlistIndex = 0.obs;
  RxInt imageIndex = 1.obs;
  RxInt currentSizeIndex = 0.obs;
  RxInt currentColorIndex = 0.obs;
  RxBool isExpanedText = false.obs;

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }

  //  打開商品詳細資料組件
  void showProductDetailsBottomSheet(Widget child){
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, 
      builder: (context){
        return child;
      }
    );
  }

  void toggleExpandText(){
    if(isExpanedText.value == true){
      isExpanedText(false);
    } else {
      isExpanedText(true);
    }
  }

  //   檢查是否已加入喜愛清單
  void checkOnWishlist(String productNo){
    final wishlist = Get.find<WishListController>().wishlist;
    if(wishlist.isNotEmpty){
      for(int i = 0; i < wishlist.length; i++){
        if(wishlist[i].productNo == productNo){
          onWishList.value = true;
          wishlistIndex.value = i;
          break;
        }
      }
    } else {
      onWishList.value = false;
    }
    update();
  }

  Future<void> jumpToPage(List imageList, int index) async {

    final result = await Get.to(() => ProductPhotoView(
      imageList: imageList, 
      initPage: index
    ));
    
    if(result != null){
      pageController.jumpToPage(result.toInt());
    }
  }

  //  加入喜愛清單
  void addToWishList(ProductModel productModel){
    if(onWishList.isTrue){
      onWishList.value = false;
      Get.find<WishListController>().removeWishListItem(wishlistIndex.value);
    } else {
      onWishList.value = true;
      Get.find<WishListController>().addWishList(WishListModel(productModel.productNo!));
    }
  }

  //  加入購物車
  void addToCart(ProductModel productModel){
    Get.find<CartController>().addCart(
      CartModel(productModel.productNo!, currentSizeIndex.value, currentColorIndex.value)
    );
    if(onWishList.isTrue){      
      Get.find<WishListController>().removeWishListItem(wishlistIndex.value);
    }
    Get.back();
    Get.back();
  }

}