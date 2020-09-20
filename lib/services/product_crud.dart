import 'package:cloud_firestore/cloud_firestore.dart';

class crudProduct {
  Future<void> addData(products) async {
    Firestore.instance.collection('products').add(products).catchError((e) {
      print(e);
    });
  }
}
