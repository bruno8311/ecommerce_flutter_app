import 'package:flutter_ecommerce_app/data/datasources/remote_product_datasource.dart';
import '../../domain/mappers/product_mapper.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/local_storage.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoryImpl implements ProductRepository {

  //DataSources
  final RemoteProductDatasource productDataSource = RemoteProductDatasource();
  final LocalStorage _localStorage = LocalStorage();

  @override
  Future<Either<String, List<Product>>> getAllProducts() async {
    final localModels = await _localStorage.getProducts();
    if (localModels.isNotEmpty) {
      productDataSource.localProducts = localModels;
      return Right(localModels.map((model) => model.toEntity()).toList());
    } else {
      final result = await productDataSource.fetchProducts();
      return result.fold(
        (error) => Left(error),
        (apiModels) async {
          await _localStorage.saveProducts(apiModels);
          return Right(apiModels.map((model) => model.toEntity()).toList());
        },
      );
    }
  }

  @override
  Future<Either<String, Product>> getProduct(int id) async {
    final result = await productDataSource.fetchProduct(id);
    return result.fold(
      (error) => Left(error),
      (model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Either<String, void>> addProduct(Product product) async {
  final model = product.toModel();
    final result = await productDataSource.createProduct(model);
    return result.fold(
      (error) => Left(error),
      (_) async {
        await _localStorage.saveProducts(productDataSource.localProducts);
        return const Right(null);
      },
    );
  }

  @override
  Future<Either<String, void>> updateProduct(Product product) async {
  final model = product.toModel();
    final result = await productDataSource.updateProduct(model);
    return result.fold(
      (error) => Left(error),
      (_) async {
        await _localStorage.saveProducts(productDataSource.localProducts);
        return const Right(null);
      },
    );
  }

  @override
  Future<Either<String, void>> deleteProduct(int id) async {
    final result = await productDataSource.deleteProduct(id);
    return result.fold(
      (error) => Left(error),
      (_) async {
        await _localStorage.saveProducts(productDataSource.localProducts);
        return const Right(null);
      },
    );
  }
}
