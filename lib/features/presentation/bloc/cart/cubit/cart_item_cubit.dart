import 'package:bloc/bloc.dart';
import 'package:ecommerce/features/domian/entities/cart_item.dart';
import 'package:ecommerce/features/domian/entities/products.dart';
import 'package:equatable/equatable.dart';

part 'cart_item_state.dart';

class CartItemCubit extends Cubit<CartItemState> {
  CartItemCubit() : super(CartItemInitial());
  List<CartItem> get _currentItems =>
      state is CartUpdated ? (state as CartUpdated).items : [];

  void addToCart(Products product) {
    final items = List<CartItem>.from(_currentItems);
    final index = items.indexWhere((e) => e.products.id == product.id);

    if (index != -1) {
      items[index] = items[index].copywith(quantity: items[index].quantity + 1);
    } else {
      items.add(CartItem(quantity: 1, products: product));
    }

    emit(CartUpdated(items: items));
  }

  void removeFromCart(int productId) {
    final items = _currentItems
        .where((e) => e.products.id != productId)
        .toList();
    emit(CartUpdated(items: items));
  }

  void updateQuantity(int productId, int quantity) {
    final items = List<CartItem>.from(_currentItems);
    final index = items.indexWhere((e) => e.products.id == productId);

    if (index != -1) {
      if (quantity <= 0) {
        items.removeAt(index);
      } else {
        items[index] = items[index].copywith(quantity: quantity);
      }
    }

    emit(CartUpdated(items: items));
  }

  void clearCart() {
    emit(CartUpdated(items: []));
  }
}
