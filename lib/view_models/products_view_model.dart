import 'dart:collection';
import 'package:dsc_shop/models/product.dart';
import 'package:dsc_shop/repositories/product_api.dart';
import 'package:dsc_shop/repositories/product_repository.dart';
import 'package:flutter/material.dart';


class ProductsViewModel extends ChangeNotifier{

  List<Product> _productsList=[];
  String searchString = "";

  ProductsRepository? productsRepository;
  ProductsViewModel({this.productsRepository});

  UnmodifiableListView<Product> get productsList => searchString.isEmpty||searchString=="" ? UnmodifiableListView(_productsList)
      : UnmodifiableListView(
      _productsList.where((product) => product.title!.toLowerCase().contains(searchString.toLowerCase())).toList());


  Future<void> fetchProducts()async{
    _productsList=await ProductsApi().fetchAllProducts();
    notifyListeners();
  }



  void changeSearchString(String searchString) {
   this.searchString = searchString;
    print(searchString);
    notifyListeners();
  }


}