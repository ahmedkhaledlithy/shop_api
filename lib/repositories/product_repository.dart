import 'package:dsc_shop/models/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> fetchAllProducts();
}