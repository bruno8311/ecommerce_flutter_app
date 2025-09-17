import 'package:atomic_desing_system_package/atomic_desing_system_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/domain/entities/user.dart';
import 'package:flutter_ecommerce_app/presentation/screens/detail_screen.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/dropdown.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/footer.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/header.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class CatalogScreen extends StatefulWidget {
  final User user;
  const CatalogScreen({super.key, required this.user});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final categories = productProvider.products.map((p) => p.category).toSet().toList();
    final products = selectedCategory == null 
        ? productProvider.products
        : productProvider.getProductsByCategory(selectedCategory!);

    return TemplateBasePage(
      header: AppHeader(user: widget.user, title: 'Catálogo'),
      body: Column(
          children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: 
               AppDropdown(
                textLabel: 'Categoría',
                 selectedItem: selectedCategory,
                 listItems: categories,
                 onChanged: (value) {
                   setState(() => selectedCategory = value);
                 },
               )
             ),
            Expanded(
              child: products.isEmpty
                ? const Center(child: Text('No hay productos para mostrar'))
                : ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return OrganismListCard(
                        imageUrls: [product.image],
                        descriptions: [product.description],
                        onSeeMoreCallbacks: [
                          () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => DetailScreen(product: product, user: widget.user),
                              ),
                            );
                          },
                        ],
                      );
                    },
                  ),
            )
          ],
        ),
        // footer: Text('HOLA')
      footer: AppFooter(user: widget.user),
    );
  }
}
