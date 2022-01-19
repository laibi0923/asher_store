import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/product_details_controller.dart';
import 'package:asher_store/model/product_model.dart';
import 'package:asher_store/widget/currency_textview.dart';
import 'package:asher_store/widget/set_cachednetworkimage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'package:loading_indicator/loading_indicator.dart';


class ProductDetails extends StatelessWidget {

  final ProductModel productModel;
  const ProductDetails({ Key? key, required this.productModel }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          //  產品圖片
          _productImagePageView(),

          //  關閉
          _closeCircleButton(),

          //  加入收藏清單
          _addToWishListButton(),

          //  加入購物車
          _addToCartButton(),

          //  產品圖片計算器
          _productImageCounter(),

          //  分享
          // _sharedButton(),

        ],
      ),
    );
  }

  //  產品圖片
  Widget _productImagePageView(){

    final _productDetailsController = Get.put(ProductDetailsController());

    return PageView.builder( 
      controller: _productDetailsController.pageController,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: productModel.imagePatch!.length,
      onPageChanged: (index) => _productDetailsController.imageIndex.value = index + 1,
      itemBuilder: (context, index){
        return GestureDetector(
          onTap: () => _productDetailsController.jumpToPage(productModel.imagePatch!, index),
          child: SetCachNetImage(
            imageUrl: productModel.imagePatch![index],
            boxFit: BoxFit.cover,
            bgColor: const Color(cGrey),
            loadingWidget: const LoadingIndicator(
              indicatorType: Indicator.lineScalePulseOutRapid,
              colors: [Color(xMainColor)],
            )
          )
        );
      }
    );
  }

  //  加入收藏清單
  Widget _addToWishListButton(){
    final _productDetailsController = Get.find<ProductDetailsController>();
    _productDetailsController.checkOnWishlist(productModel.productNo!);
    return Obx((){
      return Positioned(
        top: 60,
        left: 15,
        child: GestureDetector(
          onTap: () => _productDetailsController.addToWishList(productModel),
          child: Container(
            height: 42,
            width: 42,
            padding: const EdgeInsets.all(8),
            decoration:const BoxDecoration(
              color: Color(0x90000000),
              borderRadius: BorderRadius.all(
                Radius.circular(99)
              )
            ),
            child: Center(
              child: Image(
                image: _productDetailsController.onWishList.isTrue ? const AssetImage('assets/icon/ic_heart_fill.png') : const AssetImage('assets/icon/ic_heart.png'),
                color: _productDetailsController.onWishList.isTrue? Colors.redAccent : Colors.redAccent,
              ),
            )
          ),
        )
      );
    });
    
  }

  //  關閉
  Widget _closeCircleButton(){
    return Positioned(
      top : 60,
      right: 15,
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          height: 42,
          width: 42,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Color(0x90000000),
            borderRadius: BorderRadius.all(
              Radius.circular(99)
            ),
          ),
          child: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  //  加入購物車
  Widget _addToCartButton(){
    final _productDetailsController = Get.find<ProductDetailsController>();
    return Positioned(
      bottom: 42,
      child: GestureDetector(
        onTap: () => _productDetailsController.showProductDetailsBottomSheet(_bottomSheet()),
        child: SizedBox(
          width: MediaQuery.of(Get.context!).size.width,
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
              decoration: const BoxDecoration(
                color: Color(0x90000000),
                borderRadius: BorderRadius.all(
                  Radius.circular(99),
                ),
              ),
              child: Column(
                children: [
                  CurrencyTextView(
                    value: productModel.discountPrice! == 0 ? productModel.price! : productModel.discountPrice!, 
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                  const Text(
                    '產品資訊',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //  產品圖片計算器
  Widget _productImageCounter(){
    final _productDetailsController = Get.find<ProductDetailsController>();
    return Positioned(
      top: 0,
      left: -15,
      child: SizedBox(
        height: MediaQuery.of(Get.context!).size.height,
        child: Center(
          child: Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.rotationZ(-90 * math.pi / 180),
            child: Container(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
              decoration: const BoxDecoration(
                color: Color(0x90000000),
                borderRadius: BorderRadius.all(
                  Radius.circular(99)
                )
              ),
              child: Obx((){
                return Text(
                  _productDetailsController.imageIndex.value.toString() + ' / ' + productModel.imagePatch!.length.toString(),
                  style: const TextStyle(color: Colors.white),
                );
              })
            ),
          ),
        ),
      )
    );
  }
  
  //  分享
  // Widget _sharedButton(){
  //   return Positioned(
  //     bottom: 42,
  //     right: 15,
  //     child: GestureDetector(
  //       // onTap: () => productDetailsViewModel.sharedProductDetails('collectable43424://productdetails?name=${productModel.productNo}'),
  //       // onTap: () => productDetailsViewModel.sharedProductDetails(
  //       //   productModel.imagePatch[0],
  //       //   'collectable43424://productdetails?name=${productModel.productNo}'
  //       // ),
  //       child: Container(
  //         padding: const EdgeInsets.all(10),
  //         decoration: const BoxDecoration(
  //           color: Color(0x90000000),
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(99)
  //           ),
  //         ),
  //         child: const Icon(
  //           Icons.ios_share,
  //           color: Colors.white
  //         )
  //       ),
  //     )
  //   );
  // }
  
  // 產品細明
  Widget _bottomSheet(){
    final _productDetailsController = Get.find<ProductDetailsController>();
    return Container(
      height: MediaQuery.of(Get.context!).size.height * 0.90,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(17), 
          topRight: Radius.circular(17)
        )
      ),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Center(
            child: Container(
              height: 8,
              width: 60,
              margin:  const EdgeInsets.only(top: 15, bottom: 15),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(99)
              ),
            ),
          ),

          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [

                //  Name
                productModel.productName!.trim() == '' ? Container() :
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                  child: Text(
                    productModel.productName!,
                    style: const TextStyle(
                      fontSize: xTextSize18, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                        
                //  Product No.
                productModel.productName!.trim() == '' ? Container() :
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    productModel.productNo!,
                    style: const TextStyle(
                      color: Colors.grey
                    ),
                  ),
                ),
                
                //  Description
                productModel.description!.trim() == '' ? Container() :
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Obx((){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          productModel.description!,
                          maxLines: _productDetailsController.isExpanedText.value ? 999 : 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.grey, height: 1.5)
                        ),

                        GestureDetector(
                          onTap: () => _productDetailsController.toggleExpandText(),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 10),
                              child: _productDetailsController.isExpanedText.value ? 
                              const Text(
                                '收起',
                                style: TextStyle(color: Colors.grey),
                              ) : 
                              const Text(
                                '更多',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        )

                      ],
                    );
                  })
                ),

                //  Price
                productModel.price == null ? Container() :
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(top: 20, right: 20),
                        child: CurrencyTextView(
                          value: productModel.price!, 
                          textStyle: TextStyle(
                            fontSize: productModel.discountPrice == 0 ? xTextSize18 : xTextSize14, 
                            decoration: productModel.discountPrice == 0 ?  null : TextDecoration.lineThrough
                          ),
                        ),
                      ),
            
                      productModel.discountPrice == 0 ? Container() :
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: CurrencyTextView(
                          value: productModel.discountPrice!, 
                          textStyle: const TextStyle(
                            fontSize: xTextSize18, 
                            color: Color(cPink)
                          ),
                        ),
                      ),
                        
                    ],
                  ),
                ),

                //  Shipping Time
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text('預計送貨時間約 7-11 天'),
                ),

                //  Refundable
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: productModel.refundable == true ? Container() :
                  const Text(
                    refundableText,
                    style: TextStyle(color: Color(cPink)),
                  ),
                ),

                //  Size
                productModel.size == null ? Container() :
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Text(
                        '呎碼',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 30,
                      margin: const EdgeInsets.only(top: 15, bottom: 15),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: productModel.size!.length,
                        itemBuilder: (context, index){
                          return Obx((){
                            return Container(
                              margin: const EdgeInsets.only(left: 15),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all<double>(0),
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                  overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(99),
                                      side: BorderSide(
                                        color: index == _productDetailsController.currentSizeIndex.value ? const Color(xMainColor) : Colors.black,
                                      )
                                    )
                                  )
                                ),
                                onPressed: () => _productDetailsController.currentSizeIndex.value = index, 
                                child: Text(
                                  productModel.size![index], 
                                  style: const TextStyle(color: Colors.black),
                                )
                              ),
                            );
                          });
                        }
                      ),
                    ),
                  ],
                ),

                // Color
                productModel.color == null ? Container() :
                Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Text(
                          '顏色   (${productModel.color![_productDetailsController.currentColorIndex.value]['COLOR_NAME']})',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(top: 15, bottom: 15),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productModel.color!.length,
                          itemBuilder: (context, index){
                            return GestureDetector(
                              onTap: () => _productDetailsController.currentColorIndex.value = index,
                              child: Container(
                                height: 50,
                                width: 50,
                                margin: const EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: index == _productDetailsController.currentColorIndex.value ? const Color(xMainColor) : Colors.black,
                                    width: index == _productDetailsController.currentColorIndex.value ? 2.0 : 1.0
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(99))
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(99),
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      height: 45,
                                      width: 45,
                                      child:  ClipRRect(borderRadius: BorderRadius.circular(99),
                                        child: SetCachNetImage(
                                          imageUrl: productModel.color![index]['COLOR_IMAGE'], 
                                          boxFit: BoxFit.cover,
                                          bgColor: const Color(cGrey),
                                          loadingWidget: const LoadingIndicator(
                                            indicatorType: Indicator.lineScalePulseOutRapid,
                                            colors: [Color(xMainColor)],
                                          )
                                        )
                                      ),
                                    )
                                  ),
                                ),
                              ),
                            );
                          }
                        ),
                      ),
                    ],
                  )
                ),
                
                Container(height: 150,)
                        
              ],
            ),
          ),
  
          //  Add to Cart Button
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(xMainColor),
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
              ),
              onPressed: () => _productDetailsController.addToCart(productModel),
              child: const Text(
                '加入購物車',
              ),
            )
          )
          
        ],
      ),
    );
  }

}