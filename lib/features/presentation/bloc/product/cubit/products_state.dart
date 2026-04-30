part of 'products_cubit.dart';

abstract class ProductsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsState {}

class ProductLoading extends ProductsState {}

class ProductLoaded extends ProductsState {
  final List<Products> products;
  ProductLoaded({required this.products});
  @override
  List<Object> get props => [products];
}

class ProductError extends ProductsState {
  final String message;
  ProductError({required this.message});
    @override
  List<Object> get props => [message];
}

class ProductAdded extends ProductsState {}
