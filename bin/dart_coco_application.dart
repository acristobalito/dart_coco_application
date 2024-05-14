import 'package:dart_coco_application/coco_app.dart' as coco;
import 'package:dart_coco_application/data/repositories/products/product_repository_impl.dart';
import 'package:dart_coco_application/domain/model/categories_model.dart';
import 'package:dart_coco_application/domain/model/product_model.dart';

void main(List<String> arguments) async {
  final productRepository = ProductRepositoryImpl();
  final catalog = coco.Catalog(productRepository: productRepository);
  final responseCategories = await catalog.getAllCategories();
  final responseProductsFromCategory =
      await catalog.getProductFromCategory('electronics');
  final responseProducts = await catalog.getAllProducts();
  print('=========================');
  print('Todas las categorias:');
  print('=========================');
  responseCategories.fold((error) => print(error.message),
      (categories) => printCategories(categories));
  print('=========================');
  print('Productos de la categoria \'electronics\':');
  print('=========================');
  responseProductsFromCategory.fold((error) => print(error.message),
      (products) => printProductsFromCategories(products));
  print('=========================');
  print('Todos los productos:');
  print('=========================');
  responseProducts.fold((error) => print(error.message),
      (products) => printProductsFromCategories(products));
}

printCategories(CategoriesModel categories) {
  for (var category in categories.categories) {
    print('* $category');
  }
}

printProductsFromCategories(List<ProductModel> products) {
  final productsFiltered = products.take(2);
  for (var product in productsFiltered) {
    print('*****************');
    print('- Id producto: ${product.id}');
    print('- Titulo producto: ${product.title}');
    print('- Precio producto: ${product.price}');
    print('- Descripción producto: ${product.description}');
    print('- Categoria producto: ${product.category}');
    print('- Imagen producto: ${product.image}');
    print('- Recuento de calificaciones: ${product.rating.count}');
    print('- Tasa de calificación: ${product.rating.rate}');
  }
}
