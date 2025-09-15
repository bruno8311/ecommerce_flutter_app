import '../../entities/product.dart';
import '../../repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class AddProduct {
  final ProductRepository repository;
  AddProduct(this.repository);

  Future<Either<String, void>> call(Product product) async {
    return await repository.addProduct(product);
  }
}
