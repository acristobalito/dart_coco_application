import 'package:dart_coco_application/domain/model/rating_model.dart';

class RatingMapper {
  static Rating ratingFromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
      );
}
