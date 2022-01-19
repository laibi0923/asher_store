import 'package:asher_store/screen/product/product_details.dart';
import 'package:asher_store/widget/currency_textview.dart';
import 'package:asher_store/widget/set_cachednetworkimage.dart';
import 'package:flutter/material.dart';
import 'package:asher_store/constants.dart';
import 'package:asher_store/model/product_model.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';


Widget productGridView(List<ProductModel> list){

  var size = MediaQuery.of(Get.context!).size;
  final double itemWidth = size.width / 2;
  final double itemHeight = itemWidth + 80;
  list.shuffle();

  return GridView.builder(
    shrinkWrap: true,
    itemCount: list.length,
    padding: const EdgeInsets.all(0),
    physics: const BouncingScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 20,
      childAspectRatio: (itemWidth / itemHeight)
    ),  
    itemBuilder: (context, index){
      
        // ignore: unnecessary_null_comparison
        return list.isEmpty || list == null || list.length <= index ?
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
                          imageUrl: list[index].imagePatch![0].toString(),
                          boxFit: BoxFit.fitWidth,
                          bgColor: const Color(cGrey),
                          loadingWidget: const LoadingIndicator(
                            indicatorType: Indicator.lineScalePulseOutRapid,
                            colors: [Color(xMainColor)],
                          )
                        )
                      ),
                    ),

                    list[index].tag!.isEmpty ? Container() :
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                        color: Colors.white.withOpacity(0.6),
                        child: Text(
                          list[index].tag!
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
                    list[index].discountPrice == 0 ? 
                    const Text('') : 
                    CurrencyTextView(
                      value: list[index].price!, 
                      textStyle: const TextStyle(
                        fontSize: xTextSize11,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),

                    //  Product Price
                    CurrencyTextView(
                      value: list[index].discountPrice! == 0 ? list[index].price! : list[index].discountPrice!, 
                      textStyle: TextStyle(
                        fontSize: xTextSize16,
                        color: list[index].discountPrice == 0 ? Colors.black : const Color(cPink),
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
