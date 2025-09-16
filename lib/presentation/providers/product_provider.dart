import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/usecases/product/get_all_products.dart';
import '../../domain/usecases/product/add_product.dart';
import '../../domain/usecases/product/update_product.dart';
import '../../domain/usecases/product/delete_product.dart';
import '../../domain/usecases/product/get_product.dart';

class ProductProvider extends ChangeNotifier {

	List<Product> get mensClothing => getProductsByCategory("men's clothing");
	List<Product> get womensClothing => getProductsByCategory("women's clothing");
	List<Product> get electronics => getProductsByCategory("electronics");
	List<Product> get jewelery => getProductsByCategory("jewelery");

	//casos de uso
	late final GetAllProducts getAllProductsUseCase;
	late final GetProduct getProductUseCase;
	late final AddProduct addProductUseCase;
	late final UpdateProduct updateProductUseCase;
	late final DeleteProduct deleteProductUseCase;

	List<Product> products = [];
	String? errorMessage;

	final ProductRepositoryImpl _repository;

	ProductProvider() : _repository = ProductRepositoryImpl() {
		getAllProductsUseCase = GetAllProducts(_repository);
		getProductUseCase = GetProduct(_repository);
		addProductUseCase = AddProduct(_repository);
		updateProductUseCase = UpdateProduct(_repository);
		deleteProductUseCase = DeleteProduct(_repository);
  }

	Future<String?> loadsProducts() async {
			final result = await getAllProductsUseCase.call();
			String? error;
			result.fold(
				(err) {
					errorMessage = err;
					error = err;
				},
				(list) {
					errorMessage = null;
					products = list;
					error = null;
				},
			);
			notifyListeners();
			return error;
		}

	Future<Product?> fetchProduct(int id) async {
		final result = await getProductUseCase.call(id);
		Product? productResult;
		result.fold((error) {
			errorMessage = error;
			productResult = null;
    }, (product) {
			errorMessage = null;
			productResult = product;
		});
		notifyListeners();
		return productResult;
	}

	Future<String?> addProduct(Product product) async {
		final result = await addProductUseCase.call(product);
		String? error;
		result.fold(
			(err) {
				errorMessage = err;
				error = err;
			},
			(_) {
				errorMessage = null;
				error = null;
			},
		);
		await loadsProducts();
		return error;
	}
 
	Future<String?> updateProduct(Product product) async {
		final result = await updateProductUseCase.call(product);
		String? error;
		result.fold(
			(err) {
				errorMessage = err;
				error = err;
			},
			(_) {
				errorMessage = null;
				error = null;
			},
		);
		await loadsProducts();
		return error;
	}

	Future<String?> deleteProduct(int id) async {
		final result = await deleteProductUseCase.call(id);
		String? error;
		result.fold(
			(err) {
				errorMessage = err;
				error = err;
			},
			(_) {
				errorMessage = null;
				error = null;
			},
		);
		await loadsProducts();
		return error;
	}

  // Obtener productos por categoría
	List<Product> getProductsByCategory(String category) {
		return products.where((p) => p.category == category).toList();
	}
}
