import 'package:dartz/dartz.dart';
import '../../repositories/cart_repository.dart';

class DeleteCart {
  final CartRepository repository;
  DeleteCart(this.repository);

  Future<Either<String, void>> call(int id) async {
    return await repository.deleteCart(id);
  }
}
