import 'package:ecommerce/features/presentation/bloc/cart/cubit/cart_item_cubit.dart';
import 'package:ecommerce/features/presentation/widgets/cartitem_card.dart';
import 'package:ecommerce/features/presentation/widgets/checkout_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          BlocBuilder<CartItemCubit, CartItemState>(
            builder: (context, state) {
              if (state is CartUpdated && state.items.isNotEmpty) {
                return TextButton(
                  onPressed: () => context.read<CartItemCubit>().clearCart(),
                  child: const Text(
                    'Clear',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      body: BlocBuilder<CartItemCubit, CartItemState>(
        builder: (context, state) {
          // ── Empty Cart ─────────────────────────────────────
          if (state is! CartUpdated || state.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEECFF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      size: 72,
                      color: Color(0xFF6C63FF),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Add some products and come back!',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 28),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Continue Shopping',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          }

          // ── Cart Items ─────────────────────────────────────
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    return CartItemCard(item: state.items[index]);
                  },
                ),
              ),
              CheckoutBar(state: state),
            ],
          );
        },
      ),
    );
  }
}

// ── Cart Item Card ──────────────────────────────────────────
