import 'package:dart_coco_application/data/errors/response_error.dart';
import 'package:dart_coco_application/domain/model/categories_model.dart';
import 'package:dart_coco_application/domain/model/product_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<ResponseError, CategoriesModel>> getAllCategories();
  Future<Either<ResponseError, List<ProductModel>>> getProductsFromCategory(
      String category);
  Future<Either<ResponseError, List<ProductModel>>> getAllProducts();
}
