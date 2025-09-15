import '../../entities/product.dart';
import '../../repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateProduct {
  final ProductRepository repository;
  UpdateProduct(this.repository);

  Future<Either<String, void>> call(Product product) async {
    return await repository.updateProduct(product);
  }
}
