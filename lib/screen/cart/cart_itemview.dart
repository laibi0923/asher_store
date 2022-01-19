import 'package:asher_store/model/cart_model.dart';
import 'package:asher_store/model/product_model.dart';
import 'package:asher_store/widget/currency_textview.dart';
import 'package:asher_store/widget/set_cachednetworkimage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:asher_store/constants.dart';
import 'package:loading_indicator/loading_indicator.dart';


Widget cartItemView(CartModel cartdata, ProductModel productdata){

  return Container(
    height: 150,
    padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
    decoration: const BoxDecoration(
      color: Color(cGrey),
      borderRadius: BorderRadius.all(Radius.circular(7))
    ),
    child: Row(
      children: [

        //  Product Image
        Container(
          margin: const EdgeInsets.only(right: 20),
          height: 110,
          width: 110,
          child: ClipRRect(borderRadius: BorderRadius.circular(10),
            child: SetCachNetImage(
              imageUrl: productdata.color![cartdata.color]['COLOR_IMAGE'],
              boxFit: BoxFit.cover,
              bgColor: const Color(cGrey),
              loadingWidget: const LoadingIndicator(
                indicatorType: Indicator.lineScalePulseOutRapid,
                colors: [Color(xMainColor)],
              )
            )
          ),
        ),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //  Product Name
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  productdata.productName!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              const Spacer(),

              //  Instock & Refund
              Row(
                children: [
                  productdata.inStock == false ?
                  Expanded(
                    child: Text(
                      productdata.inStock == false ? '此貨品已下架' : '',
                      style: const TextStyle(color: Color(cPink)),
                    )
                  ) :
                  Expanded(
                    child: Text(
                      productdata.refundable == true ? '' : refundableText,
                      style: const TextStyle(color: Color(cPink)),
                      textAlign: TextAlign.right,
                    )
                  )
                ],
              ),

              const Spacer(),

              Row(
                children: [

                  // Product Color
                  Text(
                    '${productdata.color![cartdata.color]['COLOR_NAME']} | ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  //  Product Size
                  Text(
                    productdata.size![cartdata.size],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  // Prouct Price
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children:  [
                        
                        // 判斷如商品冇特價時不顯示, 相反則顥示正價 (刪除線)
                        productdata.discountPrice == 0 ? Container() :
                        CurrencyTextView(
                          value: productdata.price!, 
                          textStyle: const TextStyle(
                            fontSize: xTextSize11,
                            decoration: TextDecoration.lineThrough
                          ),
                        ),
                        
                        //  判斷如商品冇特價時顯示正價, 相反以紅色顯示特價銀碼
                        productdata.discountPrice != 0 ?
                        CurrencyTextView(
                          value: productdata.discountPrice!, 
                          textStyle: const TextStyle(
                            fontSize: xTextSize14,
                            color: Color(cPink)
                          ),
                        ) :
                        CurrencyTextView(
                          value: productdata.price!, 
                          textStyle: const TextStyle(),
                        )
                
                      ],
                    ),
                  ),

                ],
              ),
              
            ],
          )
        ),

      ],
    ),
  );
}
