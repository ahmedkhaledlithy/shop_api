import 'package:dsc_shop/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsApi extends ChangeNotifier{

  List<Product>productsList=[];
  Future<List<Product>>fetchAllProducts() async {


    http.Response futureProducts = await http.get(Uri.parse("https://fakestoreapi.com/products"));

    if (futureProducts.statusCode == 200) {
      var jsonData = jsonDecode(futureProducts.body);


      for (var item in jsonData) {
        productsList.add(Product.fromJson(item));
        notifyListeners();
      }
    } else {
      throw Exception("can not load data from server");
    }
    notifyListeners();
    return productsList;
  }


}