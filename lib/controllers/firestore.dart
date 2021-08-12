import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_shop/models/user.dart';
import 'package:flutter/material.dart';

class DataBase extends ChangeNotifier{

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("Users");


  Future<void> addUser(Users user) async {
     await userCollection.doc(user.id).set(user.toJson());
     notifyListeners();
  }


}