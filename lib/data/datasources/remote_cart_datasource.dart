import 'package:fake_store_api_package/domain/entities/cart.dart';
import 'package:fake_store_api_package/domain/entities/cart_product.dart';
import 'package:fake_store_api_package/fake_store_api_package.dart';
import 'package:flutter_ecommerce_app/data/models/cart_model.dart';
import 'package:dartz/dartz.dart';

class RemoteCartDatasource {
  Future<Either<String, void>> createCart(CartItemModel cart) async {
    try {
      final entity = Cart(
        id: cart.id,
        userId: cart.userId,
        products: cart.products.map((p) => CartProduct(
          productId: p.productId,
          quantity: p.quantity,
        )).toList(),
      );
      return await api.createCart(entity);
    } catch (e) {
      return Left(e.toString());
    }
  }
  final FakeStoreApiPackage api = FakeStoreApiPackage();

  Future<Either<String, List<CartItemModel>>> getCarts() async {
    try {
      final result = await api.getCarts();
      return result.fold<Either<String, List<CartItemModel>>>(
        (err) => Left(err),
        (data) => Right(
          data.map((e) => CartItemModel(
            id: e.id,
            userId: e.userId,
            products: e.products.map((p) => CartProduct(
              productId: p.productId,
              quantity: p.quantity,
            )).toList(),
          )).toList(),
        ),
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

  Future<Either<String, void>> updateCart(CartItemModel cart) async {
    try {
      final entity = Cart(
        id: cart.id,
        userId: cart.userId,
        products: cart.products.map((p) => CartProduct(
          productId: p.productId,
          quantity: p.quantity,
        )).toList(),
      );
      return await api.updateCart(entity);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> deleteCart(int id) async {
    try {
      return await api.deleteCart(id);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
