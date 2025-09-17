import 'package:fake_store_api_package/domain/entities/cart.dart';
import 'package:fake_store_api_package/domain/entities/cart_product.dart';
import 'package:fake_store_api_package/fake_store_api_package.dart';
import 'package:flutter_ecommerce_app/data/models/cart_model.dart';
import 'package:dartz/dartz.dart';

class RemoteCartDatasource {

  final FakeStoreApiPackage api = FakeStoreApiPackage();
  List<CartItemModel> localCarts = [];

  Future<Either<String, List<CartItemModel>>> getCarts() async {
    try {
      if(localCarts.isNotEmpty) {
        return Right(localCarts);
      }
      final result = await api.getCarts();
      return result.fold<Either<String, List<CartItemModel>>>(
        (err) => Left(err),
        (data) {
          localCarts = data.map((e) => CartItemModel(
            id: e.id,
            userId: e.userId,
            products: e.products.map((p) => CartProduct(
              productId: p.productId,
              quantity: p.quantity,
            )).toList(),
          )).toList();
          return Right(localCarts);
        }
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, CartItemModel>> getCart(int id) async {
    try {
      final result = await api.getCart(id);
      return result.fold(
        (err) => Left(err),
        (data) => Right(CartItemModel(
          id: data.id,
          userId: data.userId,
          products: data.products.map((p) => CartProduct(
            productId: p.productId,
            quantity: p.quantity,
          )).toList(),
        )),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, CartItemModel>> createCart(CartItemModel cart) async {
    try {
      final entity = Cart(
        id: cart.id,
        userId: cart.userId,
        products: cart.products.map((p) => CartProduct(
          productId: p.productId,
          quantity: p.quantity,
        )).toList(),
      );
      final result = await api.createCart(entity);
      return result.fold(
        (error) => Left(error),
        (_)  {
          localCarts.add(cart);
          return Right(cart);
        },
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, CartItemModel>> updateCart(CartItemModel cart) async {
    try {
      final entity = Cart(
        id: cart.id,
        userId: cart.userId,
        products: cart.products.map((p) => CartProduct(
          productId: p.productId,
          quantity: p.quantity,
        )).toList(),
      );
      final result = await api.updateCart(entity);
      return result.fold(
        (error) => Left(error),
        (_)  {
          final index = localCarts.indexWhere((c) => c.id == cart.id);
          if (index != -1) {
            localCarts[index] = cart;
          }
          return Right(cart);
        },
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> deleteCart(int id) async {
    try {
      final result = await api.deleteCart(id);
      return result.fold(
        (error) => Left(error),
        (_) async {
          localCarts.removeWhere((cart) => cart.id == id);
          return const Right(true);
        },
      );
    } catch (e) {
      return Left(e.toString());
    }
  }
}
