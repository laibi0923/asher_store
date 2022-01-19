import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/product_photoview_controller.dart';
import 'package:asher_store/widget/set_cachednetworkimage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ProductPhotoView extends StatelessWidget {
  const ProductPhotoView({ Key? key, required this.imageList, required this.initPage }) : super(key: key);

  final List<dynamic> imageList;
  final int initPage;
  

  @override
  Widget build(BuildContext context) {

    final productPhotoViewController = Get.put(ProductPhotoViewController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: productPhotoViewController.photoViewPageController,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: imageList.length,
            itemBuilder: (context, index){
              return InteractiveViewer(
                child: SetCachNetImage(
                  imageUrl: imageList[index], 
                  boxFit: BoxFit.fitWidth,
                  bgColor: Colors.black,
                  loadingWidget: const LoadingIndicator(
                    indicatorType: Indicator.lineScalePulseOutRapid,
                    colors: [Color(xMainColor)],
                  )
                )
              );
            }
          ),

          Positioned(
            top: 40,
            right: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: IconButton(
                onPressed: () => productPhotoViewController.getBack(),
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            ),
          )

        ],
      )
    );
  }
}
