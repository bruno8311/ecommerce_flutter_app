import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/domain/entities/cart.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  final int userId;
  const CartScreen({super.key, this.userId = 1});

  @override
  State<CartScreen> createState() => _CartScreenState();
}


class _CartScreenState extends State<CartScreen> {
  Cart? _cart;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final cart = await cartProvider.getCart(widget.userId);
    setState(() {
      _cart = cart;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : (_cart == null || _cart!.products.isEmpty)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Tu carrito está vacío'),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.shopping_bag),
                        label: const Text('Ir al catálogo'),
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/catalog');
                        },
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _cart!.products.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final cartProduct = _cart!.products[index];
                    return ListTile(
                      leading: const Icon(Icons.shopping_cart),
                      title: Text('Producto ID: ${cartProduct.productId}'),
                      subtitle: Text('Cantidad: ${cartProduct.quantity}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Eliminar producto del carrito
                          // cartProvider.deleteCartProduct(cartProduct.productId);
                        },
                      ),
                    );
                  },
                ),
      bottomNavigationBar: null, // Puedes agregar lógica para el botón de pago si lo deseas
    );
  }
}
