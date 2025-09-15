// import 'package:fake_store_api_package/domain/entities/cart_product.dart';

import '../../data/models/cart_model.dart';
import '../../domain/entities/cart.dart';

// extension FakeStoreCartMapper on Cart {
//   CartItemModel toModel() => CartItemModel(
//     id: id,
//     userId: userId,
//     products: products.map((p) => CartProduct(
//       productId: p.productId,
//       quantity: p.quantity,
//     )).toList(),
//   );
// }

// extension CartItemModelMapper on CartItemModel {
//   Cart toEntity() => Cart(
//     id: id,
//     userId: userId,
//     products: products.map((p) => CartProduct(
//       productId: p.productId,
//       quantity: p.quantity,
//     )).toList(),
//   );
// }
extension CartMapper on Cart {
  CartItemModel toModel() =>
      CartItemModel(id: id, userId: userId, products: products);
}

extension CartItemModelMapper on CartItemModel {
  Cart toEntity() => Cart(id: id, userId: userId, products: products);
}
