import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/domain/repositories/product_repository.dart';
import 'package:flutter_ecommerce_app/domain/entities/product.dart';

class GetProduct {
  final ProductRepository repository;

  GetProduct(this.repository);

  Future<Either<String, Product>> call(int id) async {
    return await repository.getProduct(id);
  }
}