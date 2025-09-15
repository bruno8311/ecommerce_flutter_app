import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/domain/entities/cart.dart';

abstract class CartRepository {
   Future<Either<String, List<Cart>>> getAllCarts();
   Future<Either<String, Cart>> getCart(int id);
   Future<Either<String, void>> addCart(Cart item);
   Future<Either<String, void>> updateCart(Cart item);
   Future<Either<String, void>> deleteCart(int id);
}