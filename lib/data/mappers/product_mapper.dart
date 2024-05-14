import 'dart:convert';

import 'package:dart_coco_application/data/mappers/rating_mapper.dart';
import 'package:dart_coco_application/domain/model/product_model.dart';

class ProductMapper {
  static ProductModel _productFromJson(Map<String, dynamic> json) =>
      ProductModel(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: RatingMapper.ratingFromJson(json["rating"]),
      );
  static List<ProductModel> productsFromJson(String response) =>
      List<ProductModel>.from(
          json.decode(response).map((x) => _productFromJson(x)));
}
