import 'package:ecommerce/features/domian/entities/dimensions.dart';
import 'package:ecommerce/features/domian/entities/meta.dart';
import 'package:ecommerce/features/domian/entities/products.dart';
import 'package:ecommerce/features/domian/entities/review.dart';

class ProductModel extends Products {

  final String? description;
  final String? category;
  final double? discountPercentage;
  final int? stock;
  final List<String>? tags;
  final String? brand;
  final String? sku;
  final int? weight;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final String? returnPolicy;
  final int? minimumOrderQuantity;
  final Meta? meta;

  ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.rating,
    required super.images,    
    required super.reviews,   
    required super.thumbnail, 
    super.dimensions,         
    this.description,
    this.category,
    this.discountPercentage,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'] ?? '',
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      thumbnail: json['thumbnail'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      reviews: json['reviews'] != null
          ? List<Review>.from(                        
              json['reviews'].map((v) => Review.fromJson(v))) // 
          : [],
      description: json['description'],
      category: json['category'],
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      stock: json['stock'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      brand: json['brand'],
      sku: json['sku'],
      weight: json['weight'],
      dimensions: json['dimensions'] != null
          ? Dimensions.fromJson(json['dimensions'])
          : null,
      warrantyInformation: json['warrantyInformation'],
      shippingInformation: json['shippingInformation'],
      availabilityStatus: json['availabilityStatus'],
      returnPolicy: json['returnPolicy'],
      minimumOrderQuantity: json['minimumOrderQuantity'],
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'rating': rating,
      'thumbnail': thumbnail,
      'images': images,
      'reviews': reviews.map((v) => v.toJson()).toList(),
      'description': description,
      'category': category,
      'discountPercentage': discountPercentage,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'sku': sku,
      'weight': weight,
      'dimensions': dimensions?.toJson(),
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'meta': meta?.toJson(),
    };
  }
}