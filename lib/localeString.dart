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
      'cancel_text' : 'cancel',
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
      'checkout_cardpayment' : 'Pay by credit card',
      'checkout_erro_title' : 'Alert',
      'checkout_erro_name' : 'Please input receipient name.',
      'checkout_erro_phone' : 'Please input contact no.',
      'checkout_erro_shippingmethod' : 'Please select shipping method.',
      'checkout_erro_dflockerlocation' : 'Please select SF Locker',
      'checkout_erro_unit' : 'Please input your RM / Unit',
      'checkout_erro_building' : 'Please input your building name.',
      'checkout_erro_district' : 'Please input your district',
      //  SF Locker
      'empty_sflocker_text' : 'Cannot found SF Locker',
      'sflocker_text' : 'Search SF Locker',
      // Thankyou Page
      'thankyou_content' : 'We have received your order. \n Please wait with patience，We will deliver to you as soon as possible. \n And you can check your order at order history.',
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
      'coupon_verify_title' : 'Alert',
      'coupon_code_empty' : 'Please input your coupon code.',
      'coupon_code_used' : 'This code aready used.',
      'coupon_code_exprie' : 'This code was expried.',
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
      'product_details_shipping_date' : 'estimated time of delivery : 7-11 days',
      'product_details_size' : 'Size',
      'product_details_color' : 'Color',
      'product_details_addcart' : 'Add to Cart',
      // Email Verify
      'email_verify_content' : 'We have sent a confirmation email to your email.\nPlease check your email',
      'email_verify_usreceivedemail' : 'Haven\'t received the email yet??',
      'email_verify_resendemail' : 'Re-send verify email',
      // Login Page
      'login_tag' : 'Signin',
      'login_email' : 'Email',
      'login_pw' : 'Password',
      'login_forgotpw' : 'Forgot password?',
      'login_logintext' : 'Login',
      'login_fail_title' : 'Login Fail',
      'login_fail_emptyemail' : 'Please input email address.',
      'login_fail_emptypw' : 'Please input password.',
      'login_fail_incorrectdata' : 'Your email or password is invalid',
      'login_fail_failtoomuch' : 'Please try again later.',
      'login_fail_tryagainlater' : 'Please try again later.',
      // Register
      'register_tag' : 'Register',
      'register_email' : 'Email',
      'register_pw' : 'Password',
      'register_pw2' : 'Confirme password',
      'register_registertext' : 'Register',
      'register_erro_title' : 'Register Fail',
      'register_erro_email' : 'Please input email address.',
      'register_erro_pw' : 'Please input password.',
      'register_erro_confirmpw' : 'Please input password again',
      'register_erro_pwnotmatch' : 'Password is not correct, please check.',
      'register_erro_pwweak' : 'The password is weak.',
      'register_erro_areadyregister' : 'This email is aready use.',
      'register_erro_emailincorrect' : 'Your email is invalid.',
      'register_erro_contactadmin' : 'Please contact adminer.',
      'resetpw_fail_title' : 'Reset password fail',
      'resetpw_fail_emailempty' : 'Please input your email',
      'resetpw_fail_emailincorrect' : 'Your email is invalid',
      'resetpw_sussess' : 'Reset password sussessful.',
      'resetpw_sussess_checkemail' : 'Please check your email.',
      //  Refund
      'refund_title' : 'Alert',
      'refund_cannot_refund' : 'This item cannot be refund.',
      'refund_cannot_refundprocessing' : 'Refund is processing.',
      'refund_cannot_refundprocessing1' : 'Refund is processing, we will contact you.',
      'refund_cannot_refundaready' : 'This item is aready refund.',
      'refund_cannot_onshipping' : 'This item is on shipping.',
      'refund_apply_title' : 'Applying Refund',
      'refund_apply_content' : 'Are you sure refund this item? \n we will contact you by email.',
      // User Info
      'userinfo_title' : 'Update user info.',
      'userinfo_erro_username' : 'The user name cannot be empty.'
    },

     // 繁體
    'zh_TW':{
      // Public
      'clear_text' : '清除',
      'delete_text' : '刪除',
      'submit_text' : '確認',
      'cancel_text' : '取消',
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
      'checkout_erro_title' : '提示',
      'checkout_erro_name' : '請選輸入收件人名稱',
      'checkout_erro_phone' : '請輸入聯絡電話',
      'checkout_erro_shippingmethod' : '請選擇送貨方式',
      'checkout_erro_dflockerlocation' : '請選擇智能櫃地點',
      'checkout_erro_unit' : '請輸入單位或樓層',
      'checkout_erro_building' : '請輸入大廈名稱',
      'checkout_erro_district' : '請輸入地區',

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
      'coupon_verify_title' : '提示',
      'coupon_code_empty' : '請輸入優惠碼',
      'coupon_code_used' : '此優惠代碼您已經使用過',
      'coupon_code_exprie' : '此優惠已失效',
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
      'login_tag' : '登入',
      'login_email' : '電子郵件',
      'login_pw' : '密碼',
      'login_forgotpw' : '忘記密碼',
      'login_logintext' : '登入',
      'login_fail_title' : '登入失敗',
      'login_fail_emptyemail' : '請輸入電郵',
      'login_fail_emptypw' : '請輸入密碼',
      'login_fail_incorrectdata' : '你所輸入的電郵或密碼不正確。',
      'login_fail_failtoomuch' : '由於多次登入失敗，請稍後嘗試。',
      'login_fail_tryagainlater' : '請稍後嘗試',
      // Register
      'register_tag' : '註冊',
      'register_email' : '電子郵件',
      'register_pw' : '密碼',
      'register_pw2' : '確認密碼',
      'register_registertext' : '註冊',
      'register_erro_title' : '註冊失敗',
      'register_erro_email' : '請輸入電郵',
      'register_erro_pw' : '請輸入密碼',
      'register_erro_confirmpw' : '請再次輸入密碼',
      'register_erro_pwnotmatch' : '確認密碼不一致, 請重新輸入',
      'register_erro_pwweak' : '請檢查你的密碼強度',
      'register_erro_areadyregister' : '此電郵已註冊',
      'register_erro_emailincorrect' : '輸入電郵不正確',
      'register_erro_contactadmin' : '請與管理員聮絡',
      'resetpw_fail_title' : '重置密碼失敗',
      'resetpw_fail_emailempty' : '請輸入電郵',
      'resetpw_fail_emailincorrect' : '請輸入正確電郵',
      'resetpw_sussess' : '重置密碼成功',
      'resetpw_sussess_checkemail' : '請檢查你的電子郵箱',
      //  Refund
      'refund_title' : '退貨提示',
      'refund_cannot_refund' : '此貨品不能退貨',
      'refund_cannot_refundprocessing' : '此貨品退貨申請中，請耐心等候',
      'refund_cannot_refundprocessing1' : '此貨品退貨申請成功，稍後時間會有專人與你聯絡，請耐心等候。',
      'refund_cannot_refundaready' : '此貨品已退貨',
      'refund_cannot_onshipping' : '此貨品出貨進行中',
      'refund_apply_title' : '退貨申請',
      'refund_apply_content' : '確定要退此貨品嗎? \n 申請後我們會以電郵形式與您了解。',
      // User Info
      'userinfo_title' : '更新用戶資料',
      'userinfo_erro_username' : '用戶名稱不能為空'
    }
  };
  

}