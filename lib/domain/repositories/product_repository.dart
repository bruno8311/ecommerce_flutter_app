import '../entities/product.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<String, List<Product>>> getAllProducts();
  Future<Either<String, Product>> getProduct(int id);
  Future<Either<String, void>> addProduct(Product product);
  Future<Either<String, void>> updateProduct(Product product);
  Future<Either<String, void>> deleteProduct(int id);
}
