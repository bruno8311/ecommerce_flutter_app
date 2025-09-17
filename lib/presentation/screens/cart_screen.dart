import 'package:atomic_desing_system_package/atomic_desing_system_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/domain/entities/user.dart';
import 'package:flutter_ecommerce_app/presentation/screens/edit_cart_screen.dart';
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
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      await cartProvider.loadCarts();
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TemplateBasePage(
      header: AppHeader(user: widget.user, title: 'Mis Carritos'),
      body: Center(
        child: Consumer<CartProvider>(
          builder: (context, cartProvider, _) {
            final userCarts = cartProvider.getCartsByUserId(widget.user.id);
            if (_loading) {
              return const Text('Cargando...');
            }
            if (userCarts.isEmpty) {
              return const Text('No tienes carritos, agrega productos');
            }
            return ListView.builder(
              itemCount: userCarts.length,
              itemBuilder: (context, index) {
                final cart = userCarts[index];
                return OrganismListIconCard(
                  titles: ['Carrito ${cart.id}'],
                  subtitles: ['N° Productos: ${cart.products.length} - Cantidad total de productos: ${cart.products.fold<int>(0, (sum, p) => sum + p.quantity)}'],
                  icons: [Icons.shopping_cart],
                  onTaps: [
                    () async {
                      final cartIdToDelete = cart.id;
                      showModalBottomSheet(
                        context: context,
                        builder: (sheetContext) {
                          return SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const AtomIcon(icon: Icons.edit),
                                  title: const AtomLabel(text: 'Ver / editar carrito'),
                                  onTap: () {
                                    Navigator.pop(sheetContext);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => EditCartScreen(user: widget.user, cart: cart),
                                      ),
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: AtomIcon(icon: Icons.delete, color: Colors.red),
                                  title: const Text('Eliminar carrito'),
                                  onTap: () async {
                                    Navigator.pop(sheetContext);
                                    final error = await cartProvider.deleteCart(cartIdToDelete);
                                    if (error != null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Error al eliminar carrito: $error')),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Eliminado con exito')),
                                      );
                                    }
                                  },
                                ),
                                ListTile(
                                  leading: const AtomIcon(icon: Icons.check, color: Colors.green),
                                  title: const Text('Comprar carrito'),
                                  onTap: () async {
                                    Navigator.pop(sheetContext);
                                    final error = await cartProvider.deleteCart(cartIdToDelete);
                                    if (error != null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Error al comprar carrito: $error')),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Compra realizada con exito')),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  ],
                );
              },
            );
          },
        ),
      ),
      footer: AppFooter(user: widget.user),
    );
  }
}