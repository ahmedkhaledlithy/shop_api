import 'package:dsc_shop/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsApi {

  List<Product> _productsList=[];

  Future<List<Product>>fetchAllProducts() async {

    http.Response futureProducts = await http.get(Uri.parse("https://fakestoreapi.com/products"));
     try{
       if (futureProducts.statusCode == 200) {
         var jsonData = jsonDecode(futureProducts.body);

         for (var item in jsonData) {
           _productsList.add(Product.fromJson(item));
         }

       } else {
         throw Exception("can not load data from server");
       }
     }catch(e){
       debugPrint(e.toString());
     }
    return _productsList;
  }










}



