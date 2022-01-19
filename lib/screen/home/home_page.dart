import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/auth_controller.dart';
import 'package:asher_store/controller/home_controller.dart';
import 'package:asher_store/controller/product_controller.dart';
import 'package:asher_store/model/product_model.dart';
import 'package:asher_store/screen/product/product_details.dart';
import 'package:asher_store/screen/search/search_page.dart';
import 'package:asher_store/widget/currency_textview.dart';
import 'package:asher_store/widget/set_cachednetworkimage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class HomePage extends GetView<AuthController> {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: false,
        headerSliverBuilder: (content, innerBoxIsScrolled) => [ _sliverAppbar() ],
        body: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 20, right: 20),
          children: [
            _bannerListView(),
            _buildLeaderboard(),
            _buildRecommendList()
          ],
        ),
      ),
    );
  }

  SliverAppBar _sliverAppbar(){
    return SliverAppBar(
      elevation: 0,
      floating: true,
      snap: true,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        appName,
        style: GoogleFonts.alice(fontWeight: FontWeight.bold)
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: IconButton(
            onPressed: () => Get.to(() => const SearchPage(searchKey: '',)),
            icon: const Icon(Icons.search)
          ),
        ),
      ],
    );
  }

  Widget _bannerListView(){

    final _homeController = Get.find<HomeController>();

    return ListView.builder(
      itemCount: _homeController.bannerList.value.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index){
        return GestureDetector(
          onTap: () => Get.to(() => SearchPage(searchKey: _homeController.bannerList.value[index].queryString)),
          child: Container(
            height: 220,
            margin: const EdgeInsets.only(bottom: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SetCachNetImage(
                imageUrl: _homeController.bannerList.value[index].bannerUri, 
                boxFit: BoxFit.cover,
                bgColor: const Color(cGrey),
                loadingWidget: const LoadingIndicator(
                  indicatorType: Indicator.lineScalePulseOutRapid,
                  colors: [Color(xMainColor)],
                )
              )
            ),
          ),
        );
      },
    );
  }

  Widget _buildLeaderboard(){

    List<ProductModel> tempList = [];
    tempList.addAll(Get.find<ProductController>().productList);
    tempList.sort((a, b) => (b.sold)!.compareTo(a.sold!));

    var size = MediaQuery.of(Get.context!).size;
      final double itemHeight = size.width / 2;
      final double itemWidth = size.width / 2;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top:20, bottom: 10),
          child: Text(
            '人氣排行榜',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ), 
        
        GridView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            itemCount: 3,
            physics: const BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              childAspectRatio: (itemWidth / itemHeight)
            ),  
            itemBuilder: (context, index){
              return Stack(
                children: [
                  tempList.isEmpty || tempList.length <= index ? 
                  ClipRRect(borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 180,
                      width: 180,
                      color: const Color(cGrey),
                    )
                  ) :
                  GestureDetector(
                    onTap: () => Get.to(() => ProductDetails(productModel: tempList[index])),
                    child: ClipRRect(borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 180,
                        width: 180,
                        color: const Color(cGrey),
                        child: SetCachNetImage(
                          imageUrl: tempList[index].imagePatch![0], 
                          boxFit: BoxFit.cover,
                          bgColor: const Color(cGrey),
                          loadingWidget: const LoadingIndicator(
                            indicatorType: Indicator.lineScalePulseOutRapid,
                            colors: [Color(xMainColor)],
                          )
                        )
                      )
                    ),
                  ),

                  SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      'assets/icon/ic_crown.png',
                      color : 
                      index == 1 ? Colors.white60 : 
                      index == 2 ? const Color(0xFFB87333) : 
                      const Color(0xFFFFD700)
                    ),
                  )

                ],
              );               
            }
        ),
      ],
    );

  }

  Widget _buildRecommendList(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Padding(
          padding: EdgeInsets.only(top:20, bottom: 20),
          child: Text(
            '為你推薦',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ), 

        _productGridView(20),

        InkWell(
          onTap: () => Get.to(() => const SearchPage(searchKey: '新品',)),
          child: Container(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: const Center(
              child: Text('更多推薦產品')
            )
          ),
        ),

      ],
    );

  }

  Widget _productGridView(int listLength){
    
    var size = MediaQuery.of(Get.context!).size;
    final double itemWidth = size.width / 2;
    final double itemHeight = itemWidth + 80;
    List<ProductModel> tempList = [];
    tempList.addAll(Get.find<ProductController>().productList);
    tempList.shuffle();

    return GridView.builder(
      shrinkWrap: true,
      itemCount: listLength,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        childAspectRatio: (itemWidth / itemHeight)
      ),  
      itemBuilder: (context, index){
        return tempList.isEmpty || tempList.length <= index ?
        Column(
          children: [
            Container(
              height: itemWidth - 30,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: const Color(cGrey),
                borderRadius: BorderRadius.circular(7)
              )
            ),
            Container(
              height: 12,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: const Color(cGrey),
                borderRadius: BorderRadius.circular(7)
              )
            ),
            Container(
              height: 12,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: const Color(cGrey),
                borderRadius: BorderRadius.circular(7)
              )
            ),
          ],
        ):
        GestureDetector(
          onTap: () => Get.to(() => ProductDetails(productModel: tempList[index],)),
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
                          boxFit: BoxFit.cover,
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
                        child: Text(tempList[index].tag!),
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
                      value: tempList[index].discountPrice == 0 ? tempList[index].price! : tempList[index].discountPrice!, 
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