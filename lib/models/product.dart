import 'package:cloud_firestore/cloud_firestore.dart';

class Product{
  int id;
  String title;
  double price;
  String description;
  String category;
  String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl});

  factory Product.fromJson(Map<String,dynamic>json)
  {
    return Product(
      id: json["id"],
      category: json["category"].toString(),
      price: json["price"],
      description: json["description"].toString(),
      imageUrl: json["image"].toString(),
      title: json["title"].toString(),
    );
  }

}

