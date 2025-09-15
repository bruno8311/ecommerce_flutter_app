import 'package:dartz/dartz.dart';
import '../../entities/cart.dart';
import '../../repositories/cart_repository.dart';

class UpdateCart {
  final CartRepository repository;
  UpdateCart(this.repository);

  Future<Either<String, void>> call(Cart cart) async {
    return await repository.updateCart(cart);
  }
}
