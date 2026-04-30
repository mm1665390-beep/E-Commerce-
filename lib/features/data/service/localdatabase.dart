import 'dart:convert';
import 'package:ecommerce/core/errors/exception.dart';

import 'package:ecommerce/features/data/models/productandreviewanddimensionsmodels.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();
  Future<void> cacheProducts(List<ProductModel> products);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String cachedProductsKey = 'CACHED_PRODUCTS';

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final jsonString = sharedPreferences.getString(cachedProductsKey);

    if (jsonString == null) {
      throw EmptyCacheException();
    }

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final String jsonString = jsonEncode(
      products.map((product) => product.toJson()).toList(),
    );

    await sharedPreferences.setString(cachedProductsKey, jsonString);
  }
}
