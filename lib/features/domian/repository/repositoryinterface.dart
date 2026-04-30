
import 'package:ecommerce/features/domian/entities/products.dart';

abstract class ProductRepository {
  Future<List<Products>> getAllProducts();
  Future<Products> addProduct(Products product);
}
