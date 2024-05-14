import 'dart:convert';

import 'package:dart_coco_application/domain/model/categories_model.dart';

class CategoriesMapper {
  static CategoriesModel categoriesModelFromJson(String str) => CategoriesModel(
      categories: List<String>.from(json.decode(str).map((x) => x)));
}
