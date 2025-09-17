import 'package:atomic_desing_system_package/atomic_desing_system_package.dart';
import 'package:fake_store_api_package/domain/entities/cart_product.dart';
import 'package:flutter_ecommerce_app/presentation/providers/cart_provider.dart';
import 'package:flutter_ecommerce_app/presentation/providers/product_provider.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/dropdown.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/footer.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/cart.dart';

class EditCartScreen extends StatefulWidget {
  final User user;
  final Cart cart;
  const EditCartScreen({super.key, required this.user, required this.cart});

  @override
  State<EditCartScreen> createState() => _EditCartScreenState();
}

class _EditCartScreenState extends State<EditCartScreen> {
  late List<TextEditingController> _quantityControllers;
  late List<String?> _selectedProductIds;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final productProvider = Provider.of<ProductProvider>(context, listen: false);
      await productProvider.loadsProducts();
    });
    _selectedProductIds = widget.cart.products.map((p) => p.productId.toString()).toList();
    _quantityControllers = widget.cart.products.map((p) => TextEditingController(text: p.quantity.toString())).toList();
  }

  @override
  void dispose() {
    for (final c in _quantityControllers) {
      c.dispose();
    }
    super.dispose();
  }

  String productDropdownLabel(int id, String title) {
    final truncated = title.length > 14 ? '${title.substring(0, 14)}...' : title;
    return '$id - $truncated';
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final items = productProvider.products.map((product) => productDropdownLabel(product.id, product.title)).toList();
    if (items.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return TemplateBasePage(
        header: AppHeader(user: widget.user, title: 'Gestionar carrito ${widget.cart.id}'),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID del Carrito: ${widget.cart.id}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            // Lista de productos
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _selectedProductIds.length,
                itemBuilder: (context, i) {
                  String selected = _selectedProductIds[i] != null && items.contains(_selectedProductIds[i]) ? _selectedProductIds[i]! : items.first;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: AppDropdown(
                                textLabel: 'Producto',
                                selectedItem: selected,
                                listItems: items,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedProductIds[i] = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Cantidad', style: TextStyle(fontSize: 12)),
                                SizedBox(
                                  width: 70,
                                  child: AtomInput(
                                    controller: _quantityControllers[i],
                                    keyboardType: TextInputType.number,
                                    hintText: 'Cant.',
                                  ),
                                ),
                              ],
                            ),
                            AtomIconButton(
                              icon: Icons.close,
                              iconColor: Colors.red,
                              onPressed: () {
                                setState(() {
                                  _selectedProductIds.removeAt(i);
                                  _quantityControllers.removeAt(i).dispose();
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final cartProvider = Provider.of<CartProvider>(context, listen: false);
                  final newProducts = List.generate(_selectedProductIds.length, (i) {
                    final selectedLabel = _selectedProductIds[i] ?? items.first;
                    final productId = int.tryParse(selectedLabel.split(' - ').first) ?? 0;
                    final quantity = int.tryParse(_quantityControllers[i].text) ?? 1;
                    return CartProduct(productId: productId, quantity: quantity);
                  });
                  final updatedCart = Cart(
                    id: widget.cart.id,
                    userId: widget.cart.userId,
                    products: newProducts,
                  );
                  widget.cart.products
                    ..clear()
                    ..addAll(newProducts);
                  final error = await cartProvider.updateCart(updatedCart);
                  if (error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al guardar cambios: $error')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: const Text('Cambios guardados con éxito')),
                    );
                  }
                },
                child: const Text('Guardar cambios'),
              ),
            ),
          ],
        ),
      ),
      footer: AppFooter(user: widget.user),
    );
  }
}
