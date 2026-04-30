import 'package:ecommerce/features/domian/entities/products.dart';

class CartItem {
  final int quantity;
  final Products products;
  CartItem({required this.quantity, required this.products});
  CartItem copywith({int? quantity}) {
    return CartItem(products: products, quantity: quantity ?? this.quantity );
  }
  double get totalPrice => products.price * quantity;
}
