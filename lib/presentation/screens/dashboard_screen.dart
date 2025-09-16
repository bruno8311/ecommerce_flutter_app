import 'package:atomic_desing_system_package/atomic_desing_system_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/domain/entities/user.dart';
import 'package:flutter_ecommerce_app/presentation/screens/cart_screen.dart';
import 'package:flutter_ecommerce_app/presentation/screens/catalog_screen.dart';
import 'package:flutter_ecommerce_app/presentation/screens/contact_screen.dart';
import 'package:flutter_ecommerce_app/presentation/screens/login_screen.dart';
import 'package:flutter_ecommerce_app/presentation/screens/support_screen.dart';
import 'package:provider/provider.dart';
import 'product_detail_screen.dart';
import 'search_screen.dart';
import '../providers/product_provider.dart';

class DashboardScreen extends StatefulWidget {
  final User user;
  const DashboardScreen({super.key, required this.user});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final productProvider = Provider.of<ProductProvider>(context, listen: false);
      await productProvider.loadsProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    // Favoritos y promociones obtenidos de productos
  final novedades = productProvider.products.take(2).toList();
  final pomotions = productProvider.products.take(4).toList();

      return TemplateDashboardPage(
        headerUserName: widget.user.username,
        headerUserImageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=687&auto=format&fit=crop',
        headerShowBackArrow: false,
        headerOnSearch: (value) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SearchScreen(initialQuery: value, user: widget.user),
            ),
          );
        },
        headerTitle: 'Ecommerce App',
        headerOnLogout: () {
        Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const LoginScreen(),
              ),
            );
        },
        headerOnHome: () {
        },
        headerHintText: 'Buscar productos...',
        bodyCardHeaderTitle: 'Explora la tienda',
        bodyCardIcons: const [
          Icons.shopping_bag,
          Icons.search,
          Icons.shopping_cart,
        ],
        bodyCardTitles: const [
          'Catalogo de productos',
          'Busqueda de productos',
          'Ver carrito'
        ],
        bodyCardSubtitles: const [
          'Navega y ve productos por categorías',
          'Busqueda avanzanda de productos',
          'Revisa los productos en tu carrito',
        ],
        bodyCardOnTaps: [
          () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CatalogScreen(user: widget.user),
              ),
            );
          },
          () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => SearchScreen(initialQuery: '', user: widget.user),
              ),
            );
          },
          () {
            // Navegar a la pantalla del carrito
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CartScreen(user: widget.user),
              ),
            );
          },
        ],
        bodyCarouselsTitles: const [
          'Promociones',
          'Novedades',
        ],
        bodyCarouselsImageUrls: [
          pomotions.map((p) => p.image).toList(),
          novedades.map((p) => p.image).toList()
        ],
        bodyCarouselsDescriptions: [
          pomotions.map((p) => "${p.title} - S/ ${p.price.toStringAsFixed(2)}").toList(),
          novedades.map((p) => "${p.title} - S/ ${p.price.toStringAsFixed(2)}").toList()
        ],
        bodyCarouselsOnSeeMore: [
          pomotions.map((p) => () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProductDetailScreen(product: p, user: widget.user),
              ),
            );
          }).toList(),
          novedades.map((p) => () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProductDetailScreen(product: p, user: widget.user),
              ),
            );
          }).toList(),
        ],
        footerIcons: const [
          Icons.facebook,
          Icons.email,
        ],
        footerLabels: const ['Contacto', 'Ayuda'],
        footerActions: [
        () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ContactScreen(user: widget.user),
            ),
          );
        },
        () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SupportScreen(user: widget.user),
            ),
          );
        },
      ],
    );
  }
}
