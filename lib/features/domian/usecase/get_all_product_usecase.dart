import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failure.dart';
import 'package:ecommerce/features/domian/entities/products.dart';

import 'package:ecommerce/features/domian/repository/repositoryinterface.dart';

class GetAllProductUsecase {
  final ProductRepository productRepository;

  GetAllProductUsecase({required this.productRepository});

  Future<Either<Failure, List<Products>>> call() async {
    return await productRepository.getAllProducts();
  }
}
