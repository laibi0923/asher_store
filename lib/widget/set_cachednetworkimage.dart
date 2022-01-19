import 'package:asher_store/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SetCachNetImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit? boxFit;
  final Color? bgColor;
  final Widget? loadingWidget;
  const SetCachNetImage({ Key? key, this.imageUrl, this.boxFit, this.bgColor, this.loadingWidget }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: boxFit,
      placeholder: (context, url){
        return Container(
          color: bgColor,
          child: Center(
            child: SizedBox(
              width: 30,
              child: loadingWidget,
            ),
          ),
        );
      },
      errorWidget: (context, url, error){
        return const Center(
          child: Icon(
            Icons.broken_image,
            color: Color(cGrey),
          ),
        );
      },
    );
  }
}

Widget setCachedNetworkImage(String imageUrl, BoxFit boxFit, Color bgColor, Widget loadingWidget){
  return CachedNetworkImage(
    imageUrl: imageUrl,
    placeholder: (context, url) {
      return Container(
        color: bgColor,
        child: Center(
          child: SizedBox(
            width: 30,
            child: loadingWidget,
            // child: LoadingIndicator(
            //   indicatorType: Indicator.lineScalePulseOutRapid,
            //   colors: [Color(xMainColor)],
            // ),
          ),
        ),
      );
    } ,
    errorWidget: (context, url, error) {
      return const Center(
        child: Icon(
          Icons.broken_image, 
          color:Color(cGrey)
        ),
      );
    },
    fit: boxFit,
  );
}