import '../../entities/product.dart';
import '../../repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllProducts {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  Future<Either<String, List<Product>>> call() async {
    return await repository.getAllProducts();
  }
}
