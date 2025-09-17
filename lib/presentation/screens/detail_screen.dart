import 'package:atomic_desing_system_package/atomic_desing_system_package.dart';
import 'package:flutter_ecommerce_app/domain/entities/cart.dart';
import 'package:flutter_ecommerce_app/presentation/screens/contact_screen.dart';
import 'package:flutter_ecommerce_app/presentation/screens/dashboard_screen.dart';
import 'package:flutter_ecommerce_app/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/user.dart';
import 'package:fake_store_api_package/domain/entities/cart_product.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';

class DetailScreen extends StatelessWidget {
  
  int _getNextCartId(CartProvider cartProvider, int userId) {
    final userCarts = cartProvider.getCartsByUserId(userId);
    if (userCarts.isEmpty) return 1;
    return userCarts.map((c) => c.id).reduce((a, b) => a > b ? a : b) + 1;
  }

  Future<void> _addCartAndNavigate(BuildContext context, CartProvider cartProvider) async {
    final newId = _getNextCartId(cartProvider, user.id);
    final newCart = Cart(
      id: newId,
      userId: user.id,
      products: [CartProduct(productId: product.id, quantity: 1)],
    );
    final error = await cartProvider.addCart(newCart);
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al añadir al carrito: $error')),
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => CartScreen(user: user),
        ),
        (route) => false,
      );
    }
  }
  final Product product;
  final User user;
  const DetailScreen({super.key, required this.product, required this.user});

  @override
  Widget build(BuildContext context) {
  final cartProvider = Provider.of<CartProvider>(context, listen: false);
  return TemplateDetailPage(
      headerUserImageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=687&auto=format&fit=crop',
      headerUserName: user.username,
      headerTitle: 'Detalles del Producto',
      headerOnLogout: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
      },
      headerOnHome: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DashboardScreen(user: user),
          ),
        );
      },
      productImageUrl: product.image,
      productTitle: product.title,
      productPrice: 'S/ ${product.price.toStringAsFixed(2)}',
      productCategory: product.category,
      productDescription: product.description,
      onButtonPressed: () async {
        await _addCartAndNavigate(context, cartProvider);
      },
      footerIcons: const [
        Icons.facebook,
        Icons.email,
      ],
      footerLabels: const ['Contacto', 'Ayuda'],
      footerActions: [
        () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ContactScreen(user: user, userTitle: 'Contactanos', descriptionTitle: 'Siguenos en nuestras redes sociales', descriptionSubtitle: 'Email: soporte@ecommerce.com\nFacebook: facebook.com/ecommerce\nInstagram: instagram.com/ecommerce\n Dejanos un comentario:',),
            ),
          );
        },
        () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ContactScreen(user: user, userTitle: 'Soporte', descriptionTitle: '¿Tienes algun inconveniente con el sistema?', descriptionSubtitle: 'Linea telefónica para soporte en linea:\n Teléfono: +51 999 999 999\n Escribe tu problema y te ayudaremos lo antes posible.'),
            ),
          );
        },
      ],
    );

  }
}
