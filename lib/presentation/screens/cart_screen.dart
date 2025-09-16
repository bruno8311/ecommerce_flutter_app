import 'package:atomic_desing_system_package/atomic_desing_system_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/domain/entities/cart.dart';
import 'package:flutter_ecommerce_app/domain/entities/user.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/footer.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/header.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  final User user;
  const CartScreen({super.key, required this.user});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      await cartProvider.loadCarts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    print('Los carritos del user son: ${cartProvider.getCartsByUserId(widget.user.id)}');
    return TemplateBasePage(
      header: AppHeader(user: widget.user),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cartProvider.carts.isEmpty
                ? const Text('No hay carritos disponibles.')
                : Expanded(
                    child: ListView.builder(
                      itemCount: cartProvider.carts.length,
                      itemBuilder: (context, index) {
                        final cart = cartProvider.carts[index];
                        return OrganismListIconCard (
                          titles: ['Carrito ID: ${cart.id}'],
                          subtitles: ['Productos: ${cart.products.length}'],
                          icons: [Icons.shopping_cart],
                          onTaps: [
                            () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Carrito ID: ${cart.id}, Productos: ${cart.products.length}'))
                              );
                            }
                          ],
                        );
                      },
                    ),
                  )
                   ],
                )

      ),
      footer: AppFooter(user: widget.user),
    );

    //   ),
    //   body: _loading
    //       ? const Center(child: CircularProgressIndicator())
    //       : (_cart == null || _cart!.products.isEmpty)
    //           ? Center(
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   const Text('Tu carrito está vacío'),
    //                   const SizedBox(height: 16),
    //                   ElevatedButton.icon(
    //                     icon: const Icon(Icons.shopping_bag),
    //                     label: const Text('Ir al catálogo'),
    //                     onPressed: () {
    //                       Navigator.of(context).pushReplacementNamed('/catalog');
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             )
    //           : ListView.separated(
    //               padding: const EdgeInsets.all(16),
    //               itemCount: _cart!.products.length,
    //               separatorBuilder: (_, __) => const Divider(),
    //               itemBuilder: (context, index) {
    //                 final cartProduct = _cart!.products[index];
    //                 return ListTile(
    //                   leading: const Icon(Icons.shopping_cart),
    //                   title: Text('Producto ID: ${cartProduct.productId}'),
    //                   subtitle: Text('Cantidad: ${cartProduct.quantity}'),
    //                   trailing: IconButton(
    //                     icon: const Icon(Icons.delete, color: Colors.red),
    //                     onPressed: () {
    //                       // Eliminar producto del carrito
    //                       // cartProvider.deleteCartProduct(cartProduct.productId);
    //                     },
    //                   ),
    //                 );
    //               },
    //             ),
    //   bottomNavigationBar: null, // Puedes agregar lógica para el botón de pago si lo deseas
    // );
  }
}
