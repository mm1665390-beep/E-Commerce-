import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failure.dart';
import 'package:ecommerce/features/domian/entities/products.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Products>>> getAllProducts();
  Future<Either<Failure, Unit>> addProduct(Products product); 
}