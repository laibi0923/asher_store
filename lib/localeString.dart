import 'package:get/get.dart';

class LocaleString extends Translations{

  @override
  Map<String, Map<String, String>> get keys => {

     //ENGLISH LANGUAGE
    'en_US':{
      'recommendation_item' : 'Recommend',
      'hot_item' : 'Hot Item',
      'load_more_product' : 'more...',
    },

     //HINDI LANGUAGE
    'zh_TW':{
      'recommendation_item' : '為你推薦',
      'hot_item' : '人氣排行榜',
      'load_more_product' : '更多推薦產品',
    },
    
  };
  

}