import 'package:asher_store/model/product_model.dart';
import 'package:asher_store/service/firebase_service.dart';
import 'package:get/state_manager.dart';

class ProductController extends GetxController{

  RxList<ProductModel> productList = <ProductModel>[].obs;
  // RxList<ProductModel> topProductList = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    productList.bindStream(FirebaseService().getProduct);
  }

  void topProduct() {
    productList.sort((a, b) => (b.sold)!.compareTo(a.sold!));
  }

}