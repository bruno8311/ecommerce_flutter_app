import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final int index;
  final VoidCallback? onTap;

  const ProductTile({
    super.key,
    required this.product,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 5,
      color: Colors.blue.shade100,
      child: ListTile(
        title: Text(product.title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
        subtitle: _buildSubTitle(),
        trailing: const Icon(Icons.arrow_forward),
        leading: _buildLeading(),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSubTitle() {
    return Text(
      product.description.length > 50
          ? '${product.description.substring(0, 50)}...'
          : product.description,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildLeading() {
    return product.image.isNotEmpty
        ? ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              product.image,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.broken_image, color: Colors.white, size: 32),
                );
              },
            ),
          )
        : Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.image, color: Colors.white, size: 32),
          );
  }
}
