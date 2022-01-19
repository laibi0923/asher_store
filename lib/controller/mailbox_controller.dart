import 'package:asher_store/model/mailbox_model.dart';
import 'package:asher_store/screen/mailbox/mailbox_content.dart';
import 'package:asher_store/service/firebase_service.dart';
import 'package:get/get.dart';

class MailboxContorller extends GetxController{

  RxList mailBoxList = <MailBoxModel>[].obs;
  RxList unReadMailBoxList = <MailBoxModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    bindMailboxStream();
  }

  void bindMailboxStream(){
    mailBoxList.bindStream(FirebaseService().getUserMailbox());
    unReadMailBoxList.bindStream(FirebaseService().getUnReadMailbox());
    update();
  }
  
  //  刪除郵件
  void removeMail(String userUid, String docId) {
    FirebaseService().removeMailboxItem(docId);
  }

  //  開啟郵件
  void openMail(String userId, MailBoxModel mailBoxModel){
    if(mailBoxModel.isReaded == false){
      FirebaseService().readedMailBox(mailBoxModel.docId!);
    }
    Get.to(() => MailboxContent(mailBoxModel: mailBoxModel));
  }
  
}