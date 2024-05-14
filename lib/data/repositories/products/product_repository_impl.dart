import 'package:dart_coco_application/data/api/fake_api.dart';
import 'package:dart_coco_application/data/errors/response_error.dart';
import 'package:dart_coco_application/data/mappers/categories_mapper.dart';
import 'package:dart_coco_application/data/mappers/product_mapper.dart';
import 'package:dart_coco_application/domain/model/product_model.dart';
import 'package:dart_coco_application/domain/repositories/products/product_repository.dart';
import 'package:dart_coco_application/domain/model/categories_model.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

class ProductRepositoryImpl extends ProductRepository with FakeApi {
  @override
  Future<Either<ResponseError, CategoriesModel>> getAllCategories() async {
    final url = getAllCategoriesUrl();
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return right(CategoriesMapper.categoriesModelFromJson(response.body));
    } else {
      return left(ResponseError('Ops!, ha ocurrido un error'));
    }
  }

  @override
  Future<Either<ResponseError, List<ProductModel>>> getProductsFromCategory(
      String category) async {
    final url = getProductsFromCategoryUrl(category);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return right(ProductMapper.productsFromJson(response.body));
    } else {
      return left(ResponseError('Ops!, ha ocurrido un error'));
    }
  }

  @override
  Future<Either<ResponseError, List<ProductModel>>> getAllProducts() async {
    final url = getAllProductsUrl();
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return right(ProductMapper.productsFromJson(response.body));
    } else {
      return left(ResponseError('Ops!, ha ocurrido un error'));
    }
  }
}
