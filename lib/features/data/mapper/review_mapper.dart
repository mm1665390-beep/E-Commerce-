import 'package:ap/features/data/models/productandreviewanddimensionsmodels.dart';


extension ReviewMapper on Reviews{
  Reviews toEntity(){
    return Reviews(
    rating: rating ,
    comment: comment,
    reviewerName: reviewerName ,
    );
  }
}