
import 'package:fake_store_api_package/domain/entities/cart_product.dart';

class CartItemModel {
  final int id;
  final int userId;
  final List<CartProduct> products;

  const CartItemModel({
    required this.id,
    required this.userId,
    required this.products,
  });

   factory CartItemModel.fromJson(Map<String, dynamic> json) {
     return CartItemModel(
       id: json['id'] ?? 0,
       userId: json['userId'] ?? 0,
       products: (json['products'] as List? ?? [])
         .map((e) => CartProduct(
           productId: e['productId'] ?? 0,
           quantity: e['quantity'] ?? 0,
         ))
         .toList(),
     );
   }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'products': products.map((e) => {
        'productId': e.productId,
        'quantity': e.quantity,
      }).toList(),
    };
  }
}
