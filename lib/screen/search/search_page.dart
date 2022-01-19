import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/category_controller.dart';
import 'package:asher_store/controller/product_controller.dart';
import 'package:asher_store/controller/searchpage_controller.dart';
import 'package:asher_store/model/product_model.dart';
import 'package:asher_store/screen/product/product_details.dart';
import 'package:asher_store/widget/currency_textview.dart';
import 'package:asher_store/widget/set_cachednetworkimage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SearchPage extends StatelessWidget {
  final String searchKey;
  const SearchPage({ Key? key, required this.searchKey }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _searchController = Get.put(SearchPageController());

    if(searchKey.isNotEmpty){
      _searchController.queryStringfromCategory(searchKey);
    }

    return Scaffold(
      appBar: _buildSearchAppbar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Obx((){
          return Column(
            children: [
              searchKey == '' || _searchController.categoryCurrentIndex.value != 9999999 || _searchController.searchFliedController.text.isNotEmpty ? Container() :
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 20),
                child: Text(
                  '共找到 ${_searchController.searchResultList.length} 筆 "$searchKey" 的相關資料',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              searchKey == '' && _searchController.searchFliedController.text.isEmpty && _searchController.searchResultList.isEmpty ?
              Expanded(
                child: _buildProductGirdView(Get.find<ProductController>().productList)
              ):
              Expanded(
                child: _searchController.searchFliedController.text.isNotEmpty || _searchController.searchResultList.isNotEmpty ?
                _buildProductGirdView(_searchController.searchResultList) :
                const Center(
                  child: Text(
                    '找不到捜尋結果',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              )
            ],
          );
        })
      )
    );
  }

  AppBar _buildSearchAppbar(){

    final _categoryController = Get.find<CategoryController>();
    final _searchController = Get.find<SearchPageController>();
    
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Container(
        decoration: const BoxDecoration(
          color: Color(cGrey),
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back, size: 20)
            ),
            Expanded(
              child: TextField(
                controller: _searchController.searchFliedController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(0),
                isDense: true,
                hintText: '輸入產品名稱',
              ),
                onSubmitted: (value) => _searchController.queryfromString()
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(Icons.search),
            )
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          height: 40,
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: ListView.builder(
            itemCount: _categoryController.categoryList.value.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
                return Obx((){
                  return GestureDetector(
                  onTap: () {
                    _searchController.queryfromCategory(index, _categoryController.categoryList.value[index].name);
                    
                  } ,
                  child: _categoryController.categoryList.value[index].quickSearch == false ? Container() :
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: index == _searchController.categoryCurrentIndex.value ? const Color(xMainColor) : Colors.transparent,
                      border: Border.all(
                        width: 1.0,
                        color: const Color(xMainColor)
                      ),
                      borderRadius: BorderRadius.circular(99)
                    ),
                    child: Center(
                      child: Text(
                        _categoryController.categoryList.value[index].name,
                        style: index == _searchController.categoryCurrentIndex.value ?
                        const TextStyle(color: Colors.white) :
                        const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                );
              });
            }
          )
        ),
      )
    );
  }


  Widget _buildProductGirdView(List<ProductModel> list){
    if(list.isEmpty){
      return const Center(
        child: Text(
          '找不到捜尋結果',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
    return _productGridView(list, list.length);
  }

  Widget _productGridView(List<ProductModel> list, int listLength){

    var size = MediaQuery.of(Get.context!).size;
    final double itemWidth = size.width / 2;
    final double itemHeight = itemWidth + 80;
    List<ProductModel> tempList = [];
    tempList.addAll(list);
    tempList.shuffle();

    return GridView.builder(
      shrinkWrap: true,
      itemCount: listLength,
      padding: const EdgeInsets.all(0),
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        childAspectRatio: (itemWidth / itemHeight)
      ),  
      itemBuilder: (context, index){
        // ignore: unnecessary_null_comparison
        return tempList.isEmpty || tempList == null || tempList.length <= index ?
        Container(
          height: itemWidth - 30,
          color: const Color(cGrey),
          margin: const EdgeInsets.only(bottom: 10),
        ):
        GestureDetector(
          onTap: () => Get.to(() => ProductDetails(productModel: list[index])),
          child: Column(
            children: [

              SizedBox(
                height: itemWidth - 30,
                child: Stack(
                  children: [

                    SizedBox(
                      width: itemWidth,
                      child: ClipRRect(borderRadius: BorderRadius.circular(7),
                        child: SetCachNetImage(
                          imageUrl: tempList[index].imagePatch![0].toString(), 
                          boxFit: BoxFit.fitWidth,
                          bgColor: const Color(cGrey),
                          loadingWidget: const LoadingIndicator(
                            indicatorType: Indicator.lineScalePulseOutRapid,
                            colors: [Color(xMainColor)],
                          )
                        )
                      ),
                    ),

                    tempList[index].tag!.isEmpty ? Container() :
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                        color: Colors.white.withOpacity(0.6),
                        child: Text(
                          tempList[index].tag!
                        ),
                      )
                    ),

                  ],
                ),
              ),
            
              Container(
                padding: const EdgeInsets.only(top: 10),
                height: 50,
                child: Column(
                  children: [

                    // Product Price
                    tempList[index].discountPrice == 0 ? 
                    const Text('') : 
                    CurrencyTextView(
                      value: tempList[index].price!, 
                      textStyle: const TextStyle(
                        fontSize: xTextSize11,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),

                    //  Product Price
                    CurrencyTextView(
                      value: tempList[index].discountPrice! == 0 ? tempList[index].price! : tempList[index].discountPrice!, 
                      textStyle: TextStyle(
                        fontSize: xTextSize16,
                        color: tempList[index].discountPrice == 0 ? Colors.black : const Color(cPink),
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }



}