import 'package:dartz/dartz.dart';

import '../../repositories/product_repository.dart';

class DeleteProduct {
  final ProductRepository repository;
  DeleteProduct(this.repository);

  Future<Either<String, void>> call(int id) async {
      return await repository.deleteProduct(id);
  }
}
