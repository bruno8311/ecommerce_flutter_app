import 'package:dartz/dartz.dart';
import '../../entities/cart.dart';
import '../../repositories/cart_repository.dart';

class GetCart {
  final CartRepository repository;
  GetCart(this.repository);

  Future<Either<String, Cart>> call(int id) async {
    return await repository.getCart(id);
  }
}
