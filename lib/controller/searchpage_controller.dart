import 'package:asher_store/controller/product_controller.dart';
import 'package:asher_store/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController{
  
  RxInt categoryCurrentIndex = 9999999.obs;
  RxList<ProductModel> searchResultList = <ProductModel>[].obs;
  final TextEditingController searchFliedController = TextEditingController();
  final List<ProductModel> productlist = Get.find<ProductController>().productList;

  @override
  void onClose() {
    super.onClose();
    searchFliedController.dispose();
  }

  //  Query from Category
  void queryfromCategory(int index, String searchKey){
    searchFliedController.clear();
    searchResultList.clear();
    categoryCurrentIndex.value = index;
    for(int i = 0; i < productlist.length; i++){
      for(int k = 0; k < productlist[i].category!.length; k ++){
        if(productlist[i].category![k].toString().contains(searchKey)){
          searchResultList.add(productlist[i]);
        }
      }
    } 
  }

  //  Query from Category by String
  void queryStringfromCategory(String searchKey){
    categoryCurrentIndex.value = 9999999;
    searchResultList.clear();
    for(int i = 0; i < productlist.length; i++){
      for(int k = 0; k < productlist[i].category!.length; k ++){
        if(productlist[i].category![k].toString().contains(searchKey)){
          searchResultList.add(productlist[i]);
        }
      }
    }
  }

  //  Query from user input
  void queryfromString(){
    categoryCurrentIndex.value = 9999999;
    searchResultList.clear();
    if(searchFliedController.text.trim().isEmpty){
      searchResultList.clear();
    } else {
      searchResultList.clear();
      for(int i = 0; i < productlist.length; i++){
        if(productlist[i].productName!.toUpperCase().contains(searchFliedController.text.toUpperCase())){
          searchResultList.add(productlist[i]);
        }
      }
    }
  }

}