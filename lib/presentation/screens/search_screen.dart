
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/domain/entities/user.dart';
import 'package:flutter_ecommerce_app/presentation/screens/dashboard_screen.dart';
import 'package:flutter_ecommerce_app/presentation/screens/login_screen.dart';
import 'package:flutter_ecommerce_app/presentation/screens/detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:atomic_desing_system_package/atomic_desing_system_package.dart';
import '../providers/product_provider.dart';

class SearchScreen extends StatefulWidget {
  final String? initialQuery;
  final User user;
  const SearchScreen({super.key, this.initialQuery, required this.user});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late String query;

  @override
  void initState() {
    super.initState();
    query = widget.initialQuery ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products.where((product) {
      final lowerQuery = query.toLowerCase();
      return product.title.toLowerCase().contains(lowerQuery) ||
          product.description.toLowerCase().contains(lowerQuery);
    }).toList();

    return TemplateListCarts(
      headerUserName: widget.user.username,
      headerUserImageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=687&auto=format&fit=crop',
      headerShowBackArrow: true,
      headerOnSearch: (value) {
        setState(() {
          query = value;
        });
      },
      headerOnHome: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DashboardScreen(user: widget.user),
          ),
        );
      },
      headerOnLogout: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      },
      headerSearchController: TextEditingController(text: query),
      headerTitle: 'Buscar',
      bodyCardImageUrls: products.map((p) => p.image).toList(),
      bodyCardDescriptions: products.map((p) => '${p.title} - S/ ${p.price.toStringAsFixed(2)}').toList(),
      bodyCardOnSeeMore: products.map((product) {
        return () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => DetailScreen(product: product, user: widget.user),
            ),
          );
        };
      }).toList(),
      footerIcons: const [Icons.facebook, Icons.email],
      footerLabels: const ['Términos', 'Privacidad'],
      footerActions: [
        () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Términos')));
        },
        () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Privacidad')));
        },
      ]
    );
  }
}
