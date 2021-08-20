import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_shop/models/user.dart';


class DataBase {

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("Users");



  Future<void> addUser(Users user) async {
     await userCollection.doc(user.id).set(user.toJson());
  }
  Future<void> updateUser(Users user,Map<String,Object?> data) async {
     await userCollection.doc(user.id).update(data);
  }

  Stream<DocumentSnapshot> getUser(Users user){
    return userCollection.doc(user.id).snapshots();
  }

  Future<DocumentSnapshot> userData(Users user){
    return userCollection.doc(user.id).get();
  }




}