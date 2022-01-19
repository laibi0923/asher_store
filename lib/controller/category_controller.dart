import 'package:asher_store/model/category_model.dart';
import 'package:asher_store/service/firebase_service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{

  late Rx<List<CategoryModel>> categoryList = Rx([]);

  @override
  void onInit() {
    super.onInit();
    categoryList.bindStream(FirebaseService().getCategory);
  }

}