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

  Future<void> loadCarts() async {
    final result = await getAllCartsUseCase.call();
    result.fold(
      (error) {
        errorMessage = error;
        carts = [];
      },
      (list) {
        errorMessage = null;
        carts = list;
      },
    );
    notifyListeners();
  }

  Future<Cart?> getCart(int id) async {
    final result = await getCartUseCase.call(id);
    Cart? cartResult;
		result.fold((error) {
			errorMessage = error;
			cartResult = null;
    }, (cart) {
			errorMessage = null;
			cartResult = cart;
		});
    notifyListeners();
    return cartResult;
  }

  Future<void> addCart(Cart cart) async {
    final result = await addCartUseCase.call(cart);
    result.fold(
      (error) => errorMessage = error,
      (_) => errorMessage = null,
    );
    await loadCarts();
  }

  Future<void> updateCart(Cart cart) async {
    final result = await updateCartUseCase.call(cart);
    result.fold(
      (error) => errorMessage = error,
      (_) => errorMessage = null,
    );
    await loadCarts();
  }

  Future<void> deleteCart(int id) async {
    final result = await deleteCartUseCase.call(id);
    result.fold(
      (error) => errorMessage = error,
      (_) => errorMessage = null,
    );
    await loadCarts();
  }
}
