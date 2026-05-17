import 'package:ecommerce/features/presentation/bloc/cart/cubit/cart_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/features/domian/entities/products.dart';
import 'package:ecommerce/features/domian/entities/review.dart';
import 'package:ecommerce/features/data/models/productandreviewanddimensionsmodels.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Products product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _currentImage = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final model = product is ProductModel ? product : null;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // ── Image Gallery ──────────────────────────────
              SliverAppBar(
                expandedHeight: 340,
                pinned: true,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: product.images.isNotEmpty
                            ? product.images.length
                            : 1,
                        onPageChanged: (i) => setState(() => _currentImage = i),
                        itemBuilder: (_, i) {
                          final url = product.images.isNotEmpty
                              ? product.images[i]
                              : product.thumbnail;
                          return Image.network(
                            url,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Container(
                              color: Colors.grey.shade100,
                              child: const Icon(
                                Icons.image_not_supported,
                                size: 64,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                      // Dots indicator
                      if (product.images.length > 1)
                        Positioned(
                          bottom: 14,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              product.images.length,
                              (i) => AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                width: _currentImage == i ? 22 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _currentImage == i
                                      ? const Color(0xFF6C63FF)
                                      : Colors.white.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // ── Content ───────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tags row
                      if (model?.category != null || model?.brand != null)
                        Wrap(
                          spacing: 8,
                          children: [
                            if (model?.category != null) _Tag(model!.category!),
                            if (model?.brand != null) _Tag(model!.brand!),
                          ],
                        ),
                      const SizedBox(height: 12),

                      // Title
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Price + Rating + Discount
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6C63FF),
                            ),
                          ),
                          if (model?.discountPercentage != null) ...[
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '-${model!.discountPercentage!.toStringAsFixed(0)}%',
                                style: TextStyle(
                                  color: Colors.green.shade700,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                          const Spacer(),
                          const Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${product.rating.toStringAsFixed(1)} (${product.reviews.length})',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Description
                      if (model?.description != null) ...[
                        const _SectionTitle('Description'),
                        const SizedBox(height: 8),
                        Text(
                          model!.description!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            height: 1.7,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],

                      // Info Grid
                      if (model != null) ...[
                        const _SectionTitle('Details'),
                        const SizedBox(height: 10),
                        _InfoGrid(model: model),
                        const SizedBox(height: 20),
                      ],

                      // Reviews
                      if (product.reviews.isNotEmpty) ...[
                        _SectionTitle('Reviews (${product.reviews.length})'),
                        const SizedBox(height: 12),
                        ...product.reviews.map((r) => _ReviewCard(review: r)),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ── Floating Add to Cart ───────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _AddToCartBar(product: product),
          ),
        ],
      ),
    );
  }
}

// ── Sub-Widgets ─────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFEEECFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF6C63FF),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  final ProductModel model;
  const _InfoGrid({required this.model});

  @override
  Widget build(BuildContext context) {
    final items = <Map<String, String>>[];

    if (model.stock != null) {
      items.add({'e': '📦', 'l': 'Stock', 'v': '${model.stock} units'});
    }
    if (model.availabilityStatus != null) {
      items.add({'e': '✅', 'l': 'Status', 'v': model.availabilityStatus!});
    }
    if (model.shippingInformation != null) {
      items.add({'e': '🚚', 'l': 'Shipping', 'v': model.shippingInformation!});
    }
    if (model.warrantyInformation != null) {
      items.add({'e': '🛡️', 'l': 'Warranty', 'v': model.warrantyInformation!});
    }
    if (model.returnPolicy != null) {
      items.add({'e': '↩️', 'l': 'Returns', 'v': model.returnPolicy!});
    }
    if (model.minimumOrderQuantity != null) {
      items.add({
        'e': '🔢',
        'l': 'Min Order',
        'v': '${model.minimumOrderQuantity}',
      });
    }
    if (model.weight != null) {
      items.add({'e': '⚖️', 'l': 'Weight', 'v': '${model.weight}g'});
    }
    if (model.sku != null) items.add({'e': '🏷️', 'l': 'SKU', 'v': model.sku!});

    if (items.isEmpty) return const SizedBox();

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 2.6,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: items.map((item) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${item['e']} ${item['l']}',
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
              Text(
                item['v']!,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final Review review;
  const _ReviewCard({required this.review});

  String _formatDate(String date) {
    try {
      final d = DateTime.parse(date);
      return '${d.day}/${d.month}/${d.year}';
    } catch (_) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFF6C63FF),
                child: Text(
                  review.reviewerName.isNotEmpty
                      ? review.reviewerName[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.reviewerName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (i) => Icon(
                          Icons.star_rounded,
                          size: 14,
                          color: i < review.rating
                              ? Colors.amber
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                _formatDate(review.date),
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
          if (review.comment.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              review.comment,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AddToCartBar extends StatelessWidget {
  final Products product;
  const _AddToCartBar({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton.icon(
          onPressed: () {
            context.read<CartItemCubit>().addToCart(product);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.title} added to cart! 🛍️'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: const Color(0xFF6C63FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          icon: const Icon(Icons.shopping_bag_outlined),
          label: Text(
            'Add to Cart  •  \$${product.price.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C63FF),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
