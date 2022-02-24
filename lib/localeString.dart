import 'package:get/get.dart';

class LocaleString extends Translations{

  @override
  Map<String, Map<String, String>> get keys => {

     //ENGLISH LANGUAGE
    'en_US':{
      // Public
      'clear_text' : 'clear',
      'delete_text' : 'delete',
      'submit_text' : 'submit',
      'close_text' : 'close',
      'last_modify' : 'Last Modify : ',
      //  Home
      'recommendation_item' : 'Recommend',
      'hot_item' : 'Hot Item',
      'load_more_product' : 'more...',
      //  WishList
      'wishlist_title' : 'WISHLIST',
      'empty_wishlist' : 'Your wishlist is empty.',
      // Cart
      'cart_title' : 'CART',
      'cart_coupon' : 'Input your coupon code',
      'cart_subamount' : 'Sub Amount',
      'cart_discount' : 'Discount',
      'cart_shipping' : 'Shipping Free \n(Buy 3 get waive)',
      'cart_totalamount' : 'Total Amount',
      'cart_couponcode' : 'Coupon Code',
      'shipping_details_btn1' : 'Signin and continue',
      'shipping_details_btn2' : 'Shipping details and payment',
      'empty_cart_string' : 'Your cart is empty.',
      // Cart Item View
      'cart_itemview_soldout' : 'Sold out',
      // Checkout
      'checkout_title1' : 'Receipient details',
      'checkout_title2' : 'Shipping Address',
      'checkout_select_location' : 'Add shipping address',
      'checkout_sflocker' : 'SF Locker',
      'checkout_shippingto' : 'shipping to...',
      'checkout_saveaddress' : 'save address',
      'checkout_totalpayment' : 'Total payment',
      'checkout_cardpayment' : '輸入信用卡付款',
      //  SF Locker
      'empty_sflocker_text' : 'Cannot found SF Locker',
      'sflocker_text' : 'Search SF Locker',
      // Thankyou Page
      'thankyou_content' : '我們已收到您的訂單 \n 請耐心等侯，我們會盡快將貨品送到你手上。 \n 你隨時可以到訂單紀錄查看您的訂單。',
      // Mailbox
      'mail_title' : 'Notification',
      'join_us_content' : 'We will notification here.',
      'join_us_btn': 'Join us',
      'empty_mail_text': 'You mailbox is empty.',
      // Setting
      'edit_profile' : 'Edit profile',
      'logout_btn' : 'Logout',
      'order_title' : 'Order',
      'order_history' : 'Order history',
      'return_history' : 'Return history',
      'coupon_history' : 'Coupon history',
      'general_setting' : 'General Setting',
      'language_setting' : 'Language',
      'currency_setting' : 'Currency',
      'theme_setting' : 'Theme',
      'contact_us' : 'About us',
      'private_policy' : 'Private policy',
      'return_policy' : 'Return policy',
      // Order History
      'epmty_order_text' : 'Your order history is empty.',
      // Refund History
      'return_order_no' : 'Order No. : ',
      'return_text' : 'Refunded item',
      'empty_return_text' : 'Your refund history is empty',
      // Coupon History
      'coupon_history_title' : 'Coupon used',
      'empty_coupon_text' : 'Your coupon history is empty.',
      'coupon_record_date' : 'Date of use : ',
      'coupon_code_text' : 'Coupon Code : ',
      // Private Policy
      'private_policy_title' : 'Private Policy',
      // Refund Policy
      'refund_polict_title' : 'Refund Policy',
      // Review Order
      'review_order_date' : 'Order Date',
      'review_order_no' : 'Order No.',
      'review_receipient' : 'Receipient Name',
      'review_contact_no' : 'Contact No.',
      'review_shipping_address' : 'Shipping address',
      'review_payment_method' : 'Payment Method',
      // User Information
      'user_info_titile' : 'User Info',
      'user_info_email' : 'Email',
      'user_info_username' : 'User Name',
      'user_info_shippingaddress' : 'Shipping address',
      'user_info_receipient_name' : 'Receipient Name',
      'user_info_contact_no' : 'Contact No.',
      'user_info_unit' : 'Room / Flat',
      'user_info_building' : 'Building',
      'user_info_district' : 'District',
      'user_info_save' : 'Save',
      // Search Page
      'search_find_title1' : 'finded',
      'search_find_title2' : 'records',
      'search_find_title3' : '',
      'search_empty' : 'Product not found',
      'search_searchtext' : 'Enter product name',
      'empty_search_text' : 'Result not found',
      // Product Details
      'product_details_title' : 'Product details',
      'product_details_less' : 'less',
      'product_details_more' : 'more',
      'product_details_shipping_date' : '預計送貨時間約 7-11 天',
      'product_details_size' : 'Size',
      'product_details_color' : 'Color',
      'product_details_addcart' : 'Add to Cart',
      // Email Verify
      'email_verify_content' : '我們已發送確認電郵到閣下郵箱，\n請登入你的電郵點擊生效你的帳戶。',
      'email_verify_usreceivedemail' : '還沒有收到電郵嗎?',
      'email_verify_resendemail' : 'Re-send verify email',
      // Login Page
      'login_email' : 'Email',
      'login_pw' : 'Password',
      'login_forgotpw' : 'Forgot password?',
      'login_logintext' : 'Login',
      // Register
      'register_email' : 'Email',
      'register_pw' : 'Password',
      'register_pw2' : 'Confirme password',
      'register_registertext' : 'Register',
    },

     // 繁體
    'zh_TW':{
      // Public
      'clear_text' : '清除',
      'delete_text' : '刪除',
      'submit_text' : '確認',
      'close_text' : '關閉',
      'last_modify' : '上次修改時間 : ',
      //  Home
      'recommendation_item' : '為你推薦',
      'hot_item' : '人氣排行榜',
      'load_more_product' : '更多推薦產品',
      //  WishList
      'wishlist_title' : '喜愛清單',
      'empty_wishlist' : '還沒有加入喜愛商品',
      // Cart
      'cart_title' : '購物車',
      'cart_coupon' : '輸入優惠代碼',
      'cart_subamount' : '小計',
      'cart_discount' : '折扣',
      'cart_shipping' : '運費 (滿3件免運費)',
      'cart_totalamount' : '總計',
      'cart_couponcode' : '優惠代碼',
      'shipping_details_btn1' : '登入會員後結帳',
      'shipping_details_btn2' : '輸入運送地址及付款',
      'empty_cart_string' : '你的購物車已空',
      // Cart Item View
      'cart_itemview_soldout' : '此貨品已下架',
      // Checkout
      'checkout_title1' : '收件人資料',
      'checkout_title2' : '運送地址',
      'checkout_select_location' : '點擊選擇地點',
      'checkout_sflocker' : '順豐智能櫃',
      'checkout_shippingto' : '送貨至...',
      'checkout_saveaddress' : '保存運送地址',
      'checkout_totalpayment' : '付款總額',
      'checkout_cardpayment' : '輸入信用卡付款',
      //  SF Locker
      'empty_sflocker_text' : '找不到你所輸入的智能櫃',
      'sflocker_text' : '搜尋智能櫃',
      // Thankyou Page
      'thankyou_content' : '我們已收到您的訂單 \n 請耐心等侯，我們會盡快將貨品送到你手上。 \n 你隨時可以到訂單紀錄查看您的訂單。',
      // Mailbox
      'mail_title' : '通知',
      'join_us_content' : '快啲加入我地成為會員啦\n我地定期都會推出新產品同好多最新優惠, 想拎多啲著數? 加入我地, 一有就會係呢到通知精明既你架啦!!!',
      'join_us_btn': '加入成為會員',
      'empty_mail_text': '一有新通知即時會通知你',
      // Setting
      'edit_profile' : '編輯你的個人資料',
      'logout_btn' : '登出',
      'order_title' : '訂單',
      'order_history' : '訂單紀錄',
      'return_history' : '退貨紀錄',
      'coupon_history' : '優惠代碼紀錄',
      'general_setting' : '一般設定',
      'language_setting' : '語言',
      'currency_setting' : '貨幣',
      'theme_setting' : '暗黑模式',
      'contact_us' : '關於我們',
      'private_policy' : '私隱政策',
      'return_policy' : '退貨政策',
      // Order History
      'epmty_order_text' : '你仲未有訂單喎!!!\n\n快啲幫襯下支持下我地啦!!!',
      // Refund History
      'return_order_no' : '訂單編號 : ',
      'return_text' : '已退出貨品',
      'empty_return_text' : '沒有退貨紀錄',
      // Coupon History
      'coupon_history_title' : '已使用優惠代碼',
      'empty_coupon_text' : '尚未有任何紀錄',
      'coupon_record_date' : '使用日期 : ',
      'coupon_code_text' : '優惠碼 : ',
      // Private Policy
      'private_policy_title' : '隱私政策',
      // Refund Policy
      'refund_polict_title' : '退貨政策',
      // Review Order
      'review_order_date' : '訂單日期',
      'review_order_no' : '訂單編號',
      'review_receipient' : '收件人',
      'review_contact_no' : '聯絡電話',
      'review_shipping_address' : '運送地址',
      'review_payment_method' : '支付方式',
      // User Information
      'user_info_titile' : '個人資料',
      'user_info_email' : '用戶電郵',
      'user_info_username' : '用戶名稱',
      'user_info_shippingaddress' : '送貨地址',
      'user_info_receipient_name' : '收件人名稱',
      'user_info_contact_no' : '聯絡電話',
      'user_info_unit' : '室 / 樓層',
      'user_info_building' : '大廈名稱',
      'user_info_district' : '屋苑名稱 / 地區',
      'user_info_save' : '保存',
      // Search Page
      'search_find_title1' : '共找到',
      'search_find_title2' : '筆',
      'search_find_title3' : '的相關資料',
      'search_empty' : '找不到捜尋結果',
      'search_searchtext' : '輸入產品名稱',
      'empty_search_text' : '找不到捜尋結果',
      // Product Details
      'product_details_title' : '產品資訊',
      'product_details_less' : '收起',
      'product_details_more' : '更多',
      'product_details_shipping_date' : '預計送貨時間約 7-11 天',
      'product_details_size' : '呎碼',
      'product_details_color' : '顏色',
      'product_details_addcart' : '加入購物車',
      // Email Verify
      'email_verify_content' : '我們已發送確認電郵到閣下郵箱，\n請登入你的電郵點擊生效你的帳戶。',
      'email_verify_usreceivedemail' : '還沒有收到電郵嗎?',
      'email_verify_resendemail' : '重新發送確認電郵',
      // Login Page
      'login_email' : '電子郵件',
      'login_pw' : '密碼',
      'login_forgotpw' : '忘記密碼',
      'login_logintext' : '登入',
      // Register
      'register_email' : '電子郵件',
      'register_pw' : '密碼',
      'register_pw2' : '確認密碼',
      'register_registertext' : '註冊',

    }
  };
  

}