import 'package:ap/features/data/models/productandreviewanddimensionsmodels.dart';

class Postmodelentities {
  final int id;
  final String title;
  final double price;
  final double rating;
  final String thumbnail;
  final List<String> images;
  final Dimensions? dimensions;
  final List<Reviews> reviews;

  Postmodelentities({
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
