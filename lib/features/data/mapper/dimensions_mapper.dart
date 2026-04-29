import 'package:ap/features/domian/entities/dimensions.dart';

extension DimensionsMapper on Dimensions {
  Dimensions toEntity() {
    return Dimensions(width: width, height: height, depth: depth);
  }
}
