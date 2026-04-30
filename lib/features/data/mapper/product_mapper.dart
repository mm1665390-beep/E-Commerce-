import 'package:ecommerce/features/data/models/productandreviewanddimensionsmodels.dart';

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
      reviews: reviews,
    );
  }
}
