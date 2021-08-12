import 'package:dsc_shop/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsApi {


  Future<List<Product>>fetchAllProducts() async {
    List<Product>productsList=[];

    http.Response futureProducts = await http.get(Uri.parse("https://fakestoreapi.com/products"));

    if (futureProducts.statusCode == 200) {
      var jsonData = jsonDecode(futureProducts.body);


      for (var item in jsonData) {


        productsList.add(Product.fromJson(item));

      }
    } else {
      throw Exception("can not load data from server");
    }
    return productsList;
  }


}