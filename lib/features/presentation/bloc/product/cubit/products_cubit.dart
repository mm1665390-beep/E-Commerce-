import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failure.dart';
import 'package:ecommerce/features/domian/entities/products.dart';
import 'package:ecommerce/features/domian/usecase/add_products_usecase.dart';
import 'package:ecommerce/features/domian/usecase/get_all_product_usecase.dart';
import 'package:equatable/equatable.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final AddProducts addProducts;
  final GetAllProductUsecase getAllProductUsecase;
  ProductsCubit({required this.addProducts, required this.getAllProductUsecase})
    : super(ProductsInitial());
  Future<void> getAllProducts() async {
    emit(ProductLoading()); // ✅ بيبعت Loading

    final result = await getAllProductUsecase();

    result.fold(
      (failure) => emit(ProductError(message: failure.message)),
      (products) => emit(ProductLoaded(products: products)),
    );
  }

  Future<Either<Failure, Unit>> addProduct(Products product) async {
    emit(ProductLoading());

    final result = await addProduct(product);

    result.fold(
      (failure) => emit(ProductError(message: failure.message)),
      (_) => emit(ProductAdded()), // ✅ Added
    );
    return result;
  }
}
