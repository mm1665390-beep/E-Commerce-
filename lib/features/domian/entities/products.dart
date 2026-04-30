import 'package:ecommerce/features/domian/entities/dimensions.dart';
import 'package:ecommerce/features/domian/entities/review.dart';


class Products {
  final int id;
  final String title;
  final double price;
  final double rating;
  final String thumbnail;
  final List<String> images;
  final Dimensions? dimensions;
  final List<Review> reviews;

  Products({
    required this.id,
    required this.title,
    required this.price,
    required this.rating,
    required this.thumbnail,
    required this.images,
    required this.dimensions,
    required this.reviews,
  });
}
