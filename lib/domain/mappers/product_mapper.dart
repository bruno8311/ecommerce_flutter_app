import '../entities/product.dart';
import '../../data/models/product_item_model.dart';

extension ProductMapper on Product {
  ProductItemModel toModel() => ProductItemModel(
    id: id,
    title: title,
    description: description,
    price: price,
    category: category,
    image: image,
  );
}

extension ProductItemModelMapper on ProductItemModel {
  Product toEntity() => Product(
    id: id,
    title: title,
    description: description,
    price: price,
    category: category,
    image: image,
  );
}
