import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/product_controller.dart';
import 'package:asher_store/controller/wishlist_controller.dart';
import 'package:asher_store/model/product_model.dart';
import 'package:asher_store/screen/product/product_details.dart';
import 'package:asher_store/screen/search/search_page.dart';
import 'package:asher_store/widget/currency_textview.dart';
import 'package:asher_store/widget/set_cachednetworkimage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _wishlistController = Get.find<WishListController>();
    _wishlistController.refreshWishListData();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('wishlist_title'.tr),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => Get.to(() => const SearchPage(searchKey: '')),
              icon: const Icon(Icons.search)
            ),
          )
        ],
      ),
      body: Obx((){
        return Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: _wishlistController.wishlist.isEmpty ? 
          _emptyWishlistScreen() : 
          _productGridView(_wishlistController.wishProductList, _wishlistController.wishProductList.length)
        );
      })
    );
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
        return tempList.isEmpty || tempList.length <= index ?
        Container(
          height: itemWidth - 30,
          color: const Color(cGrey),
          margin: const EdgeInsets.only(bottom: 10),
        ):
        GestureDetector(
          onTap: () => Get.to(() => ProductDetails(productModel: tempList[index])),
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

  Widget _emptyWishlistScreen() {

    final _productController = Get.find<ProductController>();
    
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [

        Padding(
          padding: const EdgeInsets.only(top:20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icon/ic_heart.png', 
                color: Colors.grey,
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 40),
                child: Text(
                  'empty_wishlist'.tr,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),

            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            'recommendation_item'.tr,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: xTextSize18),
          ),
        ),
        _productGridView(_productController.productList, _productController.productList.length)
      ],
    );
  }

  
}