import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failure.dart';
import 'package:ecommerce/features/domian/entities/products.dart';
import 'package:ecommerce/features/domian/repository/repositoryinterface.dart';

class AddProducts {
  final ProductRepository productRepository;

  AddProducts({required this.productRepository});

  Future<Either<Failure, Unit>> call(Products product) async {
    return await productRepository.addProduct(product);
  }
}
