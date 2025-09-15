
import 'package:fake_store_api_package/domain/entities/cart_product.dart';
class Cart {
  final int id;
  final int userId;
  final List<CartProduct> products;

  const Cart({
    required this.id,
    required this.userId,
    required this.products,
  });
}

