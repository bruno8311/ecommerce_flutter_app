
import 'package:flutter/material.dart';
import '../../domain/entities/cart.dart';
import '../../data/repositories/cart_repository_impl.dart';
import '../../domain/usecases/cart/get_all_carts.dart';
import '../../domain/usecases/cart/get_cart.dart';
import '../../domain/usecases/cart/add_cart.dart';
import '../../domain/usecases/cart/update_cart.dart';
import '../../domain/usecases/cart/delete_cart.dart';

class CartProvider extends ChangeNotifier {

  late final GetAllCarts getAllCartsUseCase;
  late final GetCart getCartUseCase;
  late final AddCart addCartUseCase;
  late final UpdateCart updateCartUseCase;
  late final DeleteCart deleteCartUseCase;

  List<Cart> carts = [];
  String? errorMessage;

  final CartRepositoryImpl _repository;

  CartProvider() : _repository = CartRepositoryImpl() {
    getAllCartsUseCase = GetAllCarts(_repository);
    getCartUseCase = GetCart(_repository);
    addCartUseCase = AddCart(_repository);
    updateCartUseCase = UpdateCart(_repository);
    deleteCartUseCase = DeleteCart(_repository);
  }

  Future<String?> loadCarts() async {
    final result = await getAllCartsUseCase.call();
		String? error;
    result.fold(
      (error) {
        carts = [];
				error = error;
      },
      (list) {
        carts = list;
        error = null;
      },
    );
    notifyListeners();
    return error;
  }

  Future<Cart?> getCart(int id) async {
    final result = await getCartUseCase.call(id);
    Cart? cartResult;
		result.fold(
      (error) {
			  cartResult = null;
      },
      (cart) {
			  cartResult = cart;
		  }
    );
    notifyListeners();
    return cartResult;
  }

  Future<String?> addCart(Cart cart) async {
    final result = await addCartUseCase.call(cart);
    String? error;
    result.fold(
      (err) {
        error = err;
      },
      (_) {
        error = null;
      },
    );
    await loadCarts();
    return error;
  }

  Future<String?> updateCart(Cart cart) async {
    final result = await updateCartUseCase.call(cart);
    String? error;
    result.fold(
      (err) {
        error = err;
      },
      (_) {
        error = null;
      }
    );
    await loadCarts();
    return error;
  }

  Future<String?> deleteCart(int id) async {
    print('Eliminando carrito con id: $id');
    final result = await deleteCartUseCase.call(id);
    String? error;
    result.fold(
      (err) {
        error = err;
      },
      (_) {
        error = null;
      },
    );
    await loadCarts();
    return error;
  }

  /// Devuelve los carritos que pertenecen al usuario con el userId dado.
  List<Cart> getCartsByUserId(int userId) {
    return carts.where((cart) => cart.userId == userId).toList();
  }
}
