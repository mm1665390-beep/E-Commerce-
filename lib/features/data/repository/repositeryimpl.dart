import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/exception.dart';
import 'package:ecommerce/core/errors/failure.dart';
import 'package:ecommerce/core/networks/networkinfo.dart';
import 'package:ecommerce/features/data/models/productandreviewanddimensionsmodels.dart';
import 'package:ecommerce/features/data/service/apimethod.dart';
import 'package:ecommerce/features/data/service/localdatabase.dart';
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
  Future<Either<Failure, List<Products>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final List<ProductModel> products = await remoteDataSource
            .getAllProducts('products');
        await localDataSource.cacheProducts(products);
        return Right(products);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cached = await localDataSource.getCachedProducts();
        return Right(cached); //
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addProduct(Products product) async {
    if (await networkInfo.isConnected) {
      try {
        final productModel = product as ProductModel;
        await remoteDataSource.addProduct(
          'products/add',
          productModel.toJson(),
        );
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
