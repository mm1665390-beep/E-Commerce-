import 'package:ecommerce/core/errors/exception.dart';
import 'package:ecommerce/core/errors/failure.dart';
import 'package:ecommerce/core/networks/networkinfo.dart';
import 'package:ecommerce/features/data/models/productandreviewanddimensionsmodels.dart';
import 'package:ecommerce/features/data/service/Localdatabase.dart';
import 'package:ecommerce/features/data/service/apimethod.dart';
import 'package:ecommerce/features/domian/entities/products.dart';
import 'package:ecommerce/features/domian/repository/repositoryinterface.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<Products>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final List<ProductModel> products = await remoteDataSource
            .getAllProducts('products');
        await localDataSource.cacheProducts(products);
        return products;
      } on ServerException {
        throw ServerFailure();
      }
    } else {
      try {
        return await localDataSource.getCachedProducts();
      } on EmptyCacheException {
        throw EmptyCacheFailure();
      }
    }
  }

  @override
  Future<Products> addProduct(Products product) async {
    if (await networkInfo.isConnected) {
      try {
        final productModel = product as ProductModel;
        await remoteDataSource.addProduct(
          'products/add',
          productModel.toJson(),
        );
        return product; //
      } on ServerException {
        throw ServerFailure();
      }
    } else {
      throw OfflineFailure();
    }
  }
}
