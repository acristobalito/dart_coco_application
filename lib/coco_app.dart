import 'package:dart_coco_application/data/errors/response_error.dart';
import 'package:dart_coco_application/domain/model/categories_model.dart';
import 'package:dart_coco_application/domain/model/product_model.dart';
import 'package:dart_coco_application/domain/repositories/products/product_repository.dart';
import 'package:dartz/dartz.dart';

class Catalog {
  final ProductRepository productRepository;
  Catalog({required this.productRepository});

  Future<Either<ResponseError, CategoriesModel>> getAllCategories() async =>
      productRepository.getAllCategories();

  Future<Either<ResponseError, List<ProductModel>>> getProductFromCategory(
          String category) async =>
      productRepository.getProductsFromCategory(category);

  Future<Either<ResponseError, List<ProductModel>>> getAllProducts() async =>
      productRepository.getAllProducts();
}
