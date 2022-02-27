import 'package:asher_store/constants.dart';
import 'package:asher_store/controller/auth_controller.dart';
import 'package:asher_store/controller/mailbox_controller.dart';
import 'package:asher_store/controller/root_controller.dart';
import 'package:asher_store/screen/mailbox/mailbox_itemview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class MailboxPage extends GetWidget<AuthController> {
  const MailboxPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _mailBoxController = Get.find<MailboxContorller>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text('mail_title'.tr)
        ),
      ),
      body: controller.auth.currentUser == null ? emptyUserMailBoxView() : 
      Obx((){
        return _mailBoxController.mailBoxList.isEmpty ? emptyMailBoxScreen() :
        ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 20, right: 20),
          itemCount: _mailBoxController.mailBoxList.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index){
            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Slidable(
                key: Key(_mailBoxController.mailBoxList[index].docId!),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_) => _mailBoxController.removeMail(controller.userModel.value!.uid!, _mailBoxController.mailBoxList[index].docId!),
                      backgroundColor: const Color(cPink),
                      foregroundColor: const Color(cGrey),
                      icon: Icons.delete,
                      label: 'delete_text'.tr,
                    )
                  ],
                ),
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () => _mailBoxController.openMail(controller.userModel.value!.uid!, _mailBoxController.mailBoxList[index]),
                  child: Container(
                    child: mailboxItemView(
                      _mailBoxController.mailBoxList[index].createDate!, 
                      _mailBoxController.mailBoxList[index].title!, 
                      _mailBoxController.mailBoxList[index].content!, 
                      _mailBoxController.mailBoxList[index].isReaded!
                    ),
                  ),
                )
              ),
            );
          }
        );
      })
    );

  }

  //  無用戶登入
  Widget emptyUserMailBoxView() {

    final _rootController = Get.put(RootController());

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              'join_us_content'.tr,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40,),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary:  const Color(xMainColor),
                elevation: 0,
                shape:  const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
              ),
              onPressed: () => _rootController.jumpToPage(4),
              child: Text(
                'join_us_btn'.tr,
              ),
            ),

          ],
        ),
      ),
    );
  }

  //  空郵件
  Widget emptyMailBoxScreen() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(
              'assets/icon/ic_mail.png', 
              color: Colors.grey,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'empty_mail_text'.tr,
                style: const TextStyle(color: Colors.grey),
              ),
            )
            
          ],
        ),
      ),
    );
  }

}