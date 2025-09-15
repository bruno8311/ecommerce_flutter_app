import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/data/datasources/remote_cart_datasource.dart';
import 'package:flutter_ecommerce_app/domain/mappers/cart_mapper.dart';
import 'package:flutter_ecommerce_app/domain/entities/cart.dart';
import 'package:flutter_ecommerce_app/domain/repositories/cart_repository.dart';


class CartRepositoryImpl implements CartRepository {

  //DataSources
  final RemoteCartDatasource _cartApi = RemoteCartDatasource();

  @override
  Future<Either<String, List<Cart>>> getAllCarts() async {
    final result = await _cartApi.getCarts();
    return result.fold(
      (error) => Left(error),
      (apiModels) => Right(apiModels.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<String, Cart>> getCart(int id) async {
    final result = await _cartApi.getCart(id);
    return result.fold(
      (error) => Left(error),
      (model) => Right(model.toEntity()),
    );
  }

  @override
  Future<Either<String, void>> addCart(Cart cart) async {
  final model = cart.toModel();
    final result = await _cartApi.createCart(model);
    return result.fold(
      (error) => Left(error),
      (_) => const Right(null),
    );
  }

  @override
  Future<Either<String, void>> updateCart(Cart cart) async {
  final model = cart.toModel();
    final result = await _cartApi.updateCart(model);
    return result.fold(
      (error) => Left(error),
      (_) => const Right(null),
    );
  }

  @override
  Future<Either<String, void>> deleteCart(int id) async {
    final result = await _cartApi.deleteCart(id);
    return result.fold(
      (error) => Left(error),
      (_) => const Right(null),
    );
  }
}
