import 'package:ap/features/data/mapper/review_mapper.dart';
import 'package:ap/features/data/models/productandreviewanddimensionsmodels.dart';

extension ProductMapper on ProductModel {
  ProductModel toEntity() {
    return ProductModel(
      id: id,
      title: title,
      price: price,
      rating: rating,
      thumbnail: thumbnail,
      images: images,
      dimensions: dimensions,
      reviews: reviews!.map((e) => e.toEntity()).toList(),
    );
  }
}
