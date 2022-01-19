import 'package:asher_store/controller/product_controller.dart';
import 'package:asher_store/model/product_model.dart';
import 'package:asher_store/model/wishlist_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishListController extends GetxController{

  SharedPreferences? mSharedPreferences;
  RxList<WishListModel> wishlist = <WishListModel>[].obs;
  RxList<ProductModel> wishProductList = <ProductModel>[].obs;

  
  @override
  void onInit() {
    super.onInit();
    setupSharedPreferences();
  }
  
  Future<void> setupSharedPreferences() async {
    mSharedPreferences = await SharedPreferences.getInstance();
  }

  //  取得喜好清單內貨品資料
  void refreshWishListData(){
    final List<ProductModel> productlist = Get.find<ProductController>().productList;
    wishProductList.clear();
    _getSharedPreferences();
    for (int i = 0; i < wishlist.length; i++) {
      for(int k = 0; k < productlist.length; k++){
        if(productlist[k].productNo == wishlist[i].productNo){
          wishProductList.add(productlist[k]);
        }
      }    
    } 
    update();
  }

  void _setSharedPreferences() {
    mSharedPreferences!.setString('wishListInfo', WishListModel.encode(wishlist));
  }

  void _getSharedPreferences(){
    String wishString = mSharedPreferences!.getString('wishListInfo') ?? '';
    wishlist.value = WishListModel.decode(wishString);
  }

    //  加入喜好貨品
  addWishList(WishListModel item) {
    wishlist.add(item);
    _setSharedPreferences();
    refreshWishListData();
  }
 
  //  移除單一喜好貨品
  removeWishListItem(int index){ 
    wishlist.removeAt(index);
    wishProductList.removeAt(index);
    _setSharedPreferences();
    refreshWishListData();
  }

  //  清空喜好貨品
  clearWishList() {
    wishlist.clear();
    wishProductList.clear();
    _setSharedPreferences();
    refreshWishListData();
  }

}