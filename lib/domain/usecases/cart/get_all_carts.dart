import 'package:dartz/dartz.dart';
import '../../entities/cart.dart';
import '../../repositories/cart_repository.dart';

class GetAllCarts {
  final CartRepository repository;
  GetAllCarts(this.repository);

  Future<Either<String, List<Cart>>> call() async {
    return await repository.getAllCarts();
  }
}
