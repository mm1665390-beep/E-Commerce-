import 'package:ecommerce/features/domian/entities/cart_item.dart';
import 'package:ecommerce/features/presentation/bloc/cart/cubit/cart_item_cubit.dart';
import 'package:ecommerce/features/presentation/widgets/qty_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartItemCubit>();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.products.thumbnail,
              width: 85,
              height: 85,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 85,
                height: 85,
                color: Colors.grey.shade100,
                child: const Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.products.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${item.products.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Color(0xFF6C63FF),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    // Quantity Controls
                    QtyButton(
                      icon: Icons.remove,
                      onTap: () => cubit.updateQuantity(
                        item.products.id,
                        item.quantity - 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        '${item.quantity}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    QtyButton(
                      icon: Icons.add,
                      onTap: () => cubit.updateQuantity(
                        item.products.id,
                        item.quantity + 1,
                      ),
                    ),
                    const Spacer(),
                    // Item Total
                    Text(
                      '\$${item.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () => cubit.removeFromCart(item.products.id),
          ),
        ],
      ),
    );
  }
}
