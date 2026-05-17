import 'package:ecommerce/features/presentation/bloc/cart/cubit/cart_item_cubit.dart';
import 'package:ecommerce/features/presentation/bloc/product/cubit/products_cubit.dart';
import 'package:ecommerce/features/presentation/pages/cart_screen.dart';
import 'package:ecommerce/features/presentation/pages/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '🛍️ Shop',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          BlocBuilder<CartItemCubit, CartItemState>(
            builder: (context, state) {
              final count =
                  state is CartUpdated ? state.totalQuantity : 0;
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(Icons.shopping_bag_outlined,
                          color: Colors.black, size: 28),
                      if (count > 0)
                        Positioned(
                          right: 0,
                          top: 4,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xFF6C63FF),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '$count',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF6C63FF)),
            );
          }

          if (state is ProductError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off_rounded,
                      size: 72, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () =>
                        context.read<ProductsCubit>().getAllProducts(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try Again'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is ProductLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.70,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: state.products[index]);
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
