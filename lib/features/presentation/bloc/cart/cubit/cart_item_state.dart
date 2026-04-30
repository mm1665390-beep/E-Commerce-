part of 'cart_item_cubit.dart';

sealed class CartItemState extends Equatable {
  const CartItemState();
  @override
  List<Object> get props => [];
}

final class CartItemInitial extends CartItemState {}


class CartUpdated extends CartItemState {
  final List<CartItem> items;

  const CartUpdated({required this.items});

  int get totalQuantity => items.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice =>
      items.fold(0.0, (sum, item) => sum + item.totalPrice);

  @override
  List<Object> get props => [items];
}
