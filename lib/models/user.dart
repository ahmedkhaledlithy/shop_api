import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String id;
  String? username;
  String? password;
  String? fullName;
  String? address;
  String? phone;
  String? gender;
  String? image;

  Users(
      {required this.id,
       this.username,
               this.password,
       this.fullName,
       this.address,
       this.phone,
       this.gender,
       this.image});

  List<Users> fromQuery(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Users(
        id: doc.get('user_id') ?? '',
        username: doc.get('username') ?? '',
        fullName: doc.get('fullName') ?? '',
        password: doc.get('password') ?? '',
        address: doc.get('address') ?? '',
        phone: doc.get('phone') ?? '',
        gender: doc.get('gender') ?? '',
        image: doc.get('image') ?? '',
      );
    }).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': id,
      'username': username,
      'fullName': fullName,
      'password': password,
      'address': address,
      'phone': phone,
      'gender': gender,
      'image': image,
    };
  }
}
