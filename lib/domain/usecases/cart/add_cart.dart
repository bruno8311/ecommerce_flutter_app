import 'package:dartz/dartz.dart';
import '../../entities/cart.dart';
import '../../repositories/cart_repository.dart';

class AddCart {
  final CartRepository repository;
  AddCart(this.repository);

  Future<Either<String, void>> call(Cart cart) async {
    return await repository.addCart(cart);
  }
}
