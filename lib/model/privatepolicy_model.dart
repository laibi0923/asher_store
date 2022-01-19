import 'package:cloud_firestore/cloud_firestore.dart';

class PrivatePolicyModel{
  Timestamp? lastModify;
  String? content;
  PrivatePolicyModel({this.lastModify, this.content});

  PrivatePolicyModel.fromFirestore(Map<String, dynamic> dataMap):
    lastModify = dataMap['LAST_MODIFY'],
    content = dataMap['CONTENT'];

}