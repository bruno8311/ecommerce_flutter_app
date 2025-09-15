import 'package:fake_store_api_package/domain/entities/product.dart';
import 'package:fake_store_api_package/fake_store_api_package.dart'; //Meetodos de la api
import 'package:dartz/dartz.dart';
import '../models/product_item_model.dart';
  
class RemoteProductDatasource {

  final FakeStoreApiPackage api = FakeStoreApiPackage(); // Paquete para consumir la API Fake Store Api
  List<ProductItemModel> localProducts = [];

  Future<Either<String, List<ProductItemModel>>> fetchProducts() async {
    try {
      if(localProducts.isNotEmpty) {
        return Right(localProducts);
      }
      final result = await api.getProducts();
      return result.fold(
        (err) => Left(err),
        (data) {
          localProducts = data.map((e) => ProductItemModel(
            id: e.id,
            title: e.title,
            description: e.description,
            price: e.price,
            category: e.category,
            image: e.image,
          )).toList();
          return Right(localProducts);
        },
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ProductItemModel>> fetchProduct(int id) async {
    try {
      final result = await api.getProduct(id);
      return result.fold(
        (err) => Left(err),
        (data) => Right(ProductItemModel(
          id: data.id,
          title: data.title,
          description: data.description,
          price: data.price,
          category: data.category,
          image: data.image,
        )),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ProductItemModel>> createProduct(ProductItemModel product) async {
    try {
      final entity = Product(
        id: product.id,
        title: product.title,
        description: product.description,
        price: product.price,
        category: product.category,
        image: product.image,
      );
      final result = await api.createProduct(entity);
      return result.fold(
        (err) => Left(err),
        (_) {
          localProducts.add(product);
          return Right(product);
        },
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

Future<Either<String, ProductItemModel>> updateProduct(ProductItemModel product) async {
  try {
    final entity = Product(
      id: product.id,
      title: product.title,
      description: product.description,
      price: product.price,
      category: product.category,
      image: product.image,
    );
    final result = await api.updateProduct(entity);
    return result.fold(
      (err) => Left(err),
      (_) {
        final index = localProducts.indexWhere((p) => p.id == product.id);
        if (index != -1) {
          localProducts[index] = product;
        }
        return Right(product);
      },
    );
  } catch (e) {
    return Left(e.toString());
  }
}

Future<Either<String, bool>> deleteProduct(int id) async {
  try {
    final result = await api.deleteProduct(id);
    return result.fold(
      (err) => Left('Error: $err'),
      (_) {
        localProducts.removeWhere((product) => product.id == id);
        return Right(true);
      },
    );
  } catch (e) {
    return Left(e.toString());
  }
}

}
