import 'dart:convert';
import 'package:ecommerce/core/constants/app_string.dart';
import 'package:ecommerce/core/errors/exception.dart';
import 'package:ecommerce/features/data/models/productandreviewanddimensionsmodels.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts(String endpoint);
  Future<void> addProduct(String endpoint, Map<String, dynamic> body);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSourceImpl({required this.client});
  @override
  Future<List<ProductModel>> getAllProducts(String endpoint) async {
    try {
      final response = await client.get(
        Uri.parse('$apiBaseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
      );
      final data = _handleResponse(response);
      final List products = data['products'];
      return products.map((e) => ProductModel.fromJson(e)).toList();
    } on http.ClientException {
      throw OfflineException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> addProduct(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await client.post(
        Uri.parse('$apiBaseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      _handleResponse(response);
    } on http.ClientException {
      throw OfflineException();
    } catch (e) {
      throw ServerException();
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      throw ServerException();
    } else if (response.statusCode == 404) {
      throw ServerException();
    } else {
      throw ServerException();
    }
  }
}
